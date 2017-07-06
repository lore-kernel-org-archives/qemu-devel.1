Received: from eggs.gnu.org ([2001:4830:134:3::10]:33354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT5SZ-0001cX-PJ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT5SY-0001MK-Jw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:00:39 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dT5SY-0001LG-6l
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:00:38 -0400
Received: by mail-wr0-x233.google.com with SMTP id k67so25880708wrc.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 05:00:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
References: <1499325817-9166-1-git-send-email-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2017 13:00:16 +0100
Message-ID: <CAFEAcA_SB3xCPWLuoV1Ks4dqZ6BmVnt87ATSrUcWFgm9WWCZ0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] s390x/kvm/migration: fixes,
 enhancements and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 6 July 2017 at 08:23, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> Peter,
>
> the following changes since commit 2185c93ba80f81bfa27ce6f259c7f2ef4f08b668:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next.for-upstream' into staging (2017-07-04 13:05:30 +0100)
>
> are available in the git repository at:
>
>   git://github.com/borntraeger/qemu.git tags/s390x-20170706
>
> for you to fetch changes up to 1045e3cdafaf1218d9f771080ba5c9d4f64346e4:
>
>   hw/s390x/ipl: Fix endianness problem with netboot_start_addr (2017-07-05 19:46:30 +0200)
>
> ----------------------------------------------------------------
> s390x/kvm/migration: fixes, enhancements and cleanups
>
> - new email address for Cornelia
> - Fixes: 3270, flic, virtio-scsi-ccw, ipl
> - Enhancements, cpumodel, migration
>
> ----------------------------------------------------------------
> Cornelia Huck (1):
>       s390x/MAINTAINERS: Update my email address
>
> Dong Jia Shi (1):
>       s390x/3270: fix instruction interception handler
>
> Halil Pasic (3):
>       s390x: vmstatify config migration for virtio-ccw
>       s390x: fix error propagation in kvm-flic's realize
>       s390x: fix realize inheritance for kvm-flic
>
> QingFeng Hao (1):
>       virtio-scsi-ccw: use ioeventfd even when KVM is disabled
>
> Thomas Huth (1):
>       hw/s390x/ipl: Fix endianness problem with netboot_start_addr
>
> Viktor Mihajlovski (1):
>       s390x: return unavailable features via query-cpu-definitions
>

Applied, thanks.

-- PMM
