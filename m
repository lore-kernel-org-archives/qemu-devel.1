Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD16A2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="Rx6HPF2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD16A2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgsOw-0002yS-5U
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jgsKj-0007pM-9r
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:03:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jgsKf-00031J-9A
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:03:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id c3so6698939wru.12
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=02p9Yf1L+VAOSaHm79JywoXQbGHV/s1Rp4SaiB6URfY=;
 b=Rx6HPF2MCkzx1Sk8bPJNlpzxREFI04iu5B1Rtjc+DRWIETcU3mOKcaleb+mAlUz2T+
 NS4P/t0aGv7LKrrkCPMKnk4fuHrvh2/vUHvoZyK0nOC643ubjxKA2NOwkWrYyzmSjfBI
 wPDP2whn9BqizT6QtfJ2H4LclbcozxjvvD1bS1ynzgA8ydM4qSSCXKm0EF9RvQYFkDiF
 3/Gc83t68uUD7A+Zv2PkN0e17t6e9VXID75yFIYtGOxBwHvyPUgZzM+M8P+T+jZ1nJO9
 XQrs9LMa53s53+YSWrOCHdtSZB4I5jbJH4tbf+VR7hvfnVpdQfk3rqx/1x5Nb2xrzGgu
 tHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=02p9Yf1L+VAOSaHm79JywoXQbGHV/s1Rp4SaiB6URfY=;
 b=mTL/B79o/ydzDR5JaXSrZLrU1w/OhD2u6+8FzYZNqwEObtowyj0nKT585DbYvTSuev
 x5lUKOF6+3agimDiknWMwKuCFNiuW05ANV6LKQUzoDpv1TXXMANrDdxf8inNP1y7Ij9T
 5DJAVTMcvEkxLTYg5fsZrdIxeKaM5sNXeS5ehyFW784UgKgZ4idXRkejmeY0J1FaLF/H
 Dnr8Lz4nSQ0ESLLm/ng8tBfifLZzmfbPfSSzg3N/3qToCHM6BRB3Dhy9KB/Xer823+Ze
 7W+zk9ixvGDWVeTBs2srQBp2FcsQoGIbC2pNI0YIpj0uAuvhOFmdHloeParxFy5VRKNL
 NUDw==
X-Gm-Message-State: AOAM5323RuYxWRK7Q5d0vssGOjsyPuHiZWrfi21SVk4vvQf0/1i0HSQh
 cXVL1Hz/1bN8g3Bg5vslWOYK3Q==
X-Google-Smtp-Source: ABdhPJyghlj05zWmYkgQ1PTBIQh447EakKxAX2NLoUxZRlTg7PbBR+t0VhipgEuVZea/U3PQ65ZTiQ==
X-Received: by 2002:a5d:6581:: with SMTP id q1mr4951285wru.43.1591286583290;
 Thu, 04 Jun 2020 09:03:03 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id i10sm8404117wrw.51.2020.06.04.09.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 09:03:02 -0700 (PDT)
Date: Thu, 4 Jun 2020 17:03:00 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
Message-ID: <20200604160300.GB28566@vanye>
References: <20200604125544.GW28566@vanye>
 <20200604131802.7w4hncgq2gopbw6z@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604131802.7w4hncgq2gopbw6z@kamzik.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 15:18:02 +0200, Andrew Jones wrote:
> > - drop the call from aarch64_max_initfn to aarch64_a57_initfn, and
> >   copy the relevant bits into the former for the !kvm case
> 
> I don't have a strong preference here, but if the naming is what's
> troublesome, then I'd think we're better off creating something like
> an aarch64_aXX_initfn() function and then calling it from both a57
> and max, and anywhere else it fits.

Well, the naming isn't the only issue, although there looks like a
certain amount of duplication could be deleted from a57/a53/a72 and
also be used for max if there was a common initfn.

But there's also things like:
- a57_initfn explicitly setting kvm_target, then only being called
  from max_initfn for !kvm_enabled()
- a57_initfn setting cpu->dtb_compatible to "arm,cortex-a57"
- a57 initfn setting cpu->midr, max_initfn overwriting parts of it

Best Regards,

Leif

