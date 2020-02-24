Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F320C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8BD20828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+ToiSGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8BD20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Cyx-0007rv-GC
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j6CyK-0007Pv-1D
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j6CyI-0007lS-IR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:36:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50947
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j6CyI-0007l8-EV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582547785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sQKXA/vIJD8x4wO/9gpqU5mLEVmJZfQsa+odjyIjR4=;
 b=S+ToiSGT4VMWX/qOaXnPQN0P1vCuqOcAjcx86fvJYULobabRsPEI/D4y6kskDqopL7MoJE
 f4TSp5yFWiUVipQLQAHc+PdwXi17mWwOrWvMEFTFqzGlcobRp7p5oa+xriE0HTODO256yA
 NkrzxsQGhIdINLt+mi5M06kqdedCod0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-mOcV9FeWPJaVFOKfE3mbDw-1; Mon, 24 Feb 2020 07:36:14 -0500
X-MC-Unique: mOcV9FeWPJaVFOKfE3mbDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 970D718A6EC0;
 Mon, 24 Feb 2020 12:36:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A2A95C3FA;
 Mon, 24 Feb 2020 12:36:08 +0000 (UTC)
Date: Mon, 24 Feb 2020 12:36:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: miaoyubo <miaoyubo@huawei.com>
Subject: Re: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Message-ID: <20200224123606.GM635661@redhat.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
 <20200213074952.544-3-miaoyubo@huawei.com>
 <20200213135145.GN594756@redhat.com>
 <3fc86f5a6aaf4c6f81dad4f25fcafda0@huawei.com>
 <20200214102451.GA613610@redhat.com>
 <8f977fbdd8e346ef911ebfe71dbb1514@huawei.com>
MIME-Version: 1.0
In-Reply-To: <8f977fbdd8e346ef911ebfe71dbb1514@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 15, 2020 at 08:59:28AM +0000, miaoyubo wrote:
>=20
> > -----Original Message-----
> > From: Daniel P. Berrang=C3=A9 [mailto:berrange@redhat.com]
> > Sent: Friday, February 14, 2020 6:25 PM
> > To: miaoyubo <miaoyubo@huawei.com>
> > Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
> > imammedo@redhat.com; qemu-devel@nongnu.org; Xiexiangyou
> > <xiexiangyou@huawei.com>; mst@redhat.com
> > Subject: Re: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie =
under
> > arm.
> >=20
> > On Fri, Feb 14, 2020 at 07:25:43AM +0000, miaoyubo wrote:
> > >
> > > > -----Original Message-----
> > > > From: Daniel P. Berrang=C3=A9 [mailto:berrange@redhat.com]
> > > > Sent: Thursday, February 13, 2020 9:52 PM
> > > > To: miaoyubo <miaoyubo@huawei.com>
> > > > Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
> > > > imammedo@redhat.com; qemu-devel@nongnu.org; Xiexiangyou
> > > > <xiexiangyou@huawei.com>; mst@redhat.com
> > > > Subject: Re: [RFC 2/2] pci-expender-bus:Add pcie-root-port to
> > > > pxb-pcie under arm.
> > > >
> > > > On Thu, Feb 13, 2020 at 03:49:52PM +0800, Yubo Miao wrote:
> > > > > From: miaoyubo <miaoyubo@huawei.com>
> > > > >
> > > > > Since devices could not directly plugged into pxb-pcie, under arm=
,
> > > > > one pcie-root port is plugged into pxb-pcie. Due to the bus for
> > > > > each pxb-pcie is defined as 2 in acpi dsdt tables(one for
> > > > > pxb-pcie, one for pcie-root-port), only one device could be plugg=
ed into
> > one pxb-pcie.
> > > >
> > > > What is the cause of this arm specific requirement for pxb-pcie and
> > > > more importantly can be fix it so that we don't need this patch ?
> > > > I think it is highly undesirable to have such a per-arch difference
> > > > in configuration of the pxb-pcie device. It means any mgmt app whic=
h
> > > > already supports pxb-pcie will be broken and need to special case a=
rm.
> > > >
> > >
> > > Thanks for your reply, Without this patch, the pxb-pcie is also
> > > useable, however, one extra pcie-root-port or pci-bridge or something
> > > else need to be defined by mgmt. app. This patch will could be abando=
ned.
> >=20
> > That's not really answering my question. IIUC, this pxb-pcie device wor=
ks fine
> > on x86_64, and I want to know why it doesn't work on arm ?
> > Requiring different setups by the mgmt apps is not at all nice because =
it will
> > inevitably lead to broken arm setups. x86_64 gets far more testing & us=
age,
> > developers won't realize arm is different.
> >=20
> >
>=20
> Thanks for replying. Currently, on x86_64, pxb-pcie devices is presented
> in acpi tables but on arm, It is not, only one main host bridge is
> presented for arm in acpi dsdt tables. That's why pxb-pcie works on
> x86_64 but doesn't work on arm. The patch 1/2 do the work to present
> and allocate resources for pxb-pcie in arm.

Yes, this first patch makes sense

> For x86_64, if one device is going to be plugged into pxb-pcie, one
> extra pcie-root-port or pci-bridge have to be defined and plugged on
> pxb-pcie, then the device is plugged on the pcie-root-port or pci-bridge.

> This patch 2/2 just auto defined one pcie-root-port for arm. If this
> patch abandoned, the usage of pxb-pcie would be the same with x86_64,
> therefore, to keep the same step for x86 and arm, this patch 2/2 could
> be abandonded.

Yes, I think abandoning this patch 2 is best. Applications that know
how to use pxb-pcie on x86_64, will already do the right thing on
arm too, once your first patch is merged.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


