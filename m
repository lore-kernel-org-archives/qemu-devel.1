Received: from eggs.gnu.org ([2001:4830:134:3::10]:38239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLX7a-0007wy-Q5
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLX7V-0002wG-Qe
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:55:46 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLX7V-0002vy-L7
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 11:55:41 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so4024135qtg.3
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 08:55:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170615055356.20684-1-rth@twiddle.net>
	<20170615055356.20684-6-rth@twiddle.net>
	<8799c130-96d1-b9c0-5cee-dd1c81047273@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6d705716-4f68-3e17-1279-f6d2b64548b9@twiddle.net>
Date: Thu, 15 Jun 2017 08:55:36 -0700
MIME-Version: 1.0
In-Reply-To: <8799c130-96d1-b9c0-5cee-dd1c81047273@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] target/s390x: mark CSST, CSST2,
 FPSEH facilities as available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, david@redhat.com

On 06/15/2017 02:02 AM, Thomas Huth wrote:
> On 15.06.2017 07:53, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   target/s390x/cpu_models.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index c3a4ce6..703feca 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -683,8 +683,11 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
>>           S390_FEAT_ETF2_ENH,
>>           S390_FEAT_STORE_CLOCK_FAST,
>>           S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
>> +        S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
>> +        S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
> 
> Do we really support the CSST instruction in TCG already (Opcode
> 0xc802)? I did not spot it in the source code yet...?

Whoops.  No indeed.  I claim late-ness of the hour.

On the other hand, it shouldn't be difficult to implement...


r~
