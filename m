Received: from eggs.gnu.org ([209.51.188.92]:52739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpGdt-0001sk-Of
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpGds-0006vf-R5
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:00:49 -0500
References: <1548956828-10210-1-git-send-email-thuth@redhat.com>
	<20190131185621.28815291.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <538ee62b-293d-f053-4bd2-76bf166388e1@redhat.com>
Date: Thu, 31 Jan 2019 19:00:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190131185621.28815291.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Fix the function arguments in
 the pci stub file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-31 18:56, Cornelia Huck wrote:
> On Thu, 31 Jan 2019 18:47:08 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The arguments of the stub functions to not match the real implementation
> 
> s/to/do/

D'oh!

>> (and the prototypes in the header) anymore, so if you try to compile s390x
>> without CONFIG_PCI, the build currently fails.
>>
> 
> Fixes: 468a93898a97 ("s390x/pci: pass the retaddr to all PCI instructions")
> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/s390x/s390-pci-stub.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> This file seems to be in danger of bitrot. Do you think it'll be easier
> to test rarely used configs like that after we switch to Kconfig?

I hope so, yes. There will be a new --without-default-devices options
for "configure" (which matches "make allnoconfig" from the kernel) - if
we do it right in the Kconfig file for s390x, it should be possible to
catch this problem with that option.

 Thomas
