Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CBAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CA32082F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtAVrcNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CA32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5hu-0003wu-88
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jl5SL-0001kO-3K
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:52:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jl5SJ-0006XN-6S
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:52:24 -0400
Received: by mail-pl1-x644.google.com with SMTP id m7so7955856plt.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=b6LgcOPhi8W7UE0S9DpmNMWNfQsUhx+nIS29bRv1iLE=;
 b=CtAVrcNwASTI1xRJyk3xmZVF8qwkLpYFVtMngSx58uC6WBTcvaKGAR+PsosAcvHh6j
 a2KLxLCPpF207MX3m47ptJFyT5vlwHZT7m9/+4riGFnnGAy6sffQHiiijvDYaFojJtnD
 ZF6yiDvKNYdnyV9Kjp5H8D0YV731bGibKFJfdHyLnTG2qk4FyzLouy+BnZE3k2APGQPN
 kjnopqU85WSZAo0SEgvpi9qyvLpQ4WbTiMetewDw5sLFUTRc4i6Q8yRqWu8resfhQKFP
 kb96sa/Lcd/zDHuP1seYpWsiQG27gq/8e2bYC5C1xQ7K/OVitGIRP6FaIpTNOsliVnQa
 o/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b6LgcOPhi8W7UE0S9DpmNMWNfQsUhx+nIS29bRv1iLE=;
 b=dI3iBqn16edRiaYQBZk9Sa684J3csWLum/3PtzEmVklPs0AQya+Y8PUoEP+Nc9VHPQ
 yblN3tdGwb1r43WU01EVqwsCBRk3jfmS386iRtQh5LuwONwGE5vReQzc7a0cpS/Q+rti
 1xViCrVbTkrXlW0i5c55m0Gf3kteAO5cC0w903heqKFk4H9oqiM49Be/RZp/WGx3n6Gx
 yjkc4w5nVBpLX/WTqxr88LRnZwfEsJaNlhAqhXXq1+rIxYf6IA0Tji9HvKjQM8xRh1yS
 xhSl5abHlleOejto2XiRR5a12GGzleZa0BgY/R8KUoZZ/bZT0mMbaQi/X9IiCll5udNk
 QYIg==
X-Gm-Message-State: AOAM533f+rBQFkztQtc2Y3624seqb+/7rGAz8GYIiJ79KDGICT8jZQcD
 2aJDc30HtG+6hflViAPVLItMBQ9FeKkh1g==
X-Google-Smtp-Source: ABdhPJwEYezc8s2q96LJZGaHkW7itg0QJqq1a6MBeU5CYZ4gMDKjb+TlfmVQs1/3k2ZcosEtLmhybw==
X-Received: by 2002:a17:90a:ea05:: with SMTP id
 w5mr1486138pjy.37.1592290341063; 
 Mon, 15 Jun 2020 23:52:21 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id c15sm13874833pgb.4.2020.06.15.23.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:52:20 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Tue, 16 Jun 2020 14:52:16 +0800
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200616065216.wpf2rxgwxvtqgxlk@r>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <159216218770.30485.1172665077342708998@45ef0f9c86ae>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <159216218770.30485.1172665077342708998@45ef0f9c86ae>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 14, 2020 at 12:16:28PM -0700, no-reply@patchew.org wrote:
>Patchew URL: https://patchew.org/QEMU/20200614183907.514282-1-coiby.xu@gmail.com/
>
>
>
>Hi,
>
>This series failed the asan build test. Please find the testing commands and
>their output below. If you have Docker installed, you can probably reproduce it
>locally.
>
>=== TEST SCRIPT BEGIN ===
>#!/bin/bash
>export ARCH=x86_64
>make docker-image-fedora V=1 NETWORK=1
>time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
>=== TEST SCRIPT END ===
>
>  CC      stubs/vm-stop.o
>  CC      ui/input-keymap.o
>  CC      qemu-keymap.o
>/tmp/qemu-test/src/util/vhost-user-server.c:142:30: error: use of undeclared identifier 'VHOST_MEMORY_MAX_NREGIONS'
>                             VHOST_MEMORY_MAX_NREGIONS, nfds + nfds_t);
>                             ^
>
>The full log is available at
>http://patchew.org/logs/20200614183907.514282-1-coiby.xu@gmail.com/testing.asan/?type=message.

I couldn't re-produce this error locally for both docker-test-quick@centos7
and this docker test. And I can't see any reason for this error to occur since
VHOST_MEMORY_MAX_NREGIONS is defined in contrib/libvhost-user/libvhost-user.h
which has been included by util/vhost-user-server.h.

--
Best regards,
Coiby

