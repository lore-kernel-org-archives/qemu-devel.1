Received: from eggs.gnu.org ([2001:4830:134:3::10]:34601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePXCN-0008Tq-Lb
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePXCM-0000wQ-Tu
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:21:31 -0500
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-5-jsnow@redhat.com>
	<0ac30feb-553b-cfa3-070a-0f703c4e0f10@redhat.com>
	<1b7494a6-aca5-41e8-469b-e2b9d8aade67@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b0969a32-fa45-a4f5-0768-959750622698@redhat.com>
Date: Thu, 14 Dec 2017 18:21:11 +0100
MIME-Version: 1.0
In-Reply-To: <1b7494a6-aca5-41e8-469b-e2b9d8aade67@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] blockjob: allow block_job_throttle to
 take delay_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

On 14/12/2017 17:06, John Snow wrote:
>>
>> And another question.  After this series there is exactly one
>> block_job_sleep_ns call (in block/mirror.c).  Perhaps instead of
>> block_job_throttle, you should refine block_job_sleep_ns?
>>
> Yeah, maybe? "A rose by any other name," though -- I think I might be
> coming for the block/mirror call next because I have one more downstream
> BZ that references this as a job that can cause the warning print.
> 
> So maybe we'll just have throttle calls instead of sleep calls from here
> on out.

Ok, shall we wait for v2 where you look at that BZ as well?

Thanks,

Paolo
