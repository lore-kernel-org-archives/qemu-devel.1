Received: from eggs.gnu.org ([2001:4830:134:3::10]:36837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziLw-0007xu-TH
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziEL-0002wj-C7
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:57:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fziEL-0002wU-4q
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:57:21 -0400
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-2-cota@braap.org>
	<cc3875ff-6cf0-b539-611a-9060d09624c7@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b708b8d5-ce03-1110-e3a6-b95de0500906@redhat.com>
Date: Tue, 11 Sep 2018 14:57:18 +0200
MIME-Version: 1.0
In-Reply-To: <cc3875ff-6cf0-b539-611a-9060d09624c7@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/12] cacheinfo: add i/d
 cache_linesize_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 11/09/2018 14:16, Richard Henderson wrote:
> On 09/10/2018 04:27 PM, Emilio G. Cota wrote:
>> @@ -173,5 +176,7 @@ static void __attribute__((constructor)) init_cache_info(void)
>>      fallback_cache_info(&isize, &dsize);
>>  
>>      qemu_icache_linesize = isize;
>> +    qemu_icache_linesize_log = 31 - clz32(isize);
>>      qemu_dcache_linesize = dsize;
>> +    qemu_dcache_linesize_log = 31 - clz32(dsize);
> 
> Either pow2ceil or realize that linesize is already a power of 2 and use ctz32.

Changed to ctz32.

Paolo
