Received: from eggs.gnu.org ([2001:4830:134:3::10]:46739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcoT-0005j4-Rb
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcoQ-0005sm-Iy
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:29:21 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:45975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwcoQ-0005sU-Dm
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:29:18 -0400
Received: by mail-pg0-x229.google.com with SMTP id 188so4896283pgb.2
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:29:18 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9599545c-7305-430a-b5e1-d0192a05e484@linaro.org>
Date: Mon, 25 Sep 2017 16:29:14 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 11/27] s390x/kvm: generalize SIGP stop
 and restart interrupt injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/18/2017 08:59 AM, David Hildenbrand wrote:
> Preparation for factoring it out into !kvm code.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/internal.h  |  2 ++
>  target/s390x/interrupt.c | 20 ++++++++++++++++++++
>  target/s390x/kvm-stub.c  |  8 ++++++++
>  target/s390x/kvm.c       | 33 +++++++++++++++++++++------------
>  target/s390x/kvm_s390x.h |  2 ++
>  5 files changed, 53 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
