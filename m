Received: from eggs.gnu.org ([2001:4830:134:3::10]:37251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1ezSsw-00080D-G2
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1ezSss-00086R-IS
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:01:58 -0400
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:41012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1ezSss-00085T-DB
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:01:54 -0400
Received: by mail-pl0-x22d.google.com with SMTP id b7-v6so8074798plr.8
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 13:01:54 -0700 (PDT)
Date: Fri, 23 Mar 2018 13:01:52 -0700 (PDT)
In-Reply-To: <xnbmfflpqr.fsf@greed.delorie.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-6b5e9ecc-0232-4af1-a4f8-c02e4441e2c4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dj@redhat.com
Cc: rjones@redhat.com, Michael Clark <mjc@sifive.com>, f4bug@amsat.org, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu, 22 Mar 2018 15:17:16 PDT (-0700), dj@redhat.com wrote:
> "Richard W.M. Jones" <rjones@redhat.com> writes:
>> DJ, am I remembering correctly that you tried the test case on the
>> HiFive evaluation board and it didn't demonstrate the bug?
>
> I tested it on the vc707 board, without seeing the bug.

FWIW, the cores in the bitstream for the vc707 are almost identical to the
FU540-C000.

> I can test other test cases if needed, I've got the board running Fedora
> at the moment.

Thanks!
