Received: from eggs.gnu.org ([2001:4830:134:3::10]:36782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSItr-0002Bh-RK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSItn-0004fO-R0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:14:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40280
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fSItn-0004f7-LA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:14:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5B9A7OV118993
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 05:14:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jhk49rv2m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 05:14:02 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Jun 2018 10:14:00 +0100
References: <1528374154-14680-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Jun 2018 11:13:56 +0200
MIME-Version: 1.0
In-Reply-To: <1528374154-14680-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Message-Id: <8e3ae6c8-c5d6-76b6-3350-490cf8f4f21f@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] pc-bios/s390-ccw: Allow network
 booting via pxelinux.cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>



On 06/07/2018 02:22 PM, Thomas Huth wrote:
> This patch series adds pxelinux.cfg-style network booting to the s390-ccw
> firmware. The core pxelinux.cfg loading and parsing logic has recently
> been merged to SLOF, so these patches now just have to make sure to call
> the right functions to get the config file loaded and parsed. Once this is
> done, the kernel and initrd are loaded separately, and are then glued
> together in RAM.
> 
> v2:
>  - Update SLOF submodule now that the git mirror is in sync again
>  - Last parameter to tftp_get_error_info() must not be NULL
>  - Check CC when calling STSI, and use a #define for the UUID offset
>  - Only support files with the magic "# pxelinux" string comment when
>    trying to guess the contents of a file that has been downloaded via
>    the "bootfile" DHCP parameter. This is just for developers' convenience,
>    the official way to specify pxelinux.cfg files is to use the DHCP
>    options 209 and 210 instead.
> 
> Thomas Huth (4):
>   roms: Update SLOF submodule to current status
>   pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
>   pc-bios/s390-ccw/net: Add support for pxelinux-style config files
>   pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the
>     UUID
> 
>  pc-bios/s390-ccw/netboot.mak |   9 +-
>  pc-bios/s390-ccw/netmain.c   | 226 +++++++++++++++++++++++++++++--------------
>  roms/SLOF                    |   2 +-
>  3 files changed, 162 insertions(+), 75 deletions(-)
> 

Series
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
