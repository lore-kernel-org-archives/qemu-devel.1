Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CADDC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7E5206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OEPQZM/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7E5206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUA9-0007El-1f
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYU8B-0005aN-LW
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:35:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYU8A-0008Ex-24
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:35:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CCX2tC041815;
 Tue, 12 May 2020 12:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Vn5p8lWh+vgRLItTDCf9uQrjtVGk6M7tiVIq5ef3EJw=;
 b=OEPQZM/4viwcBfN6L9UIiwQwqKKg1lcDc1PmDr1efFgkLSnLGwNSJuVQ6L4HUX4RVsQH
 zHmSYsmQmZLl+muJOG2yb9mKrh2Pp3jhVe3TqsmijeP3/0uKLLJh+xu7NXSswO9JCJ2f
 1oYm7qo3uQKKU2/eA9J812k0oXOHCzir0V0WOtp968nA7k2aw4rl5zX19qeypqd+hOc9
 DwREubD49D+119n3BrY9V6TzMCVN+kXpdP9aHM+N7PdiubaNI8t87cKCwf+MMek48Acy
 oguDfooLNZsHDSUW21K08KxKryWFNp26XOV5jOKeRjryOMc3eyTR6ZgBWjB6r5A3Ve4c kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 30x3gsjn9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 May 2020 12:35:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CCWZM3047334;
 Tue, 12 May 2020 12:35:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 30xbgjf394-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 12:35:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04CCZIKT009590;
 Tue, 12 May 2020 12:35:18 GMT
Received: from dhcp-10-39-202-98.vpn.oracle.com (/10.39.202.98)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 12 May 2020 05:35:17 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RESEND v6 17/36] multi-process: introduce proxy object
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200512122327.GG300009@stefanha-x1.localdomain>
Date: Tue, 12 May 2020 08:35:15 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <73837C4E-28A6-4A65-9626-86498A5D5A3B@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <53e7ef183df66e34aa20c026b6bf299b1726ad75.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512122327.GG300009@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=3 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120094
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 07:56:54
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 swapnil.ingle@nutanix.com, John G Johnson <john.g.johnson@oracle.com>,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 12, 2020, at 8:23 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Wed, Apr 22, 2020 at 09:13:52PM -0700, elena.ufimtseva@oracle.com =
wrote:
>> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>=20
>> Defines a PCI Device proxy object as a parent of TYPE_PCI_DEVICE.
>=20
> s/parent/child/
>=20
>>=20
>> PCI Proxy Object registers as a PCI device with QEMU and forwards all
>> PCI accesses to the remote process using the communication channel.
>=20
> Please include that functionality in this patch. The code below just
> sets up a skeleton PCI device. There is no code that forwards accesses
> to the remote process.
>=20
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
>> ---
>> MAINTAINERS                   |  3 ++
>> hw/Makefile.objs              |  2 ++
>> hw/proxy/Makefile.objs        |  1 +
>> hw/proxy/qemu-proxy.c         | 56 =
+++++++++++++++++++++++++++++++++++
>> include/hw/proxy/qemu-proxy.h | 46 ++++++++++++++++++++++++++++
>> include/io/mpqemu-link.h      |  1 +
>> 6 files changed, 109 insertions(+)
>> create mode 100644 hw/proxy/Makefile.objs
>> create mode 100644 hw/proxy/qemu-proxy.c
>> create mode 100644 include/hw/proxy/qemu-proxy.h
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 96f8d7ff19..3da3dcd311 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2866,6 +2866,9 @@ F: include/remote/machine.h
>> F: remote/machine.c
>> F: include/remote/memory.h
>> F: remote/memory.c
>> +F: hw/proxy/Makefile.objs
>> +F: hw/proxy/qemu-proxy.c
>> +F: include/hw/proxy/qemu-proxy.h
>=20
> It's a generic PCI device. hw/pci/proxy.c would be a good location for
> it.
>=20
> By the way an alternative to the "proxy"/"remote" terminology is
> RemotePCIClient/RemotePCIServer. That makes it more obvious that =
"proxy"
> is related the "remote" feature. Feel free to keep the existing
> terminology, I just wanted to suggest another possibility.

OK, got it.

>=20
>>=20
>> Build and test automation
>> -------------------------
>> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
>> index af9235b6f2..7b489b12a5 100644
>> --- a/hw/Makefile.objs
>> +++ b/hw/Makefile.objs
>> @@ -45,6 +45,8 @@ endif
>> common-obj-y +=3D $(devices-dirs-y)
>> obj-y +=3D $(devices-dirs-y)
>>=20
>> +common-obj-$(CONFIG_MPQEMU) +=3D proxy/
>> +
>> remote-pci-obj-$(CONFIG_MPQEMU) +=3D core/
>> remote-pci-obj-$(CONFIG_MPQEMU) +=3D block/
>> remote-pci-obj-$(CONFIG_MPQEMU) +=3D pci/
>> diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
>> new file mode 100644
>> index 0000000000..eb81624cf8
>> --- /dev/null
>> +++ b/hw/proxy/Makefile.objs
>> @@ -0,0 +1 @@
>> +common-obj-$(CONFIG_MPQEMU) +=3D qemu-proxy.o
>> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
>> new file mode 100644
>> index 0000000000..bf6c4117ef
>> --- /dev/null
>> +++ b/hw/proxy/qemu-proxy.c
>> @@ -0,0 +1,56 @@
>> +/*
>> + * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +
>> +#include "qapi/error.h"
>> +#include "io/mpqemu-link.h"
>> +#include "hw/proxy/qemu-proxy.h"
>> +#include "hw/pci/pci.h"
>> +
>> +static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
>> +{
>> +    PCIProxyDev *dev =3D PCI_PROXY_DEV(device);
>> +    PCIProxyDevClass *k =3D PCI_PROXY_DEV_GET_CLASS(dev);
>> +    Error *local_err =3D NULL;
>> +
>> +    if (k->realize) {
>=20
> Will anything inherit from this class? I thought this is the remote =
PCI
> client that can acts as a stand-in for all remote PCI devices, so it's
> not clear why it's acting as a base class here.

No one is inheriting from this class anymore. This is code from before
when that was the case. We could remove this.

>=20
>> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
>> index d46cb81058..73cc59b874 100644
>> --- a/include/io/mpqemu-link.h
>> +++ b/include/io/mpqemu-link.h
>> @@ -14,6 +14,7 @@
>> #include "qemu/osdep.h"
>> #include "qemu-common.h"
>>=20
>> +#include "sys/eventfd.h"
>=20
> Why? Nothing in this patch uses this header.

OK, got it.

Thanks!
=E2=80=94
Jag


