Received: from eggs.gnu.org ([2001:4830:134:3::10]:43773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJdRP-0005aR-2c
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJdRL-0007s1-SH
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:48:39 -0500
Date: Tue, 28 Nov 2017 11:48:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128114814.55ccfbf3.cornelia.huck@mailbox.org>
In-Reply-To: <1511816136-30068-3-git-send-email-walling@linux.vnet.ibm.com>
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-3-git-send-email-walling@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/5] s390-ccw: ipl structs for eckd
 cdl/ldl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 27 Nov 2017 15:55:33 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> ECKD DASDs have different IPL structures for CDL and LDL
> formats. The current Ipl1 and Ipl2 structs follow the CDL
> format, so we prepend "EckdCdl" to them. A new struct,
> EckdLdlIpl1 is introduced and contains boot info for LDL.

So does this add support for LDL DASD, or does it simply enhance the
code? It's unclear from the desription alone.

> 
> Also introduce structs for IPL stages 1 and 1b and for
> disk geometry.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 24 ++++++++++----------
>  pc-bios/s390-ccw/bootmap.h | 55 +++++++++++++++++++++++++++++++++-------------
>  2 files changed, 53 insertions(+), 26 deletions(-)
