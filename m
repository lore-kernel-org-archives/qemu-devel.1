Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A9DC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A43E20658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERMq9a6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A43E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9na-0007L9-IA
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jE9mf-00067E-Vg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jE9mf-0003iu-0L
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jE9me-0003hc-S4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584442156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SobQxR2LMYAIV71sNsI5LpBCn50uZm9JAeGTVvKhQ5s=;
 b=ERMq9a6HnctovR+2JEzHnbPgbTgtxo81yc1fhP+ADmy22a4byhSj33IOJfQ175N27A8sfQ
 iak+v+RvgkKH9jdBXpPnKtG4Ird3x11/9muYn2aW74/LLsKg3hH1PWSnlu3H+cPlLDNGXf
 HgMhxV6I5yHyX7bWrVmNFX8NDXlniPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-N2Qf0B9PPOO-9zhUwdUUsQ-1; Tue, 17 Mar 2020 06:49:12 -0400
X-MC-Unique: N2Qf0B9PPOO-9zhUwdUUsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40A9F800D50;
 Tue, 17 Mar 2020 10:49:11 +0000 (UTC)
Received: from kaapi (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5315F60BF3;
 Tue, 17 Mar 2020 10:49:06 +0000 (UTC)
Date: Tue, 17 Mar 2020 16:19:02 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/2] net: tulip: add .can_recieve routine
In-Reply-To: <27df2e70-936f-f989-7b6b-a00772dea0cd@redhat.com>
Message-ID: <nycvar.YSQ.7.76.2003171543480.5086@xnncv>
References: <20200303104724.233375-1-ppandit@redhat.com>
 <20200303104724.233375-3-ppandit@redhat.com>
 <20200306130853.GM1335569@stefanha-x1.localdomain>
 <nycvar.YSQ.7.76.2003162325500.5086@xnncv>
 <27df2e70-936f-f989-7b6b-a00772dea0cd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Ziming Zhang <ezrakiez@gmail.com>,
 Li Qiang <pangpei.lq@antfin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 17 Mar 2020, Jason Wang wrote --+
| > +-- On Fri, 6 Mar 2020, Stefan Hajnoczi wrote --+
| > | > +static int
| > | > +tulip_can_receive(NetClientState *nc)
| > | > +{
| > | > +    TULIPState *s =3D qemu_get_nic_opaque(nc);
| > | > +
| > | > +    if (s->rx_frame_len || tulip_rx_stopped(s)) {
| > | > +        return false;
| > | > +    }
|
| Btw, what's the point of checking rx_frame_len here?

tulip_can_recive() is called from tulip_receive(). IIUC non zero(0)=20
'rx_frame_len' hints that s->rs_frame[] buffer still has unread data bytes =
and=20
it can not receive new bytes. The check was earlier in tulip_receive().

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


