Received: from eggs.gnu.org ([2001:4830:134:3::10]:55703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0YpL-000068-Mz
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0YpI-0001FF-Dc
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:30:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0YpI-0001Ex-7Y
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1F2D7AEA4
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 19:30:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <76d42218-b542-4136-af87-5c0bc4d4afac@redhat.com> (Eric Blake's
	message of "Thu, 6 Apr 2017 09:09:10 -0500")
References: <20170406131326.2418-1-quintela@redhat.com>
	<20170406131326.2418-5-quintela@redhat.com>
	<76d42218-b542-4136-af87-5c0bc4d4afac@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 18 Apr 2017 21:30:06 +0200
Message-ID: <87shl5h5tt.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/5] migration: Disable hotplug/unplug
 during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> wrote:
> On 04/06/2017 08:13 AM, Juan Quintela wrote:
>> Until we have reviewed what can/can't be hotplug during migration,
>
> s/hotplug/hotplugged/
>
>> disable it.  We can enable it later for the things that we know that
>> work.  For instance, memory hotplug during postcopy don't work
>
> s/don't/doesn't/

Fixed the three typos, thanks.
