Received: from eggs.gnu.org ([2001:4830:134:3::10]:37679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKOxf-0002px-7J
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKOxa-0008VG-Oa
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:33:07 -0500
Date: Thu, 30 Nov 2017 14:32:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171130143256.2b8d93ba.cohuck@redhat.com>
In-Reply-To: <e8d586cf-99bd-3c72-0c39-44408295a744@linux.vnet.ibm.com>
References: <20171128130758.67556-1-pasic@linux.vnet.ibm.com>
	<20171129133733.7fc11968.cohuck@redhat.com>
	<6f7547b8-1346-53ce-3d80-6839c556d724@linux.vnet.ibm.com>
	<20171129182900.409be40f.cohuck@redhat.com>
	<e8d586cf-99bd-3c72-0c39-44408295a744@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/1] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

On Thu, 30 Nov 2017 13:32:12 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

(...)

Before I spend way too much time on this:

Is the proposed machine-property interface usable from a libvirt POV?
IOW, can we go with this now and fix the ugliness later (probably via a
generic overhaul of the interface)?
