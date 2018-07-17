Received: from eggs.gnu.org ([2001:4830:134:3::10]:49648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffQC0-0004PU-CN
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffQBw-0004iy-Dv
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:39:04 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffQBw-0004hx-5B
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:39:00 -0400
Received: by mail-wr1-f46.google.com with SMTP id c4-v6so1293828wrs.12
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 06:39:00 -0700 (PDT)
References: <20180717120414.5852-1-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74103c99-21bf-58f1-fa28-d575a8899462@redhat.com>
Date: Tue, 17 Jul 2018 15:38:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/14] More patches to disable stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 17/07/2018 14:04, Juan Quintela wrote:
> Hi
> 
> Notice that this is an RFC because they don't work.  As said on my
> previous submmision, we need <foo>-softmmu/config-devices.h to make
> this work.  This series just allow us to disable the devices, but not
> to enable it back O:-)
> 
> Notice:
> 
> - scsi stuff: we are testing they in cdrom-test.c, so we need to be
>   able to config them out.  Notice also that #ifdefs only go in tests/<...>
> 
> - virtio stuff: see how we need to also change hw/virtio/virtio-pci.c
>   to disable it.  The problem appears in the device-instropect-test.c.
>   As they are defined in the binary, but not complied in.  We can
>   change for a registration appreach, but that is more work that what
>   I intended for this series.

Emanuele's GSoC project will be able to do this automatically; tests are
defined to "consume" some devices, and are not enabled unless the device
is present.

Thanks,

Paolo
