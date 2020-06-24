Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB8DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 04:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9521F2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 04:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMt3AgHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9521F2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnwbF-0001L5-T6
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 00:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jnwaL-0000uO-Ln
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 00:00:29 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jnwaJ-0001TR-Ml
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 00:00:29 -0400
Received: by mail-pg1-x544.google.com with SMTP id r18so716440pgk.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 21:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3Zlt6Ds0mfK4MCo6aVeT1wQBwXN//Fc45ga81GcNYvU=;
 b=hMt3AgHdzMbabBRcr7tgw2++0aUO72wuL4I/vZr7JJV+kJf/KNFPHtUU15LCqRT+IX
 aXzfJe04xwBFmqjoAOTms57TMfJZuR/zdc6NkIPGz8R04gdZE9Y1FRV2JOQnvl1jVynU
 ZFTd1C5MflbMHRZoZsA3kmJoPQyqM2e5kPztGTsuary6JaZTXbhy4SBpyFtNn3AMzG2f
 dLK6/nVnv5rFpi5SZRcHzyihEWqvgNFZ3WqVr7zEJKWTGIy5zgSTVzHIfiUumEKVoK0d
 UBTROtEczBqpz29hWoSOPS2PLY4xoTMjIpKdj/anasTxAiQNhlWM1PK3B72AQJwEgPG9
 X/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3Zlt6Ds0mfK4MCo6aVeT1wQBwXN//Fc45ga81GcNYvU=;
 b=jJPrIUt4s0+L0mY6CQ/ZCXnbK+lI9X+70qtqe8uSWGSP0nAtCWtP8fXIEP4voi3gEP
 zHlgYkRx3KcTGWqo/etX+6TNmulD6zdGAUoZidwaq94ZnPJN5kpy0UF/F4pdL3LYZY9g
 B0MggdmfINUoJYl/LJiqAcQf9qupQ79fLFQMUqkLYBMpEFeSGgm/7xYNO2XWfoMEVSgW
 9AmDkZQsOlVxC0mdCQFH953vd0pZafJrSbIzS/Kkq5wCqo7NDjkJPTxmqebzCy0YY0UI
 Dq3/77YmvyA0jcgt4Mg0a/Vk3OEjkjY5n2kYdBq/UMAtovfly+t3KWt2XnAFWsNI6XEh
 O0jA==
X-Gm-Message-State: AOAM532kLQJrcXA+SStzQBXSYgE9Jjnwio/5+MAa3BcPe8Yk93Y03qpy
 GOX8YAzkAljPMSDDXlrLaCg=
X-Google-Smtp-Source: ABdhPJxcvu0EoggNpnIV9MpFT29e6nvU9L/dsqDzumG+vwvRbKQy9+NGom0vH2cxGl3ZB4rIXBeK9g==
X-Received: by 2002:a63:495c:: with SMTP id y28mr20284647pgk.30.1592971226134; 
 Tue, 23 Jun 2020 21:00:26 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id d6sm3841444pjh.5.2020.06.23.21.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 21:00:25 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 24 Jun 2020 12:00:19 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200624040019.ls7wzeskeohzpzld@Rk>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <159216218770.30485.1172665077342708998@45ef0f9c86ae>
 <20200616065216.wpf2rxgwxvtqgxlk@r>
 <20200618082748.GB1956319@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200618082748.GB1956319@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=coiby.xu@gmail.com; helo=mail-pg1-x544.google.com
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 09:27:48AM +0100, Stefan Hajnoczi wrote:
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
>Please see the recent change in commit
>b650d5f4b1cd3f9f8c4fdb319838c5c1e0695e41 ("Lift max ram slots limit in
>libvhost-user").
>
>The error can be solved by replacing VHOST_MEMORY_MAX_NREGIONS with
>VHOST_MEMORY_BASELINE_NREGIONS in util/vhost-user-server.c.

Thank you for the clarification! I did run "git pull" when checking this error.
It seems there is a delay when pulling updates from git://git.qemu.org/qemu.git.


--
Best regards,
Coiby

