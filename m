Received: from eggs.gnu.org ([2001:4830:134:3::10]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidsondfgl@gmail.com>) id 1fKF4v-00082J-FU
	for qemu-devel@nongnu.org; Sat, 19 May 2018 23:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidsondfgl@gmail.com>) id 1fKF4u-0005lb-P2
	for qemu-devel@nongnu.org; Sat, 19 May 2018 23:32:13 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:33118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidsondfgl@gmail.com>)
	id 1fKF4u-0005l7-Hx
	for qemu-devel@nongnu.org; Sat, 19 May 2018 23:32:12 -0400
Received: by mail-lf0-x22d.google.com with SMTP id u9-v6so2106589lfc.0
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 20:32:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180520025454.GH3652@lianli.shorne-pla.net>
References: <CALAE4RoqNTXyGEUbV3LmonNcyA=o8toPhRrDS23w4W_Zg3z3qg@mail.gmail.com>
	<20180520025454.GH3652@lianli.shorne-pla.net>
From: Davidson Francis <davidsondfgl@gmail.com>
Date: Sun, 20 May 2018 00:31:50 -0300
Message-ID: <CALAE4RpKFttWOBaw-15bTKsU4LG=h6K=K9=U08ThDsGieSJ1=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] OpenRISC - SPR_PICMR always 'OR-ing' the values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>

Thank you for quick reply,

Yes, I've tried, after that, the register works as expected, but even so, if I
enable the interrupts right after, I still receive interrupts from the same IRQ,
but maybe there is something wrong with my code.

Regards,
Davidson Francis.

2018-05-19 23:54 GMT-03:00 Stafford Horne <shorne@gmail.com>:
> On Sat, May 19, 2018 at 08:08:47PM -0300, Davidson Francis wrote:
>> Hello Stafford,
>>
>> I'm currently using or1k as a target CPU in an operating system that
>> I'm working.
>> It happens that I'm having some issues regarding the PICMR register: I realize
>> that in the latest Qemu version (2.12) when I write into PICMR, the Qemu is
>> actually 'OR-ing' the values (as I could note in target/openrisc/sys_helper.c
>> file), so I can't mask an already enabled interrupt.
>>
>> I don't know if this behaviour is expected and if so, I'm sorry, but this does
>> not occurs in the or1ksim, so I thought this could be might an issue.
>
> Hello, thanks for pointing this out.  It looks wrong to me too.  Have you tested
> changing it to just `env->picmr = rb;`?
>
> -Stafford
