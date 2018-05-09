Received: from eggs.gnu.org ([2001:4830:134:3::10]:55260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGMyZ-0005LZ-C9
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGMyV-0006A4-7A
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:09:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGMyV-00068v-32
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:09:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C116D40200A0
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:09:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180502183533.GN2679@work-vm> (David Alan Gilbert's message of
	"Wed, 2 May 2018 19:35:34 +0100")
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-13-quintela@redhat.com>
	<20180502183533.GN2679@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 09 May 2018 13:11:49 +0200
Message-ID: <877eod5bii.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 12/21] migration: Add multifd traces
 for start/end thread
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
>> We want to know how many pages/packets each channel has sent.  Add
>> counters for those.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c        | 20 ++++++++++++++++++++
>>  migration/trace-events |  4 ++++
>>  2 files changed, 24 insertions(+)

>>  typedef struct {
>> @@ -495,6 +499,10 @@ typedef struct {
>>      uint32_t flags;
>>      /* global number of generated multifd packets */
>>      uint32_t seq;
>> +    /* packets sent through this channel */
>> +    uint32_t num_packets;
>> +    /* pages sent through this channel */
>> +    uint32_t num_pages;
>
> Doesn't the comment for 'mutex' say 'protects the following parameters'
> (added in 09/21) ?  In which case....

This two are really local.  Fixing comment.

Thanks, Juan.
