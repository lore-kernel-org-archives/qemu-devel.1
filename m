Received: from eggs.gnu.org ([2001:4830:134:3::10]:57930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDFWJ-0004NI-Qt
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDFWG-0001M8-Me
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDFWG-0001Jn-CV
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:07:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A21C0155AC
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 21:07:47 +0000 (UTC)
References: <20181018145748.11697-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc8d9885-adcf-7643-9962-da852e0efa46@redhat.com>
Date: Thu, 18 Oct 2018 23:07:44 +0200
MIME-Version: 1.0
In-Reply-To: <20181018145748.11697-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [web PATCH] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

On 18/10/2018 16:57, Daniel P. Berrang=C3=A9 wrote:
> This adds a config file for git-publish, primarily so that patches get
> sent with the "web" subject prefix to distinguish them from patches to
> the main git repo.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20
> I picked Paolo & Thomas as CC since they appear to be the people
> actually committing patches to qemu-web.git so far. Feel free to
> correct me if needed...
>=20
>  .gitpublish | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 .gitpublish
>=20
> diff --git a/.gitpublish b/.gitpublish
> new file mode 100644
> index 0000000..4cf08bc
> --- /dev/null
> +++ b/.gitpublish
> @@ -0,0 +1,11 @@
> +#
> +# Common git-publish profiles that can be used to send patches to QEMU=
 upstream.
> +#
> +# See https://github.com/stefanha/git-publish for more information
> +#
> +[gitpublishprofile "default"]
> +base =3D master
> +to =3D qemu-devel@nongnu.org
> +prefix =3D web PATCH
> +cc =3D Paolo Bonzini <pbonzini@redhat.com>
> +cc =3D Thomas Huth <thuth@redhat.com>
>=20

Changed to "qemu-web PATCH", according to
https://patchwork.kernel.org/patch/10081341/, and pushed.

Paolo
