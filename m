Received: from eggs.gnu.org ([2001:4830:134:3::10]:55235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTYvl-0008UE-Op
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTYvl-0008DU-1n
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:33:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180614164431.29305-1-stefanha@redhat.com>
	<5768e8f3-eae5-30ef-888a-5e62692c238d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c5c1f362-d51d-df1e-c1dd-f57b64c3f1a1@amsat.org>
Date: Thu, 14 Jun 2018 17:33:04 -0300
MIME-Version: 1.0
In-Reply-To: <5768e8f3-eae5-30ef-888a-5e62692c238d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] compiler: add a sizeof_field() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org

On 06/14/2018 04:17 PM, John Snow wrote:
> On 06/14/2018 12:44 PM, Stefan Hajnoczi wrote:
>> Determining the size of a field is useful when you don't have a struct
>> variable handy.  Open-coding this is ugly.
>>
>> This patch adds the sizeof_field() macro, which is similar to
>> typeof_field().  Existing instances are updated to use the macro.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> How'd you find all the existing instances?

This works:

$ git grep -E 'sizeof.*)0)->'

> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
>> ---
>>  include/hw/xen/io/ring.h      |  2 +-
>>  include/qemu/compiler.h       |  2 ++
>>  accel/tcg/translate-all.c     |  2 +-
>>  hw/display/xenfb.c            |  4 ++--
>>  hw/net/rocker/rocker_of_dpa.c |  2 +-
>>  hw/net/virtio-net.c           |  2 +-
>>  target/i386/kvm.c             |  2 +-
>>  target/ppc/arch_dump.c        | 10 +++++-----
>>  target/s390x/arch_dump.c      | 20 ++++++++++----------
>>  9 files changed, 24 insertions(+), 22 deletions(-)
