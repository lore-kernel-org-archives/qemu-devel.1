Received: from eggs.gnu.org ([2001:4830:134:3::10]:48809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNIg9-0000ef-NO
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNIg5-0006Vg-5X
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:54:45 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:34875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNIg4-0006Va-Tv
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:54:41 -0400
Received: by mail-wm0-x22d.google.com with SMTP id x70so21198317wme.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 05:54:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-3-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 13:54:19 +0100
Message-ID: <CAFEAcA--sFHayb4v8rGcWNKuRCcmgjM_ZCvmcr7+6-YHrqoxcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 02/13] README: document the coding
 style used for risu
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
> We also include the an Emacs .dir-locals (as per QEMU) that enforces
> this layout.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .dir-locals.el | 2 ++
>  README         | 9 +++++++++
>  2 files changed, 11 insertions(+)
>  create mode 100644 .dir-locals.el
>
> diff --git a/.dir-locals.el b/.dir-locals.el
> new file mode 100644
> index 0000000..3ac0cfc
> --- /dev/null
> +++ b/.dir-locals.el
> @@ -0,0 +1,2 @@
> +((c-mode . ((c-file-style . "stroustrup")
> +           (indent-tabs-mode . nil))))

This prompted me to look at this, and this is wrong: it
overrides my local emacs config with something that gets
some bits of style wrong :-( Indeed there's one in QEMU
now I see, and that is why my emacs behaviour has regressed.
For instance given

static const VMStateDescription cmsdk_apb_uart_vmstate =3D {
    .name =3D "cmsdk-apb-uart",
    .version_id =3D 1,
    .minimum_version_id =3D 1,
    .fields =3D (VMStateField[]) {
        VMSTATE_END_OF_LIST()


with cursor on the blank line at the end, if I type '}' then I get
     }\n
(ie the cursor moves to a new line) but the cursor should
stay after the '}' so I can type the ','.

thanks
-- PMM
