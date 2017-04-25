Received: from eggs.gnu.org ([2001:4830:134:3::10]:47054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d33e2-0000WK-3G
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d33dz-000867-2m
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d33dy-000862-TR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:48:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC84C7D0C7
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 16:48:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <53bc98ec-fbfd-318c-4613-2c14b4e9b65e@redhat.com> (Laurent
	Vivier's message of "Tue, 25 Apr 2017 16:15:43 +0200")
References: <20170425102446.4008-1-quintela@redhat.com>
	<20170425102446.4008-6-quintela@redhat.com>
	<53bc98ec-fbfd-318c-4613-2c14b4e9b65e@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 25 Apr 2017 18:48:42 +0200
Message-ID: <87mvb4mo0l.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/6] monitor: Move hmp_info_snapshots from
 savevm.c to hmp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com

Laurent Vivier <lvivier@redhat.com> wrote:
> On 25/04/2017 12:24, Juan Quintela wrote:
>> It only uses block/* functions, nothing from migration.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>
> Perhaps the monitor.h include in savevm.c can be removed in PATCH 1/6?

hmp_info_snapshots still uses monitor_printf(), so I have to left it
until here.

Thanks, Juan.
