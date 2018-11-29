Received: from eggs.gnu.org ([2001:4830:134:3::10]:33380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSK1j-0004yU-Qi
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSK1e-00067F-43
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:58:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSK1c-000650-BS
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:58:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 231FF309178F
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:58:27 +0000 (UTC)
References: <20181128153858.11845-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f73a6661-83a1-73fa-d087-a8d9c9aaaff5@redhat.com>
Date: Thu, 29 Nov 2018 11:58:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181128153858.11845-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] download: document version
 numbering scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 2018-11-28 16:38, Daniel P. Berrang=C3=A9 wrote:
> The new version numbering scheme was mentioned in the blog post
> announcing 3.0 previously, but this will fall out of view over
> time. It is thus preferrable to mention this on the download page
> too.
>=20
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  download.html | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/download.html b/download.html
> index 5a1e4ea..bbdc00c 100644
> --- a/download.html
> +++ b/download.html
> @@ -39,6 +39,30 @@ permalink: /download/
>  	{% include_relative _download/source.html %}
>  </article>
>  </div>
> +
> +<h2>Version numbering</h2>
> +<div>
> +  <p>
> +  Since version 3.0.0, QEMU uses a time based version numbering scheme=
:
> +  </p>
> +<ul>
> +<dt>major</dt>
> +<dd>incremented by 1 for the first release of the year</dd>
> +<dt>minor</dt>
> +<dd>reset to 0 with every major increment, otherwise incremented by 1 =
for each release from git master</dd>
> +<dt>micro</dt>
> +<dd>always 0 for releases from git master, incremented by 1 for each s=
table branch release</dd>
> +</ul>

HTML validator (https://validator.w3.org) complains here:

* Element dt not allowed as child of element ul in this context.

* Element dt not allowed as child of element ul in this context.

Since I don't want to mess up your intended formatting, could you please
fix it on your own and send a v3?

 Thanks,
  Thomas
