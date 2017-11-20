Received: from eggs.gnu.org ([2001:4830:134:3::10]:51541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eGgKs-0001U7-JK
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eGgKp-0005Eb-EU
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:17:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:52371)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eGgKp-0005EM-5I
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 02:17:39 -0500
References: <1510815025-27857-1-git-send-email-yu.ning@linux.intel.com>
	<aa8a18bf-e4ac-830f-94c1-a86a612e2ebd@weilnetz.de>
	<20171116180003.GO3111@localhost.localdomain>
	<ed07d728-dc3d-3f45-23de-f4058aaf8f38@linux.intel.com>
	<20171119213130.GI3037@localhost.localdomain>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <1516fc97-6b46-5a3b-3226-d89b55974cea@linux.intel.com>
Date: Mon, 20 Nov 2017 15:17:34 +0800
MIME-Version: 1.0
In-Reply-To: <20171119213130.GI3037@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hax-interface: Add BSD license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Yu Ning <yu.ning@intel.com>, Richard Henderson <rth@twiddle.net>, Vincent Palatin <vpalatin@chromium.org>



On 11/20/2017 5:31, Eduardo Habkost wrote:
> On Fri, Nov 17, 2017 at 05:03:27PM +0800, Yu Ning wrote:
>> On 11/17/2017 2:00, Eduardo Habkost wrote:
>>> On Thu, Nov 16, 2017 at 07:47:44AM +0100, Stefan Weil wrote:
>>>> Am 16.11.2017 um 07:50 schrieb yu.ning@linux.intel.com:
>>>>> From: Yu Ning <yu.ning@intel.com>
>>>>>
>>>>> hax-interface.h defines the interface between the HAXM kernel
>>>>> module and the HAXM QEMU accelerator. The same code can be found in
>>>>> the following files of the HAXM kernel module:
>>>>>
>>>>>    include/hax_interface.h
>>>>>    include/vcpu_state.h
>>>>>    core/include/vm.h
>>>>>
>>>>> These files are now open source under the 3-clause BSD license,
>>>>> whereas hax-interface.h in QEMU uses GPLv2.
>>> Why is this a problem?
>> I know very little about licenses.  If this is not a problem, I'm happy to
>> just abandon this patch.
> As far as I can see, this is not a problem for the QEMU project
> at all, as QEMU as a whole is GPLv2.
>
> It would make sense to update the license if we wanted to keep
> our header file in sync with some other source tree (e.g. the one
> from Intel), but this doesn't seem to be the case here (yet?).
>
I see, that makes sense.

>
>>
>>> If we really care about consistency between the two
>>> projects, shouldn't we just delete the existing file and copy the
>>> headers from github.com/intel/haxm directly?
>> That's a good solution, but not feasible at the moment, because in the HAXM
>> kernel module, a small piece of the interface code currently resides in an
>> internal header (core/include/vm.h). Probably we should clean up the
>> interface headers on the HAXM side, and then push the change to QEMU.
> This would be nice, so we wouldn't need to maintain a different
> header file in QEMU.  Should we open an issue at
> https://github.com/intel/haxm?
>
Here: https://github.com/intel/haxm/issues/9

The API headers in the HAXM tree depend on another header, i.e. either 
hax_types_windows.h or hax_types_mac.h, which defines some basic data 
types (uint64_t, etc.) and macros (PACKED, ALIGNED, etc.).  If we want 
to use the same files for QEMU, we'll need to figure out an elegant way 
to provide those definitions.  Any suggestions?
