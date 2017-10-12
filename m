Received: from eggs.gnu.org ([2001:4830:134:3::10]:54011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1e2nJP-0003vZ-7z
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1e2nJO-0001Ng-IX
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:54:47 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:44878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1e2nJO-0001LW-CK
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 19:54:46 -0400
Received: by mail-pf0-x234.google.com with SMTP id x7so7230847pfa.1
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 16:54:44 -0700 (PDT)
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Thu, 12 Oct 2017 16:54:35 -0700
Message-Id: <20171012235439.19457-1-anatol.pomozov@gmail.com>
Subject: [Qemu-devel] (no subject)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, rth@twiddle.net, ehabkost@redhat.com, pbonzini@redhat.com, agraf@suse.de




It is V3 of multiboot improvements to Qemu

Changes made sinse V2:
 - rebase on top of qemu master changes
 - make multiboot/sections test more reliable
     Add generate_sections_out.py script that generates ELF sections information
 - rename 'struct section_data' to 'struct SectionData' to match naming
     convention in include/hw/loader.h
