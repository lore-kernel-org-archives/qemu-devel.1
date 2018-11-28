Received: from eggs.gnu.org ([2001:4830:134:3::10]:35183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS1Tc-0003MY-HY
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS1TY-0000qD-Hp
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:10:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gS1TY-0000mb-9e
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:10:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CA6130014AD
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 15:10:03 +0000 (UTC)
References: <20181128145008.6574-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <75c4897e-f24a-e1ef-bece-a6d54541b157@redhat.com>
Date: Wed, 28 Nov 2018 16:10:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181128145008.6574-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: document version
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2018-11-28 15:50, Daniel P. Berrang=C3=A9 wrote:
> The new version numbering scheme was mentioned in the blog post
> announcing 3.0 previously, but this will fall out of view over
> time. It is thus preferrable to mention this on the download page
> too.
>=20
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  download.html | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/download.html b/download.html
> index 5a1e4ea..59db880 100644
> --- a/download.html
> +++ b/download.html
> @@ -39,6 +39,31 @@ permalink: /download/
>  	{% include_relative _download/source.html %}
>  </article>
>  </div>
> +
> +<h2>Version numbering</h2>
> +<div>
> +  <p>
> +  In 2018, for the QEMU 3.0 release, a time based version numbering sc=
heme was
> +  adopted:

I'd maybe drop the "2018" here, and use a three digit version number
(since you describe the three digits below) ... maybe rather write it
like this:

 Since version 3.0.0, QEMU uses a time based version numbering scheme:

?

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
> +  <p>
> +    The implication of this is that changes in major version number
> +    <strong>do not</strong> have any bearing on the scope of changes
> +    included in the release. Non-backward compatible changes may be ma=
de
> +    in any master branch release, provided they have followed the
> +    <a href=3D"https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-f=
eatures">deprecation policy</a>
> +    which calls for warnings to be emitted for a minimum of two releas=
es
> +    prior to the change.
> +  </p>
> +</div>
>  <script>
>  function animateOnClick(jqThis, slide) {
>     $('.horiz-menu li').removeClass('active');
>=20

 Thomas
