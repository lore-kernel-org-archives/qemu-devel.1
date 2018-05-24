Received: from eggs.gnu.org ([2001:4830:134:3::10]:33480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLh6v-0001Nb-86
	for qemu-devel@nongnu.org; Wed, 23 May 2018 23:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLh6s-0006Mv-4P
	for qemu-devel@nongnu.org; Wed, 23 May 2018 23:40:17 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLh6r-0006ME-Un
	for qemu-devel@nongnu.org; Wed, 23 May 2018 23:40:14 -0400
Received: by mail-qt0-x244.google.com with SMTP id m5-v6so288955qti.1
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 20:40:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180522035629.30428-1-peterx@redhat.com>
	<20180522035629.30428-3-peterx@redhat.com>
	<583d5b48-bb34-2c47-8e80-6c1142701506@amsat.org>
	<20180523011915.GD31932@xz-mi>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <78299865-b6a6-26f7-915f-f99800987381@amsat.org>
Date: Thu, 24 May 2018 00:40:05 -0300
MIME-Version: 1.0
In-Reply-To: <20180523011915.GD31932@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel-iommu: start to use
 error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

On 05/22/2018 10:19 PM, Peter Xu wrote:
> On Tue, May 22, 2018 at 06:09:46PM -0300, Philippe Mathieu-Daudé wrote:
>> Hi Peter,
>>
>> On 05/22/2018 12:56 AM, Peter Xu wrote:
>>> Replace existing trace_vtd_err() with error_report_once() then stderr
>>> will capture something if any of the error happens, meanwhile we don't
>>> suffer from any DDOS.  Then remove the trace point.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  hw/i386/intel_iommu.c | 34 +++++++++++++++++-----------------
>>>  hw/i386/trace-events  |  1 -
>>>  2 files changed, 17 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index fb31de9416..cf655fb9f6 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -285,14 +285,14 @@ static void vtd_generate_fault_event(IntelIOMMUState *s, uint32_t pre_fsts)
>>>  {
>>>      if (pre_fsts & VTD_FSTS_PPF || pre_fsts & VTD_FSTS_PFO ||
>>>          pre_fsts & VTD_FSTS_IQE) {
>>> -        trace_vtd_err("There are previous interrupt conditions "
>>> +        error_report_once("There are previous interrupt conditions "
>>>                        "to be serviced by software, fault event "
>>>                        "is not generated.");
>>
>> Can you keep alignment consistent please?
> 
> That was actually intended so reviewers don't need to skim those lines
> only caused by indents.  If I'm going to touch those lines, then maybe
> I can make them even look better by dumping more valid information.

I see.  I agree it is easier to review lines with substantial change,
however I now think it is then nicer to let the code exemplary for the
next one, if possible.  So regardless your preference:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
