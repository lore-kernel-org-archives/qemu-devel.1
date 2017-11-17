Received: from eggs.gnu.org ([2001:4830:134:3::10]:57029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFcYm-0005Yy-Vr
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFcYi-0003qF-U0
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:03:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:41664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eFcYi-0003pm-Jb
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:03:36 -0500
References: <1510815025-27857-1-git-send-email-yu.ning@linux.intel.com>
	<aa8a18bf-e4ac-830f-94c1-a86a612e2ebd@weilnetz.de>
	<20171116180003.GO3111@localhost.localdomain>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <ed07d728-dc3d-3f45-23de-f4058aaf8f38@linux.intel.com>
Date: Fri, 17 Nov 2017 17:03:27 +0800
MIME-Version: 1.0
In-Reply-To: <20171116180003.GO3111@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Yu Ning <yu.ning@intel.com>, Richard Henderson <rth@twiddle.net>, Vincent Palatin <vpalatin@chromium.org>



On 11/17/2017 2:00, Eduardo Habkost wrote:
> On Thu, Nov 16, 2017 at 07:47:44AM +0100, Stefan Weil wrote:
>> Am 16.11.2017 um 07:50 schrieb yu.ning@linux.intel.com:
>>> From: Yu Ning <yu.ning@intel.com>
>>>
>>> hax-interface.h defines the interface between the HAXM kernel
>>> module and the HAXM QEMU accelerator. The same code can be found in
>>> the following files of the HAXM kernel module:
>>>
>>>   include/hax_interface.h
>>>   include/vcpu_state.h
>>>   core/include/vm.h
>>>
>>> These files are now open source under the 3-clause BSD license,
>>> whereas hax-interface.h in QEMU uses GPLv2.
> Why is this a problem?

I know very little about licenses.  If this is not a problem, I'm happy 
to just abandon this patch.
>
>>> Address this inconsistency by adding the BSD license to the QEMU
>>> file, per Stefan Weil's comment on this HAXM pull request:
>>>
>>>   https://github.com/intel/haxm/pull/2
> The existing code on qemu.git don't match the code on the GitHub
> repository above exactly, and its copyright history looks hard to
> track[1].

Right. I don't know when the QEMU header (hax-interface.h) first 
appeared, but I think it's probably a derivative of the HAXM ones, which 
date back to no later than June 2011.

> If we really care about consistency between the two
> projects, shouldn't we just delete the existing file and copy the
> headers from github.com/intel/haxm directly?

That's a good solution, but not feasible at the moment, because in the 
HAXM kernel module, a small piece of the interface code currently 
resides in an internal header (core/include/vm.h). Probably we should 
clean up the interface headers on the HAXM side, and then push the 
change to QEMU.

> Also, does it even make sense to keep the two licenses in the
> file?

I don't know the answer.  If it doesn't make sense, I can either remove 
the original GPLv2 license, or abandon this patch and later come back 
with another one implementing the above solution.
