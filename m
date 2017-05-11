Received: from eggs.gnu.org ([2001:4830:134:3::10]:36950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1d8tYy-0000Qd-PC
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1d8tYx-0004oa-C4
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:15:48 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:34013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1d8tYx-0004mA-5e
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:15:47 -0400
Received: by mail-oi0-x22b.google.com with SMTP id b204so42125566oii.1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 12:15:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170511181703.GC8701@stefanha-x1.localdomain>
References: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
	<20170511181703.GC8701@stefanha-x1.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 May 2017 12:15:43 -0700
Message-ID: <CAPcyv4irL+imcaWBtHox9oUatndpRw-3xfxtTcn1NV58iph+og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] KVM "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, KVM list <kvm@vger.kernel.org>, qemu-devel@nongnu.org, Rik van Riel <riel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kwolf@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Thu, May 11, 2017 at 11:17 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Wed, May 10, 2017 at 09:26:00PM +0530, Pankaj Gupta wrote:
>> We are sharing initial project proposal for
>> 'KVM "fake DAX" device flushing' project for feedback.
>> Got the idea during discussion with 'Rik van Riel'.
>
> CCing NVDIMM folks.
>
>>
>> Also, request answers to 'Questions' section.
>>
>> Abstract :
>> ----------
>> Project idea is to use fake persistent memory with direct
>> access(DAX) in virtual machines. Overall goal of project
>> is to increase the number of virtual machines that can be
>> run on a physical machine, in order to increase the density
>> of customer virtual machines.
>>
>> The idea is to avoid the guest page cache, and minimize the
>> memory footprint of virtual machines. By presenting a disk
>> image as a nvdimm direct access (DAX) memory region in a
>> virtual machine, the guest OS can avoid using page cache
>> memory for most file accesses.

How is this different than the solution that Clear Containers came up with?

https://lwn.net/Articles/644675/
