Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06A6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F8B2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F8B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQ8r-00040r-3P
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1iwQ7m-0003Zl-MY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1iwQ7l-0002hE-L3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:37:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1iwQ7l-0002gw-Dd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:37:45 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00SCb0Hi094625
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 07:37:44 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrhv1nu5q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 07:37:43 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Tue, 28 Jan 2020 12:37:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 28 Jan 2020 12:37:37 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00SCbalg22609938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2020 12:37:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52A17A405B;
 Tue, 28 Jan 2020 12:37:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01951A4065;
 Tue, 28 Jan 2020 12:37:36 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.43])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2020 12:37:35 +0000 (GMT)
Date: Tue, 28 Jan 2020 13:37:34 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 78/80] hostmem: fix strict bind policy
In-Reply-To: <20200128130740.2f075e04@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-79-git-send-email-imammedo@redhat.com>
 <20200124201748.1882b620.pasic@linux.ibm.com>
 <20200127083925.225859bc@redhat.com>
 <20200127154145.42e5a197.pasic@linux.ibm.com>
 <20200128130740.2f075e04@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012812-0012-0000-0000-000003816D95
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012812-0013-0000-0000-000021BDC0E7
Message-Id: <20200128133734.6cbbc7dc.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-28_03:2020-01-24,
 2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280101
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: gongsu@us.ibm.com, Cornelia Huck <cohuck@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 13:07:40 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 27 Jan 2020 15:41:45 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 27 Jan 2020 08:39:25 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
[..]
> > > 
> > > one should be able to use memory-backend property to make it work
> > > instead of -m convenience option in s390 case.  
> > 
> > Thank you very much for the quick response!
> > 
> > Honestly, I overlooked the memory-backed machine property, but regardless
> > of that -machine,memory-backend=id *does not seem viable* at the
> > moment.
> > 
[..]
> > 
> > Or, am I using it wrong?
> 
> You right, 
> I even had an alternative impl. earlier that used string property
> instead of link, but later I forgot about this complication
> and simplified it to link property which works fine but only
> for -m case.
> 
> It's necessary to rewrite patches 2-4/80 to use string property
> for memory-backend which will be used for delayed backend access
> at machine_run_board_init() time.
> 
> I'll CC you on relevant patches for reviewing when I post v4.
> 

Thanks! I will give it a spin. 

Halil


