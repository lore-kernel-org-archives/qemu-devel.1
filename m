Received: from eggs.gnu.org ([2001:4830:134:3::10]:38729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dIeHZ-0001lc-NS
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dIeHU-0007XO-R3
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:58:09 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dIeHU-0007X2-KJ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:58:04 -0400
Received: by mail-wr0-x243.google.com with SMTP id e23so1703709wre.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 09:58:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
	<871sqvepc0.fsf@secure.mitica>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1d52506-50c3-6a67-5f74-b06ee0b016a2@redhat.com>
Date: Wed, 7 Jun 2017 18:58:01 +0200
MIME-Version: 1.0
In-Reply-To: <871sqvepc0.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpus: reset throttle_thread_scheduled
 after sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, Felipe Franciosi <felipe@nutanix.com>
Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 07/06/2017 18:26, Juan Quintela wrote:
> Felipe Franciosi <felipe@nutanix.com> wrote:
>> Currently, the throttle_thread_scheduled flag is reset back to 0 before
>> sleeping (as part of the throttling logic). Given that throttle_timer
>> (well, any timer) may tick with a slight delay, it so happens that under
>> heavy throttling (ie. close or on CPU_THROTTLE_PCT_MAX) the tick may
>> schedule a further cpu_throttle_thread() work item after the flag reset,
>> but before the previous sleep completed. This results on the vCPU thread
>> sleeping continuously for potentially several seconds in a row.
>>
>> The chances of that happening can be drastically minimised by resetting
>> the flag after the sleep.
>>
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> Signed-off-by: Malcolm Crossley <malcolm@nutanix.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> Paolo, I think that the analisys makes sense.
> 
> Should you pull this patch, or do you want me to pull it?

I've already included in my jinxed (now at v6) pull request.

Paolo
