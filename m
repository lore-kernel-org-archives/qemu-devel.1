Received: from eggs.gnu.org ([2001:4830:134:3::10]:58156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxNd-0005Ox-1B
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxNc-00025M-6W
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:37:17 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:34696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHxNc-000255-2Q
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:37:16 -0500
Received: by mail-ua0-x236.google.com with SMTP id 51so46398300uai.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 10:37:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161209114830.9158-7-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
	<20161209114830.9158-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 18:36:54 +0000
Message-ID: <CAFEAcA_g4i1LJEhBd5yNKFCAgwJBU=ENDJ6LxCspGwvbOx-QGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v3 06/10] risu_aarch64: it's -> it is
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

On 9 December 2016 at 11:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  risu_aarch64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/risu_aarch64.c b/risu_aarch64.c
> index 7f9f612..8e3539e 100644
> --- a/risu_aarch64.c
> +++ b/risu_aarch64.c
> @@ -97,7 +97,7 @@ int send_register_info(write_fn write_fn, void *uc)
>   * NB: called from a signal handler.
>   *
>   * We don't have any kind of identifying info in the incoming data
> - * that says whether it's register or memory data, so if the two
> + * that says whether it is register or memory data, so if the two
>   * sides get out of sync then we will fail obscurely.
>   */
>  int recv_and_compare_register_info(read_fn read_fn, respond_fn resp_fn, =
void *uc)

Applied to risu master, thanks.

-- PMM
