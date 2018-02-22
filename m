Received: from eggs.gnu.org ([2001:4830:134:3::10]:42726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eojUl-0002ON-NW
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 00:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eojUh-0002DN-QR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 00:32:39 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<1519241752-28083-7-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4c21b669-87d1-7f64-2db2-8dd04961c42e@redhat.com>
Date: Thu, 22 Feb 2018 06:32:14 +0100
MIME-Version: 1.0
In-Reply-To: <1519241752-28083-7-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 06/13] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 21.02.2018 20:35, Collin L. Walling wrote:
> Set boot menu options for an s390 guest and store them in
> the iplb. These options are set via the QEMU command line
> option:
> 
>     -boot menu=on|off[,splash-time=X]
> 
> or via the libvirt domain xml:
> 
>     <os>
>       <bootmenu enable='yes|no' timeout='X'/>
>     </os>
> 
> Where X represents some positive integer representing
> milliseconds.
> 
> Any value set for loadparm will override all boot menu options.
> If loadparm=PROMPT, then the menu will be enabled without a
> timeout.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/ipl.h          |  9 +++++++--
>  pc-bios/s390-ccw/iplb.h |  9 +++++++--
>  3 files changed, 58 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
