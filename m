Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1687DC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB72F20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 05:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlOJU/vT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB72F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE4LO-0005oE-U5
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 01:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jE4KY-0005NY-1p
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jE4KW-0007MJ-EM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:59:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jE4KW-0007HS-AE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584421191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9w2/MbmqR0vOcDwPInDjxKSYDK13HymlDPzPtZk4gd4=;
 b=WlOJU/vTePSgs1x6xMiy9mVwgKcYH662c37ilBwBs7K0OsaCq4hE3tJLKcedV4/EqtAYXr
 MZFW9AZv7vOkcWWW/TJCDRefnbCwai5+eqeu83arW2AQu53rPMDOoGqiJLWo61PI9f4fiH
 Uk8wgwTHqBadkAxpfgo5Tg1j0gkmYPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-zZ9X5XO9OFiuJo3vBRVvXg-1; Tue, 17 Mar 2020 00:59:47 -0400
X-MC-Unique: zZ9X5XO9OFiuJo3vBRVvXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3008C1005514;
 Tue, 17 Mar 2020 04:59:46 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E15A19C58;
 Tue, 17 Mar 2020 04:59:46 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id D27EE86FED;
 Tue, 17 Mar 2020 04:59:45 +0000 (UTC)
Date: Tue, 17 Mar 2020 00:59:45 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
 <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
 <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
MIME-Version: 1.0
X-Originating-IP: [10.10.112.137, 10.4.195.18]
Thread-Topic: QEMU Gating CI
Thread-Index: LK4AdQ3x3bq5va7rGyWJ8Kf1QmwUCA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: "Cleber Rosa" <crosa@redhat.com>
> Cc: "Fam Zheng" <fam@euphon.net>, "Thomas Huth" <thuth@redhat.com>, "Bera=
ldo Leal" <bleal@redhat.com>, "Erik
> Skultety" <eskultet@redhat.com>, "Alex Benn=C3=A9e" <alex.bennee@linaro.o=
rg>, "Wainer Moschetta" <wmoschet@redhat.com>,
> "QEMU Developers" <qemu-devel@nongnu.org>, "Wainer dos Santos Moschetta" =
<wainersm@redhat.com>, "Willian Rampazzo"
> <wrampazz@redhat.com>, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>,=
 "Eduardo Habkost" <ehabkost@redhat.com>
> Sent: Monday, March 16, 2020 10:57:30 AM
> Subject: Re: [PATCH 0/5] QEMU Gating CI
>=20
> On Mon, 16 Mar 2020 at 12:26, Cleber Rosa <crosa@redhat.com> wrote:
> > About the runners and the fact that the job is stuck without them,
> > the message seems straightforward enough, but I can't get to the
> > project configuration to look at the registered runners with my
> > current permissions (set as "developer").
>=20
> I've moved you up to 'maintainer' status, hopefully that is
> sufficient to look at the relevant config ?
>=20
> thanks
> -- PMM
>=20
>=20

Hi Peter,

Yes, that did the trick and I can now see the configuration.  What I can
*not* see is any "Specific Runner" configured.  So maybe:

1) The documentation I included is not clear enough about the fact that
setup steps need to be done on a machine so that it becomes a "Runner"

2) The (Ansible) playbooks (especially contrib/ci/orgs/qemu/gitlab-runner.y=
ml)
is not working as intended

3) Some expectations misalignment on machines that would be available to ru=
n
those jobs

In any case, none of those should be big problems.  Please let me know what
you did/experienced/expected up to this point, and we can continue from the=
re.

Regards,
- Cleber.


