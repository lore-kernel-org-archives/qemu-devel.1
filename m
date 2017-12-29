Received: from eggs.gnu.org ([2001:4830:134:3::10]:48527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eUoAC-0001ex-FC
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eUoAB-0002i2-LB
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:29:04 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-6-git-send-email-gengdongjiu@huawei.com>
	<20171228144910.49fad2a9@igors-macbook-pro.local>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <07d9d13d-b1ae-6b6d-52f2-fcf5b2e90da8@huawei.com>
Date: Fri, 29 Dec 2017 14:27:39 +0800
MIME-Version: 1.0
In-Reply-To: <20171228144910.49fad2a9@igors-macbook-pro.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 5/9] target-arm: kvm64: inject
 synchronous External Abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

Hi, Igor,

On 2017/12/28 21:49, Igor Mammedov wrote:
>> so user space how to inject it. The test result that injection SEA to guest by Qemu
>> is shown in [2].
> is it possible to inject SEA when running in TCG mode?
 I have tested it in TCG mode, It supports to inject SEA when running in TCG mode. Thanks

 Start vm commands:
 ./qemu-system-aarch64 -m 1024 -cpu cortex-a57 -machine virt,gic-version=2  -bios QEMU_EFI.fd -smp 4 -nographic -kernel Image -append "root=/dev/sda1 \
 console=ttyAMA0" -device virtio-scsi-device,id=scsi -drive file=./linaro.img,id=rootimg,cache=unsafe,if=none -device scsi-hd,drive=rootimg

> 
> it would be useful from testing/verification point of view
> (i.e. we could test logic on non ARM host during 'make check')>
> 
