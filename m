Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC51C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBC82070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OOaC93eZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBC82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcufH-0002n3-NN
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58008)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hctKd-0005uq-PY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hctKb-00045L-Ug
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:14:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hctKX-0003zx-Ed; Mon, 17 Jun 2019 11:13:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HF3kBi194566;
 Mon, 17 Jun 2019 15:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=WCE/eVOInWRjDUXPI18eufrIj4kFcHynJE1+yfekyrk=;
 b=OOaC93eZ00eHhS2ZM09A1qiRH09wsY/01xb9VqCAprjWP4lSHij1WbE7JTK7iYmDBWlG
 h9VPjDyEGs5RhtUrtP91HZXjAdfctLIMfMElO3sDRY0TiKo1JiGvBWpY1qO7luLWNB3Y
 q+duvgPurDn50b61AipqvV/AkuVprPHdPwFHGMLFcuqWJeLPXfrPqo5eALB0sD6uSfHG
 WnAQUToEkbJL26Nd80Ol79JgW/l9JnJ2oQaI2sX9oFxzcSJt4oigTy8zMuTCzOm09fUz
 JqGb+leWqQzUejX3kZ0FlMxt8oBiN5ZKF8IB2WE1bCB82IhXTo1MaBFlgIS7TOD4dTjA sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t4r3tf7h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 15:13:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HFD6ij153602;
 Mon, 17 Jun 2019 15:13:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2t5h5t6gm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 15:13:55 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HFDs2N005822;
 Mon, 17 Jun 2019 15:13:54 GMT
Received: from [10.0.5.157] (/213.57.127.10)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 08:13:54 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190617144810.GA31709@morn.lan>
Date: Mon, 17 Jun 2019 18:13:48 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <09CBB1C5-1091-43A2-BC09-126FA86DFD6E@oracle.com>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612115939.23825-8-shmuel.eiderman@oracle.com>
 <20190617072040.yriunmoffbjhvqc5@sirius.home.kraxel.org>
 <ECEA4896-C290-45A7-9574-D1704C63842C@oracle.com>
 <20190617144810.GA31709@morn.lan>
To: "Kevin O'Connor" <kevin@koconnor.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170136
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [QEMU] [PATCH v2 7/8] bootdevice: FW_CFG interface
 for LCHS values
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 liran.alon@oracle.com, Gerd Hoffmann <kraxel@redhat.com>,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 17 Jun 2019, at 17:48, Kevin O'Connor <kevin@koconnor.net> wrote:
>=20
> On Mon, Jun 17, 2019 at 10:36:54AM +0300, Sam Eiderman wrote:
>> So overall, WDYT?
>> Keep it extendible for a low price of ABI + =E2=80=9Cbootdevices=E2=80=9D=
 name.
>> Or go strict and rename to =E2=80=9Cbios-geometries=E2=80=9D?
>=20
> If we add another qemu to firmware interface I think the interface
> should be documented.  I also think that a mix of an ascii and binary
> interface is going to be difficult to describe and document.  I'd
> prefer a pure ascii interface - for example a newline separated list
> of four space separted fields: <device name> <cylinders> <heads> <spt>

We can go pure ascii.
I meanwhile sent a v3 QEMU and v2 SeaBIOS patches for more comments.

Sam

>=20
> -Kevin


