Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4ABC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986EC24650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W+5z+Pgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986EC24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KWM-0007V3-Mq
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1j7KVH-0006RM-Er
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1j7KVG-0004x3-3m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:51:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1j7KVF-0004w9-R0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:51:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01REgexP183472;
 Thu, 27 Feb 2020 14:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=TkgmmhZIU3Z19aERoGe7v+RyQBUR7Ybp4nHQWFIEsE0=;
 b=W+5z+PgsbTAu1M7JTSlQj0qfrI8601abqDEuuv0r9z6GObUGfszgqxWUSGEF0wjQY+sX
 7s1i2KcaSCJak0/YgB2xvqGTfoFhqSfOxcBikDO5P6C7vQ0HI33nEx7SMHkVJPC7iKmw
 JC/e3RHDL1HANm7drXemcWTrhnhMGXg8Qm7NyaA1t6VF4+F5Kvxxb7nwCFqMmfVb7AyJ
 aUDpOqHi/mmyASfp+u6IGFfl8vpA+drZrWfEF86YM3DuktbawHWIoWkW1cpzhXPPn5RP
 8V3galXS2OFUthSiwdF4SWdu5Jbs5LXZg4Xo+ATDvfV/c8ZFqp3yd6FROecnBZ9EO0WC IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2ydct3bd6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2020 14:51:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01REiGDh128833;
 Thu, 27 Feb 2020 14:51:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2ydj4mqq6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2020 14:51:02 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01REp0dt030294;
 Thu, 27 Feb 2020 14:51:00 GMT
Received: from starbug-mbp.localdomain (/10.169.57.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Feb 2020 06:51:00 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 41A265AE9AF3;
 Thu, 27 Feb 2020 14:50:57 +0000 (GMT)
Date: Thu, 27 Feb 2020 14:50:56 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v2 0/2] Fix spelling/formatting in fuzzing patches
Message-ID: <20200227145056.obhvqkgwsfa5y5my@starbug-mbp>
Mail-Followup-To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 stefanha@redhat.com
References: <20200227031439.31386-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200227031439.31386-1-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270117
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the series:

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

On Wed, Feb 26, 2020 at 10:14:37PM -0500, Alexander Bulekov wrote:
>These patches fix some spelling and line-length violations introduced by
>the device-fuzzing changes:
>https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05965.html
>
>v2: fixes comment style in the fork_fuzz.ld linker script
>
>Alexander Bulekov (2):
>  fuzz: fix style/typos in linker-script comments
>  qtest: fix fuzzer-related 80-char limit violations
>
> qtest.c                       |  3 ++-
> tests/qtest/fuzz/fork_fuzz.ld | 16 ++++++++++------
> tests/qtest/fuzz/qos_fuzz.c   |  5 ++++-
> 3 files changed, 16 insertions(+), 8 deletions(-)
>
>-- 
>2.25.0
>
>

