Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E90C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2092D2173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZHO91/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2092D2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOS3-0007vR-86
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hnORs-0007Wo-DG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hnORr-0006FC-HG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:28:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hnORr-0006Et-BS
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:28:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n9so21209381wrr.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lzj/yiNDFh4JW84RkK4BcDNLtWpH3d5QATkJFn3L+HM=;
 b=kZHO91/+O50GEaBwI8eudoz2SosSPR4YrfSfxlq7+aBoScaaXupgwirD2tybU7Y4FW
 QiDyrtL0TPQ7vAMVoUfdH6P0DI3UNqjM38BCWC/kOJKMsllX2dHnCbkM1tdbklu5xPQh
 iWND+Zu3u4Rdvbw/hefYLJNbFgR/Vr/mlKTqN94GvOi9VtC2mCfJUcq3+/OI3hiJCZtn
 CFktSndspoEsSFyQ6+sDJGHmcEKndv2tPSM2EGzrGemC+udF1jAh27UNaPgBAPr/wCk6
 Fg74Ydxat1YzSM4KK7hWFJeciFyaOXXlvPPKUDP4yhLZMpjZKXKspfjgQwPfTmewMHlI
 6hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lzj/yiNDFh4JW84RkK4BcDNLtWpH3d5QATkJFn3L+HM=;
 b=LV6OpckEoEGnljPpHvUNvJloAA7RcqIQhxC4DxuqAdb5IJ00BlyqAXAdJeLzZ0B5TB
 AcXx5AgekZsnv0b3QfJHoVMUN/ZYPoGMJwu5kacTa5ehuHZvhKIZDSELRYBoRW/xSrtW
 ZI9caPwh1pDjdX/vVb9hfhxSEK4bYBTUyt11m7O1yjxSr3sy+ErIxKz79jnaugdojp6H
 X1UQaVV6KOXNdRT5JriT8/FuF9+0ML6jak5JU/1Mb5heo1whLG75oPCKbK6dWjeTPvxw
 adu+AAGW08D5mCxnHRowhFGJhoU8zZ/RCNODykqu/tW/1sXQQ8EOYmX6iMvcVX5OkRkU
 oY+A==
X-Gm-Message-State: APjAAAVVSNChwtA9wnb+52aTbhqvy4BvDfPqPHcyWUwoBpjrQJUULkqJ
 d2LFsgMQ+GSpF4ISpQE5Da9D2IZiokNoh2HY5Nw=
X-Google-Smtp-Source: APXvYqxq2KYweQ8J1Yho7vX0Fb1WD5C+bM9sbO3pckTvX4NKIkR6MK+SU8jOPn7W1KvGy5+v0/TrjjfjaeohfS5tZGQ=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr1665916wrp.149.1563287334174; 
 Tue, 16 Jul 2019 07:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190712115024.2659-1-sw@weilnetz.de>
In-Reply-To: <20190712115024.2659-1-sw@weilnetz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 16 Jul 2019 15:28:43 +0100
Message-ID: <CAJSP0QWM6=iPyCkQDC58ZPQ-Dp2EhGokyW5oLFAdZ+LBRMDtXA@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: Re: [Qemu-devel] [PATCH v2] libvhost-user: Add missing GCC_FMT_ATTR
 and fix three format errors
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

