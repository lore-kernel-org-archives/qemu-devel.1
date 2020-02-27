Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B959C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A59F24692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fw30V0MB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A59F24692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GTU-00073R-Bo
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j7GRg-0005CU-6d
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j7GRe-0003bJ-VW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:31:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j7GRe-0003ao-RJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582799466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9fM46098J55AN/cBKJX+9W/vdOo7fvx8SsK7lnkkjc=;
 b=fw30V0MB8rzUD7WUpUrLnU7AnfZPfqntWXrbaWmnCAbAAuSrq40h973rfRIMAQTDA1Ft6h
 0yCrv6VfNn9ar6AeJdHImm/pLoiNxnBXBpJorWNrdR/Ojdlkz4Cu3nwjEEVp5CIs8YdgEB
 6POdu8x3wKBJFZb0F6px36lY7qPN4Co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-dfi3YcmCMESswz_qqbWh3Q-1; Thu, 27 Feb 2020 05:31:02 -0500
X-MC-Unique: dfi3YcmCMESswz_qqbWh3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A45B2108BD16;
 Thu, 27 Feb 2020 10:31:00 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DAE060C88;
 Thu, 27 Feb 2020 10:30:56 +0000 (UTC)
Date: Thu, 27 Feb 2020 11:30:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
 iscsi_open()
Message-ID: <20200227103054.GB7493@linux.fritz.box>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-3-kuhn.chenqun@huawei.com>
 <20200226095444.GB6096@linux.fritz.box>
 <7412CDE03601674DA8197E2EBD8937E83B6638BE@dggemm531-mbx.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B6638BE@dggemm531-mbx.china.huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.02.2020 um 02:49 hat Chenqun (kuhn) geschrieben:
> >-----Original Message-----
> >From: Kevin Wolf [mailto:kwolf@redhat.com]
> >Sent: Wednesday, February 26, 2020 5:55 PM
> >To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>
> >Cc: qemu-devel@nongnu.org; qemu-trivial@nongnu.org;
> >peter.maydell@linaro.org; Zhanghailiang <zhang.zhanghailiang@huawei.com>=
;
> >Euler Robot <euler.robot@huawei.com>; Ronnie Sahlberg
> ><ronniesahlberg@gmail.com>; Paolo Bonzini <pbonzini@redhat.com>; Peter
> >Lieven <pl@kamp.de>; Max Reitz <mreitz@redhat.com>
> >Subject: Re: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
> >iscsi_open()
> >
> >Am 26.02.2020 um 09:46 hat kuhn.chenqun@huawei.com geschrieben:
> >> From: Chen Qun <kuhn.chenqun@huawei.com>
> >>
> >> Clang static code analyzer show warning:
> >>   block/iscsi.c:1920:9: warning: Value stored to 'flags' is never read
> >>         flags &=3D ~BDRV_O_RDWR;
> >>         ^        ~~~~~~~~~~~~
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> >
> >Hmm, I'm not so sure about this one because if we remove the line, flags=
 will
> >be inconsistent with bs->open_flags. It feels like setting a trap for an=
yone
> >who wants to add code using flags in the future.
> Hi Kevin, =20
> I find it exists since 8f3bf50d34037266.   :  ) =20

Yes, it has existed from the start with auto-read-only.

> It's not a big deal,  just upset clang static code analyzer.=20
> As you said, it could be a trap for the future.=20

What's interesting is that we do have one user of the flags later in the
function, but it uses bs->open_flags instead:

    ret =3D iscsi_allocmap_init(iscsilun, bs->open_flags);

Maybe this should be using flags? (The value of the bits we're
interested in is the same, but when flags is passed as a parameter, I
would expect it to be used.)

Kevin


