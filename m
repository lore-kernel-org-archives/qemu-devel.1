Received: from eggs.gnu.org ([2001:4830:134:3::10]:45972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dq0cs-0005IG-5q
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dq0cn-0002y9-LZ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:30:02 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:37264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dq0cn-0002xn-E6
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:29:57 -0400
Received: by mail-wr0-x233.google.com with SMTP id k20so676006wre.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 10:29:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0tC5cqxVKi+pyPEUuumvNAQ6peMFPq0abqOBz4jfq5w@mail.gmail.com>
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<CAFEAcA8_SsbdXWFbAt+qKXF-XGBjAt=ZbDgzSaeXYFzYPL1KTQ@mail.gmail.com>
	<20170224171152.GU2778@thinpad.lan.raisama.net>
	<CAFEAcA_0tC5cqxVKi+pyPEUuumvNAQ6peMFPq0abqOBz4jfq5w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 18:29:35 +0100
Message-ID: <CAFEAcA-B+NL=139kr98m2btvFFAm8HMQ93up4pXhG3cEpBZtVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] i386: Add "max" CPU model to TCG
 and KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 24 February 2017 at 18:04, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 24 February 2017 at 17:11, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> On Fri, Feb 24, 2017 at 01:48:46PM +0000, Peter Maydell wrote:
>>> I had a look at implementing this for ARM, and ran into problems
>>> because of how we've done '-cpu host'. For us the "host" CPU
>>> type is registered dynamically when kvm_init() is called,
>>> because (a) it only exists if -enable-kvm and (b) it probes
>>> the kernel to find out what's available. So I could easily
>>> add 'max' in the same place; but then where should I add the
>>> type definition of 'max' for the non-KVM case?
>>
>> I recommend registering the type unconditionally, moving
>> KVM-specific initialization to ->instance_init() and/or
>> ->realize() (being careful to make instance_init() not crash if
>> KVM is disabled), and make ->realize() fail if KVM is disabled.
>> IIRC, we did exactly that on x86 a while ago.
>
> Thanks, sounds reasonable. Also sounds like more rework than
> I want to try to write, test and cram into QEMU before freeze
> deadline on Tuesday, so I guess we'll have to wait til after
> 2.9; a pity, but can't be helped.

I remembered this week that I'd completely forgotten that
we should have a go at "cpu max" for ARM in the 2.10 cycle.
Maybe for 2.11 :-)

thanks
-- PMM
