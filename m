Received: from eggs.gnu.org ([2001:4830:134:3::10]:48437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1VSt-0003p1-6V
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d1VSp-0006ut-W1
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:06:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d1VSp-0006ue-Pj
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:06:55 -0400
References: <1491911135-216950-1-git-send-email-agraf@suse.de>
	<CALMp9eT220btgiw7S-0cLswr1j=-OCuMwOAWuWS51EmNYYRuJw@mail.gmail.com>
	<4622E361-52AB-40F2-9915-45C48F0DBCD2@suse.de>
	<CALMp9eR7AWETNZA1pSBXW2BWcrJXPk-Y1hbNvwu2Vq7Dkf6AjA@mail.gmail.com>
	<204f274d-697d-f9c6-8719-9bf91105f8b9@suse.de>
	<20170412185249-mutt-send-email-mst@kernel.org>
	<f1046a02-d42d-0b0b-47e0-f1055788a13b@redhat.com>
	<03f26e4b-6355-602a-f817-2c1ab38de199@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78ccf88c-9316-d922-8d8d-99442e6ce618@redhat.com>
Date: Fri, 21 Apr 2017 12:06:49 +0200
MIME-Version: 1.0
In-Reply-To: <03f26e4b-6355-602a-f817-2c1ab38de199@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] kvm: better MWAIT emulation for guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, kvm list <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Gabriel L. Somlo" <gsomlo@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, qemu-devel@nongnu.org



On 21/04/2017 12:05, Alexander Graf wrote:
> 
> 
> On 21.04.17 12:02, Paolo Bonzini wrote:
>>
>>
>> On 12/04/2017 18:29, Michael S. Tsirkin wrote:
>>> I don't really agree we do not need the PV flag. mwait on kvm is
>>> different from mwait on bare metal in that you are heavily penalized by
>>> scheduler for polling unless you configure the host just so.
>>> HLT lets you give up the host CPU if you know you won't need
>>> it for a long time.
>>>
>>> So while many people can get by with monitor cpuid (those that isolate
>>> host CPUs) and it's a valuable option to have, I think a PV flag is also
>>> a valuable option and can be set for more configurations.
>>>
>>> Guest has an idle driver calling mwait on short waits and halt on longer
>>> ones.  I'm in fact testing an idle driver using such a PV flag and will
>>> post when ready (after vacation ~3 weeks from now probably).
>>
>> For now I think I'm removing the PV flag, making this just an
>> optimization of commit 87c00572ba05aa8c ("kvm: x86: emulate
>> monitor and mwait instructions as nop").
>>
>> We can add it for 4.13 together with the idle driver.
> 
> I think that's a perfectly reasonable approach, yes. We can always add
> the PV flag with the driver.
> 
> Thanks a lot!

Queuing the patch for 4.12.

Paolo
