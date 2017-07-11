Received: from eggs.gnu.org ([2001:4830:134:3::10]:38566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUr6b-0002kH-Ot
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUr6a-0005FY-T9
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUr6a-0005FK-MH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:05:16 -0400
Date: Tue, 11 Jul 2017 11:05:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711110507.1a137dfd@dhcp-192-215.str.redhat.com>
In-Reply-To: <d9a2dfc8-f45f-f297-7929-e457a666d608@redhat.com>
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
	<1499700760-4777-6-git-send-email-thuth@redhat.com>
	<20170711095939.3470a289@dhcp-192-215.str.redhat.com>
	<d9a2dfc8-f45f-f297-7929-e457a666d608@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/10] pc-bios/s390-ccw: Move byteswap
 functions to a separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Tue, 11 Jul 2017 10:52:24 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 11.07.2017 09:59, Cornelia Huck wrote:
> > On Mon, 10 Jul 2017 17:32:35 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> We'll need them in code that is not related to bootmap.h, so
> >> they should reside in an independent header.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  pc-bios/s390-ccw/bootmap.c |  1 +
> >>  pc-bios/s390-ccw/bootmap.h | 26 --------------------------
> >>  pc-bios/s390-ccw/bswap.h   | 25 +++++++++++++++++++++++++
> >>  3 files changed, 26 insertions(+), 26 deletions(-)
> >>  create mode 100644 pc-bios/s390-ccw/bswap.h  
> >   
> >> diff --git a/pc-bios/s390-ccw/bswap.h b/pc-bios/s390-ccw/bswap.h
> >> new file mode 100644
> >> index 0000000..45b5ef4
> >> --- /dev/null
> >> +++ b/pc-bios/s390-ccw/bswap.h  
> > 
> > Add a copyright/licence text?  
> 
> The original file include/qemu/bswap.h (where this code comes from) also
> does not have a copyright statement, so I was not sure which one to add
> here. I think that simply means that the default applies here...
> But I can certainly also add the default GPLv2+ statement if you think
> that we need it here...

No, that's fine; it's just the only file in this subdirectory without
an explicit header...

Acked-by: Cornelia Huck <cohuck@redhat.com>
