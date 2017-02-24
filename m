Received: from eggs.gnu.org ([2001:4830:134:3::10]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chDoG-0008R1-JS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chDoB-0007RT-Li
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1chDoB-0007PR-Fh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:07 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF3FE3D945
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:13:07 +0000 (UTC)
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<20170222183919.11928-4-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a226a458-dca6-af74-2f87-ce1ff6697359@redhat.com>
Date: Fri, 24 Feb 2017 12:13:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170222183919.11928-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

Am 22.02.2017 um 19:39 schrieb Eduardo Habkost:
> Host CPUID info is used by the "max" CPU model only in KVM mode.
> Move the initialization of CPUID data for "max" from class_init
> to instance_init, and don't set CPUClass::cpu_def for "max".

Doesn't that mean that the same code is now called for every cpu
instance vs. only once for the class?

-- 
Thanks,

David
