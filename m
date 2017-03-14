Received: from eggs.gnu.org ([2001:4830:134:3::10]:55354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnq2O-0003e8-3L
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnq2J-0001mg-7L
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:15:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnq2J-0001mJ-1T
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:15:03 -0400
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica> <20170314160113.GM2445@work-vm>
	<20170314162020.GT2652@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20a2953d-b911-094a-35da-ee71be05ba6f@redhat.com>
Date: Tue, 14 Mar 2017 18:14:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170314162020.GT2652@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>



On 14/03/2017 17:20, Daniel P. Berrange wrote:
>> I also do a FreeBSD VM, and grab an aarch64 and/or PPC bigendian host
>> to test on.
>>
>> (I could grab an ia64 host, but I don't think I could find anything
>> to install on it that would be new enough for the rest of our build
>> requirements).
>
> Indeed, ia64 is a fully dead as a host architecture at this point, only
> interesting as a historical curiosity. Paolo already killed ia64 KVM
> host support in Linux git back in 2014.

QEMU also never supported ia64 KVM, only qemu-kvm ever did.

Paolo
