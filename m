Received: from eggs.gnu.org ([2001:4830:134:3::10]:40594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gS1jd-0004St-Mk
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gS1jZ-00065T-Va
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:26:41 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:54788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gS1jZ-000643-I2
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:26:37 -0500
References: <20181122141741.11108-1-marcandre.lureau@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <0432176d-72a6-2dd4-ccc7-8486ea49be7b@weilnetz.de>
Date: Wed, 28 Nov 2018 16:26:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181122141741.11108-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: apply some qemu.org-like CSS style
 to HTML
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com

Am 22.11.2018 um 15:17 schrieb Marc-Andr=C3=A9 Lureau:
> Style a bit the HTML documents, to make them look like qemu.org pages.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile                     |   2 +
>  docs/texinfo-extra-head.html |   7 ++
>  docs/texinfo.css             | 226 +++++++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 docs/texinfo-extra-head.html
>  create mode 100644 docs/texinfo.css


I tried this patch, and here are the results without the patch and with
the patch, so everybody can compare both looks:

old: https://qemu.weilnetz.de/doc/qemu-doc.html
new: https://qemu.weilnetz.de/doc/3.1/qemu-doc.html

I like the new look and can use it from now on, no matter whether it is
merged into QEMU 3.1 or delayed for release 4.

Tested-by: Stefan Weil <sw@weilnetz.de>

PS: https://qemu.weilnetz.de/doc/3.1/qemu-ga-ref.html and
https://qemu.weilnetz.de/doc/3.1/qemu-qmp-ref.html are also candidates
for the new look.
