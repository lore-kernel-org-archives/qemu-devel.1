Received: from eggs.gnu.org ([2001:4830:134:3::10]:50769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRaAv-0002zJ-5p
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRaAs-000361-Fi
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:56:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRaAs-00035P-8G
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:56:26 -0500
References: <20171124073417.4342-1-peterx@redhat.com>
	<20171220031349.GD22308@xz-mi>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3a9925d-65cf-1743-abc1-9061e674ae46@redhat.com>
Date: Wed, 20 Dec 2017 09:56:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171220031349.GD22308@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] cpu: suffix cpu address spaces with
 indexes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 20/12/2017 04:13, Peter Xu wrote:
> On Fri, Nov 24, 2017 at 03:34:14PM +0800, Peter Xu wrote:
>> v2:
>> - drop patch 1 since merged
>> - add last patch as suggested by Paolo
>>
>> Please review, thanks.
> 
> Ping for 2.12 dev window.

Already queued. :)

Paolo

>>
>> Peter Xu (3):
>>   cpu: refactor cpu_address_space_init()
>>   cpu: suffix cpu address spaces with cpu index
>>   cpu: put AddressSpace into CPUAddressSpace
>>
>>  cpus.c                  |  5 +----
>>  exec.c                  | 41 ++++++++++++++++++++++++++---------------
>>  include/exec/exec-all.h |  6 ++++--
>>  target/arm/cpu.c        | 13 +++----------
>>  target/i386/cpu.c       | 10 ++--------
>>  5 files changed, 36 insertions(+), 39 deletions(-)
>>
>> -- 
>> 2.14.3
>>
> 
