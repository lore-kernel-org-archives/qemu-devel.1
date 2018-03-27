Received: from eggs.gnu.org ([2001:4830:134:3::10]:50368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0v2l-00067v-T0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0v2i-00085s-Oz
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:18:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f0v2i-00085a-Jl
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:18:04 -0400
References: <20180327113452.19613-1-dgilbert@redhat.com>
	<20180327113452.19613-4-dgilbert@redhat.com>
	<0bfadead-a3c2-9bce-3e53-8ca3a258a57a@redhat.com>
	<20180327164753.GF2837@work-vm>
	<8c238385-5cab-2c7d-6550-d6d0866570eb@redhat.com>
	<20180327180115.GH2837@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66a2b6b9-0231-bd32-10cd-81117fd06725@redhat.com>
Date: Tue, 27 Mar 2018 22:17:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180327180115.GH2837@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] e1000: Old machine types,
 turn new subsection off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, eswierk@skyportsystems.com, jasowang@redhat.com, peterx@redhat.com, quintela@redhat.com

On 27/03/2018 20:01, Dr. David Alan Gilbert wrote:
>> New->old migration will place tx_legacy_vmstate_props in tx.props on the
>> destination; new->new will realize the subsection was transmitted and
>> ignore the tx_legacy_vmstate_props; old->new will not find data from the
>> subsection and copy the tx_legacy_vmstate_props into one of tx.props and
>> tx.tso_props.
> Yeh, adding a legacy_props field should do it; although we never need
> to transmit more than 2 copies.  
> 
> I'll look at this more tomorrow; I am a bit worried about testing it
> though.

Yes, I'm also afraid that we can't really do much better than careful
code review.

Paolo
