Received: from eggs.gnu.org ([2001:4830:134:3::10]:47592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8H6v-00034P-AQ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 23:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8H6q-00069F-Bd
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 23:16:49 -0400
References: <1523897770-30155-1-git-send-email-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dfe788ef-0bd5-699e-84f1-7b6c897fd8fe@redhat.com>
Date: Tue, 17 Apr 2018 05:16:32 +0200
MIME-Version: 1.0
In-Reply-To: <1523897770-30155-1-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Small fixes for s390x QEMU boot menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: gor@linux.ibm.com, frankja@linux.ibm.com

On 16.04.2018 18:56, Collin Walling wrote:
> Change Log:
> 
>     v3
> 
>         - added r-b's
>         - added check around memset
> 
>     v2
> 
>         - added r-b's
>         - s/zipl_println/zipl_print_entry
>             - prints entry and returns entry number
>         - while loop now handles valid_entries
> 
> These patches fix the following:
> 
>     - The QEMU zIPL boot menu does not allow accurate selection of
>         non-sequential entries.
> 
>     - The QEMU zIPL boot menu does not have all the capabilities of the
>         real zIPL menu (such as commandline args). We should print a different
>         banner to reflect this.
> 
>     - The loadparm array in main.c can end up being not null terminated when
>         converted to an integer via atoui.
> 
>     - A loadparm set to an empty string does not allow a boot menu.
> 
> Collin Walling (4):
>   pc-bios/s390-ccw: rename MAX_TABLE_ENTRIES to MAX_BOOT_ENTRIES
>   pc-bios/s390-ccw: fix loadparm initialization and int conversion
>   pc-bios/s390-ccw: fix non-sequential boot entries (eckd)
>   pc-bios/s390-ccw: fix non-sequential boot entries (enum)

Thanks, queued to my s390-ccw-bios branch now.

 Thomas
