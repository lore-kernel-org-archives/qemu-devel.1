Received: from eggs.gnu.org ([2001:4830:134:3::10]:37859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZC37-0008Py-LJ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZC34-0002zW-Ei
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:47:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZC34-0002yc-8O
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:47:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D87A7F7B9
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 08:47:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180110062545.GB5984@xz-mi> (Peter Xu's message of "Wed, 10 Jan
	2018 14:25:45 +0800")
References: <20180105215246.908-1-quintela@redhat.com>
	<20180105215246.908-3-quintela@redhat.com>
	<20180110062545.GB5984@xz-mi>
Reply-To: quintela@redhat.com
Date: Wed, 10 Jan 2018 09:47:43 +0100
Message-ID: <87incayua8.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 02/11] tests: Migration ppc test was
 missing arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Fri, Jan 05, 2018 at 10:52:37PM +0100, Juan Quintela wrote:
>> Argument file is also needed there.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Does it also mean this?
>
> Fixes: aaf89c8a49a8c ("test: port postcopy test to ppc64")

Dunno.  I was trying to consolidate the command line options for ppc and
x86 when I found this problem.  I haven't tested of ppc.

Thanks, Juan.
