Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE047C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB78206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xqGPD/1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB78206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXSo-0008Ka-PD
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jtXOC-000067-ED
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:19:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jtXOA-0001y0-Cd
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:19:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069EGi16192374;
 Thu, 9 Jul 2020 14:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=la6Wbq4x3VaHENzXZUNagc2jofjdNe/HZpsRNTH9a2E=;
 b=xqGPD/1O0KsSVU2R5Ctmw/MXy1a8+jvXHJmAO0ja/zgt9TSizfj+Hs1ZGA2rZQXhtFpE
 KsswKk8L5r4LeTEGkwMhkrp/jpjtgswXVCzoD2MadkZF4k5a++V4gS3V8x+Gmk5rAgum
 uxWGYbr+Fq950Zmj82mNVsc6Iupuhvuow2BZRpuHUHnQH6DtufVnz9OCdbtyrN/uQbVx
 4HH9SaQzo667YRNGVTPf3vG85/m9nCY1UQ0ypg8u5KwtX5MGM28V+5hCaV+qQPSB+AeC
 dU+cLIa1UbLN7WkO5vCM9On1By4iGxl+17Ge3KlSIlwU+dbxWIBomr6DHIEw4aiLM8DL dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 325y0ahwk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 09 Jul 2020 14:18:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069EDKP8190331;
 Thu, 9 Jul 2020 14:16:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 325k3han5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jul 2020 14:16:40 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 069EGbBC011543;
 Thu, 9 Jul 2020 14:16:37 GMT
Received: from [10.39.237.80] (/10.39.237.80)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 09 Jul 2020 07:16:36 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v7 00/21] Initial support for multi-process qemu
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200702134042.GG152912@stefanha-x1.localdomain>
Date: Thu, 9 Jul 2020 10:16:31 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <4316F79B-02ED-40D7-A1B2-7EA9D2EBA32A@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <20200702134042.GG152912@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090106
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 10:18:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jul 2, 2020, at 9:40 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Sat, Jun 27, 2020 at 10:09:22AM -0700, elena.ufimtseva@oracle.com =
wrote:
>> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>=20
>> This is the v7 of the patchset.
>=20
> I have completed the review and left comments on the patches.
>=20
> I'm glad it was possible to simplify this feature. The overall =
approach

Hi Stefan,

We=E2=80=99re also with you on this. The feature looks much simpler now.

> makes sense to me and I see how it forms the base on which
> VFIO-over-socket and smaller remote program builds using Kconfig can =
be
> developed.
>=20
> My main concern is that the object lifecycle has not been fully
> implemented in the proxy and remote device. Error handling is

Thank you for your feedback on. FWIW, we did check about the unrealize() =
path
in the object lifecycle management. We noticed that the destructor for =
the PCI
devices (pci_qdev_unrealize()) is currently not invoking the instance =
specific
destructor/unrealize functions. While this is not an excuse for not =
implementing
the unrealize functions, it currently doesn=E2=80=99t have an impact on =
the hot unplug path.

You=E2=80=99re correct, we should implement the unrealize/destructor for =
the Proxy & remote
objects. We=E2=80=99ll also look into any background for why the PCI =
devices don=E2=80=99t call
instance specific destructor.

> incomplete, resources are leaked, and hot unplug does not work. =
Thinking

We=E2=80=99ll double check the resource leak issues, specifically with =
respect to open
file destructors.

> through the lifecycle is very important so that additional work can
> build on top of this later. I have tried to point out these issues in
> the individual patches.

We got a chance to go over your feedback. We will send out responses to =
them
shortly.

Thank you very much!
--
Jag=

