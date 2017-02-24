Received: from eggs.gnu.org ([2001:4830:134:3::10]:33442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1chF3f-0007Ud-Tw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1chF3f-00055J-67
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:33:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1chF3f-00054X-0C
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:33:11 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 300C283F38
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:33:11 +0000 (UTC)
Date: Fri, 24 Feb 2017 09:33:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170224123308.GS2778@thinpad.lan.raisama.net>
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<20170222183919.11928-4-ehabkost@redhat.com>
	<a226a458-dca6-af74-2f87-ce1ff6697359@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a226a458-dca6-af74-2f87-ce1ff6697359@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] i386: Don't set CPUClass::cpu_def
 on "max" model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Feb 24, 2017 at 12:13:05PM +0100, David Hildenbrand wrote:
> Am 22.02.2017 um 19:39 schrieb Eduardo Habkost:
> > Host CPUID info is used by the "max" CPU model only in KVM mode.
> > Move the initialization of CPUID data for "max" from class_init
> > to instance_init, and don't set CPUClass::cpu_def for "max".
> 
> Doesn't that mean that the same code is now called for every cpu
> instance vs. only once for the class?

Yes, but I don't see a problem with that.

-- 
Eduardo
