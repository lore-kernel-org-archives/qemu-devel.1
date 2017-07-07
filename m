Received: from eggs.gnu.org ([2001:4830:134:3::10]:48859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSpH-0003AC-MP
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSpE-0005uk-Mf
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:57:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSpE-0005uR-Gn
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:57:36 -0400
Date: Fri, 7 Jul 2017 14:57:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170707145731.149c3014@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499423224-23060-5-git-send-email-thuth@redhat.com>
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-5-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/8] pc-bios/s390-ccw: Add a write()
 function for stdio
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

On Fri,  7 Jul 2017 12:27:00 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The stdio functions from the SLOF libc need a write() function for
> printing text to stdout/stderr. Let's implement this function by
> refactoring the code from sclp_print().
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/sclp.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
