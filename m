Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC3DC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40779218BB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40779218BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjJ1H-0006dQ-Iw
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49620)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hjJ08-0005OD-0E
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hjJ06-0004s5-Vl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:51:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hjJ04-0004r3-KH; Fri, 05 Jul 2019 03:51:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 40E4930BC589;
 Fri,  5 Jul 2019 07:51:02 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C661868C7E;
 Fri,  5 Jul 2019 07:50:54 +0000 (UTC)
Date: Fri, 5 Jul 2019 09:50:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "wangjie (P)" <wangjie88@huawei.com>
Message-ID: <20190705075053.GA5016@dhcp-200-226.str.redhat.com>
References: <2b55a1d9-7c4f-c895-95fa-a32a7f63ad07@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b55a1d9-7c4f-c895-95fa-a32a7f63ad07@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 05 Jul 2019 07:51:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] 
 =?utf-8?q?question=EF=BC=9Aabout_introduce_a_new_fe?=
 =?utf-8?b?YXR1cmUgbmFtZWQg4oCcSS9PIGhhbmfigJ0=?=
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
 armbru@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.07.2019 um 17:16 hat wangjie (P) geschrieben:
> Hi, everybody=EF=BC=9A
>=20
> I developed a feature named "I/O hang"=EF=BC=8Cmy intention is to solve=
 the problem
> like that=EF=BC=9A
> If the backend storage media of VM disk is far-end storage like IPSAN o=
r
> FCSAN, storage net link will always disconnection and
> make I/O requests return EIO to Guest, and the status of filesystem in =
Guest
> will be read-only, even the link recovered
> after a while, the status of filesystem in Guest will not recover.

The standard solution for this is configuring the guest device with
werror=3Dstop,rerror=3Dstop so that the error is not delivered to the gue=
st,
but the VM is stopped. When you run 'cont', the request is then retried.

> So I developed a feature named "I/O hang" to solve this problem, the
> solution like that=EF=BC=9A
> when some I/O requests return EIO in backend, "I/O hang" will catch the
> requests in qemu block layer and
> insert the requests to a rehandle queue but not return EIO to Guest, th=
e I/O
> requests in Guest will hang but it does not lead
> Guest filesystem to be read-only, then "I/O hang" will loop to rehandle=
 the
> requests for a period time(ex. 5 second) until the requests
> not return EIO(when backend storage link recovered).

Letting requests hang without stopping the VM risks the guest running
into timeouts and deciding that its disk is broken.

As you say your "hang" and retry logic sits in the block layer, what do
you do when you encounter a bdrv_drain() request?

> In addition to the function as above, "I/O hang" also can sent event to
> libvirt after backend storage status changed.
>=20
> configure methods:
> 1. "I/O hang" ability can be configured for each disk as a disk attribu=
te.
> 2. "I/O hang" timeout value also can be configured for each disk, when
> storage link not recover in timeout value,
> =C2=A0=C2=A0 "I/O hang" will disable rehandle I/O requests and return E=
IO to Guest.
>=20
> Are you interested in the feature?=C2=A0 I intend to push this feature =
to qemu
> org, what's your opinion?

Were you aware of werror/rerror? Before we add another mechanism, we
need to be sure how the features compare, that the new mechanism
provides a significant advantage and that we keep code duplication as
low as possible.

Kevin

