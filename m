Received: from eggs.gnu.org ([2001:4830:134:3::10]:44338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSb9-0007Ty-J3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSb6-0007hT-FT
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:43:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSb6-0007gq-93
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:43:00 -0400
Date: Fri, 7 Jul 2017 14:42:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170707144253.6c6974d8@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499423224-23060-3-git-send-email-thuth@redhat.com>
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/8] pc-bios/s390-ccw: Move ebc2asc
 to sclp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Fri,  7 Jul 2017 12:26:58 +0200
Thomas Huth <thuth@redhat.com> wrote:

> We will later need this array in a file that we will link to the
> netboot code, too. Since there is some ebcdic convertion done
> in sclp_get_loadparm_ascii(), the sclp.c file seems to be a good
> candidate.

Interacting with sclp is probably the only place we'll need to deal
with ebcdic in the ccw bios, so this seems sensible.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c | 11 -----------
>  pc-bios/s390-ccw/sclp.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
