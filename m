Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E9CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239D2206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="BCsq+x6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239D2206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh7fK-0007mM-Dd
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 04:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jh7ed-0006hc-Nl
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:24:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jh7ec-0006qZ-OS
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:24:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id r15so8183837wmh.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=woE/tUAWGDnjVuiERgjRjVK5NV+0gJ6Br7LgTFzA6aA=;
 b=BCsq+x6gvQ+7/5lOo8Vs0ap5A9po4zzwN7AlZW2mqcEWdKjN0TKBeWy2I4YTIEi35R
 JdUDIq++tKrKxubZjQLk/TNiFXPVGyc3Sbs8XmJqFpyn0o+49lVkbZ+JPjxAOPMiBE8O
 oTuOwlXp+qoLNg50EbbMi9mS8WftUnmpVFAhHd3D4iD4BUWqvayBKSQuA7hJHtjSEGva
 jSconKAFqbh1InkHuT4IfZIWoRakVL/MWx6jHctQNpwBT0vBGvQIZFzpkoZNZLsGFfad
 5cQ1MXpGteYOpGDIo0MIRqWdvMi+qbDBZlIfynmGS+e0uggCw+yaWgbi1wQVsZw6n4IF
 8RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=woE/tUAWGDnjVuiERgjRjVK5NV+0gJ6Br7LgTFzA6aA=;
 b=rBsZJRPSrGtDlyVKF4+jeRSvU+tXo5J/52faFSMDb4cVr5el+GVy0P7x1RqhtrWtgG
 rghSCusU0rw9m9b3+dElEVV9QDaSgxiuZfpHNAElbB7H5I7R79rh2s+9qt6ZQwLLlMHt
 3NEWv+c/6m6mKej65D9V710aOOHM6atcj+taT8bz5tKE7I7M9I6SQ6uoyPzCI5i1cucL
 CpaghrUaT00bN8DUQooh9gFm1Xoht7uj3hnGeFGJ/R/+UA7ZtqEzN1SXIoXvb8mjrR89
 ZFKsk5EVOaAT6e2bDfVxDaVTdGCSJiXgV/eznBDYiYnOd/qvM+Qa6pnfL0xpcVf+pi70
 AAlw==
X-Gm-Message-State: AOAM532NnFMYrm88cMG2xwW8PBYgh2vAaOdMQ2aSeYEHGFXmzExvErT1
 9M0GhU+kIufRY80ZwXsm2aLFy5y9QYi2Wxw/
X-Google-Smtp-Source: ABdhPJzJHVWNJ0Fu9Qr4sTcVfIx5yllSwPwt+1OHhVyFAnlw2E2upqUBm3GRmQXDE8WRdd+gdFBEow==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr1486412wmc.142.1591345480452; 
 Fri, 05 Jun 2020 01:24:40 -0700 (PDT)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [2001:8b0:bb71:7140:64::1])
 by smtp.gmail.com with ESMTPSA id i74sm11368563wri.49.2020.06.05.01.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 01:24:39 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 22df01d5;
 Fri, 5 Jun 2020 08:24:38 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] osdep: Make MIN/MAX evaluate arguments only once
In-Reply-To: <20200604215236.2798244-1-eblake@redhat.com>
References: <20200604215236.2798244-1-eblake@redhat.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Fri, 05 Jun 2020 09:24:38 +0100
Message-ID: <m2eeqtapix.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::342;
 envelope-from=dme@dme.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_NEUTRAL=0.779,
 UNPARSEABLE_RELAY=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, quintela@redhat.com,
 crosthwaite.peter@gmail.com, dgilbert@redhat.com, f4bug@amsat.org,
 kraxel@redhat.com, dirty.ice.hu@gmail.com, pbonzini@redhat.com,
 Max Reitz <mreitz@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, 2020-06-04 at 16:52:36 -05, Eric Blake wrote:

>  /* Minimum function that returns zero only iff both values are zero.

Not your change, but "only" is unnecessary here (or iff -> if).

dme.
-- 
But uh oh, I love her because, she moves in her own way.

