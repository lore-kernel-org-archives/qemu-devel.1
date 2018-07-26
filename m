Received: from eggs.gnu.org ([2001:4830:134:3::10]:42841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1fihqi-0000OA-CZ
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 11:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1fihqe-0004t6-DX
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 11:06:40 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1fihqe-0004by-8d
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 11:06:36 -0400
Received: by mail-vk0-f67.google.com with SMTP id t4-v6so943714vke.9
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 08:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180726113337.23144-1-kwolf@redhat.com>
	<605ad10a-13c0-7f62-1c71-a8afe9021ee6@redhat.com>
In-Reply-To: <605ad10a-13c0-7f62-1c71-a8afe9021ee6@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 26 Jul 2018 18:06:13 +0300
Message-ID: <CAMRbyyu4Z_1BaLsTD6JQ2fEG=Pr1piJF9RFz+gbzkxtyW8PpOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-3.0] file-posix: Fix
 write_zeroes with unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Thu, Jul 26, 2018 at 5:28 PM Eric Blake <eblake@redhat.com> wrote:

> On 07/26/2018 06:33 AM, Kevin Wolf wrote:
> > The BLKDISCARD ioctl doesn't guarantee that the discarded blocks read as
> > all-zero afterwards, so don't try to abuse it for zero writing. We try
> > to only use this if BLKDISCARDZEROES tells us that it is safe, but this
> > is unreliable on older kernels and a constant 0 in newer kernels. In
>
> For my own curiosity, which kernel commit switched to constant 0, so I
> can read the rationale in that commit message?
>

This should help
https://patchwork.kernel.org/patch/9903757/

Nir
