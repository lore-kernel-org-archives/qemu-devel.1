Received: from eggs.gnu.org ([2001:4830:134:3::10]:46511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d869m-0000cp-I2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d869g-0000nC-Ne
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:30:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d869g-0000n8-DW
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:30:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v49ESlZR113191
	for <qemu-devel@nongnu.org>; Tue, 9 May 2017 10:30:23 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2abfbdgr6v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 10:30:22 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 9 May 2017 15:30:19 +0100
Date: Tue, 9 May 2017 16:30:08 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170509082800.10756-2-aurelien@aurel32.net>
References: <20170509082800.10756-1-aurelien@aurel32.net>
	<20170509082800.10756-2-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170509163008.47eae2f9.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] target/s390x: mask the SIGP order_code
 using SIGP_ORDER_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue,  9 May 2017 10:27:58 +0200
Aurelien Jarno <aurelien@aurel32.net> wrote:

> For that move the definition from kvm.c to cpu.h
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/s390x/cpu.h         | 3 +++
>  target/s390x/kvm.c         | 2 --
>  target/s390x/misc_helper.c | 3 +--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

I guess this will go with the other patches in this series?
