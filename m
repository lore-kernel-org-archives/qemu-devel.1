Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2047C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6414920870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6414920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50861 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDRhY-0000Ga-Nd
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 06:40:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDRgn-0008MI-C1
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDRgm-0001kj-KC
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hDRgk-0001jg-I5; Mon, 08 Apr 2019 06:39:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6492C0467EB;
	Mon,  8 Apr 2019 10:39:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-165.ams2.redhat.com [10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B327D19C57;
	Mon,  8 Apr 2019 10:39:40 +0000 (UTC)
Date: Mon, 8 Apr 2019 12:39:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: ghorges <ghorges@xiyoulinux.org>
Message-ID: <20190408103939.GC11997@linux.fritz.box>
References: <20190408084056.26212-1-ghorges@xiyoulinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190408084056.26212-1-ghorges@xiyoulinux.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 08 Apr 2019 10:39:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Wshadow in qemu/linux-user/syscall.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408103939.qbPFDp3Xvbp0J1Po6uBs9FExrIcBi91QMvsLwi1QA10@z>

Am 08.04.2019 um 10:40 hat ghorges geschrieben:
> ---
>  linux-user/syscall.c | 66 ++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)

Thomas already gave you some hints what to improve. I'd just like to add
that you shouldn't send the email to the qemu-block mailing list if the
patch is not about the block layer at all.

Kevin

