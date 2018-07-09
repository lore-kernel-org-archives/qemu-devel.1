Received: from eggs.gnu.org ([2001:4830:134:3::10]:46030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1fcSy7-0001l6-LP
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 06:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1fcSxx-0001Xs-R2
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 06:00:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:58368 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1fcSxx-0001Wx-Jv
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 06:00:21 -0400
From: Andreas Schwab <schwab@suse.de>
References: <20180706012215.21714-1-alistair.francis@wdc.com>
Date: Mon, 09 Jul 2018 12:00:16 +0200
In-Reply-To: <20180706012215.21714-1-alistair.francis@wdc.com> (Alistair
	Francis's message of "Thu, 5 Jul 2018 18:22:08 -0700")
Message-ID: <mvm36ws7mq7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL v4 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mjc@sifive.com, alistair23@gmail.com, f4bug@amsat.org

What is the state of the sifive_u emulation?  When I tried to boot a bbl
with an included kernel I get these errors:

qemu-system-riscv64: plic: invalid register write: 00002090
qemu-system-riscv64: plic: invalid register write: 00002094
qemu-system-riscv64: plic: invalid register write: 00002098
qemu-system-riscv64: plic: invalid register write: 0000209c
qemu-system-riscv64: plic: invalid register write: 000020a0
qemu-system-riscv64: plic: invalid register write: 000020a4
qemu-system-riscv64: plic: invalid register write: 000020a8
qemu-system-riscv64: plic: invalid register write: 000020ac
qemu-system-riscv64: plic: invalid register write: 000020b0
qemu-system-riscv64: plic: invalid register write: 000020b4

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
