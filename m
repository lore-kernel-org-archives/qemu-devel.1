Received: from eggs.gnu.org ([2001:4830:134:3::10]:41552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cg7Rc-0004s5-1Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cg7RX-0001E4-3H
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:13:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40168
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cg7RW-0001Dm-SN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:13:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1LA8fhH109692
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:13:09 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28rk5e1554-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:13:09 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 21 Feb 2017 10:13:07 -0000
Date: Tue, 21 Feb 2017 11:13:01 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <967f7397-9995-0d24-bf35-682da2c732ff@redhat.com>
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<20170220141943.8426-2-cornelia.huck@de.ibm.com>
	<967f7397-9995-0d24-bf35-682da2c732ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170221111301.4a3f0c28.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] elf-loader: Allow late loading of elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, agraf@suse.de, Farhan Ali <alifm@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

(restored cc:s)

On Mon, 20 Feb 2017 16:33:36 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 20.02.2017 15:19, Cornelia Huck wrote:
> > From: Farhan Ali <alifm@linux.vnet.ibm.com>
> > 
> > The current QEMU ROM infrastructure rejects late loading of ROMs.
> > And ELFs are currently loaded as ROM, this prevents delayed loading
> > of ELFs. So when loading ELF, allow the user to specify if ELF should
> > be loaded as ROM or not.
> > 
> > If an ELF is not loaded as ROM, then they are not restored on a
> > guest reboot/reset and so its upto the user to handle the reloading.
> 
> Could you maybe also explain here why you need such a delayed ELF
> loading? Why can't you load the s390-netboot.img at the same time as
> s390-ccw.img?
> 
>  Thomas
> 
> 

Why should we load the netboot image in all cases, and not just when we
actually need it?
