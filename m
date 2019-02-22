Received: from eggs.gnu.org ([209.51.188.92]:41063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwyW6-0004qm-Bq
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwyW4-0007Mf-Sq
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:16:38 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwyW0-00057x-29
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 19:16:35 -0500
Received: by mail-pf1-x443.google.com with SMTP id i19so235424pfd.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 16:14:12 -0800 (PST)
References: <20190219233421.388-1-richard.henderson@linaro.org>
	<20190221212130.GA6971@flamenco> <87va1c3h1y.fsf@zen.linaroharston>
	<20190221225906.GA31346@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17486cd7-bf8e-b8a9-656d-b9ac0f289119@linaro.org>
Date: Thu, 21 Feb 2019 16:14:07 -0800
MIME-Version: 1.0
In-Reply-To: <20190221225906.GA31346@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 2/21/19 2:59 PM, Emilio G. Cota wrote:
> Should have done so the first time. Here it is:
> 
> (gdb) r                                          
> Starting program: /data/src/qemu/build/arm-softmmu/qemu-system-arm -machine type=virt -nographic -m 4096 -netdev user,id=unet,hostfwd=tcp::2222-:22 -d
> evice virtio-net-device,netdev=unet -drive file=../img/arm/jessie-arm32-die-on-boot.qcow2,id=myblock,index=0,if=none -device virtio-blk-device,drive=m
> yblock -kernel ../img/arm/aarch32-current-linux-kernel-only.img -append console=ttyAMA0\ root=/dev/vda1 -name arm,debug-threads=on -smp 1
> [...]
> VFS: Mounted root (ext4 filesystem) readonly on device 254:1.
> devtmpfs: mounted
> Freeing unused kernel memory: 300K (80669000 - 806b4000)
> **
> ERROR:/data/src/qemu/target/arm/helper.c:14049:cpu_get_tb_cpu_state: assertion failed (flags == check_flags): (0x10080000 == 0x10080080)

Thanks, I've now reproduced this.


r~
