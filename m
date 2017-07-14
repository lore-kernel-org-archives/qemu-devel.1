Received: from eggs.gnu.org ([2001:4830:134:3::10]:52663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW1dq-0001ic-JR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW1dp-0001qZ-Ol
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:32:26 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW1dp-0001q8-H3
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:32:25 -0400
Received: by mail-wr0-x233.google.com with SMTP id k67so68114689wrc.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:32:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 15:32:03 +0100
Message-ID: <CAFEAcA8qC+YP_-Ndxy17TfvsKbQD0icPccOrDie2GJcFzFF7jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/40] s390x: fixes,
 enhancements for 2.10 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 14 July 2017 at 11:40, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> Peter,
>
> this should be the last big chunk for s390/kvm related changes
> for 2.10.
> Patch 2 does a header sync against a kernel version from Linus tree,
> which already  contains the KVM changes for 4.13. Please note that
> one fix in linux/kvm.h is pending for 4.13. I will submit a followup
> patch as soon as this hits the kernel.
>
>
> The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d4f:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12' into staging (2017-07-13 16:56:06 +0100)
>
> are available in the git repository at:
>
>   git://github.com/borntraeger/qemu.git tags/s390x-20170714
>
> for you to fetch changes up to 86158a2a2b81f075c84d0b95c6d72b98dbf1dc61:
>
>   s390x/gdb: add gs registers (2017-07-14 12:29:49 +0200)
>
> ----------------------------------------------------------------
> s390x/kvm/migration/cpumodel: fixes, enhancements and cleanups
>
> - add a network boot rom for s390 (Thomas Huth)
> - migration of storage attributes like the CMMA used/unused state
> - PCI related enhancements - full support for aen, ais and zpci
> - migration support for css with vmstates (Halil Pasic)
> - cpu model enhancements for cpu features
> - guarded storage support
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
