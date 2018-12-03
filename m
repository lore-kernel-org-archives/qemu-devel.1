Received: from eggs.gnu.org ([2001:4830:134:3::10]:52939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTp1s-0004GK-Di
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTp1o-0006YP-9a
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:16:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gTp1n-0006WJ-Eq
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:16:52 -0500
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-3-git-send-email-thuth@redhat.com>
	<daefe1bb-2da4-a7ab-5e2f-798db6c5f353@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <945ff81d-1b71-021f-7c0d-eceda08705c2@redhat.com>
Date: Mon, 3 Dec 2018 15:16:47 +0100
MIME-Version: 1.0
In-Reply-To: <daefe1bb-2da4-a7ab-5e2f-798db6c5f353@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/7] Remove support for compilers
 that can not do 128-bit arithmetics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org

On 2018-12-03 15:11, Richard Henderson wrote:
> On 12/3/18 8:05 AM, Thomas Huth wrote:
>> +++ b/include/qemu/host-utils.h
>> @@ -28,7 +28,6 @@
>>  
>>  #include "qemu/bswap.h"
>>  
>> -#ifdef CONFIG_INT128
>>  static inline void mulu64(uint64_t *plow, uint64_t *phigh,
>>                            uint64_t a, uint64_t b)
>>  {
>> @@ -76,35 +75,6 @@ static inline int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
>>          return result != *plow;
>>      }
>>  }
>> -#else
>> -void muls64(uint64_t *phigh, uint64_t *plow, int64_t a, int64_t b);
>> -void mulu64(uint64_t *phigh, uint64_t *plow, uint64_t a, uint64_t b);
> 
> No, because __int128 support requires a 64-bit host.
> This will not compile for a 32-bit host.

Oops, my bad, you're right, of course. This would have been too easy, I
guess ... So it seems that the only thing that we could do here is to
get rid of the Clang version check in the configure script...

 Thomas
