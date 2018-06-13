Received: from eggs.gnu.org ([2001:4830:134:3::10]:53420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTCxp-000325-VR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTCxp-0007PJ-27
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:05:57 -0400
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
	<1528879723-24675-10-git-send-email-eric.auger@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8bf1bccc-b32a-9982-6123-b644c41a96d3@redhat.com>
Date: Wed, 13 Jun 2018 23:05:41 +0200
MIME-Version: 1.0
In-Reply-To: <1528879723-24675-10-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 9/9] hw/arm/virt: Add virt-3.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: wei@redhat.com, drjones@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, christoffer.dall@arm.com, zhaoshenglong@huawei.com

On 06/13/18 10:48, Eric Auger wrote:

> PATCH: merge of ECAM and VCPU extension
> - Laszlo reviewed the ECAM changes but I dropped his R-b
>   due to the squash

Was there any particular reason why the previous patch set (with only
the ECAM enlargement) couldn't be merged first? To be honest I'm not
super happy when my R-b is dropped for non-technical reasons; it seems
like wasted work for both of us.

Obviously if there's a technical dependency or some other reason why
committing the ECAM enlargement in separation would be *wrong*, that's
different. Even in that case, wouldn't it be possible to keep the
initial virt-3.0 machtype addition as I reviewed it, and then add the
rest in an incremental patch?

Thanks,
Laszlo
