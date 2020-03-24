Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB37C2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A237208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQvGEQxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A237208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjU1-00048C-84
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jGjTJ-0003dp-M8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jGjTI-0000R5-Id
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:19:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jGjTI-0000Qp-FZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585055995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcLMVMJVNf1ljozQRq7wYAii/D1b2MJORVmREsSlQes=;
 b=GQvGEQxO1IgmObj8qdIqM4ASSAlNcJTuIpRVYhNNVu2Y3bkpp48jvaQs+CdDAqnFqMek8L
 /WAp7tcX6U/N6OQeVkvScTAJ3rZ8h4M4A02CBVckPTra44C9P3QNqNZMmLb135yUEOLDkK
 PA3cLvbPl12iN8y5mburPNpeBnWvD60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-xhwEaSK8O1uZb4AIU6_LtQ-1; Tue, 24 Mar 2020 09:19:53 -0400
X-MC-Unique: xhwEaSK8O1uZb4AIU6_LtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56216801A01;
 Tue, 24 Mar 2020 13:19:52 +0000 (UTC)
Received: from kaapi (ovpn-117-4.sin2.redhat.com [10.67.117.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 830848FC12;
 Tue, 24 Mar 2020 13:19:47 +0000 (UTC)
Date: Tue, 24 Mar 2020 18:49:44 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v6 1/2] net: tulip: check frame size and r/w data
 length
In-Reply-To: <a72da97b-dc0f-99d4-1d59-aba9da2760c9@redhat.com>
Message-ID: <nycvar.YSQ.7.76.2003241810530.10235@xnncv>
References: <20200323122100.893417-1-ppandit@redhat.com>
 <20200323122100.893417-2-ppandit@redhat.com>
 <CAKXe6SKtuk7qr1dFVJoHm3LZ40OG8Nfhanj1zqdBVzAQ+Smc0w@mail.gmail.com>
 <a72da97b-dc0f-99d4-1d59-aba9da2760c9@redhat.com>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.76.2003241848110.10235@xnncv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463811718-1199711412-1585055541=:10235"
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Li Qiang <liq3ea@gmail.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1463811718-1199711412-1585055541=:10235
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-ID: <nycvar.YSQ.7.76.2003241848111.10235@xnncv>
Content-Transfer-Encoding: quoted-printable

+-- On Tue, 24 Mar 2020, Jason Wang wrote --+
| >     +=A0 =A0 =A0 =A0 if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)=
) {
| >     +=A0 =A0 =A0 =A0 =A0 =A0 return;
| >     +=A0 =A0 =A0 =A0 }
| >
| > Why here is '>=3D' instead of '>'. IIUC the total sending length can re=
ach=20
| > to sizeof(s->rx_frame). Same in the other place in this patch.
|=20
| Yes, this need to be fixed.

But, wouldn't s->rx_frame[sizeof(s->rx_frame)] be off-by-one?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463811718-1199711412-1585055541=:10235--


