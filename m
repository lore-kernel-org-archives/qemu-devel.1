Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2886CC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022D4206E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022D4206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVEne-0003YI-1q
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1iVEmj-00035P-48
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1iVEmh-0006AD-T3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:03:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24092
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1iVEmh-0006A1-OT
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:03:39 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xAECuhTe177984
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 08:03:39 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w95qbmn71-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 08:03:35 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Thu, 14 Nov 2019 13:02:41 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Nov 2019 13:02:38 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAED2bup48824554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 13:02:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01850AE05A;
 Thu, 14 Nov 2019 13:02:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8DEFAE056;
 Thu, 14 Nov 2019 13:02:36 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.41])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 14 Nov 2019 13:02:36 +0000 (GMT)
Date: Thu, 14 Nov 2019 14:02:35 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub
 Channels tests
In-Reply-To: <20191114113823.5d752648.cohuck@redhat.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
 <20191114113823.5d752648.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111413-0016-0000-0000-000002C39AB9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111413-0017-0000-0000-000033253C91
Message-Id: <20191114140235.30a788d6.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-14_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140121
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
Cc: thuth@redhat.com, frankja@linux.ibm.com,
 Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 11:38:23 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 13 Nov 2019 20:02:33 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> Minor nit for $SUBJECT: this isn't a kvm-unit-tests patch, that's just
> one consumer :)

And subchannel is one word in s390-speak.

> 

[..]

> Some questions regarding this device and its intended usage:
> 
> - What are you trying to test? Basic ccw processing, or something more
>   specific? Is there any way you can use the kvm-unit-test
>   infrastructure to test basic processing with an existing device?

I'm also curious about the big picture (what is in scope and what out
of scope). Your design should be evaluated in the light of intended
usage.

BTW have you had a look at this abandoned patch-set of mine:

https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04220.html

We made some different design decisions, while aiming essentially for the
same. Maybe it's due to different scope, maybe not. For instance one
can't test IDA with PONG, I guess.

Regards,
Halil

> - Who is instantiating this device? Only the kvm-unit-test?
> - Can you instantiate multiple instances? Does that make sense? If yes,
>   it should probably not request a new chpid every time :)
> - What happens if someone instantiates this by hand? The only drawback
>   is that it uses up a subchannel and a chpid, right?
> - Do you plan to make this hotpluggable later?
> 
> 


