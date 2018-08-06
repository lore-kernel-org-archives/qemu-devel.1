Received: from eggs.gnu.org ([2001:4830:134:3::10]:41932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmjp0-0007SR-J7
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmjom-00085A-Ow
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:01:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fmjom-000843-8a
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:01:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4546740201A0
	for <qemu-devel@nongnu.org>; Mon,  6 Aug 2018 18:01:19 +0000 (UTC)
References: <20180718120334.27138-1-berrange@redhat.com>
	<20180718120334.27138-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32da5960-f2b7-2221-78b6-d4bb9b5301a4@redhat.com>
Date: Mon, 6 Aug 2018 13:01:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180718120334.27138-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] crypto: require libgcrypt >= 1.5.0 for
 building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

On 07/18/2018 07:03 AM, Daniel P. Berrang=C3=A9 wrote:
> libgcrypt 1.5.0 was released in 2011 and all the distros that are build
> target platforms for QEMU [1] include it:
>=20
>    RHEL-7: 1.5.3
>    Debian (Stretch): 1.7.6
>    Debian (Jessie): 1.6.3
>    OpenBSD (ports): 1.8.2
>    FreeBSD (ports): 1.8.3
>    OpenSUSE Leap 15: 1.8.2
>    Ubuntu (Xenial): 1.6.5
>    macOS (Homebrew): 1.8.3
>=20
> Based on this, it is reasonable to require libgcrypt >=3D 1.5.0 in QEMU
> which allows for some conditional version checks in the code to be
> removed.
>=20
> [1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platform=
s
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
