Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303BBC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F0120673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F0120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCoTF-00057c-9B
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1iCniJ-0002mp-2t
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1iCniH-000748-KA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:30:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55406
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1iCniC-0006zQ-BC; Tue, 24 Sep 2019 12:30:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8OGM6SX037630; Tue, 24 Sep 2019 12:30:34 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v7mh6eppc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Sep 2019 12:30:34 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8OGPH5h008861;
 Tue, 24 Sep 2019 16:30:25 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03dal.us.ibm.com with ESMTP id 2v5bg75juq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Sep 2019 16:30:25 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8OGUOOc52953396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Sep 2019 16:30:24 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33EE978067;
 Tue, 24 Sep 2019 16:30:24 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AC027805C;
 Tue, 24 Sep 2019 16:30:23 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.160.71.206])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 24 Sep 2019 16:30:23 +0000 (GMT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <fcc3b597-856f-23bd-bc56-d886f021a2f4@us.ibm.com>
Date: Tue, 24 Sep 2019 11:30:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Subject: Re:  [PATCH 0/7] target/ppc: DFP fixes and improvements
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-24_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909240148
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark,

What tree / branch would these patches apply to?  (I've tried qemu master, dgibson master and ppc-for-4.2, or I'm doing something wrong.)

PC

On 9/24/19 10:35 AM, Mark Cave-Ayland wrote:
> This patchset fixes the DFP issue reported at https://urldefense.proofpoint.com/v2/url?u=https-3A__bugs.launchpad.net_qemu_-2Bbug_1841990&d=DwIDAg&c=jf_iaSHvJObTbx-siA1ZOg&r=0emNUfh2Pr0wDtXKlYJSCQ&m=NtaEgUJhN3SbT5hKyyOdgnt5ArLSzDw2l22WvleDMmU&s=qIBW6IX8pu3ej_AJj-toJH8PmhrvgJaXDJgbg1tgbY8&e= 
> caused by the change in FP register storage in commit ef96e3ae96 "target/ppc:
> move FP and VMX registers into aligned vsr register array" along with some
> further tidy-up/improvements.
> 
> Patches 1 and 2 introduce get/set helper functions for reading and writing
> DFP even-odd register pairs (rather than accessing the register pointers
> directly) which then leads to the real fix in patch 3.
> 
> Following on from this patches 4 to 6 change the struct PPC_DFP internal
> decimal representation from uint64[2] to ppc_vsr_t which enables us to use
> the existing VsrD() macro to access the correct elements regardless of host
> endian and remove the explicit HI_IDX and LO_IDX references.
> 
> Finally patch 7 simplifies the calls to set_dfp{64,128}() in DFP macros
> which can now be generated directly by the preprocessor rather than requiring
> an explicit if() statement.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> 
> Mark Cave-Ayland (7):
>   target/ppc: introduce get_dfp{64,128}() helper functions
>   target/ppc: introduce set_dfp{64,128}() helper functions
>   target/ppc: update {get,set}_dfp{64,128}() helper functions to
>     read/write DFP numbers correctly
>   target/ppc: introduce dfp_finalize_decimal{64,128}() helper functions
>   target/ppc: change struct PPC_DFP decimal storage from uint64[2] to
>     ppc_vsr_t
>   target/ppc: use existing VsrD() macro to eliminate HI_IDX and LO_IDX
>     from dfp_helper.c
>   target/ppc: remove unnecessary if() around calls to set_dfp{64,128}()
>     in DFP macros
> 
>  target/ppc/cpu.h        |   1 +
>  target/ppc/dfp_helper.c | 384 ++++++++++++++++++++--------------------
>  target/ppc/helper.h     |   2 +-
>  3 files changed, 193 insertions(+), 194 deletions(-)
> 

