Received: from eggs.gnu.org ([2001:4830:134:3::10]:55235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEIi8-0000hT-FK
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEIi3-0005iN-Jv
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:35:20 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cEIi3-0005N6-E4
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:35:15 -0500
Received: by mail-qk0-f195.google.com with SMTP id n204so44408416qke.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 08:34:54 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-20-git-send-email-rth@twiddle.net>
	<87h96hyqml.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bdc2095f-e010-a029-2988-fc327c4c32f8@twiddle.net>
Date: Tue, 6 Dec 2016 08:33:49 -0800
MIME-Version: 1.0
In-Reply-To: <87h96hyqml.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 19/64] tcg/optimize: Fold movcond 0/1
 into setcond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 12/06/2016 08:22 AM, Alex Bennée wrote:
>> > +                if (fv == 1 && tv == 0) {
>> > +                    cond = tcg_invert_cond(cond);
>> > +                } else if (!(tv == 1 && fv == 0)) {
>> > +                    goto do_default;
>> > +                }
> Why the weird exit early here on an inverted test. Couldn't it just be
> 
>                 } else if (tv == 1 && fv == 0) {
>                     args[3] = cond;
>                     op->opc = opc = (opc == INDEX_op_movcond_i32
>                                      ? INDEX_op_setcond_i32
>                                      : INDEX_op_setcond_i64);
>                     nb_iargs = 2;
>                 }
> 
> And fall through to the goto do_default as before?
> 

Not if you want to share the update code with the first case above.


r~
