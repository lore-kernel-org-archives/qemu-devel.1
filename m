Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B90C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 04:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF6B2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 04:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWpJ72GQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF6B2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnx8f-0004Ph-Fs
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 00:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jnx84-0003u5-Iz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 00:35:20 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jnx82-00073J-Ko
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 00:35:20 -0400
Received: by mail-pl1-x642.google.com with SMTP id d10so515393pls.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 21:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NU2s4Szh4ZgsCIg9RQKHCmQapJmjPK88jfBxLcCEwOs=;
 b=sWpJ72GQmKLcuLu/7WkXsBsOgd3HmNzRnkWM563979T3v5/WysdMZbmN2DbMJYWFkO
 vWaVE4GtxmIl6/YhfoIxYJtgSpiZb4P8uTNLbU7C07XEfEZ5KnqjN8J5T0HEpxxtLd5p
 WgB5ikX1c3bZDjH60ouTvLzq58YmJ0L/IS+NzvgjFwV3PdbNLSq/Qur/caSHfUuTbewD
 wvQcIpW7rHEF2maPNmMGIMFP62/smT86rXhDjAmMQuy1NFQ24OZ9d+B6avPsltCEO8fM
 UXjXbr9bZPHID6R/PE55xL7ZR7ZuVevD35aBHRRoREOgQhT2GtO/ECH9eCBWEXB1mcYn
 iyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NU2s4Szh4ZgsCIg9RQKHCmQapJmjPK88jfBxLcCEwOs=;
 b=L9myADYscNq1ZRvOh4cMZLA4/3yHB/t6l1n4FW6DPIcvnh5HrerJ7jhtZ0YQAjYekr
 vEU2bLz6DOjr0toKsCLYS3I4rSIRQDP2S2N53l2DSA6UZmyU0aByUKnK2SdukXtuQEFS
 qC8vUXOK966aQ4BiloVj5cr8VEWz7C2FnzvGdle6kqfw5YTLVvljyGvtk3Y7qHzS6Yws
 D4kaggaWhpMKZY+5ydR39pQN+BKHcDjzSD3VpimS1BA30lG+DG9L+gN7bENlxQnULShq
 pbjvtkrF2k5MmRxYGV1Hug+XRQWL+R8n4qtlNspfmAztrPbJ9VrEiU45KiHti5VqFDiI
 d3rw==
X-Gm-Message-State: AOAM532xsnRvLfBqP7/5WLcOgxCGdhMAABd4Yjbcc6mcu3sYLlIY5Lqw
 1z2xXxUM9YaE7dmQVuTW2Z4=
X-Google-Smtp-Source: ABdhPJxpheLYhMDK9Et+2tRG2YIKebCFvybnVn/F6kxaP8kRssRoUsBdk15wixU3jwjxlGXCGI2zJQ==
X-Received: by 2002:a17:90a:e60b:: with SMTP id
 j11mr806056pjy.189.1592973317099; 
 Tue, 23 Jun 2020 21:35:17 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id h9sm18702785pfe.32.2020.06.23.21.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 21:35:16 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 24 Jun 2020 12:35:10 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v9 5/5] new qTest case to test the vhost-user-blk-server
Message-ID: <20200624043510.ydzwuyr325ncgnxr@Rk>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-6-coiby.xu@gmail.com>
 <20200618151751.GD1956319@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200618151751.GD1956319@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, bharatlkmlkvm@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 04:17:51PM +0100, Stefan Hajnoczi wrote:
>On Mon, Jun 15, 2020 at 02:39:07AM +0800, Coiby Xu wrote:
>> This test case has the same tests as tests/virtio-blk-test.c except for
>> tests have block_resize. Since vhost-user server can only server one
>> client one time, two instances of qemu-storage-daemon are launched
>> for the hotplug test.
>>
>> In order to not block scripts/tap-driver.pl, vhost-user-blk-server will
>> send "quit" command to qemu-storage-daemon's QMP monitor. So a function
>> is added to libqtest.c to establish socket connection with socket
>> server.
>>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>>  tests/Makefile.include              |   3 +-
>>  tests/qtest/Makefile.include        |   2 +
>>  tests/qtest/libqos/vhost-user-blk.c | 130 +++++
>>  tests/qtest/libqos/vhost-user-blk.h |  48 ++
>>  tests/qtest/libqtest.c              |  35 +-
>>  tests/qtest/libqtest.h              |  17 +
>>  tests/qtest/vhost-user-blk-test.c   | 739 ++++++++++++++++++++++++++++
>>  7 files changed, 971 insertions(+), 3 deletions(-)
>>  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
>>  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
>>  create mode 100644 tests/qtest/vhost-user-blk-test.c
>
>This test case fails for me:
>
>qemu-system-x86_64: Failed to read from slave.
>qemu-system-x86_64: Failed to set msg fds.
>qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
>qemu-system-x86_64: Failed to read from slave.
>qemu-system-x86_64: Failed to read from slave.
>qemu-system-x86_64: Failed to read from slave.
>qemu-system-x86_64: Failed to set msg fds.
>qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
>qemu-system-x86_64: Failed to read msg header. Read -1 instead of 12. Original request 11.
>qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Input/output error (5)
>
>Does "make -j4 check" pass for you?

Actually it's a success since it won't fail CI. The reason for the
occurrence of these dubious messages is after finishing the tests,
vhost-user-blk-server is stopped before qemu-system-x86_64 is destroyed.
I'll see if I can find a way to kill qemu-system-x86_64 first.

--
Best regards,
Coiby

