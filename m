Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6830CC606B4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F3920861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F3920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkTYZ-00047y-CS
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 09:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hkTWk-0002lO-G3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hkTWi-0000Pd-DN
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:17:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hkTWV-0008KI-Vs; Mon, 08 Jul 2019 09:17:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 930B98E22C;
 Mon,  8 Jul 2019 13:16:50 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01AD42B9F5;
 Mon,  8 Jul 2019 13:16:46 +0000 (UTC)
Message-ID: <7470cb6f1a3889015a086d340cc83ff326b9e720.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "wangjie (P)" <wangjie88@huawei.com>
Date: Mon, 08 Jul 2019 16:16:43 +0300
In-Reply-To: <20190705075053.GA5016@dhcp-200-226.str.redhat.com>
References: <2b55a1d9-7c4f-c895-95fa-a32a7f63ad07@huawei.com>
 <20190705075053.GA5016@dhcp-200-226.str.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 08 Jul 2019 13:16:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] 
 =?utf-8?q?=5BQemu-block=5D_question=EF=BC=9Aabout_i?=
 =?utf-8?q?ntroduce_a_new_feature_named_=E2=80=9CI/O_hang=E2=80=9D?=
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
Cc: qemu-block@nongnu.org, "Fangyi \(C\)" <eric.fangyi@huawei.com>,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-07-05 at 09:50 +0200, Kevin Wolf wrote:
> Am 04.07.2019 um 17:16 hat wangjie (P) geschrieben:
> > Hi, everybody=EF=BC=9A
> >=20
> > I developed a feature named "I/O hang"=EF=BC=8Cmy intention is to sol=
ve the problem
> > like that=EF=BC=9A
> > If the backend storage media of VM disk is far-end storage like IPSAN=
 or
> > FCSAN, storage net link will always disconnection and
> > make I/O requests return EIO to Guest, and the status of filesystem i=
n Guest
> > will be read-only, even the link recovered
> > after a while, the status of filesystem in Guest will not recover.
>=20
> The standard solution for this is configuring the guest device with
> werror=3Dstop,rerror=3Dstop so that the error is not delivered to the g=
uest,
> but the VM is stopped. When you run 'cont', the request is then retried=
.
>=20
> > So I developed a feature named "I/O hang" to solve this problem, the
> > solution like that=EF=BC=9A
> > when some I/O requests return EIO in backend, "I/O hang" will catch t=
he
> > requests in qemu block layer and
> > insert the requests to a rehandle queue but not return EIO to Guest, =
the I/O
> > requests in Guest will hang but it does not lead
> > Guest filesystem to be read-only, then "I/O hang" will loop to rehand=
le the
> > requests for a period time(ex. 5 second) until the requests
> > not return EIO(when backend storage link recovered).
>=20
> Letting requests hang without stopping the VM risks the guest running
> into timeouts and deciding that its disk is broken.
I came to say exactly this.
While developing the nvme-mdev I also had this problem and due to assumpt=
ions built in the block layer,
you can't just let the guest wait forever for a request.

Note that Linux's nvme driver does know how to retry failed requests, inc=
luding these that timed out if that helps in any way.

Best regards,
	Maxim Levitsky


>=20
> As you say your "hang" and retry logic sits in the block layer, what do
> you do when you encounter a bdrv_drain() request?
>=20
> > In addition to the function as above, "I/O hang" also can sent event =
to
> > libvirt after backend storage status changed.
> >=20
> > configure methods:
> > 1. "I/O hang" ability can be configured for each disk as a disk attri=
bute.
> > 2. "I/O hang" timeout value also can be configured for each disk, whe=
n
> > storage link not recover in timeout value,
> >    "I/O hang" will disable rehandle I/O requests and return EIO to Gu=
est.
> >=20
> > Are you interested in the feature?  I intend to push this feature to =
qemu
> > org, what's your opinion?
>=20
> Were you aware of werror/rerror? Before we add another mechanism, we
> need to be sure how the features compare, that the new mechanism
> provides a significant advantage and that we keep code duplication as
> low as possible.
>=20
> Kevin
>=20



