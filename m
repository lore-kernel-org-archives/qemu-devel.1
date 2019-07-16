Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E6C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04DE205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04DE205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQAU-0003JP-O4
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hnQAH-0002pL-Vp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hnQAH-0002bj-5f
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>)
 id 1hnQAA-0002Qa-D4; Tue, 16 Jul 2019 12:18:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2B5630872EC;
 Tue, 16 Jul 2019 16:18:37 +0000 (UTC)
Received: from kaapi (ovpn-116-158.sin2.redhat.com [10.67.116.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F277611DE;
 Tue, 16 Jul 2019 16:18:27 +0000 (UTC)
Date: Tue, 16 Jul 2019 21:48:20 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: John Snow <jsnow@redhat.com>
In-Reply-To: <52979901-15a7-ee2c-80d7-4cbbc99f461c@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1907162144140.16268@xnncv>
References: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
 <0bce1e99-fb98-6354-9426-391a3e9363f1@linux.com>
 <20190716112535.GB7297@linux.fritz.box>
 <52979901-15a7-ee2c-80d7-4cbbc99f461c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 16 Jul 2019 16:18:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [QEMU-SECURITY] ide: fix assertion in
 ide_dma_cb() to prevent qemu DoS from quest
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
Cc: Kevin Wolf <kwolf@redhat.com>, sstabellini@kernel.org,
 Petr Matousek <pmatouse@redhat.com>, mdroth@linux.vnet.ibm.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Alexander Popov <alex.popov@linux.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 16 Jul 2019, John Snow wrote --+
| I also feel that a privileged DOS by a guest of a legacy device is actually 
| low priority security-wise, unless we can demonstrate that there are side 
| effects that can be exploited.

Right, we are not treating this as a CVE issue as is. Privileged guest user 
has many ways to cause similar DoS effect, without triggering this assert(3).

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

