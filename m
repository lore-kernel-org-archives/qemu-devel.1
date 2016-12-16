Received: from eggs.gnu.org ([2001:4830:134:3::10]:58289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxOF-0007v6-4a
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHxOE-0002Lm-Cv
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:37:55 -0500
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:33285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHxOE-0002Le-8S
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 13:37:54 -0500
Received: by mail-ua0-x232.google.com with SMTP id b35so18682401uaa.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 10:37:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161209114830.9158-8-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
	<20161209114830.9158-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 18:37:33 +0000
Message-ID: <CAFEAcA8WeygE6W3ObsADJq-yE34x6WAm7mtziik4AMxyWgS4Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v3 07/10] risugen: remove grocer's
 apostrophe from REs
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
> This also fixes perl-modes confusion about escaped strings.

Missing apostrophe: should be "perl-mode's" :-)

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Applied to risu master with that fixed; thanks.

-- PMM

> ---
>  risugen | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/risugen b/risugen
> index a604fe5..77a550b 100755
> --- a/risugen
> +++ b/risugen
> @@ -288,7 +288,7 @@ Valid options:
>                     'VMULL' will match 'VMULL A1' and 'VMULL A2' but not
>                     'VMULL_scalar A1'. This is generally what you wanted.
>      --not-pattern re[,re...] : exclude patterns matching regular express=
ion.
> -                   These RE's are applied after the matching pattern whi=
ch
> +                   These REs are applied after the matching pattern whic=
h
>                     is useful if you want to exclude a specific instructi=
on from
>                     a general set you have excluded.
>       --no-fp      : disable floating point: no fp init, randomization et=
c.
> --
> 2.11.0
>
