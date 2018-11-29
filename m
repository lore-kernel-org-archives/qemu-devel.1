Received: from eggs.gnu.org ([2001:4830:134:3::10]:33404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSMT8-0008Vq-7R
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSMT4-0004Eo-3C
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:35:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSMT3-0004DF-TR
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 08:34:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E3C97B020
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 13:34:57 +0000 (UTC)
References: <20181129104658.26585-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14b6a1da-dc71-adbc-1911-a6e281229c43@redhat.com>
Date: Thu, 29 Nov 2018 07:34:56 -0600
MIME-Version: 1.0
In-Reply-To: <20181129104658.26585-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Document how to test the site
 with jekyll locally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 11/29/18 4:46 AM, Daniel P. Berrang=C3=A9 wrote:
> Add a README file that tells people this is a jekyll based static
> website, and shows people how to run jekyll for testing purposes.
>=20
> Tested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   .gitignore  |  2 ++
>   README      | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
>   _config.yml |  2 ++
>   3 files changed, 59 insertions(+)
>   create mode 100644 README

> +Testing locally with Jekyll
> +---------------------------
> +
> +When adding/changing content on this site, it is possible to run a
> +local Jekyll service to test the result.
> +
> +QEMU requires a specific version of Jekyll (listedin Gemfile) which ma=
y

s/listedin/listed in/

> +++ b/_config.yml
> @@ -37,3 +37,5 @@ gems:
>   exclude:
>     - Gemfile
>     - Gemfile.lock
> +  - vendor/
> +  - README

Should .gitignore be in this list?  But that's pre-existing.

With the typo fix,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
