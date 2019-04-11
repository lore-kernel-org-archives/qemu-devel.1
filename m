Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD38C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 21:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78352146F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 21:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78352146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEhFX-0000WY-JU
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 17:28:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hEhEh-0000Bv-Ar
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 17:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hEhEf-0000mi-MN
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 17:27:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1hEhEf-0000lt-7Y
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 17:27:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BLFhFG015447
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 17:27:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rtc9v300t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 17:27:49 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Thu, 11 Apr 2019 22:27:48 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
	by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 11 Apr 2019 22:27:46 +0100
Received: from b03ledav004.gho.boulder.ibm.com
	(b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3BLRiIm22741166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 11 Apr 2019 21:27:44 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5202078060;
	Thu, 11 Apr 2019 21:27:44 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 349107805C;
	Thu, 11 Apr 2019 21:27:43 +0000 (GMT)
Received: from [9.80.220.2] (unknown [9.80.220.2])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu, 11 Apr 2019 21:27:42 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
	<4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
Date: Thu, 11 Apr 2019 17:27:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19041121-8235-0000-0000-00000E7E3B9B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010911; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000284; SDB=6.01187706; UDB=6.00622150;
	IPR=6.00968469; 
	MB=3.00026399; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 21:27:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041121-8236-0000-0000-0000451C5F12
Message-Id: <571b9f8c-cfb0-704e-ded4-8661a8136876@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-11_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904110137
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0a-001b2d01.pphosted.com id x3BLFhFG015447
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe to access
 channel programs
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
Cc: linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
	kvm@vger.kernel.org, qemu-s390x@nongnu.org,
	Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411212742.bLGON4chEcIy9XHAU7JLBIkMcS_H4FbDQbwweyfKEFM@z>



On 4/10/19 10:59 PM, Eric Farman wrote:
>=20
>=20
> On 4/9/19 7:34 PM, Halil Pasic wrote:
>> On Mon, 8 Apr 2019 19:07:47 +0200

...snip...

>> I'm just running fio on a pass-through DASD and on some virto-blk disk=
s
>> in parallel. My QEMU is today's vfio-ccw-caps from your repo.
>>
>> I see stuff like this:
>> qemu-git: vfio-ccw: wirte I/O region failed with errno=3D16[1811/7332/=
0=20
>> iops] [eta 26m:34s]
>=20
> Without knowing what the I/O was that failed, this is a guessing game.=20
> But I encountered something similar just now running fio.
>=20
> qemu:
> 2019-04-11T02:06:09.524838Z qemu-system-s390x: vfio-ccw: wirte I/O=20
> region failed with errno=3D16

...snip...

>  From the associated I/O, I think this is fixed by a series I am nearly=
=20
> ready to send for review.=C2=A0 I'll try again with those fixes on top =
of the=20
> two series here, and report back.

So, I've run enough combinations to feel comfortable saying that the=20
error (EBUSY) I saw last night (and presumably the one Halil saw) exists=20
in today's code and is not introduced by this series.  It also appears=20
to be addressed by one of the patches in a series I'm working on, but=20
which that series still has some further problems.  Sigh, there are too=20
many branches and too many interrupts.

  - Eric


