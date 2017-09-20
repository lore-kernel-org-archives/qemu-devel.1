Received: from eggs.gnu.org ([2001:4830:134:3::10]:43002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dufCa-0003jT-KX
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dufCU-0002MR-OB
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:38:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dufCU-0002Lg-Gx
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:38:02 -0400
References: <20170919142654.16369-1-david@redhat.com>
	<20170919142654.16369-4-david@redhat.com>
	<452a304a-70e4-c3ab-2e76-a67823922e90@linaro.org>
	<8bc7cb17-522a-48ea-5818-12bdbfb37d70@redhat.com>
	<3e21fee6-4560-a3c9-926a-165a6212b1ef@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aee44e68-84e7-fa88-5be1-70e078e00b1d@redhat.com>
Date: Wed, 20 Sep 2017 15:37:57 +0200
MIME-Version: 1.0
In-Reply-To: <3e21fee6-4560-a3c9-926a-165a6212b1ef@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] s390x/tcg: add basic MSA features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 20.09.2017 15:23, Richard Henderson wrote:
> On 09/19/2017 02:36 PM, David Hildenbrand wrote:
>> On 19.09.2017 19:47, Richard Henderson wrote:
>>> On 09/19/2017 09:26 AM, David Hildenbrand wrote:
>>>> +    const uint8_t fc = env->regs[0] & 0x7fULL;
>>>
>>> Don't mask here...
>>
>> Bit 56 is the mod bit (see variable "mod") and is checked inside the
>> switch(). The function code really is just composed of bit 57 - 63, so
>> this is correct.
> 
> "mod bit"?
> 
>   # Bit 56 of general register 0 must be zero; oth-
>   # erwise, a specification exception is recognized.
> 
> I don't suppose this is a change in PoO v11?  I'm still looking at v10.
> 

I'm also looking at v10.

This bit is called "M" bit for all cpacf instructions that allow
en/decryption. M == modifier bit == mod bit == bit 56

e.g. for KM (7-56)

"When the modifier bit in general register 0 is one, a
decipher operation is performed. ...".

For instructions that don't allow switching between de/encryption (e.g.
KLMD), the modifier bit a.k.a. bit 56 must not be set.

I don't really see the need here to rename mod -> bit_56 here.

Thank!

-- 

Thanks,

David
