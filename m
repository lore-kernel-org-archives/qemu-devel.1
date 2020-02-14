Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DEAC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892D5206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQZPn/Vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892D5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2YAU-00078m-Mk
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 05:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j2Y9n-0006Uj-SQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j2Y9m-0003OK-6y
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:25:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j2Y9m-0003Ir-2E
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581675909;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pU+V+UxKPs3P5u+G29kH9M0TDj7vqQAKV/UG0co3CY=;
 b=jQZPn/Vvw0SpnDBwPk7xldG44LraxDNmz0sFYwvL5K6g3fwJXyBeWWiPTS26rx420WWZhB
 MKziMSR1O+1OTUrYWzu9/aDIgv4/h9n3HILRdGJJagD8AmF4i/zI3Gd7mV7Fq9WEP/uU2a
 HBB3O6QO7jcXnYrPTRbQ6mjWTnEoaFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-3_al3f7-PMGialTbbckNoA-1; Fri, 14 Feb 2020 05:24:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E90381882CD1;
 Fri, 14 Feb 2020 10:24:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04DD38AC4B;
 Fri, 14 Feb 2020 10:24:53 +0000 (UTC)
Date: Fri, 14 Feb 2020 10:24:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: miaoyubo <miaoyubo@huawei.com>
Subject: Re: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Message-ID: <20200214102451.GA613610@redhat.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
 <20200213074952.544-3-miaoyubo@huawei.com>
 <20200213135145.GN594756@redhat.com>
 <3fc86f5a6aaf4c6f81dad4f25fcafda0@huawei.com>
MIME-Version: 1.0
In-Reply-To: <3fc86f5a6aaf4c6f81dad4f25fcafda0@huawei.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 3_al3f7-PMGialTbbckNoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Fri, Feb 14, 2020 at 07:25:43AM +0000, miaoyubo wrote:
>=20
> > -----Original Message-----
> > From: Daniel P. Berrang=C3=A9 [mailto:berrange@redhat.com]
> > Sent: Thursday, February 13, 2020 9:52 PM
> > To: miaoyubo <miaoyubo@huawei.com>
> > Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
> > imammedo@redhat.com; qemu-devel@nongnu.org; Xiexiangyou
> > <xiexiangyou@huawei.com>; mst@redhat.com
> > Subject: Re: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie
> > under arm.
> >=20
> > On Thu, Feb 13, 2020 at 03:49:52PM +0800, Yubo Miao wrote:
> > > From: miaoyubo <miaoyubo@huawei.com>
> > >
> > > Since devices could not directly plugged into pxb-pcie, under arm, on=
e
> > > pcie-root port is plugged into pxb-pcie. Due to the bus for each
> > > pxb-pcie is defined as 2 in acpi dsdt tables(one for pxb-pcie, one fo=
r
> > > pcie-root-port), only one device could be plugged into one pxb-pcie.
> >=20
> > What is the cause of this arm specific requirement for pxb-pcie and mor=
e
> > importantly can be fix it so that we don't need this patch ?
> > I think it is highly undesirable to have such a per-arch difference in
> > configuration of the pxb-pcie device. It means any mgmt app which alrea=
dy
> > supports pxb-pcie will be broken and need to special case arm.
> >=20
>=20
> Thanks for your reply, Without this patch, the pxb-pcie is also useable,=
=20
> however, one extra pcie-root-port or pci-bridge or something else need=20
> to be defined by mgmt. app. This patch will could be abandoned.

That's not really answering my question. IIUC, this pxb-pcie device
works fine on x86_64, and I want to know why it doesn't work on arm ?
Requiring different setups by the mgmt apps is not at all nice because
it will inevitably lead to broken arm setups. x86_64 gets far more testing
& usage, developers won't realize arm is different.



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


