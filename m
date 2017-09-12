Received: from eggs.gnu.org ([2001:4830:134:3::10]:48999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1droBV-0004rJ-Rt
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1droBR-00068U-PP
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:37:13 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1droBR-00068L-Jl
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:37:09 -0400
Received: by mail-pg0-x22a.google.com with SMTP id i130so14929585pgc.3
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:37:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
	<20170906160612.22769-29-richard.henderson@linaro.org>
	<CABoDooN99XUyw6TFG+G2cu1yUfvgK057NKy1mEoKCtuyebwk0g@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e1bd6cdc-203d-a637-f7ff-ed545226607c@twiddle.net>
Date: Tue, 12 Sep 2017 09:37:04 -0700
MIME-Version: 1.0
In-Reply-To: <CABoDooN99XUyw6TFG+G2cu1yUfvgK057NKy1mEoKCtuyebwk0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 28/32] target/arm: [tcg] Port to generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>

On 09/12/2017 09:12 AM, Laurent Desnogues wrote:
>> +static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>> +{
>> +    tcg_clear_temp_count();
>> +}
> 
> Is it really needed to call tcg_clear_temp_count here when it's now
> called in translator_loop?

Nope, missed while moving these calls around.
Thanks.


r~
