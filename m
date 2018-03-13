Received: from eggs.gnu.org ([2001:4830:134:3::10]:37473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1evi01-00083f-Rf
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1evhzy-0007a5-O5
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:21:45 -0400
Received: from mail-cys01nam02on0612.outbound.protection.outlook.com
	([2a01:111:f400:fe45::612]:47136
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1evhzy-0007Yk-5w
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:21:42 -0400
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-29-brijesh.singh@amd.com>
	<20180308170824.GL4718@redhat.com>
	<e6db1aaa-83c7-ae5c-2311-bc247b301426@amd.com>
	<20180308214504.GE3417@localhost.localdomain>
	<20180309101200.GB3213@work-vm>
	<3c921c44-980c-7cb2-4c89-cdf251df4d8d@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <537c6968-d157-6f63-4c28-e1fbbd1124f5@amd.com>
Date: Tue, 13 Mar 2018 06:21:28 -0500
MIME-Version: 1.0
In-Reply-To: <3c921c44-980c-7cb2-4c89-cdf251df4d8d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: brijesh.singh@amd.com, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Bruce Rogers <brogers@suse.com>



On 3/13/18 4:07 AM, Paolo Bonzini wrote:
> On 09/03/2018 11:12, Dr. David Alan Gilbert wrote:
>> * Eduardo Habkost (ehabkost@redhat.com) wrote:
>>> On Thu, Mar 08, 2018 at 02:18:55PM -0600, Brijesh Singh wrote:
>>>>
>>>> On 3/8/18 11:08 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>> On Thu, Mar 08, 2018 at 06:49:01AM -0600, Brijesh Singh wrote:
>>>>>> Blacklist the following commands to fix the 'make check' failure.
>>>>>>
>>>>>> query-sev-launch-measure: it returns meaninful data only when we lau=
nch
>>>>>> SEV guest otherwise the command returns an error.
>>>>>>
>>>>>> query-sev: it return an error when SEV is not available on host (e.g=
 non
>>>>>> X86 platform or KVM is disabled at the build time)
>>>>>>
>>>>>> query-sev-capabilities: it returns an error when SEV feature is not
>>>>>> available on host machine.
>>>>> We generally expect 'make check' to succeed on every single patch
>>>>> in a series, so that 'git bisect' doesn't break.
>>>>>
>>>>> So you should add each command to the blacklist in the same commit
>>>>> that introduced the failure in the first place.
>>>>
>>>> Sure, I can quickly send the updated patch series to address your this
>>>> concern, but before spamming everyone's inbox I was wondering if I can
>>>> get some indication whether this series will make into 2.12 merge.
>>>>
>>>> Paolo, Eduardo and Richard,
>>>>
>>>> Most of the changes are in x86 directory hence any thought if you are
>>>> considering this series for 2.12 ? I have been testing the series with
>>>> and without SEV support and so far have not ran into any issue. if you
>>>> are not planning to pull this series in 2.12 then I will wait a bit
>>>> longer to get more feedback before sending the updates to address
>>>> Daniel's comment. thanks
>>> Trying to merge it before 2.12 soft freeze (next Tuesday) still
>>> looks like a reasonable goal to me.  What do others think?
>> I've only looked at a few general comments and things but it looks like
>> it's getting there;  I don't think it's had many comments from the KVM
>> side yet.
> The KVM side is a pretty linear use of the kernel API.  I'm not very
> happy with the debug API for MemoryRegions (but it's not really
> Brijesh's fault), so my plan would be to merge it without debug support.

Thanks Paolo, I am working to drop the complete debug support and will
send series very soon. I need to run some quick smoke test to make sure
I don't break SEV guest support.
