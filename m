Received: from eggs.gnu.org ([2001:4830:134:3::10]:48542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cZXvZ-0000F1-8K
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cZXvU-0003xJ-8W
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:05:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55785
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cZXvU-0003wi-3q
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 02:04:56 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v136xIXT085033
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 02:04:55 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28ckgpbbqc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 02:04:54 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 3 Feb 2017 12:34:51 +0530
Date: Fri, 3 Feb 2017 12:34:46 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1486047755-93584-1-git-send-email-imammedo@redhat.com>
	<1486047755-93584-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486047755-93584-2-git-send-email-imammedo@redhat.com>
Message-Id: <20170203070446.GB12744@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr: cpu core: separate child
 threads destruction from machine state operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Thu, Feb 02, 2017 at 04:02:33PM +0100, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/ppc/spapr_cpu_core.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

I would mention explicitly that we are adding core unrealizefn and
doing threads' destruction from it now.

Otherwise, Reviewed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Regards,
Bharata.
