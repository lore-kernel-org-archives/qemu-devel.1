Received: from eggs.gnu.org ([2001:4830:134:3::10]:41162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUwEq-0002TA-V5
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUwEl-0004Tl-4r
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:34:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUwEk-0004TL-UV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:34:03 -0400
Date: Tue, 11 Jul 2017 16:33:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711163353.390b053c@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499781397-19749-12-git-send-email-thuth@redhat.com>
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
	<1499781397-19749-12-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/11] pc-bios/s390-ccw: Link libnet
 into the netboot image and do the TFTP load
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

On Tue, 11 Jul 2017 15:56:37 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Most of the code has been taken from SLOF's netload.c file. Now we
> can finally load an image via TFTP and execute the downloaded kernel.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/netboot.mak |  12 ++-
>  pc-bios/s390-ccw/netmain.c   | 225 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 236 insertions(+), 1 deletion(-)

Still

Acked-by: Cornelia Huck <cohuck@redhat.com>
