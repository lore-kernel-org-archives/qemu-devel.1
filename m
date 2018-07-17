Received: from eggs.gnu.org ([2001:4830:134:3::10]:59456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOvp-0000Qa-TU
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOvm-0000Jr-Eg
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:18:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOvm-0000JS-8U
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:18:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEAE277885
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:18:13 +0000 (UTC)
References: <20180717120414.5852-1-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eb90a7b9-5a02-b9f7-c989-f646a272c4f3@redhat.com>
Date: Tue, 17 Jul 2018 14:18:12 +0200
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

On 17.07.2018 14:04, Juan Quintela wrote:
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
> 
> What do you think?

I think this is the wrong way to go. If you add #ifdefs to the sources,
you have to make the binaries target-specific. Currently each test
binary can work for each target architecture. With #ifdefs, that's not
possible anymore. So please don't do that.

If you want to make the tests more flexible for configuration, please
use QOM instead to check whether the devices are available or not.

 Thomas
