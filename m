Received: from eggs.gnu.org ([2001:4830:134:3::10]:54368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eefsF-0007ST-4q
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eefsC-0000DW-00
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:39:19 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-4-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c6161112-4dd4-d626-556f-b3a958607779@redhat.com>
Date: Thu, 25 Jan 2018 12:39:09 +0100
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-4-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/10] s390-ccw: refactor IPL structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 23.01.2018 19:26, Collin L. Walling wrote:
> ECKD DASDs have different IPL structures for CDL and LDL
> formats. The current Ipl1 and Ipl2 structs follow the CDL
> format, so we prepend "EckdCdl" to them. Boot info for LDL
> has been moved to a new struct: EckdLdlIpl1.
> 
> Also introduce structs for IPL stages 1 and 1b.

I'd maybe move the 1b stuff into a later patch, when you really need it.

By the way, is there a public spec available somewhere for these ECKD
boot structures?

Anyway, patch looks fine to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
