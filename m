Received: from eggs.gnu.org ([2001:4830:134:3::10]:39883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSXnw-0006R5-Kb
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSXns-00084g-KQ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:41:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSXns-00083J-EJ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:41:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 321133078AB6
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 01:41:11 +0000 (UTC)
Received: from [10.3.117.105] (ovpn-117-105.phx2.redhat.com [10.3.117.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F1DEC60CD1
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 01:41:10 +0000 (UTC)
References: <20181130011146.3065277-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b26f4d25-b83d-b3e3-c4cf-6e12f0c9d4f8@redhat.com>
Date: Thu, 29 Nov 2018 19:41:10 -0600
MIME-Version: 1.0
In-Reply-To: <20181130011146.3065277-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1? 0/2] NBD dirty bitmap cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 11/29/18 7:11 PM, Eric Blake wrote:
> I'm working on a bigger series to add 'qemu-nbd --list' that shows
> all details about all exports of a given server. In the process,
> it turned up a couple of bugs. By themselves, these are not enough
> to cause -rc4 (the bugs already existed in 3.0; this is not a
> regression fix), but if we have -rc4 for any other reason, both
> of these would be nice to have as it makes incremental backups
> easier to manage.
> 

Cover letter sent alone in error; I'll try again in a moment for the 
full series.

> Eric Blake (2):
>    nbd/server: Advertise all contexts in response to bare LIST
>    nbd/client: Make x-dirty-bitmap more reliable
> 
>   nbd/client.c | 21 +++++++++++++++++++++
>   nbd/server.c |  1 +
>   2 files changed, 22 insertions(+)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
