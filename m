Received: from eggs.gnu.org ([2001:4830:134:3::10]:54030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLJTt-00012I-2V
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLJTp-0008Sp-Ub
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:21:53 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:36745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLJTp-0008Sk-NI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:21:49 -0400
Received: by mail-pg0-x232.google.com with SMTP id a70so194244pge.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 18:21:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-2-rth@twiddle.net>
	<20170614202733.GA8420@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cc6d30a7-e2fd-a783-043f-efeccfe7e42a@twiddle.net>
Date: Wed, 14 Jun 2017 18:21:46 -0700
MIME-Version: 1.0
In-Reply-To: <20170614202733.GA8420@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg-runtime: increase hit rate of
 lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com

On 06/14/2017 01:27 PM, Emilio G. Cota wrote:
> On Wed, Jun 14, 2017 at 12:48:17 -0700, Richard Henderson wrote:
>> We can call tb_htable_lookup even when the tb_jmp_cache
>> is completely empty.  Therefore, un-nest most of the code
>> dependent on tb != NULL from the read from the cache.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
> 
> I just wrote this alternative patch, which does the same thing
> as yours. I also measured what the effect of this change
> has on the hit rate of lookup_tb_ptr. Feel free to reuse parts
> of the patch and/or the commit message!

Thanks.  I'll adjust the commit.


r~
