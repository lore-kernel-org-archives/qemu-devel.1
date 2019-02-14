Received: from eggs.gnu.org ([209.51.188.92]:40492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guLQT-0002kR-Ck
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guLQS-0008DG-Lf
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:07:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guLQS-0008A4-6F
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:07:56 -0500
References: <20190214122700.18572-1-zhengxiang9@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec12aeeb-a480-f07d-c75e-6d6acf0359fa@redhat.com>
Date: Thu, 14 Feb 2019 19:07:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190214122700.18572-1-zhengxiang9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-cd: Fix crash after remote cdrom
 detached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiang Zheng <zhengxiang9@huawei.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, wanghaibin.wang@huawei.com, lizhengui@huawei.com

On 14/02/19 13:27, Xiang Zheng wrote:
> There is a small window between the twice blk_is_available in
> scsi_disk_emulate_command which would cause crash due to the later
> assertion if the remote cdrom is detached in this window.
> 
> So this patch replaces assertions with return to avoid qemu crash.
> 
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
> The qemu error log shows:
> 
> qemu-system-aarch64: /home/qemu/hw/scsi/scsi-disk.c:1896: scsi_disk_emulate_command: Assertion `blk_is_available(s->qdev.conf.blk)' failed.
> 2019-02-15 04:35:18.592: shutting down, reason=crashed

Is this with virtio-scsi-dataplane?

Paolo
