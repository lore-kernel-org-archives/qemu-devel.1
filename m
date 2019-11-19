Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A664C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64231219FA
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64231219FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7nH-00078A-IJ
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 13:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1iX7mc-0006gh-PP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1iX7mb-0007L5-6z
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:59:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3494
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1iX7mb-0007Kp-2A
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:59:21 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAJHvcGo056978
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:59:19 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf46b10k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:59:19 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Tue, 19 Nov 2019 17:59:17 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 19 Nov 2019 17:59:15 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAJHxEkF29229546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 17:59:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E355442042;
 Tue, 19 Nov 2019 17:59:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9CB742041;
 Tue, 19 Nov 2019 17:59:13 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.42])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2019 17:59:13 +0000 (GMT)
Date: Tue, 19 Nov 2019 18:59:11 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 1/8] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL
 for EIO
In-Reply-To: <20191119130220.7c0eef35.cohuck@redhat.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-2-farman@linux.ibm.com>
 <20191118191334.001f9343.cohuck@redhat.com>
 <20191119122340.41c77c5b.pasic@linux.ibm.com>
 <20191119130220.7c0eef35.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111917-0028-0000-0000-000003BBE0E6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111917-0029-0000-0000-0000247EFF70
Message-Id: <20191119185911.0ccec0c9.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 13:02:20 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 19 Nov 2019 12:23:40 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 18 Nov 2019 19:13:34 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > > EIO is returned by vfio-ccw mediated device when the backing
> > > > host subchannel is not operational anymore. So return cc=3
> > > > back to the guest, rather than returning a unit check.
> > > > This way the guest can take appropriate action such as
> > > > issue an 'stsch'.    
> > > 
> > > Hnm, I'm trying to recall whether that was actually a conscious choice,
> > > but I can't quite remember... the change does make sense at a glance,
> > > however.  
> > 
> > Is EIO returned if and only if the host subchannel/device is not
> > operational any more, or are there cases as well? 
> 
> Ok, I walked through the kernel code, and it seems -EIO can happen

Thanks Connie for having a look.

> - when we try to do I/O while in the NOT_OPER or STANDBY states... cc 3
>   makes sense in those cases

I do understand NOT_OPER, but I'm not sure about STANDBY.

Here is what the PoP says about cc 3 for SSCH.
"""
Condition code 3 is set, and no other action is
taken, when the subchannel is not operational for
START SUBCHANNEL. A subchannel is not opera-
tional for START SUBCHANNEL if the subchannel is
not provided in the channel subsystem, has no valid
device number associated with it, or is not enabled.
"""

Are we guaranteed to reflect one of these conditions back?

Under what circumstances do we expect that our request will
find the device in STANDBY?

> - when the cp is not initialized when trying to fetch the orb... which
>   is an internal vfio-ccw kernel module error


So the answer seems to be, no EIO is also used for something else than
'device not operational' in a sense of the s390 IO architecture (cc=3
and stuff).

AFAIR the idea was that EIO means something is broken, and we decided
to reflect that as an unit check (because the broader device -- the
actual device + our pass-through code == device for the guest) is broken.
So I think it was a conscious choice.

Regards,
Halil

> 
> Btw., this patch only changes one of the handlers; I think you have to
> change all of start/halt/clear?
> 
> [Might also be good to double-check the handling for the different
> instructions.]
> 
> > Is the mapping
> > (cc to condition) documented? By the QEMU code I would think that
> > we already have ENODEV and EACCESS for 'not operational' -- no idea
> > why we need two codes though.
> 
> -ENODEV: device gone
> -EACCES: no path operational
> 
> We should be able to distinguish between the two; in the 'no path
> operational' case, the device may still be accessible with a different
> path mask in the request.
> 


