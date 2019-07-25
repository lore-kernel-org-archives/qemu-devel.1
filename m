Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D4CC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09FD2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09FD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqasD-0007LH-63
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54272)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hqas3-0006td-GS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hqas2-0007do-4f
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hqas1-0007bY-Qu
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 842CC85550;
 Thu, 25 Jul 2019 10:21:07 +0000 (UTC)
Received: from kaapi (ovpn-116-69.phx2.redhat.com [10.3.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23699608A5;
 Thu, 25 Jul 2019 10:20:57 +0000 (UTC)
Date: Thu, 25 Jul 2019 15:50:52 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <536a2066-2a06-2a51-baaa-6e146c6dbeec@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1907251547550.19510@xnncv>
References: <156390388086.12764.7714147258543962468@c4a48874b076>
 <536a2066-2a06-2a51-baaa-6e146c6dbeec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 25 Jul 2019 10:21:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/3] restrict bridge interface name to
 IFNAMSIZ
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
Cc: liq3ea@gmail.com, berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello Jason,

+-- On Thu, 25 Jul 2019, Jason Wang wrote --+
| > URL:https://patchew.org/QEMU/20190723104754.29324-1-ppandit@redhat.com/
| 
| Prasad, this looks unrelated to the series? Please double check.

Yes, it is unrelated. Not sure how it gets triggered.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

