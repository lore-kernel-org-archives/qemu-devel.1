Received: from eggs.gnu.org ([2001:4830:134:3::10]:47786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fW2w7-0005BY-Ab
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fW2w4-0001JL-9m
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:59:55 -0400
References: <20180424101859.10239-1-david@redhat.com>
	<7c046e3c-8752-87c5-f4ff-06ef56ef0128@de.ibm.com>
	<20180621180443.1f0dc588.cohuck@redhat.com>
	<0c3f3ee4-f8b9-8781-6ad5-31dd7753a2c4@de.ibm.com>
	<eda9ada5-1fdd-1652-6cc8-0a3592dbf996@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b73a7220-62a2-4e85-0268-cd6c40ca3b24@redhat.com>
Date: Thu, 21 Jun 2018 18:59:45 +0200
MIME-Version: 1.0
In-Reply-To: <eda9ada5-1fdd-1652-6cc8-0a3592dbf996@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 21/06/2018 18:08, David Hildenbrand wrote:
>> Without this we have no kdump/kexec/ipl
>> as soon as somebody uses -no-reboot.
>>
> Paolo even said that consistent -no-reboot handling would be one of the
> benefits :)
> 

kdump/kexec (and of course "ipl") do not reboot on x86, so fixing the
bug does help in making things consistent. :)

Do we really want a reset event for ipl?  Maybe for kexec/kdump, but
perhaps just using SHUTDOWN_CAUSE_NONE for MODIFIED_CLEAR and
LOAD_NORMAL (not sure about the difference) is the way to go.

For example, x86 suspend is a "reboot" but it is already special cased
to use SHUTDOWN_CAUSE_NONE.

Paolo
