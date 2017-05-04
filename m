Received: from eggs.gnu.org ([2001:4830:134:3::10]:46921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6DLT-0005Dh-AX
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6DLS-0004X2-NB
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:46:47 -0400
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-10-pbonzini@redhat.com>
	<20170504085546.GA14580@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a9eef055-c98e-ea10-6cfc-e5697c0e7786@redhat.com>
Date: Thu, 4 May 2017 11:46:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170504085546.GA14580@rkaganb.sw.ru>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 09/17] util: add stats64 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/05/2017 10:55, Roman Kagan wrote:
> On Thu, Apr 20, 2017 at 02:00:50PM +0200, Paolo Bonzini wrote:
>> This module provides fast paths for 64-bit atomic operations on machines
>> that only have 32-bit atomic access.
> 
>> --- /dev/null
>> +++ b/include/qemu/stats64.h
> [...]
>> +#ifndef STAT64_NEED_SPINLOCK
> [...]
>> +static inline void stat64_min(Stat64 *s, uint32_t value)
>                                                 ^^
> 				       typo or intentional?

Typo.

Thanks,

Paolo
