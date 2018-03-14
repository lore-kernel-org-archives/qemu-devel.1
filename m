Received: from eggs.gnu.org ([2001:4830:134:3::10]:53005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew7kv-0001mp-5e
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew7ku-0000HJ-HV
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:51:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew7ku-0000Gy-Dk
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:51:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41EF24023155
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 14:51:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180313165339.GI3545@work-vm> (David Alan Gilbert's message of
	"Tue, 13 Mar 2018 16:53:40 +0000")
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-9-quintela@redhat.com>
	<20180313165339.GI3545@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 14 Mar 2018 15:52:31 +0100
Message-ID: <87vadyso9c.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 08/24] migration: Add multifd test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We set the x-multifd-page-count and x-multifd-channels.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
>
> This should probably go nearer the end of the series;

it is _much_ better here.  It makes so much easier to test that I don't
break neither migration nor multifd while developing O:-)

> we've also got the problem that things are a bit delicate with TCG so
> adding more migration tests probably shouldn't happen until Paolo's
> TCG fixes are worked out.



> Also, should we be checking for some stats to show all 4 channels were
> used?

There are traces now, I can add new counters is that is what you want.

Later, Juan.
