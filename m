Received: from eggs.gnu.org ([2001:4830:134:3::10]:59267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evfuV-0000h8-2N
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evfuJ-0000Nq-D7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:07:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evfuJ-0000Mt-1j
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:07:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id r8so5152502wrg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 02:07:43 -0700 (PDT)
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-29-brijesh.singh@amd.com>
	<20180308170824.GL4718@redhat.com>
	<e6db1aaa-83c7-ae5c-2311-bc247b301426@amd.com>
	<20180308214504.GE3417@localhost.localdomain>
	<20180309101200.GB3213@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c921c44-980c-7cb2-4c89-cdf251df4d8d@redhat.com>
Date: Tue, 13 Mar 2018 10:07:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180309101200.GB3213@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 28/28] tests/qmp-test: blacklist sev
 specific qmp commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Brijesh Singh <brijesh.singh@amd.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Bruce Rogers <brogers@suse.com>

On 09/03/2018 11:12, Dr. David Alan Gilbert wrote:
> * Eduardo Habkost (ehabkost@redhat.com) wrote:
>> On Thu, Mar 08, 2018 at 02:18:55PM -0600, Brijesh Singh wrote:
>>>
>>>
>>> On 3/8/18 11:08 AM, Daniel P. Berrangé wrote:
>>>> On Thu, Mar 08, 2018 at 06:49:01AM -0600, Brijesh Singh wrote:
>>>>> Blacklist the following commands to fix the 'make check' failure.
>>>>>
>>>>> query-sev-launch-measure: it returns meaninful data only when we launch
>>>>> SEV guest otherwise the command returns an error.
>>>>>
>>>>> query-sev: it return an error when SEV is not available on host (e.g non
>>>>> X86 platform or KVM is disabled at the build time)
>>>>>
>>>>> query-sev-capabilities: it returns an error when SEV feature is not
>>>>> available on host machine.
>>>> We generally expect 'make check' to succeed on every single patch
>>>> in a series, so that 'git bisect' doesn't break.
>>>>
>>>> So you should add each command to the blacklist in the same commit
>>>> that introduced the failure in the first place.
>>>
>>>
>>> Sure, I can quickly send the updated patch series to address your this
>>> concern, but before spamming everyone's inbox I was wondering if I can
>>> get some indication whether this series will make into 2.12 merge.
>>>
>>> Paolo, Eduardo and Richard,
>>>
>>> Most of the changes are in x86 directory hence any thought if you are
>>> considering this series for 2.12 ? I have been testing the series with
>>> and without SEV support and so far have not ran into any issue. if you
>>> are not planning to pull this series in 2.12 then I will wait a bit
>>> longer to get more feedback before sending the updates to address
>>> Daniel's comment. thanks
>>
>> Trying to merge it before 2.12 soft freeze (next Tuesday) still
>> looks like a reasonable goal to me.  What do others think?
> 
> I've only looked at a few general comments and things but it looks like
> it's getting there;  I don't think it's had many comments from the KVM
> side yet.

The KVM side is a pretty linear use of the kernel API.  I'm not very
happy with the debug API for MemoryRegions (but it's not really
Brijesh's fault), so my plan would be to merge it without debug support.

Paolo
