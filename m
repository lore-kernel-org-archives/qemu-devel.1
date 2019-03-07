Received: from eggs.gnu.org ([209.51.188.92]:42536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1oB6-0001xH-95
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1oB5-0000Sz-3Y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:14:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h1oB4-0000Sf-QV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:14:55 -0500
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b794ba1-f719-e1f4-5a17-ba261aeebea6@redhat.com>
Date: Thu, 7 Mar 2019 09:14:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Cc: john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com

On 07/03/2019 08.22, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> TODO: Make relevant changes to the doc.
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  docs/devel/qemu-multiprocess.txt | 1109 ++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 1109 insertions(+)
>  create mode 100644 docs/devel/qemu-multiprocess.txt
>=20
> diff --git a/docs/devel/qemu-multiprocess.txt b/docs/devel/qemu-multipr=
ocess.txt
> new file mode 100644
> index 0000000..e29c6c8
> --- /dev/null
> +++ b/docs/devel/qemu-multiprocess.txt
> @@ -0,0 +1,1109 @@
> +/*
> + * Copyright 2019, Oracle and/or its affiliates. All rights reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */

Somehow weird to see such a big license statement talking about
"software", but which applies to a text file only... Not sure if it is
an option for you, but maybe one of the Creative Common licenses
(dual-licensed with the GPLv2+) would be a better fit? E.g. for the QEMU
website, the content is dual-licensed: https://www.qemu.org/license.html

 Thomas
