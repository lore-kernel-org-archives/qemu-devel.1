Received: from eggs.gnu.org ([2001:4830:134:3::10]:58563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJHe-0005ka-D1
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJHd-0002vq-AE
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:33:30 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJHd-0002vf-31
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:33:29 -0400
Received: by mail-wr0-x22a.google.com with SMTP id c11so36559875wrc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 06:33:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-7-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 14:33:07 +0100
Message-ID: <CAFEAcA97OqyoeyhMU06LB-H5xuEu4DXziDwv=PU1knhjXE5KXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 06/13] risu: a bit more verbosity
 when starting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 June 2017 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> When debugging faults it is useful to know where the generated
> instructions are living.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --

Separator should be '---'.

> v5
>   - dropped all the status update due to signal handler contraints
> v3
>   - use portable fmt string for image_start_address
>   - include arm dumping position
> ---
>  risu.c | 4 ++++
>  risu.h | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/risu.c b/risu.c
> index 2cd6d22..a10422a 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -124,6 +124,8 @@ int master(int sock)
>      }
>      master_socket =3D sock;
>      set_sigill_handler(&master_sigill);
> +    fprintf(stderr, "starting master image at 0x%"PRIxPTR"\n",
> +            image_start_address);
>      fprintf(stderr, "starting image\n");
>      image_start();
>      fprintf(stderr, "image returned unexpectedly\n");
> @@ -134,6 +136,8 @@ int apprentice(int sock)
>  {
>      apprentice_socket =3D sock;
>      set_sigill_handler(&apprentice_sigill);
> +    fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n",
> +            image_start_address);
>      fprintf(stderr, "starting image\n");
>      image_start();
>      fprintf(stderr, "image returned unexpectedly\n");
> diff --git a/risu.h b/risu.h
> index 3fbeda8..78a7313 100644
> --- a/risu.h
> +++ b/risu.h
> @@ -37,6 +37,7 @@ extern uintptr_t image_start_address;
>  extern void *memblock;
>
>  extern int test_fp_exc;
> +extern int ismaster;
>
>  /* Ops code under test can request from risu: */
>  #define OP_COMPARE 0
> @@ -72,6 +73,8 @@ int recv_and_compare_register_info(int sock, void *uc);
>   */
>  int report_match_status(void);
>
> +void report_test_status(void *pc);
> +
>  /* Interface provided by CPU-specific code: */
>
>  /* Move the PC past this faulting insn by adjusting ucontext
> --

Stray extra changes here ?

thanks
-- PMM
