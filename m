Received: from eggs.gnu.org ([2001:4830:134:3::10]:56926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCkBS-0002CG-Sc
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCkBP-0003xe-3z
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:40:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCkBO-0003wd-Qa
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 07:40:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19696308404C
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 11:40:10 +0000 (UTC)
References: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2890bcd3-1ebf-7b56-f99a-cadf9f8be7d8@redhat.com>
Date: Wed, 17 Oct 2018 13:40:00 +0200
MIME-Version: 1.0
In-Reply-To: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] call HotplugHandler->plug() as the last
 step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com

On 16/10/2018 15:33, Igor Mammedov wrote:
> TODO:
>  remove usage of Error** from plug() callback, we need to factor out
>  pre_plug part from plug() callbacks, before proceeding with it.
>  DavidH has recently finished it for pc-dimm/memory_devices, cpus
>  mostly have pre_plug parts factored out, but there still are parts
>  that could fail so it needs some more work to eliminate failure points
>  from plug() callbacks. Meanwhile, I'll plan to treat other misc
>  handlers (pci[e]/acpi/usb/...) and introduce pre_plug() where
>  necessary.

I am not sure it's a good idea to do this first, rather than last (so
that we risk introducing a ping-pong of bugs that appear now and are
fixed when the other changes are made), but if others disagree I am okay
with the patch.

I agree that virtio-scsi is fine here.

Paolo
