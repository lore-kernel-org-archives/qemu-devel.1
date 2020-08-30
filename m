Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8261DC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 07:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438B320693
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 07:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gson.org header.i=@gson.org header.b="zPv69+FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438B320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gson.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCHKR-0005y3-FF
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 03:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gson@gson.org>) id 1kCHJQ-0005X2-Hq
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 02:59:36 -0400
Received: from gusty.araneus.fi ([185.55.84.130]:60592)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gson@gson.org>) id 1kCHJN-0003da-Qz
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 02:59:36 -0400
Received: from guava.gson.org (unknown [10.0.1.131])
 by gusty.araneus.fi (Postfix) with ESMTP id 6EBB7DB779B;
 Sun, 30 Aug 2020 06:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gson.org; s=mail;
 t=1598770768; bh=6NNMYXTrxuy3yK2QYsJV+HURrouwRFfM/6dsum0B7Y0=;
 h=Date:To:Cc:Subject:In-Reply-To:References:From;
 b=zPv69+FNPY/RjAR6ut1WbL13RO3Cx/Eg2hBI/fmnYBYbAG93Rtq3o3S4S6ulIsjLx
 7ZcwX3G6eypf283pz19kuFCeh3OXRjJmgn+hujzS/p4SwlBayiUCTiu8qbd+bYB7tu
 MJeJim9Hl2E6n/77L9M5TW9O+qZ/t6ADvexUd704=
Received: by guava.gson.org (Postfix, from userid 101)
 id E40D6253F75; Sun, 30 Aug 2020 09:59:27 +0300 (EEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Message-ID: <24395.20047.450062.992384@guava.gson.org>
Date: Sun, 30 Aug 2020 09:59:27 +0300
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH v2] hw/display/tcx: Allow 64-bit accesses to
 framebuffer stippler and blitter
In-Reply-To: <20200822142127.1316231-1-f4bug@amsat.org>
References: <20200822142127.1316231-1-f4bug@amsat.org>
X-Mailer: VM 8.2.0b under 25.3.1 (x86_64--netbsd)
From: Andreas Gustafsson <gson@gson.org>
Received-SPF: pass client-ip=185.55.84.130; envelope-from=gson@gson.org;
 helo=gusty.araneus.fi
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 02:59:30
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Michael Lorenz <macallan@NetBSD.org>, 1892540@bugs.launchpad.net,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=E9 wrote:
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 1fb45b1aab8..96c6898b149 100644

With this patch, the kernel boots successfully for me.
--=20
Andreas Gustafsson, gson@gson.org

