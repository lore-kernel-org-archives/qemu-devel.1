Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09565C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BF72084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nxS9vO0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BF72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvjd-0004h8-VC
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48737)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hcvgP-0003am-ET
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hcvgO-0002qN-5Y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:44:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hcvgN-0002nt-Oa
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:44:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HHhoeI140127;
 Mon, 17 Jun 2019 17:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=4Ft4B5LHThT/l5bOqqZuFBPdkfS0jei0j+liWl64d7s=;
 b=nxS9vO0dXJviUvkPaEZ27dH2IOw/IXpZYIcn0YSIKplpdQygeLCDhqmd7gCVghcy+frt
 5LPkZgO1kC/9ovNXHDJYiw2Pp/gsndk4RP5Hk2l/C0Hrr6+a75/OGb7cqceuva5Vlc+0
 LZORbS9SdpL7tGdJEMz/K9A99zFTPf7emfQfJkqMbCIUay7qZogP+D8POHU2FWuOf3FW
 8KE3xx/fq6/ZFEIsUZ+kLuepQSlEHuwlJSEVBsJ2N8dc2CXQN8u7f9wTtNwLfWkmRLWb
 Fv6A5sUtYKPszk064/znvDdWSt8czVBszj39WgjDGXb+6JVucBG0riiuv1tUWruZnVmw Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t4saq7uf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 17:44:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HHiOkK091684;
 Mon, 17 Jun 2019 17:44:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t5mgbfs5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 17:44:37 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HHiZ7s027997;
 Mon, 17 Jun 2019 17:44:36 GMT
Received: from [10.30.3.10] (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 10:44:35 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <d61b72cd-95df-c3b7-2f10-8b8ac1364479@redhat.com>
Date: Mon, 17 Jun 2019 20:44:32 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E392342-13CB-4F27-8FDD-8B82385DC8D5@oracle.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
 <20190615004256.16367-5-pbonzini@redhat.com>
 <829F36FB-3551-4682-9E69-50CC479DAC09@oracle.com>
 <d61b72cd-95df-c3b7-2f10-8b8ac1364479@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=981 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170158
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH 4/7] linux-headers: import improved
 definition of KVM_GET/SET_NESTED_STATE structs
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
Cc: qemu-devel@nongnu.org, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 17 Jun 2019, at 20:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 16/06/19 10:29, Liran Alon wrote:
>>=20
>> I think this is cleaner.
>>=20
>> -Liran
>=20
> Yes, it is.  I'll post it to kvm@vger.kernel.org.  Are you going to =
send
> v2 of this series or shall I?
>=20
> Paolo

The KVM patch is already submitted and I think you saw it.
I=E2=80=99m just about to send today a new v2 for the QEMU patches. It =
has additional changes.

-Liran


