Received: from eggs.gnu.org ([209.51.188.92]:52870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grN4c-0000Sd-4p
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grMqm-0007Bv-Ij
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:02:49 -0500
References: <1549456893-16589-1-git-send-email-thuth@redhat.com>
	<20190206135840.60a2a49f.cohuck@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <52b3de29-6918-952d-9d91-abdfb6dba25b@vivier.eu>
Date: Wed, 6 Feb 2019 14:02:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190206135840.60a2a49f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: Fix the confusing
 contributions-after-2012 license statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 06/02/2019 13:58, Cornelia Huck wrote:
> On Wed,  6 Feb 2019 13:41:33 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The license information in these files is rather confusing. The text
>> declares LGPL first, but then says that contributions after 2012 are
>> licensed under the GPL instead. How should the average user who just
>> downloaded the release tarball know which part is now GPL and which
>> is LGPL?
> 
> FWIW, that statement was added in ccb084d3f0ec ("s390: new
> contributions GPLv2 or later").
> 
>>
>> Looking at the text of the LGPL (see COPYING.LIB in the top directory),
>> the license clearly states how this should be done instead:
>>
>> "3. You may opt to apply the terms of the ordinary GNU General Public
>>  License instead of this License to a given copy of the Library. To do
>>  this, you must alter all the notices that refer to this License, so
>>  that they refer to the ordinary GNU General Public License, version 2,
>>  instead of to this License."
> 
> Hm. This talks about GPL v2, not GPL v2-or-later...
> 
>>
>> Thus let's clean up the confusing statements and use the proper GPL
>> text only.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  linux-user/s390x/target_cpu.h | 19 ++++++++-----------
>>  target/s390x/cpu.c            | 19 ++++++++-----------
>>  target/s390x/cpu.h            | 19 ++++++++-----------
>>  target/s390x/kvm.c            | 19 ++++++++-----------
> 
> BTW: Is the original author of the code still around?

For the linux-user/s390x/target_cpu.h, it seems this code has been pushed by Alex Graf:

commit 10ec51174ca69a4c3c5149b0b3baaa6ccba66273
Author: Alexander Graf <agraf@suse.de>
Date:   Sat Dec 5 12:44:21 2009 +0100

    S/390 CPU fake emulation
    
    Because Qemu currently requires a TCG target to exist and there are quite some
    useful helpers here to lay the groundwork for out KVM target, let's create a
    stub TCG emulation target for S390X CPUs.
    
    This is required to make tcg happy. The emulation target itself won't work
    though.
    
    Signed-off-by: Alexander Graf <agraf@suse.de>
    Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

But the "(c) 2009 Ulrich Hecht" is confusing.

Laurent
