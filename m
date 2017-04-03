Received: from eggs.gnu.org ([2001:4830:134:3::10]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cuxST-0006MM-UW
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cuxSQ-0004aI-S4
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:35:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cuxSQ-0004aC-Ia
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 04:35:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v338XnkN137403
	for <qemu-devel@nongnu.org>; Mon, 3 Apr 2017 04:35:25 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29jvy03fq9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 04:35:25 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 3 Apr 2017 09:35:23 +0100
Date: Mon, 3 Apr 2017 10:35:18 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <CA+KKJYBi31Bs7DtVdzZdwG2t+u5+FGiAhQpd3pqJzUX1O8Cprg@mail.gmail.com>
References: <CA+KKJYBi31Bs7DtVdzZdwG2t+u5+FGiAhQpd3pqJzUX1O8Cprg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170403103518.459f1c10.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 21/43] s390: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Danil Antonov <g.danil.anto@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net

On Sat, 1 Apr 2017 16:56:30 +0300
Danil Antonov <g.danil.anto@gmail.com> wrote:

> From cbc3425092b6ee94d6666365f8714a39af5a583a Mon Sep 17 00:00:00 2001
> From: Danil Antonov <g.danil.anto@gmail.com>
> Date: Wed, 29 Mar 2017 12:33:01 +0300
> Subject: [PATCH 21/43] s390: made printf always compile in debug output
> 
> Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
> This will ensure that printf function will always compile even if debug
> output is turned off and, in turn, will prevent bitrot of the format
> strings.
> 
> Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 18 +++++++++++-------
>  hw/s390x/s390-pci-inst.c | 18 +++++++++++-------
>  2 files changed, 22 insertions(+), 14 deletions(-)

This one missed some maintainer cc:s...

Queued for 2.10 as well.
