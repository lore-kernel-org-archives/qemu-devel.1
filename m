Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD72C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B15F20658
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI0zisRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B15F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7aRb-0007vp-HL
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1k7aR5-0007SO-Qq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:24:07 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1k7aR4-0001kX-2O
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:24:07 -0400
Received: by mail-pl1-x644.google.com with SMTP id t10so7125871plz.10
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rCqLM7D9cz7EkGgyqNShQArGdgLMeQfCg6ugANAoEjg=;
 b=VI0zisRtESnZtfpsHzr/2mQhXfQTvWXcdAJ4ZFGRXXvH3tO0QzyDkgC3It+VYFCiBW
 gIR20DWc3i57eQGQdhWZx+KpYFm5xNzn58MyZxwtGEaBrir3SgdV//y9d0bhdx2aTbQe
 Ww/NRH/8G4H+Q17dFJg6Gpn22Lwq8Fe6JjndooI7Uu8o6S0gfkU3gecm9/jY7M67IanU
 fQtbSvM46NXj2ZU8a17KEP4wtv6r7TDcUbKhGjzCrUEjvmVgwHbc3s1vbt++fEdTwjNG
 NFUsrXjmj84Jq4cX5njNt3i/I5nBezH/KL95Y9bMRcYBl+aAMCnRqHQJhAyJDZs1QD51
 zH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rCqLM7D9cz7EkGgyqNShQArGdgLMeQfCg6ugANAoEjg=;
 b=Ww1Nq8rbueaZ7X3SgtgTluY+v2Rp9qvd3qt+G09/bkPIN3fHbBPNUwHOZ2qU4j+NSD
 8vlqvPY+DM5bzyWlgSAIb97fYtbenZIfLZvRkYVl0t/gOeuqlzVZmGTrR/giVrgv691D
 oI1UnZaj1jq89jJnjy563MajKOdKqt6UlSFSCPZJs1SVQG8lRqI5x68h1izWtbdsQdCu
 bulKkoXpVs3gcDamgbZXmxoIhWEZ0WZ5hg1WKnHnEnqp0C5wOVgrPVD5UkDOWeZEKE/e
 K9bpVeCF8yVwxSAtHD2AKACcXt9IMMUWIGQC+ItpZ5NWE1yt3lSzZwHJZQYdrCt1LiLH
 PR7g==
X-Gm-Message-State: AOAM532kB/77SQORAeMGoPxjld7wyRm00uBN9r2+igmdV97o8rMulP9t
 SAz0Tka58nZpRbuttJ1zOpg=
X-Google-Smtp-Source: ABdhPJyjz61rGptfXaFHhKKkpP63A82Dhom+zIKeFwYO9ZJgg2XvmtJ7Vx0SLi4+Dq5+U2eroNwj/A==
X-Received: by 2002:a17:902:834a:: with SMTP id
 z10mr10674325pln.5.1597652644596; 
 Mon, 17 Aug 2020 01:24:04 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id j5sm18891072pfg.80.2020.08.17.01.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:24:03 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 17 Aug 2020 16:23:52 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200817082352.ofuzd6wirqfdi3yi@Rk>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <159216218770.30485.1172665077342708998@45ef0f9c86ae>
 <20200616065216.wpf2rxgwxvtqgxlk@r>
 <20200618082844.GC1956319@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200618082844.GC1956319@stefanha-x1.localdomain>
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
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 09:28:44AM +0100, Stefan Hajnoczi wrote:
>On Tue, Jun 16, 2020 at 02:52:16PM +0800, Coiby Xu wrote:
>> On Sun, Jun 14, 2020 at 12:16:28PM -0700, no-reply@patchew.org wrote:
>> > Patchew URL: https://patchew.org/QEMU/20200614183907.514282-1-coiby.xu@gmail.com/
>> >
>> >
>> >
>> > Hi,
>> >
>> > This series failed the asan build test. Please find the testing commands and
>> > their output below. If you have Docker installed, you can probably reproduce it
>> > locally.
>> >
>> > === TEST SCRIPT BEGIN ===
>> > #!/bin/bash
>> > export ARCH=x86_64
>> > make docker-image-fedora V=1 NETWORK=1
>> > time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
>> > === TEST SCRIPT END ===
>> >
>> >  CC      stubs/vm-stop.o
>> >  CC      ui/input-keymap.o
>> >  CC      qemu-keymap.o
>> > /tmp/qemu-test/src/util/vhost-user-server.c:142:30: error: use of undeclared identifier 'VHOST_MEMORY_MAX_NREGIONS'
>> >                             VHOST_MEMORY_MAX_NREGIONS, nfds + nfds_t);
>> >                             ^
>> >
>> > The full log is available at
>> > http://patchew.org/logs/20200614183907.514282-1-coiby.xu@gmail.com/testing.asan/?type=message.
>>
>> I couldn't re-produce this error locally for both docker-test-quick@centos7
>> and this docker test. And I can't see any reason for this error to occur since
>> VHOST_MEMORY_MAX_NREGIONS is defined in contrib/libvhost-user/libvhost-user.h
>> which has been included by util/vhost-user-server.h.
>
>Using G_N_ELEMENTS(vmsg->fds) instead of VHOST_MEMORY_MAX_NREGIONS is an
>even cleaner fix.
>
>Stefan

Thank you for this cleaner fix!

--
Best regards,
Coiby

