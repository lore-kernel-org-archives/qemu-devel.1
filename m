Received: from eggs.gnu.org ([2001:4830:134:3::10]:55051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQqW8-0000ni-GB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQqW5-0003Fc-BH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:11:20 -0500
References: <151350631739.45.12182008427471484789@5adcb62bf0d6>
	<766e1250-9930-3af7-099c-29fafd37c270@weilnetz.de>
	<f358f063-dcb7-84c5-97c6-010618a6e24d@redhat.com>
	<f08aa70b-2088-591d-2c5e-ce391c30409e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2c10c94b-d946-db35-88b6-132f2eaa9811@redhat.com>
Date: Mon, 18 Dec 2017 09:11:03 +0100
MIME-Version: 1.0
In-Reply-To: <f08aa70b-2088-591d-2c5e-ce391c30409e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: Add missing
 QEMU_NORETURN attribute (CID 1383842)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, famz@redhat.com, agraf@suse.de, rth@twiddle.net

On 18.12.2017 09:05, David Hildenbrand wrote:
> 
>>> Or we could suppress the s390x compiler warning by using a compiler
>>> pragma. But I don't like that alternative.
>>
>> I think the best solution would be to call tcg_s390_program_interrupt()
>> directly from helper_divs64() instead of going through the
>> s390_program_interrupt() wrapper. helper_divs64() is for TCG only, so it
>> should be fine to directly use the tcg_s390_program_interrupt() function
>> there.
> 
> If there is not a good reason, I'd prefer to have only one function for
> injecting program interrupts. (adding 3 return statements looks IMHO
> nicer).

Agreed, that also makes the source code a little bit easier to read (you
don't have to look up that tcg_s390_program_interrupt() is marked as
noreturn this way).

 Thomas
