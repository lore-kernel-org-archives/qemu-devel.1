Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF60C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C61206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lXMZWUe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C61206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYc1c-0002SA-ER
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 15:56:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1hYc0u-0001yd-Es
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpa@zytor.com>) id 1hYc0l-00068y-Db
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:55:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54939 helo=mail.zytor.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpa@zytor.com>) id 1hYc0e-0005Sc-5r
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:55:44 -0400
Received: from carbon-x1.hos.anvin.org ([192.55.54.60]) (authenticated bits=0)
	by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x55JtN271660258
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 5 Jun 2019 12:55:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x55JtN271660258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2019051801; t=1559764528;
	bh=nQ7d0NzVmeYZX5h42LR5kpiTw7aa4e3qC1p5rNhsCLg=;
	h=To:From:Subject:Date:From;
	b=lXMZWUe7VrrH563LJkeJ61WhbJ0G6PM/D9TifwKNtbP1+HQPlL+ltYOtXN/IFxejD
	mTUJWJTXIBgzhuu9JsrsNxyftFmz5wioLiauB2bY/zp0Gkoag+Yc3tDJf/KaHi2cKD
	7Gw2gtTz0E8xPzSYs4Ublffxl2tj6puM5bEAdaA3CQexFQJxKCu9zdmRzJX1G1/AF9
	EsLCJzNkJueMO/m3Q2FPtn/2BsHFZw7mnRsXKyT8TNoWqd32CW3tatk6GRvx88ieSC
	YDTjq1fD7M3zWbefLzwOYMxSBiK/zoQwrsR5xmIBQu2GftSX7cWmfRcmRTZfIYvNwL
	w9GYTFR7bIMww==
To: qemu-devel@nongnu.org
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6364a057-23ab-db7f-cb2c-ccff70fb7aed@zytor.com>
Date: Wed, 5 Jun 2019 12:55:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.137.202.136
Subject: [Qemu-devel] Qemu baseline requirements/portability?
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I am writing some code I'm hoping will be able to make it into Qemu, but I
can't seem to find what the baseline portability requirements are.  I'm
specifically wondering about newer POSIX features like openat(), which seems
to be used in the 9p filesystem and nowhere else, and what version of glib one
can rely on?

Thanks,

	-hpa

