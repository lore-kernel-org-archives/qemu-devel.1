Received: from eggs.gnu.org ([2001:4830:134:3::10]:37791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYv0-0007a7-Pv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYun-0002eX-FC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:53:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gXYum-0002VG-AD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:53:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BF41307D861
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:53:02 +0000 (UTC)
References: <20181213184340.24037-1-armbru@redhat.com>
	<20181213184340.24037-28-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45516d95-2271-5577-8cad-38d66ff2181f@redhat.com>
Date: Thu, 13 Dec 2018 15:52:58 -0600
MIME-Version: 1.0
In-Reply-To: <20181213184340.24037-28-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 27/32] qapi: add #if conditions to generated
 code members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 12/13/18 12:43 PM, Markus Armbruster wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Wrap generated enum and struct members and their supporting code with
>=20

Git ate the line because it started with #.  Not sure if you can sneak=20
in a v2 pull request that puts something sane here...

> We do enum and struct in a single patch because union tag enum and the
> associated variants tie them together, and dealing with that to split
> the patch doesn't seem worthwhile.
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
