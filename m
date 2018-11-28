Received: from eggs.gnu.org ([2001:4830:134:3::10]:36918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gS1YF-0007Qb-40
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gS1YA-00043x-26
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:14:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gS1Y9-0003wS-M6
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 10:14:49 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so26198400qtr.12
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 07:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20181128145008.6574-1-berrange@redhat.com>
In-Reply-To: <20181128145008.6574-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Nov 2018 19:14:34 +0400
Message-ID: <CAMxuvaz8ZmbdxtQhQi4+Zi6XEN_Oz_nqnEGkqu5w3frY7estvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "P. Berrange, Daniel" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On Wed, Nov 28, 2018 at 6:50 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> The new version numbering scheme was mentioned in the blog post
> announcing 3.0 previously, but this will fall out of view over
> time. It is thus preferrable to mention this on the download page
> too.
>
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks for the clarification. (It should be displayed under the os
menu/carousel on https://www.qemu.org/download/)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  download.html | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/download.html b/download.html
> index 5a1e4ea..59db880 100644
> --- a/download.html
> +++ b/download.html
> @@ -39,6 +39,31 @@ permalink: /download/
>         {% include_relative _download/source.html %}
>  </article>
>  </div>
> +
> +<h2>Version numbering</h2>
> +<div>
> +  <p>
> +  In 2018, for the QEMU 3.0 release, a time based version numbering sche=
me was
> +  adopted:
> +  </p>
> +<ul>
> +<dt>major</dt>
> +<dd>incremented by 1 for the first release of the year</dd>
> +<dt>minor</dt>
> +<dd>reset to 0 with every major increment, otherwise incremented by 1 fo=
r each release from git master</dd>
> +<dt>micro</dt>
> +<dd>always 0 for releases from git master, incremented by 1 for each sta=
ble branch release</dd>
> +</ul>
> +  <p>
> +    The implication of this is that changes in major version number
> +    <strong>do not</strong> have any bearing on the scope of changes
> +    included in the release. Non-backward compatible changes may be made
> +    in any master branch release, provided they have followed the
> +    <a href=3D"https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-fea=
tures">deprecation policy</a>
> +    which calls for warnings to be emitted for a minimum of two releases
> +    prior to the change.
> +  </p>
> +</div>
>  <script>
>  function animateOnClick(jqThis, slide) {
>     $('.horiz-menu li').removeClass('active');
> --
> 2.19.2
>
