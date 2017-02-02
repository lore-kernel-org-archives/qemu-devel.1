Received: from eggs.gnu.org ([2001:4830:134:3::10]:56850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZJrK-0005MD-4e
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZJrJ-0004Wz-96
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:03:42 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:33638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZJrJ-0004Wl-5m
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:03:41 -0500
Received: by mail-ua0-x22a.google.com with SMTP id i68so14508502uad.0
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 08:03:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485939884-39956-1-git-send-email-borntraeger@de.ibm.com>
References: <1485939884-39956-1-git-send-email-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 16:03:19 +0000
Message-ID: <CAFEAcA8NsQvLiXLQgkWZwwOfigKd_c7wBALTgzAS-MBDJ9g5FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] s390x fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>

On 1 February 2017 at 09:04, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> Peter,
>
> The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)
>
> are available in the git repository at:
>
>   git://github.com/borntraeger/qemu.git tags/s390x-20170201
>
> for you to fetch changes up to d8923bc75479cd3fdcc72b7647f4877f91950b01:
>
>   target/s390x: use "qemu" cpu model in user mode (2017-02-01 09:15:17 +0100)
>
> ----------------------------------------------------------------
> s390x fixes
>
> - build error with old gcc versions
> - race between cmma reset and rom/loader resets
> - linux-user vs. cpu model
>
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       s390x/kvm: fix small race reboot vs. cmma
>
> David Hildenbrand (1):
>       target/s390x: use "qemu" cpu model in user mode
>
> Paolo Bonzini (1):
>       s390-pci: fix compilation on older GCC versions

Applied, thanks.

-- PMM
