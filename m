Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8B7C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145EC20722
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3YXO4Vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145EC20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErxK-00060s-9S
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jErwi-0005UX-5J
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jErwh-0004IB-5r
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:58:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47251)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jErwh-0004Gi-2H
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584611914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shhh89Eyx4S+KAMtoC2V2e53NX6RTps2u8+w2MCcaTQ=;
 b=c3YXO4VungmiFzuNhoW36knbbzzgpn5rSv2ixN3yz0w9sxgSOJ9egcDppTI7lK2e8iwdKL
 Q6MRaMdpSbSktzHg54lFXUOOV9cDFfNVVS+Xjw6lGVqKt1EsGdRMYuVa//mlII/6pQfhCp
 XC8FPZzOajBfQsaefNtOkPrDXQd4NTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-lDg9vEyOPwyYlNtQknJ2wQ-1; Thu, 19 Mar 2020 05:58:32 -0400
X-MC-Unique: lDg9vEyOPwyYlNtQknJ2wQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6603613EA;
 Thu, 19 Mar 2020 09:58:31 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50C8E10016EB;
 Thu, 19 Mar 2020 09:58:19 +0000 (UTC)
Date: Thu, 19 Mar 2020 15:28:14 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/2] net: tulip: add .can_recieve routine
In-Reply-To: <976adb02-5653-2f57-555d-c41b8d392fc1@redhat.com>
Message-ID: <nycvar.YSQ.7.76.2003191525010.5086@xnncv>
References: <20200303104724.233375-1-ppandit@redhat.com>
 <20200303104724.233375-3-ppandit@redhat.com>
 <20200306130853.GM1335569@stefanha-x1.localdomain>
 <nycvar.YSQ.7.76.2003162325500.5086@xnncv>
 <27df2e70-936f-f989-7b6b-a00772dea0cd@redhat.com>
 <nycvar.YSQ.7.76.2003171543480.5086@xnncv>
 <976adb02-5653-2f57-555d-c41b8d392fc1@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Ziming Zhang <ezrakiez@gmail.com>,
 Li Qiang <pangpei.lq@antfin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello Jason,

+-- On Wed, 18 Mar 2020, Jason Wang wrote --+
| Right, so need to make sure qemu_flush_ququed_packets() was called when=
=20
| rx_frame_len is zero.

  Sent patch v4, with this call. Please see when you've time.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


