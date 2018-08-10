Received: from eggs.gnu.org ([2001:4830:134:3::10]:40985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4Yd-0001hP-1q
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4YZ-0005Wc-S1
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:22:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo4YZ-0005V3-Jm
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:22:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so1344518wmc.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 03:22:07 -0700 (PDT)
References: <20180808114830.7169-1-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3dadb8b2-14d1-bb05-e8bc-c2d1a4540a9e@redhat.com>
Date: Fri, 10 Aug 2018 12:22:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/22] More patches to disable stuff
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

On 08/08/2018 13:48, Juan Quintela wrote:
> Hi
> 
> First the things I didn'~t touch:
> - CONFIG_FOO in source files (scsi mainly)
>   Paolo said that there are people working on that

IIRC I was referring to tests, so basically the first half of this
series.  The virtio-pci bits look great though.

Paolo

> - usb: it is a mess how things are entangled there
> - acpi options (like hotplug etc); another entanglement
> 
> So, what is there?
> - the bits that didn't got reviewed on previous iteration
> - virtio-pci: As Thomas did something for s390, I did the bits for virtio-pci.
> 
> I am able now to disable all virtio-pci devices, and run make tests.
> This is my current virtio bits:
