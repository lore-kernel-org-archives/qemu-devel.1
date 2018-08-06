Received: from eggs.gnu.org ([2001:4830:134:3::10]:42869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmjq6-0008C3-DS
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fmjq2-00014j-6i
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:02:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fmjq2-00014N-2H
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 14:02:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92EF07C6A9
	for <qemu-devel@nongnu.org>; Mon,  6 Aug 2018 18:02:37 +0000 (UTC)
References: <20180718120334.27138-1-berrange@redhat.com>
	<20180718120334.27138-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbb6fea3-9c52-7ff4-0399-dfa5fad6173c@redhat.com>
Date: Mon, 6 Aug 2018 13:02:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180718120334.27138-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] crypto: require nettle >= 1.5.0 for
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
> nettle 2.7.1 was released in 2013 and all the distros that are build
> target platforms for QEMU [1] include it:
>=20
>    RHEL-7: 2.7.1
>    Debian (Stretch): 3.3
>    Debian (Jessie): 2.7.1
>    OpenBSD (ports): 3.4
>    FreeBSD (ports): 3.4
>    OpenSUSE Leap 15: 3.4
>    Ubuntu (Xenial): 3.2
>    macOS (Homebrew): 3.4
>=20
> Based on this, it is reasonable to require nettle >=3D 2.7.1 in QEMU
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
