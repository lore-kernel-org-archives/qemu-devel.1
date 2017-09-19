Received: from eggs.gnu.org ([2001:4830:134:3::10]:47795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duL9c-0005zP-DC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duL9b-0006mx-Lc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:13:44 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:48163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duL9b-0006mX-Fs
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:13:43 -0400
Received: by mail-wr0-x232.google.com with SMTP id 108so90509wra.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:13:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 17:13:21 +0100
Message-ID: <CAFEAcA9WKUzGZgPJ01bBtkES=cj+=eyMM40DN+5UGmFgcYd2cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/38] various s390x patches (+some fixes)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 19 September 2017 at 15:55, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 11e06ce1ed28fd0ffcbc1e2436b72f3412b4ecc8:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2017-09-19 10:13:51 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170919
>
> for you to fetch changes up to 4f195287a30f1d58e4aee911aed310883bb819db:
>
>   MAINTAINERS/s390x: add terminal3270.c (2017-09-19 15:32:26 +0200)
>
> ----------------------------------------------------------------
> Assorted s390x patches:
> - introduce virtio-gpu-ccw, with virtio-gpu endian fixes
> - lots of cleanup in the s390x code
> - make device_add work for s390x cpus
> - enable seccomp on s390x
> - an ivshmem endian fix
> - set the reserved DHCP client architecture id for netboot
> - fixes in the css and pci support
>
> ----------------------------------------------------------------

Hi -- this doesn't apply because it deletes hw/s390x/s390-virtio.c
which has been modified in master. Can I ask you to fix this up
and resend, please?

thanks
-- PMM
