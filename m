Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CDFC04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 07:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6734B20862
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 07:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRB6a-0004gP-Gn
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 03:47:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hRB5Y-00049u-JJ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 03:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1hRB5X-00058k-Kt
	for qemu-devel@nongnu.org; Thu, 16 May 2019 03:46:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
	id 1hRB5X-00057A-9k
	for qemu-devel@nongnu.org; Thu, 16 May 2019 03:46:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4G7b1l5130906
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 03:46:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sh1rtd6m6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 03:46:01 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
	Thu, 16 May 2019 08:45:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 16 May 2019 08:45:56 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4G7jt9644761304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 16 May 2019 07:45:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A9CAA405C;
	Thu, 16 May 2019 07:45:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA000A4054;
	Thu, 16 May 2019 07:45:53 +0000 (GMT)
Received: from sathnaga86 (unknown [9.122.211.101])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Thu, 16 May 2019 07:45:53 +0000 (GMT)
Date: Thu, 16 May 2019 13:15:51 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Greg Kurz <groug@kaod.org>
References: <155799221739.527449.14907564571096243745.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155799221739.527449.14907564571096243745.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-TM-AS-GCONF: 00
x-cbid: 19051607-0008-0000-0000-000002E738F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051607-0009-0000-0000-00002253DC99
Message-Id: <20190516074551.GB25414@sathnaga86>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-16_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905160052
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH] spapr: Print out extra hints when CAS
 negotiation of interrupt mode fails
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 09:36:57AM +0200, Greg Kurz wrote:
> Let's suggest to the user how the machine should be configured to allow
> the guest to boot successfully.
> 
> Suggested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_hcall.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-and-Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

2019-05-16T07:42:43.018771Z qemu-system-ppc64: Guest requested unavailable interrupt mode (XICS), either don't set the ic-mode machine property or try ic-mode=xics or ic-mode=dual
2019-05-16 07:42:43.394+0000: shutting down, reason=crashed

> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 63a55614b83d..aae9fd2b3e6d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1646,12 +1646,12 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>       */
>      if (guest_xive) {
>          if (spapr->irq->ov5 == SPAPR_OV5_XIVE_LEGACY) {
> -            error_report("Guest requested unavailable interrupt mode (XIVE)");
> +            error_report("Guest requested unavailable interrupt mode (XIVE), try the ic-mode=xive or ic-mode=dual machine property");
>              exit(EXIT_FAILURE);
>          }
>      } else {
>          if (spapr->irq->ov5 == SPAPR_OV5_XIVE_EXPLOIT) {
> -            error_report("Guest requested unavailable interrupt mode (XICS)");
> +            error_report("Guest requested unavailable interrupt mode (XICS), either don't set the ic-mode machine property or try ic-mode=xics or ic-mode=dual");
>              exit(EXIT_FAILURE);
>          }
>      }
> 


