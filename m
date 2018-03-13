Received: from eggs.gnu.org ([2001:4830:134:3::10]:56970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evpEb-0002iK-Ct
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evpEX-0004Ac-9F
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:05:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evpEX-0004AA-2A
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:05:13 -0400
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-9-brijesh.singh@amd.com>
	<20180308164910.GF4718@redhat.com>
	<e39191c3-9c83-8c44-f1d2-9fa7a2f7695d@amd.com>
	<20180308224412.GF3417@localhost.localdomain>
	<8cf2f9bc-0339-1c80-b53b-ef5915248d1f@redhat.com>
	<20180313184950.GB3417@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <253374a3-0d09-a29a-94fc-ea4f5718f477@redhat.com>
Date: Tue, 13 Mar 2018 20:04:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180313184950.GB3417@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 08/28] target/i386: add Secure
 Encrypted Virtulization (SEV) object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Bruce Rogers <brogers@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Borislav Petkov <bp@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 13/03/2018 19:49, Eduardo Habkost wrote:
>>>
>>> Exactly, in other words these two options are part of the guest
>>> ABI, and QEMU promises to never make the guest ABI depend on the
>>> host hardware unless you're using "-cpu host".
>>
>> This is not entirely true; while MAXPHYADDR is constant downstream
>> unless using "-cpu host", in practice that behavior is wrong and a guest
>> could misbehave if passed a MAXPHYADDR that is different from the host's.
>>
>> I think this is the same, and management software will have to live with it.
> 
> I think they are very far from being equivalent.

Right, I only meant to say that guest ABI actually does depend on the
host hardware, even outside of "-cpu host".

> But if you tell the guest the wrong C-bit location, guests are
> likely to rely on it and break.  Migration between hosts with
> different C-bit locations won't work, will it?

It won't---but as long as the destination hosts fails fast when the
C-bit location is wrong, it's okay.  What matters is that we don't run
guest code with the wrong C bit, as you noted.

Paolo
