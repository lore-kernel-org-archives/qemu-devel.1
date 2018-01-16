Received: from eggs.gnu.org ([2001:4830:134:3::10]:53276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebTVk-0001qT-Et
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebTVg-0003CJ-Kk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:50:52 -0500
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:38379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebTVg-0003Bp-EL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:50:48 -0500
Received: by mail-pl0-x236.google.com with SMTP id 13so6451816plb.5
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 07:50:48 -0800 (PST)
References: <20180116033404.31532-1-richard.henderson@linaro.org>
	<CAFEAcA_6KgcmRFa_AyyhpUb2EQKNBUsQQ9Wk_-guJXsoS-h-tw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a89ba2c9-0248-644e-2d95-83985780e422@linaro.org>
Date: Tue, 16 Jan 2018 07:50:43 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6KgcmRFa_AyyhpUb2EQKNBUsQQ9Wk_-guJXsoS-h-tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 00/26] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 01/16/2018 03:59 AM, Peter Maydell wrote:
> /var/tmp/patchew-tester-tmp-r7vd2rsz/src/accel/tcg/tcg-runtime-gvec.c:533:26:
> internal compiler error: in emit_move_insn, at expr.c:3495

Bah.  I remember seeing this myself on the gcc 4.8.x that is the system
compiler on the gcc compile farm machines.  I forgot about it because I
immediately changed my path to select gcc 7.x.  ;-P

> We need to either work around that or update the compiler in patchew's
> setup or disable that build before we can merge this, or patchew will
> start mailing complaints about every series that's sent to the list...

I can work around it in configure, but it might be worth updating the compiler
as well -- this bug has been fixed for years.


r~
