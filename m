Received: from eggs.gnu.org ([2001:4830:134:3::10]:33699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e8L5A-0008Ip-Pw
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e8L57-0002OH-Oi
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:59:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e8L57-0002Nu-IG
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:58:57 -0400
Date: Sat, 28 Oct 2017 08:58:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171028085635.29aeaacb.cohuck@redhat.com>
In-Reply-To: <1509120893-28054-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1509120893-28054-1-git-send-email-walling@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] s390-ccw: print carriage return with
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, bwalk@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, rth@twiddle.net

On Fri, 27 Oct 2017 12:14:53 -0400
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
> conversion in the console part of the driver. 
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
> ---
>  pc-bios/s390-ccw/sclp.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
