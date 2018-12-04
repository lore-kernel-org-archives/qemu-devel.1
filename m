Received: from eggs.gnu.org ([2001:4830:134:3::10]:38562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gU8NG-0001sD-7W
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gU8NC-0001M9-F6
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:56:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gU8NB-0001Ld-Tu
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:56:14 -0500
References: <20181203164105.29858-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <08d36eda-e8e7-4ece-edc5-ef436d25e6b7@redhat.com>
Date: Tue, 4 Dec 2018 11:56:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181203164105.29858-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Import historical documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <codyprime@gmail.com>

On 2018-12-03 17:41, Daniel P. Berrang=C3=A9 wrote:
> The files included are taken from formal builds of previous versions
> of QEMU, going back to 2.0.0
>=20
>   - qemu-doc.html
>   - qemu-qmp-ref.html
>   - qemu-ga-ref.html
>=20
> To import them all content outside of <body></body> is stripped and
> replaced by a trivial jekyll header. This causes the rendered docs
> to get consistent styling and navbar heading.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20
> This patch shows what it would be like if we just copied the
> pre-rendered QEMU docs into qemu-web for each major release....
>=20
> ...it would be large. 2.0.0 was only 300 KB in size, but latest
> 3.0.0 release has 1.3 MB of docs. So we'd be adding about 4 MB
> of docs to qemu-web each year if we committed them.
>=20
> This feels undesirable as a strategy.

I also dislike the idea to store data in the git repo that is generated
automatically from other sources (qemu-doc.texi and friends in this case)=
.

> At least in terms of the end result for users, I think it is
> positive.

Agreed, for the users it might be helpful to have access to all
different versions of the documenation.

> Other ideas
>=20
>  1. Upload built docs to a lookaside directory on the download
>     site when making a release, then have a jekyll plugin to
>     pull them in. Extra work for the person making releases
>     principally.
>=20
>  2. Have a jekyll plugin that uses docker env to build each
>     release docs from pristine tarballs. Would need caching
>     to avoid burning CPU cycles in each web update. Reliably
>     building older QEMU versions gets increasingly troublesome

We'd also need to discuss how new docs get added after a release
anyway... automatically? Manually? In the latter case, who does that job?

I think it would be best if we find a way to automate this process, e.g.
when a new release is tagged, a script generates the docs and puts them
somewhere on the web server, into the right new folder based on the name
of the tag. However, I don't know the qemu server well enough to know
whether that's possible or not ... maybe Jeff or Paolo can comment on
this...

 Thomas
