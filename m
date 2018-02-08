Received: from eggs.gnu.org ([2001:4830:134:3::10]:42319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ejnXh-000246-OB
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ejnXd-00016i-UC
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:51:17 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:54989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ejnXd-00015z-M9
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:51:13 -0500
Received: by mail-wm0-x235.google.com with SMTP id i186so9943875wmi.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:51:13 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAPUexz9mg8wtAkWKfQLqoFgTQ6i+2pC4bGSkTwCEq-nQZin1hg@mail.gmail.com>
	<20180207153106.w3guxswbj6tciczc@eukaryote>
	<4abbf785-5df3-584a-8743-825c7435c2a2@redhat.com>
	<CAPUexz-9fFGJaV15Pwg+=OLvLmZgPWnrtPMet6uAcBm1ztqtNw@mail.gmail.com>
	<f8466a41-b86d-cd2f-03ea-3fbf9f3b5650@redhat.com>
	<CAPUexz_ENYsz9jPso26JGum5FpR0B=rBoC8MheRfjG=eLKt9dg@mail.gmail.com>
	<09b9a576-b4d1-6142-b88e-c59ee062cd1d@redhat.com>
	<CAPUexz-2Kt6orEskhGuJk82Y9D6HU7GJordVo0eKsB5=7VJpMg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <895301a7-4d89-6d39-6340-a9df5fe7453c@redhat.com>
Date: Thu, 8 Feb 2018 15:51:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAPUexz-2Kt6orEskhGuJk82Y9D6HU7GJordVo0eKsB5=7VJpMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt-users] Nested KVM: L0 guest produces
 kernel BUG on wakeup from managed save (while a nested VM is running)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Haas <florian@hastexo.com>, qemu-devel <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>

On 08/02/2018 14:57, Florian Haas wrote:
>>>     <feature policy='disable' name='vme'/>
>>>     <feature policy='disable' name='ss'/>
>>>     <feature policy='disable' name='f16c'/>
>>>     <feature policy='disable' name='rdrand'/>
>>>     <feature policy='disable' name='hypervisor'/>
>>>     <feature policy='disable' name='arat'/>
>>>     <feature policy='disable' name='tsc_adjust'/>
>>>     <feature policy='disable' name='xsaveopt'/>
>>>     <feature policy='disable' name='abm'/>
>>>     <feature policy='disable' name='aes'/>
>>>     <feature policy='disable' name='invpcid'/>
>>> </cpu>
>> Maybe one of these features is the root cause of the "messed up" state
>> in KVM. So disabling it also makes the L1 state "less broken".
> 
> Would you try a guess as to which of the above features is a likely culprit?

You're just being lucky. :)

In fact, if you every migrate or save a VM that's running in L2, you
would get an unholy mixture of source L1 and source L2 state running on
the destination *as L1* (because the destination doesn't know it's
running a nested guest!).  It just cannot work yet---sorry about that!

Paolo
