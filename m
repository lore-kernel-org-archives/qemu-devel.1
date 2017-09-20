Received: from eggs.gnu.org ([2001:4830:134:3::10]:33303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duezh-00012M-7p
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dueyc-0001Ki-TH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:24:49 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:49394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dueyY-0001Bc-7P
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:23:42 -0400
Received: by mail-oi0-x22f.google.com with SMTP id t21so2552489oih.6
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:23:37 -0700 (PDT)
References: <20170919142654.16369-1-david@redhat.com>
	<20170919142654.16369-4-david@redhat.com>
	<452a304a-70e4-c3ab-2e76-a67823922e90@linaro.org>
	<8bc7cb17-522a-48ea-5818-12bdbfb37d70@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e21fee6-4560-a3c9-926a-165a6212b1ef@linaro.org>
Date: Wed, 20 Sep 2017 08:23:32 -0500
MIME-Version: 1.0
In-Reply-To: <8bc7cb17-522a-48ea-5818-12bdbfb37d70@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 09/19/2017 02:36 PM, David Hildenbrand wrote:
> On 19.09.2017 19:47, Richard Henderson wrote:
>> On 09/19/2017 09:26 AM, David Hildenbrand wrote:
>>> +    const uint8_t fc = env->regs[0] & 0x7fULL;
>>
>> Don't mask here...
> 
> Bit 56 is the mod bit (see variable "mod") and is checked inside the
> switch(). The function code really is just composed of bit 57 - 63, so
> this is correct.

"mod bit"?

  # Bit 56 of general register 0 must be zero; oth-
  # erwise, a specification exception is recognized.

I don't suppose this is a change in PoO v11?  I'm still looking at v10.

> E.g. for KMAC (7-187):
> 
> "A specification exception is recognized and no other
> action is taken if any of the following occurs:
> [...]
>  The R2 field designates an odd-numbered regis-
> ter or general register 0."

Hmm, ok.  There's different text earlier on page 7-178 that describes the
even-odd requirement but omits the non-zero requirement.  Irritating.


r~
