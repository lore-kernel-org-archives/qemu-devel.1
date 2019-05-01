Received: from eggs.gnu.org ([209.51.188.92]:35626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLrGc-0000gm-Mg
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLrGY-0006dc-DX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:35:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLrGY-0006d1-7Q
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:35:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so16485698wrs.2
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:35:26 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190430181326.1314-1-driver1998@foxmail.com>
	<c794f5a4-470a-3f49-c5df-bd37d97d711a@redhat.com>
Message-ID: <4c1ceb10-4dfa-7173-0a7e-1af919154fbd@redhat.com>
Date: Wed, 1 May 2019 17:35:23 +0200
MIME-Version: 1.0
In-Reply-To: <c794f5a4-470a-3f49-c5df-bd37d97d711a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] util/cacheinfo.c: Use uintptr_t
 instead of unsigned long in AArch64 arch_cache_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>

On 4/30/19 9:12 PM, Philippe Mathieu-Daudé wrote:
> On 4/30/19 8:13 PM, Cao Jiaxi wrote:
>> Windows ARM64 uses LLP64 model, which breaks current assumptions.
>>
>> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
>> ---
>>  util/cacheinfo.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
>> index 3cd080b83d..ce6f0dbf6a 100644
>> --- a/util/cacheinfo.c
>> +++ b/util/cacheinfo.c
>> @@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
>>  static void arch_cache_info(int *isize, int *dsize)
>>  {
>>      if (*isize == 0 || *dsize == 0) {
>> -        unsigned long ctr;
>> +        uintptr_t ctr;
>>  
>>          /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
>>             but (at least under Linux) these are marked protected by the
>>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

Maybe you can use a shorter commit subject, such "util/cacheinfo: Use
uintptr_t on LLP64 model to satisfy Windows ARM64" (or better), so it
won't be cut in git log (limited to 72 chars).
