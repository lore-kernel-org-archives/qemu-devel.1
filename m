Received: from eggs.gnu.org ([2001:4830:134:3::10]:46541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e7zx5-0003rv-V1
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e7zx1-0004CW-ME
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:25:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e7zx1-00049j-Eh
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:25:11 -0400
Date: Fri, 27 Oct 2017 10:24:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171027102459.1495f386.cohuck@redhat.com>
In-Reply-To: <1509043965-5852-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1509043965-5852-1-git-send-email-walling@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390-ccw: print carriage return with
 new lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, thuth@redhat.com, bwalk@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, rth@twiddle.net

On Thu, 26 Oct 2017 14:52:45 -0400
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

> The sclp console in the s390 bios writes raw data,
> leading console emulators (such as virsh console) to
> treat a new line ('\n') as just a new line instead
> of as a Unix line feed. Because of this, output
> appears in a "stair case" pattern.
> 
> Let's print \r\n on every occurrence of a new line
> in the string passed to write to amend this issue.
> 
> This is in sync with the guest Linux code in
> drivers/s390/char/sclp_vt220.c which also does a line feed
> conversion  in the console part of the driver. 
> 
> This fixes the s390-ccw and s390-netboot output like
> $ virsh start test --console
> Domain test started
> Connected to domain test
> Escape character is ^]
> Network boot starting...
>                           Using MAC address: 02:01:02:03:04:05
>                                                                 Requesting information via DHCP:  010
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

I'm a bit confused about that s-o-b chain... where does Christian come
in here?

[Nothing further from me about the actual code change.]

> ---
>  pc-bios/s390-ccw/sclp.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
