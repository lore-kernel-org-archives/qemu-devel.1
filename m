Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAD6C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F28206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kswmKBuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F28206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36582 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heM65-0006Pp-Ny
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 12:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36499)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heLzO-0000lp-VE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heLzN-0002M2-BX
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:02:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heLzN-000228-1J
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:02:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LFwvaJ113559;
 Fri, 21 Jun 2019 16:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=EjVSLH1q4r+/8T1DyKa3WCpao6GbyyT8Rt4WJWx6pbY=;
 b=kswmKBuCeNVzexyPL/kXAUdcWbgPTP6MvH0GfhX2CKM+Oso9oId5KRUwfeaae5Lp6nwy
 KAXVeFL72VcXmImgATUNs5xmvoyvetHcp9ZB4PJFz3EsczcpSYCh6mZcUS+I3757YpaK
 /0ionY4GpCYr1+sCtNnV/9DTalOwebBZGJbEN2kU9aXzO7JAbu+XFsSsdPd9N+iU0qas
 Oorr4ZHsOhcu0IKDR8tQ6bnZEYxwM8t96gPV89jSnsPjvPNgvA5umh/kzTSCoyd/mjCk
 C+J0FuyT1aApZMi0Rqhn4n5okPRKWpnvEZNsBCrrTRQC0GdXhd9jGvK7ZVVm/nORGds1 Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t7809qbeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 16:01:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LG1JBE165213;
 Fri, 21 Jun 2019 16:01:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2t7rdxtre7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 16:01:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5LG1q9q026486;
 Fri, 21 Jun 2019 16:01:52 GMT
Received: from [192.168.14.112] (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 09:01:51 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <B51C9BA9-A736-416B-82BF-2C0659AA7B77@oracle.com>
Date: Fri, 21 Jun 2019 19:01:49 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <7735CAAD-2518-4F0E-A28A-7ED6BD36E52D@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-21-git-send-email-pbonzini@redhat.com>
 <C67C73E9-F0FA-4711-98F1-BB5CD782E473@oracle.com>
 <3b4d778c-8c41-b8f2-7e1c-b7328072c3d5@redhat.com>
 <96B0BE25-AA15-4FAA-9228-A68C0845E110@oracle.com>
 <beac3448-d66f-438f-c0bf-b35bc7c90137@redhat.com>
 <10C55D5F-B505-4172-8500-D8EBCEA43941@oracle.com>
 <7c67d746-6095-25a8-d569-0d590024c3dc@redhat.com>
 <B51C9BA9-A736-416B-82BF-2C0659AA7B77@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210129
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
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



> On 21 Jun 2019, at 18:44, Liran Alon <liran.alon@oracle.com> wrote:
>=20
>=20
>=20
>> On 21 Jun 2019, at 18:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>=20
>> On 21/06/19 17:00, Liran Alon wrote:
>>> Cool.
>>> Are you planning to make those changes when applying/merging or
>>> do you need me to submit a new patch-series version?
>>> Also note my comment on the other patch regarding block migration on =
AMD vCPU which expose SVM.
>>=20
>> It's already merged, but it's not a big deal since it's only AMD.  We
>> can follow up before release.
>>=20
>> Paolo
>=20
> Ok then. We at least now have nVMX migration working in QEMU! :)
> I will just submit additional separate patches on top of QEMU master.
>=20
> Thanks,
> -Liran
>=20

Oh the applied patch-series is not very nice actually=E2=80=A6
It seems that some of the commits cannot even compile such as =
"target/i386: kvm: Block migration for vCPUs exposed with nested =
virtualization".
You have removed cpu_has_nested_virt(env) from that commit even though =
it is used=E2=80=A6
But as the author of the commit I will be blamed for this broken =
bisection :(
LOL. Oh well=E2=80=A6 Mistakes happen. :)

-Liran


