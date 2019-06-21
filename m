Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DACC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C934920673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hqsjbqId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C934920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heLjw-00031J-J7
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 11:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heLiC-0002Zs-Cq
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heLiB-0005mm-Fl
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:44:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heLiB-0005kU-26
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:44:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LFdFME104032;
 Fri, 21 Jun 2019 15:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=f00wV92w96RixkapeAWwN3VvQk62PD+Wm5Mb5zwChwc=;
 b=hqsjbqIdnyKMssNdsvCcgbJrlbiJbX64HJqY2PjtnGofxayhlCcvtNZRw1nTPnnZpWfA
 wGlUl8v9buik3WOxL1qVap6BB7xsVYL5ex8QyS7a3u7Tkcw+616kyZe+JztxtNy5r4h/
 OPswakpuoyyFCIKM732YQjR0d25oaHi4DLj5/B5u6CY596Lg2udnqngUnZ1jIuahSVZ7
 kFfZJBwqn5/sAya1pDDA5poTMryXO5i3GbDZ7RRQ7CXS+cBrrSaHk52VZXyqn8QkYaWj
 2gh7QckBRlS8q1bXKZ924eN1tdm8ARX6Z7fWu1WpMsluAMie8HHpWssHMMPRlowVs7/1 mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2t7809q6x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 15:44:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LFhai3058463;
 Fri, 21 Jun 2019 15:44:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2t77yp949j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 15:44:20 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5LFiKXZ017714;
 Fri, 21 Jun 2019 15:44:20 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 08:44:20 -0700
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <7c67d746-6095-25a8-d569-0d590024c3dc@redhat.com>
Date: Fri, 21 Jun 2019 18:44:17 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <B51C9BA9-A736-416B-82BF-2C0659AA7B77@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-21-git-send-email-pbonzini@redhat.com>
 <C67C73E9-F0FA-4711-98F1-BB5CD782E473@oracle.com>
 <3b4d778c-8c41-b8f2-7e1c-b7328072c3d5@redhat.com>
 <96B0BE25-AA15-4FAA-9228-A68C0845E110@oracle.com>
 <beac3448-d66f-438f-c0bf-b35bc7c90137@redhat.com>
 <10C55D5F-B505-4172-8500-D8EBCEA43941@oracle.com>
 <7c67d746-6095-25a8-d569-0d590024c3dc@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210126
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PULL 20/25] target/i386: kvm: Add support for
 save and restore nested state
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 21 Jun 2019, at 18:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 21/06/19 17:00, Liran Alon wrote:
>> Cool.
>> Are you planning to make those changes when applying/merging or
>> do you need me to submit a new patch-series version?
>> Also note my comment on the other patch regarding block migration on =
AMD vCPU which expose SVM.
>=20
> It's already merged, but it's not a big deal since it's only AMD.  We
> can follow up before release.
>=20
> Paolo

Ok then. We at least now have nVMX migration working in QEMU! :)
I will just submit additional separate patches on top of QEMU master.

Thanks,
-Liran


