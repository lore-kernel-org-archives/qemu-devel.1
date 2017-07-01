Received: from eggs.gnu.org ([2001:4830:134:3::10]:44060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRRKT-0003Jl-JF
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 18:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRRKQ-0000mj-JH
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 18:57:29 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRRKQ-0000mN-Cr
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 18:57:26 -0400
Received: by mail-qk0-x244.google.com with SMTP id v143so7085459qkb.3
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 15:57:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865316837.17063.1608754834009945976.stgit@frigg.lan>
	<20170630000240.GF13979@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bd970a00-5442-d1e0-c455-d4230179ae23@twiddle.net>
Date: Sat, 1 Jul 2017 15:57:21 -0700
MIME-Version: 1.0
In-Reply-To: <20170630000240.GF13979@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 04/29] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 06/29/2017 05:02 PM, Emilio G. Cota wrote:
>> +void translate_block(const TranslatorOps *ops, DisasContextBase *db,
>> +                     CPUState *cpu, TranslationBlock *tb);
> I'd rather avoid "block" here. Some alternatives:
> 
> - tb_translate()
> - translate_tb()
> - translate()
> - translator_gen()
> - translator_loop()

I like translator_loop.


r~
