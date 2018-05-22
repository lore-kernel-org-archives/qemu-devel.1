Received: from eggs.gnu.org ([2001:4830:134:3::10]:40301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLFQ9-0004vC-HZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLFQ8-0004ti-I4
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:06:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fLFQ8-0004tG-Cj
	for qemu-devel@nongnu.org; Tue, 22 May 2018 18:06:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id m24-v6so325989pls.11
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 15:06:16 -0700 (PDT)
References: <20180522192034.13318-1-pbonzini@redhat.com>
	<724510e7-e739-5f88-b20b-9e27376a3438@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a4ac337-762c-7ad7-5cfe-dfc6554bcc71@redhat.com>
Date: Wed, 23 May 2018 00:06:10 +0200
MIME-Version: 1.0
In-Reply-To: <724510e7-e739-5f88-b20b-9e27376a3438@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: remove softfloat from --disable-tcg
 builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thuth@redhat.com, david@redhat.com

On 22/05/2018 22:53, Richard Henderson wrote:
> On 05/22/2018 12:20 PM, Paolo Bonzini wrote:
>> Even though the presence of softfloat does not cause --disable-tcg builds to fail,
>> it is the single largest .o file in them.  Remove it, since TCG is the only client.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  Makefile.target          |   2 +-
>>  hw/i386/x86-iommu-stub.c | 132 +++++++++++++++++++++++++++++++++++++++
> 
> Assuming this wasn't supposed to be here.

Oops, no it wasn't.  Thanks for the quick review!

Paolo

>>  2 files changed, 133 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/i386/x86-iommu-stub.c
>>
>> diff --git a/Makefile.target b/Makefile.target
>> index d0ec77a307..dad2cf8778 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -97,7 +97,7 @@ obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
>>  obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
>>  obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
>>  obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
>> -obj-y += fpu/softfloat.o
>> +obj-$(CONFIG_TCG) += fpu/softfloat.o
> 
> But for this change alone,
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~
> 
