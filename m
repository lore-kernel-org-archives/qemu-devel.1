Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39715C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F393A20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxhNKfhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F393A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv2P-0007pV-38
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jDuKb-0000w9-8N
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jDuKZ-0003wp-T6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:19:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47465)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jDuKZ-0003Uy-By
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584382693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkH1Ghs3O6XH2FgG3vKfkdJYcVY5/H1lOoCj2gpoWGI=;
 b=KxhNKfhdecjzZos0xHG7lwJSZ6+D4S7zklhbZp+u8FwdWDkSJRrhUNc+dFkrrAQGydQ04M
 IUZJ3KdyfWAXdf677AdC8pfEYlyf5fFUZQibUk5Av4IoStrW7kADxNKxeSoYgwZ8frmJ81
 EvSOGCDlcswN2jT53lk7zrTgD2m64wY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-OF21HhA-MQKS2I0KbVaAsg-1; Mon, 16 Mar 2020 14:18:09 -0400
X-MC-Unique: OF21HhA-MQKS2I0KbVaAsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A39310FAF35;
 Mon, 16 Mar 2020 18:01:22 +0000 (UTC)
Received: from kaapi (unknown [10.74.10.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6B0E7E300;
 Mon, 16 Mar 2020 18:01:15 +0000 (UTC)
Date: Mon, 16 Mar 2020 23:31:08 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 2/2] net: tulip: add .can_recieve routine
In-Reply-To: <20200306130853.GM1335569@stefanha-x1.localdomain>
Message-ID: <nycvar.YSQ.7.76.2003162325500.5086@xnncv>
References: <20200303104724.233375-1-ppandit@redhat.com>
 <20200303104724.233375-3-ppandit@redhat.com>
 <20200306130853.GM1335569@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Li Qiang <pangpei.lq@antfin.com>, Jason Wang <jasowang@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Qemu Developers <qemu-devel@nongnu.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello Stefan, Jason,

+-- On Fri, 6 Mar 2020, Stefan Hajnoczi wrote --+
| > +static int
| > +tulip_can_receive(NetClientState *nc)
| > +{
| > +    TULIPState *s =3D qemu_get_nic_opaque(nc);
| > +
| > +    if (s->rx_frame_len || tulip_rx_stopped(s)) {
| > +        return false;
| > +    }
| > +
| > +    return true;
| > +}
|=20
| Are the required qemu_flush_queued_packets() calls in place so that
| packet transfer wakes up again when .can_receive() transitions from
| false to true?

  Yes, qemu_flush_queued_packets() calls are in tulip_write(). Do we need t=
o=20
call tulip_can_receive() before each call?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


