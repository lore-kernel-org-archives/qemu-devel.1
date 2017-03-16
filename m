Received: from eggs.gnu.org ([2001:4830:134:3::10]:46673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqc1r-00058w-4k
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqc1l-0001AP-Lr
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cqc1l-0001A9-Fq
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 04:53:57 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Thu, 16 Mar 2017 15:50:44 +0100
Message-Id: <20170316145045.10840-1-vfeenstr@redhat.com>
In-Reply-To: <0342808A-63C6-40BE-91AB-B6088AD62CD2@redhat.com>
References: <0342808A-63C6-40BE-91AB-B6088AD62CD2@redhat.com>
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
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com

In this version:

- Changed the use of strdup to g_strdup and the use of sprintf with a local
  buffer to use g_strdup_printf instead.
- Made the majority of fields in the GuestOSInfo optional to allow 0 values
- Used the right target version in the schema (2.10 vs 2.8 before)
- Refactored the code for deciding which release/version file to use to use a
  configuration struct and a while loop to iterate over the options.

I was looking into the usage of uname, as suggested by eric, however after
looking into this I realized that there's no additional information to be
gained from this. Therefore I decided that this is still a feasible approach.
In most cases the code will break out of the loop after accessing the second
file. For older systems there are some supported fallbacks available, but
/etc/os-release and /usr/lib/os-release are already quite established.
