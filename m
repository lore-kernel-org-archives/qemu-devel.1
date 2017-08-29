Received: from eggs.gnu.org ([2001:4830:134:3::10]:51424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dmUJ3-0007g5-9F
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dmUJ0-00014m-4T
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:23:01 -0400
Message-ID: <59A4B3BD.6030505@huawei.com>
Date: Tue, 29 Aug 2017 08:22:21 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <20170828113737.12199-1-f4bug@amsat.org>
	<59A4B375.7040307@huawei.com>
In-Reply-To: <59A4B375.7040307@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: fix incorrect size_t format in
 benchmark-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org



On 2017/8/29 8:21, Longpeng (Mike) wrote:

> 
> 
> On 2017/8/28 19:37, Philippe Mathieu-Daudé wrote:
> 
>>   $ make check-speed
>>   tests/benchmark-crypto-hash.c: In function 'test_hash_speed':
>>   tests/benchmark-crypto-hash.c:44:5: error: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' [-Werror=format=]
>>        g_print("Testing chunk_size %ld bytes ", chunk_size);
>>        ^
>>   tests/benchmark-crypto-hash.c: In function 'main':
>>   tests/benchmark-crypto-hash.c:62:9: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' [-Werror=format=]
>>            snprintf(name, sizeof(name), "/crypto/hash/speed-%lu", i);
>>            ^
>>   cc1: all warnings being treated as errors
>>   rules.mak:66: recipe for target 'tests/benchmark-crypto-hash.o' failed
>>   make: *** [tests/benchmark-crypto-hash.o] Error 1
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> 
> Reviewed-by: Longpeng(Mike) <longpeng@@huawei.com>
> 


Sorry, s/@/2/

Reviewed-by: Longpeng(Mike) <longpeng2@huawei.com>

>> ---
>> testing v2.10.0-rc4
>>
>>  tests/benchmark-crypto-cipher.c | 4 ++--
>>  tests/benchmark-crypto-hash.c   | 4 ++--
>>  tests/benchmark-crypto-hmac.c   | 4 ++--
>>  3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cipher.c
>> index c6a40929e4..cf98443468 100644
>> --- a/tests/benchmark-crypto-cipher.c
>> +++ b/tests/benchmark-crypto-cipher.c
>> @@ -59,7 +59,7 @@ static void test_cipher_speed(const void *opaque)
>>      total /= 1024 * 1024; /* to MB */
>>  
>>      g_print("cbc(aes128): ");
>> -    g_print("Testing chunk_size %ld bytes ", chunk_size);
>> +    g_print("Testing chunk_size %zu bytes ", chunk_size);
>>      g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
>>      g_print("%.2f MB/sec\n", total / g_test_timer_last());
>>  
>> @@ -80,7 +80,7 @@ int main(int argc, char **argv)
>>  
>>      for (i = 512; i <= (64 * 1204); i *= 2) {
>>          memset(name, 0 , sizeof(name));
>> -        snprintf(name, sizeof(name), "/crypto/cipher/speed-%lu", i);
>> +        snprintf(name, sizeof(name), "/crypto/cipher/speed-%zu", i);
>>          g_test_add_data_func(name, (void *)i, test_cipher_speed);
>>      }
>>  
>> diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.c
>> index 6769d2a11b..122bfb6b85 100644
>> --- a/tests/benchmark-crypto-hash.c
>> +++ b/tests/benchmark-crypto-hash.c
>> @@ -41,7 +41,7 @@ static void test_hash_speed(const void *opaque)
>>  
>>      total /= 1024 * 1024; /* to MB */
>>      g_print("sha256: ");
>> -    g_print("Testing chunk_size %ld bytes ", chunk_size);
>> +    g_print("Testing chunk_size %zu bytes ", chunk_size);
>>      g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
>>      g_print("%.2f MB/sec\n", total / g_test_timer_last());
>>  
>> @@ -59,7 +59,7 @@ int main(int argc, char **argv)
>>  
>>      for (i = 512; i <= (64 * 1204); i *= 2) {
>>          memset(name, 0 , sizeof(name));
>> -        snprintf(name, sizeof(name), "/crypto/hash/speed-%lu", i);
>> +        snprintf(name, sizeof(name), "/crypto/hash/speed-%zu", i);
>>          g_test_add_data_func(name, (void *)i, test_hash_speed);
>>      }
>>  
>> diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.c
>> index 72408be987..c30250df3e 100644
>> --- a/tests/benchmark-crypto-hmac.c
>> +++ b/tests/benchmark-crypto-hmac.c
>> @@ -56,7 +56,7 @@ static void test_hmac_speed(const void *opaque)
>>      total /= 1024 * 1024; /* to MB */
>>  
>>      g_print("hmac(sha256): ");
>> -    g_print("Testing chunk_size %ld bytes ", chunk_size);
>> +    g_print("Testing chunk_size %zu bytes ", chunk_size);
>>      g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
>>      g_print("%.2f MB/sec\n", total / g_test_timer_last());
>>  
>> @@ -74,7 +74,7 @@ int main(int argc, char **argv)
>>  
>>      for (i = 512; i <= (64 * 1204); i *= 2) {
>>          memset(name, 0 , sizeof(name));
>> -        snprintf(name, sizeof(name), "/crypto/hmac/speed-%lu", i);
>> +        snprintf(name, sizeof(name), "/crypto/hmac/speed-%zu", i);
>>          g_test_add_data_func(name, (void *)i, test_hmac_speed);
>>      }
>>  
> 
> 


-- 
Regards,
Longpeng(Mike)
