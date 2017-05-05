Received: from eggs.gnu.org ([2001:4830:134:3::10]:44241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6Xw3-0003kx-Ps
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6Xw0-0000by-Pn
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:45:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6Xw0-0000bq-J2
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:45:52 -0400
References: <20170504145658.5506-1-berrange@redhat.com>
	<20170504184241.GB3482@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5014609b-b009-5919-185c-abb96b030c97@redhat.com>
Date: Fri, 5 May 2017 09:45:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170504184241.GB3482@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] i386: expose "TCGTCGTCGTCG" in the
 0x40000000 CPUID leaf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, "Richard W.M. Jones" <rjones@redhat.com>



On 04/05/2017 20:42, Eduardo Habkost wrote:
> 
>> NB2, for KVM, we added a flag for '-cpu kvm=off' to let you
>> hide the KVMKVMKVM signature from guests. Presumably we should
>> add a 'tcg=off' flag for the same reason ?
> I don't like "kvm=off" because it sounds like it disables KVM
> completely. "tcg=off" would be misleading as well.
> 
> What about a generic "hypervisor-cpuid=off" property?

Yeah, it should also disable the CPUID_EXT_HYPERVISOR feature, in fact.

Paolo
