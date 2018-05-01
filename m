Received: from eggs.gnu.org ([2001:4830:134:3::10]:33713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <airlied@redhat.com>) id 1fDbq0-0002n7-5Q
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <airlied@redhat.com>) id 1fDbpu-0004sq-TJ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:25:24 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:46499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <airlied@redhat.com>) id 1fDbpu-0004sT-NB
	for qemu-devel@nongnu.org; Tue, 01 May 2018 16:25:18 -0400
Received: by mail-ua0-f176.google.com with SMTP id e8so5860338uam.13
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 13:25:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180501161509.28517.344.stgit@gimli.home>
References: <20180501161509.28517.344.stgit@gimli.home>
From: David Airlie <airlied@redhat.com>
Date: Wed, 2 May 2018 06:25:16 +1000
Message-ID: <CAMwc25p+3ugAHz14shv_Dyo8LmJzf=dNJXH53RMyS4kAD0qvag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] Update linux-headers to v4.17-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com

On Wed, May 2, 2018 at 2:25 AM, Alex Williamson <alex.williamson@redhat.com>
wrote:

> This series is based on Michael's series moving kvm_para.h out to
> standard headers, which resolves the conflict in definitions of
> KVM_HINTS_DEDICATED between QEMU and kernel.
>
> Additionally, this series moves the definition of
> VIRTIO_GPU_CAPSET_VIRGL2 into QEMU code as the definition does not
> exist in the upstream header and it seems unreasonable to expect
> anyone wanting to update headers should manually resolve this
> conflict.
>

I thought the headers went qemu->linux which is why I never pushed this to
Linux.

Happy to have a patch in the kernel that adds this.

Dave.
