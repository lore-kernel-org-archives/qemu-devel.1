Received: from eggs.gnu.org ([2001:4830:134:3::10]:56380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMFTD-0004hm-LA
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gMFT9-0003zk-N0
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:53:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gMFT9-0003xt-CL
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:53:47 -0500
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<20181102165409.GF21191@redhat.com>
	<f58da4e8-aa40-2659-8db6-42c2b47f5b2f@redhat.com>
	<20181112161829.GU3602@redhat.com> <20181112165053.GF2293@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81d4f6c0-ede1-8986-8d7f-1741fc6de18a@redhat.com>
Date: Mon, 12 Nov 2018 17:53:38 +0100
MIME-Version: 1.0
In-Reply-To: <20181112165053.GF2293@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>, jmattson@google.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On 12/11/2018 17:50, Dr. David Alan Gilbert wrote:
>> Migration has always been busted historically, so those people using
>> nested VMX already won't be hurt by not having ability to live migrate
>> their VM, but could otherwise continue using them without being forced
>> to upgrade their kernel to fix a feature they're not even using.
> Yes, although I am a bit worried we might have a population of users
> that:
>    a) Have enabled nesting
>    b) Run VMs with vmx enabled
>    c) Don't normally actually run nested guests
>    d) Currently happily migrate.

Hmm, let's add a migration blocker for nested virtualization.

Paolo
