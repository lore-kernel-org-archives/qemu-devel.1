Received: from eggs.gnu.org ([2001:4830:134:3::10]:41376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEG5n-0000fD-WA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEG5n-0005oi-7s
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:24:23 -0400
References: <1525360636-18229-1-git-send-email-frederic.konrad@adacore.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <937f65c3-0aa8-6d9a-ef74-871e0274dec4@adacore.com>
Date: Thu, 3 May 2018 17:24:20 +0200
MIME-Version: 1.0
In-Reply-To: <1525360636-18229-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 0/3] riscv: some little fix.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, mjc@sifive.com, f4bug@amsat.org, peter.maydell@linaro.org

s/fix/fixes in the subject :/

Fred

On 05/03/2018 05:17 PM, KONRAD Frederic wrote:
> Hi all,
> 
> Here are some fixes for RISCV.
> 
> The two firsts allow to map the HTIF @0x00000000.
> The third one requires fdt to be present on the build machine so the build
> doesn't end with a linker error.
> 
> Thanks,
> Fred
> 
> KONRAD Frederic (3):
>    riscv: spike: allow base == 0
>    riscv: htif: increase the priority of the htif subregion
>    riscv: requires libfdt
> 
>   configure             |  2 +-
>   hw/riscv/riscv_htif.c | 12 ++++++++----
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
