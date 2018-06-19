Received: from eggs.gnu.org ([2001:4830:134:3::10]:37693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLD5-0007r2-4y
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLD0-0008Bl-JL
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:18:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38726 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVLD0-0008BY-ES
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:18:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E784740122D5
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 18:18:25 +0000 (UTC)
References: <20180619163552.18206-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f44a357-4ba7-9dc3-4be6-9ed424d61b2f@redhat.com>
Date: Tue, 19 Jun 2018 13:18:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180619163552.18206-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: fix crash in when incoming
 client channel setup fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 06/19/2018 11:35 AM, Daniel P. Berrang=C3=A9 wrote:
> The way we determine if we can start the incoming migration was
> changed to use migration_has_all_channels() in:
>=20
>    commit 428d89084c709e568f9cd301c2f6416a54c53d6d
>    Author: Juan Quintela <quintela@redhat.com>
>    Date:   Mon Jul 24 13:06:25 2017 +0200
>=20
>      migration: Create migration_has_all_channels
>=20
> This method in turn calls multifd_recv_all_channels_created()
> which is hardcoded to always return 'true' when multifd is
> not in use. This is a latent bug...
>=20
> ...activated in in a following commit where that return result

s/in in/in/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
