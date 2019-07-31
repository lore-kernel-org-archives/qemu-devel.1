Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8530FC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0C020693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0C020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hskqi-0003vV-Mi
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hskqA-0003Uu-DD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hskq9-00011E-JU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:24:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hskq9-00010W-E6
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:24:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5F3B3082201;
 Wed, 31 Jul 2019 09:24:08 +0000 (UTC)
Received: from kaapi (ovpn-116-38.phx2.redhat.com [10.3.116.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6765960852;
 Wed, 31 Jul 2019 09:23:55 +0000 (UTC)
Date: Wed, 31 Jul 2019 14:53:49 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <3bd45075-bec1-f597-8f84-4de1f9bd29bf@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1907311453170.1746@xnncv>
References: <20190723104754.29324-1-ppandit@redhat.com>
 <20190723104754.29324-4-ppandit@redhat.com>
 <20190723130326.GC5445@stefanha-x1.localdomain>
 <CAKXe6S+pXN0d6K9Vw=kxsy51bVz1PxXBHYEmTesUnYo8u8vcYg@mail.gmail.com>
 <nycvar.YSQ.7.76.1907241116470.10049@xnncv>
 <20190729150400.GG6771@stefanha-x1.localdomain>
 <fb5835f4-2894-72c5-db35-91ccf966cb9f@redhat.com>
 <nycvar.YSQ.7.76.1907311211020.1746@xnncv>
 <3bd45075-bec1-f597-8f84-4de1f9bd29bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 31 Jul 2019 09:24:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/3] net: tap: replace snprintf with
 g_strdup_printf calls
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
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Wed, 31 Jul 2019, Jason Wang wrote --+
| The series has been merged. Just need a patch on top and I can queue it for 
| next release.

Sent patch v5. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

