Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA8C7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D569C20726
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUahHx5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D569C20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cbB-0002n0-Ux
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1j3cab-0002LW-SI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1j3caa-00073i-6D
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:21:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1j3caa-00070E-2o
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581931274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EW86BLOv+2XvEG9UDXHlUKT1zvK+ejJOyf+cIs2bPlQ=;
 b=YUahHx5kdTbNTybDjr7WqncuHav0IZgy5ueIl2NExQj0SP6dZPCayTCIRNyiIX3gZBcr4E
 W9g5F/cmCWBXfx5GLUuV6mAn/AMt8lKjWqOSu1sT7pyWnt0GR0Diw7P4zHc9Zvj14oKZw9
 wdwWX+7gHKrPTFXgoIcfIxuTx6lk3D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-CZXo5wuePZe5oZUp9_3R0w-1; Mon, 17 Feb 2020 04:21:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0804140D;
 Mon, 17 Feb 2020 09:21:08 +0000 (UTC)
Received: from kaapi (unknown [10.74.10.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E37090531;
 Mon, 17 Feb 2020 09:20:58 +0000 (UTC)
Date: Mon, 17 Feb 2020 14:50:55 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH] net: tulip: check frame size and r/w data length
In-Reply-To: <20200215092132.GE18657@t470p.stackframe.org>
Message-ID: <nycvar.YSQ.7.76.2002171448510.84833@xnncv>
References: <20200211073930.224024-1-ppandit@redhat.com>
 <20200215092132.GE18657@t470p.stackframe.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CZXo5wuePZe5oZUp9_3R0w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Li Qiang <pangpei.lq@antfin.com>, Jason Wang <jasowang@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Sat, 15 Feb 2020, Sven Schnelle wrote --+
| > +    if (!len1 || !len2 || !s->rx_frame_len) {
| > +        return;
|=20
| I haven't tested the patch yet, but would that work if the guest OS passe=
s
| only one buffer to the card? I.e. len1 =3D x, and len2 =3D 0 because only
| buffer 1 is available?

  No, it won't. I'll send a revised patch.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


