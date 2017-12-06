Received: from eggs.gnu.org ([2001:4830:134:3::10]:44325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMZrh-0006du-P7
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 08:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMZre-0000F1-Lt
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 08:35:57 -0500
References: <20171206120000.63822-1-borntraeger@de.ibm.com>
	<0b60c788-0470-1fa0-390c-472d75aef0dc@redhat.com>
	<8c5f5393-9191-fdae-e852-196163d42d50@de.ibm.com>
	<48792114-6784-249d-0e5f-3b1f1ace7a75@redhat.com>
	<c040f027-54a5-f7d3-0406-e06fd1064fa6@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f54eaa5-4100-ae59-b0fb-8a7faae2749a@redhat.com>
Date: Wed, 6 Dec 2017 14:35:44 +0100
MIME-Version: 1.0
In-Reply-To: <c040f027-54a5-f7d3-0406-e06fd1064fa6@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC] s390x: split memory into 4TB chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/12/2017 13:15, Christian Borntraeger wrote:
>> a) bumping up KVM_MEM_MAX_NR_PAGES makes sense.
> The original limitation comes from the fact that this define is used to limit
> the number of bits in the dirty bitmap as some architectures do not provide
> bitops beyond 2^32.
> 
>> b) as I said, transparently handle it in kvm slot handling code.
> adding Paolo to check what he thinks.

It's a bit of a first-world problem, :) and working around it in QEMU
makes is easy enough that it's okay in my opinion.

Bumping up KVM_MEM_MAX_NR_PAGES if the bitops allows it should be a good
idea too, but it requires auditing the code for overflows and truncations.

Paolo
