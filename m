Received: from eggs.gnu.org ([2001:4830:134:3::10]:47977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKagC-00020Y-5l
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 22:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKag9-0000uE-2I
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 22:08:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2569 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
	id 1gKag7-0000dP-3q
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 22:08:20 -0500
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-11-david@redhat.com>
	<20181107042212.GA5575@umbus.fritz.box>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <edcb0c5b-ce63-fc09-5b61-5d966840d70d@huawei.com>
Date: Thu, 8 Nov 2018 11:08:00 +0800
MIME-Version: 1.0
In-Reply-To: <20181107042212.GA5575@umbus.fritz.box>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU bootup hang in tcg model using mainline QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>

Hi All
  using mainline QEMU code and below boot up commands, the QEMU will be hang when do bootup, if I add the "-enable-kvm" parameter, it can boot up successfully,  do you know the reason about it?
I also try the "remotes/origin/stable-2.12" branch code using below same boot up commands, it does not have this hang issue. it seems the mainline code has some issue.


./qemu-system-aarch64  -m 1024 -cpu cortex-a57 -machine virt,gic-version=3 \
  -smp 4 -nographic -kernel Image -append "root=/dev/sda1 console=ttyAMA0 sched_debug ignore_loglevel" \
  -device virtio-scsi-device,id=scsi -drive file=./linaro.img,id=rootimg,cache=unsafe,if=none -device scsi-hd,drive=rootimg
