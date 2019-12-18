Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D320EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0A321582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="C9ye+cTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0A321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihVgN-0003WB-EH
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 04:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1ihVcV-0002jC-5X
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1ihVcU-0003oG-2M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:27:51 -0500
Received: from mout.web.de ([212.227.17.12]:33581)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1ihVcT-0003gD-P1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1576661235;
 bh=nfHGuiE4HL/UYFYQafT5rCuyPPNdBBdV3WSojeKHE8s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=C9ye+cTosgpa/vD5qh59w3HJefcCgkFt4varBCwBIF2UlP6Cs+6dJVkjinSSzvQjn
 pgRVxTImnPzTeZRQsTJ0oOH+ZDzbhWEacKdeKd/qlvExTGUpUB98w21HKzRpac0VEn
 8oVIauScaG7I4bHUwI+T5KqYFRjWleB9SnsWyXm0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.213]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmcnP-1i8S2a2kaZ-00aDuT; Wed, 18
 Dec 2019 10:27:15 +0100
Date: Wed, 18 Dec 2019 10:27:11 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/4] colo: Introduce resource agent and high-level test
Message-ID: <20191218102711.19e321ac@luklap>
In-Reply-To: <20191127221134.2b439e00@luklap>
References: <cover.1574356137.git.lukasstraub2@web.de>
 <20191122094646.GA2785@work-vm> <20191127221134.2b439e00@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0HAe07AkK4CEWugBH+8ReY1g1Ouf+hUGEjsE49W7HMgNmNv1VFf
 YTEH650uPkHOChOaug4UDyCW2VI/LBObGAWN+s37ZM0qpXv46ONGklI2UGZdZq+VBiMsy2E
 PLJpTpvpD9elF4l9PAst3ICbroys8yV6GRxX2YgkXpPtNdlzCjgNHbrCTfeqzR9Vug6Bjv/
 a/O2bxSqWvJEE2v4spqMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:muM7CnRRTPA=:0TNKPFz8p7JBl6aOissm9j
 DfeDUbfYNI1eXuVu9hUx7zsMxlyMybyzjd+/vncV3sz9sFFvlArGtSsYXzEqIn1Tn48ufYYM2
 1KgBgziOS/BwvhU55ZRbx17WfJz89nXC3u9AX/NMEpeMHrSYm2brLqBDtWstbIh1GX+Vm0TC+
 JmOoRRLN7eN6R9osTAr2pLfXwf25psl3zhorOdV164UBcJrOcHIdiIdQG+MZXrmCN7apZySaU
 fy6htH8Y7iza44PAbA5nUyqj7hOX+Xid50pU7mXNEgZEMpqKRhzTX58emQ6njjBo4S7/2R+Dz
 lc2x48TgaAji5DMmwA3mkNwiWaFsD2Czn/o8R85zhBblxu7swj8CrDIvUjxWjSBZrLK3QajBj
 PCVZXH+WS9J43Y1mfW2Re7Qfy1ph4H9use8B0mW/ZquBOYlLSwDO0J/v+E8w3rAbH3L/QitO2
 NbrN0QqyHiTbXgM3K/bT89HXaD1hNzZksh4TizVUORiJnQYqLGjf6YEhe2MLQyjjnilRgcIE0
 f+cEBFDaAILO5zIX7N7VL66NZOEZHTXikYRRhToklm162kUTSYSpZF9E15PgrsNZQNPsdBz3X
 EeoxF/YCXUwWJeRkNEqEl89yx/BFN5VHvXBwKodpxU3pCTnaxQbfbWkq+1NwCFAXcZvoAgCZl
 Ahht5V0+gNxpmbOxEU3zEFyoSy1OIChOZJ3cwWbZ+ZxCV4cJ6hetfo5zASvM8+uBa0XiPgsYH
 eqsqZOHblg4Ns841RNkjU5MSM9P1IekHl0TyXr6y5c50NpVy3GGrPwqNhE2HktWBCCfbB4u9r
 1ABDnz6uLKxuUcsIkUaMEw8YEUk4TnR1Z00B6t3kF5On+U8herGmfFHmW2EI2u9NJUlZkONER
 A45XQ/OEwuyP25Nkj4adso8MXFtSa2GFlQYXm/7aFFNumrAEonb2WeHcWHXFcJPCJKSJt8fAJ
 xyt3tIRgIr/4TKPFF1u+iMJtdwprSG9jmsi081+hgeVZTDY8h1pTm8XpQ/nbGAi+BjCuNWp12
 H5B2Y60D3Ab5AaY7hNRhy6fGIrDttKNcTme2QHMOrOoZLrbTWH9HRhZOuCNTCa3kEo/FFYET5
 VuPq6N+UrVPfCqxH5hYWyXHan5CZ+mU1qmJg0vX7LonfbgqfqTj3Z36mxDyYoCEXGB1E/jpSm
 9o1HnO+zp358BtI+2GjvGqUCul35a4kQ36Ycrgmlxt3XCShvuxnF8KFrYvLyPmUH/dJh5ZVAz
 EvXfg7QtHgOqCZjUUb4F5rfEuUlTR7Dgcjlxpy7yQlYDFk8noH2ohQqyLuKA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.12
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 Nov 2019 22:11:34 +0100
Lukas Straub <lukasstraub2@web.de> wrote:

> On Fri, 22 Nov 2019 09:46:46 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>
> > * Lukas Straub (lukasstraub2@web.de) wrote:
> > > Hello Everyone,
> > > These patches introduce a resource agent for use with the Pacemaker =
CRM and a
> > > high-level test utilizing it for testing qemu COLO.
> > >
> > > The resource agent manages qemu COLO including continuous replicatio=
n.
> > >
> > > Currently the second test case (where the peer qemu is frozen) fails=
 on primary
> > > failover, because qemu hangs while removing the replication related =
block nodes.
> > > Note that this also happens in real world test when cutting power to=
 the peer
> > > host, so this needs to be fixed.
> >
> > Do you understand why that happens? Is this it's trying to finish a
> > read/write to the dead partner?
> >
> > Dave
>
> I haven't looked into it too closely yet, but it's often hanging in bdrv=
_flush()
> while removing the replication blockdev and of course thats probably bec=
ause the
> nbd client waits for a reply. So I tried with the workaround below, whic=
h will
> actively kill the TCP connection and with it the test passes, though I h=
aven't
> tested it in real world yet.
>

In the real cluster, sometimes qemu even hangs while connecting to qmp (af=
ter remote
poweroff). But I currently don't have the time to look into it.

Still a failing test is better than no test. Could we mark this test as kn=
own-bad and
fix this issue later? How should I mark it as known-bad? By tag? Or warn i=
n the log?

Regards,
Lukas Straub

