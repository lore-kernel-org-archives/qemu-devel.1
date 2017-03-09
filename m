Received: from eggs.gnu.org ([2001:4830:134:3::10]:40246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clwgH-0000q3-Lv
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clwgE-0004Bm-IF
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:56:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clwgE-0004BZ-D8
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:56:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C58D80477
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 11:56:26 +0000 (UTC)
References: <20170307194617.GJ2869@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4e853c1-7b28-c368-267e-eebf4d7a3e44@redhat.com>
Date: Thu, 9 Mar 2017 12:56:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170307194617.GJ2869@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] RAMBlock's named ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, marcel@redhat.com, imammedo@redhat.com, lvivier@redhat.com



On 07/03/2017 20:46, Dr. David Alan Gilbert wrote:
>   (from https://bugzilla.redhat.com/show_bug.cgi?id=1425273)
>   The simplest reproducer of this is:
> 
> ./qemu-system-x86_64 -nographic  -device e1000e,id=foo -m 1G -M pc,accel=kvm my.img
> 
>   with a Linux image and after it's booted do a device_del foo
> 
>   migration at that point sees an empty RAMBlock that was the ROM
>   associated with the device.  This doesn't happen on an e1000 device,
>   so I've not figured out what the difference is.

This is a leak of the e1000e object.  The cause is a simple typo.

Paolo
