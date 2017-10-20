Received: from eggs.gnu.org ([2001:4830:134:3::10]:49842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5N4z-0007jk-P9
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5N4v-0001sK-IQ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:30:33 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:50032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5N4v-0001rK-9Q
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:30:29 -0400
Received: by mail-pf0-x241.google.com with SMTP id i5so8833554pfe.6
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 19:30:29 -0700 (PDT)
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-39-richard.henderson@linaro.org>
	<b420cf7c-a15f-6edc-74a8-4e41738bad28@redhat.com>
	<20171018181949.GA32663@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8f423a08-dbf7-a862-66ec-512623f4e47a@linaro.org>
Date: Thu, 19 Oct 2017 19:30:25 -0700
MIME-Version: 1.0
In-Reply-To: <20171018181949.GA32663@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 38/50] translate-all: use a binary
 search tree to track TBs in TBContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 10/18/2017 11:19 AM, Emilio G. Cota wrote:
> On Wed, Oct 18, 2017 at 09:41:43 +0200, Paolo Bonzini wrote:
>> On 16/10/2017 19:25, Richard Henderson wrote:
>>>   * Translation Cache-related fields of a TB.
>>> + * This struct exists just for convenience; we keep track of TB's in a binary
>>> + * search tree, and the only fields needed to compare TB's in the tree are
>>> + * @ptr and @size. @search is brought here for consistency, since it is also
>>> + * a TC-related field.
>>>   */
>>>  struct tb_tc {
>>>      void *ptr;    /* pointer to the translated code */
>>>      uint8_t *search;  /* pointer to search data */
>>> +    size_t size;
>>>  };
>>
>> Isn't search equal to ptr + size, or something like that?
> 
> It is indeed! Fixup below.
> 
> The change shrinks TranslationBlock, but it leaves performance unchanged
> (recall that we add padding after TranslationBlock to avoid cache line
> overlap between the struct and translated code).
> 
> Thanks,
> 
> 		Emilio
> 
> -- >8 --
> Subject: [PATCH] fixup

Merged, thanks.


r~
