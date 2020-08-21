Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E53AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1881204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZP/xoPHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1881204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98X8-0008AY-4J
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k98WQ-0007cS-TG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k98WO-0002b0-Qw
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598021999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vy881/qAEDsV+KBZjqT0uXzbJppbrI4v+kwEoJq2ncY=;
 b=ZP/xoPHbi1TLUUEwqxLiFSPNuws933/CtZb4J5D5yXrnxq+j+mR6g3bFsl593VgTKiwzbw
 bvfUjp6utW9dXw23oa3dayYWrhTNbvZy8FluuEjxPh4PeO9kOfzRqCWGGUHpzB7l6SsxR7
 B1G8CUIZUrc5JDgC8ZheipyGo1o5IPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-5Banx7P_OPithdDy21sy-Q-1; Fri, 21 Aug 2020 10:59:58 -0400
X-MC-Unique: 5Banx7P_OPithdDy21sy-Q-1
Received: by mail-wr1-f70.google.com with SMTP id t3so622680wrr.5
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 07:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vy881/qAEDsV+KBZjqT0uXzbJppbrI4v+kwEoJq2ncY=;
 b=ATwBxfezzAN/gpgFl9kv/RtD5AfvxYyFbOu6fhYhjpj7kilu637ma6PsO4Ca53JUmn
 ChLScvobyET21lyJHv6s51kR1p0MCWHS9ubhSYI0Iisi5lKF1fMYvmxwGAfSPhPOE5Yx
 g3pE+BLgse+VP9BqqHMZAG87islEa31Z+/b8PIe9X5pngULZj2JVL+AMTmApXM9BKR5e
 ZUsDNjXP68key4rgvsbAnfaIWx+4OTkyQT3dJjpoVorP9dDHevHqMmSPASZC4r40mE3M
 O0+A6H9+ocwrDLJY0HngM343W/krnuI1X1wrmP8N0zxGL+zCABn/S+RJcRKSmOn7R3yM
 Qk/Q==
X-Gm-Message-State: AOAM530NgdlYL1uiAl0tnNZqwdfxDfy/YKNKePhkH/G4WdUiRx2o3REs
 cB9Xpty5/IUVEM0YOzQ9SRd/xQ4ZgkyBtAXCGWCdSACMxytWALW28DSf0mA3kOFA3gtToQIXBJO
 CpOYURG7G6PA7XiI=
X-Received: by 2002:a1c:a54e:: with SMTP id o75mr4389451wme.181.1598021996769; 
 Fri, 21 Aug 2020 07:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGGk0oy4C/84zGj3zX1ttxgX2wOQZwjViEbXsSjkf6cuhliWK1IAuF4L20gMqUzM0PdS7hNg==
X-Received: by 2002:a1c:a54e:: with SMTP id o75mr4389425wme.181.1598021996482; 
 Fri, 21 Aug 2020 07:59:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id n8sm4465991wra.32.2020.08.21.07.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 07:59:56 -0700 (PDT)
Subject: Re: ANNOUNCE: build system conversion to Meson has landed
To: Laszlo Ersek <lersek@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-87BcmoPjY9BCodx9+m6QmhfikHv5sLVJ8w20cszDvDA@mail.gmail.com>
 <be069d22-510c-7c5f-7b57-00e8abd0ba41@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74116413-bd9d-b1a3-2364-26b7dcc7f105@redhat.com>
Date: Fri, 21 Aug 2020 16:59:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <be069d22-510c-7c5f-7b57-00e8abd0ba41@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/20 16:50, Laszlo Ersek wrote:
> On 08/21/20 15:49, Peter Maydell wrote:
> 
>> https://wiki.qemu.org/Features/Meson/Next has a summary of changes
>> and is worth a quick scan through.
> 
> I'd like to propose a wording clarification:
> 
> """
> For bisection: incremental builds work fine in the forward direction.
> They probably don't work at all backwards. This is mitigated by the fact
> that bisection usually starts at a release, and the patches should be
> applied on top of the 5.1.0 tag.
> """
> 
> namely:
> 
> - s/forward direction/forward direction, across the conversion/
> - s/backwards/backwards, across the conversion/
> 
> Because the way the paragraph is worded now, it suggests that *any*
> individual bisection step that moves backwards in the git history will
> not build. That would be of course catastrophic. We should clarify that
> the symptom is limited to steps that straddle the conversion commit range.
> 
> If the suggested replacements are OK, I can make the edit myself (if
> that's preferred).
> 
> (Not trying to be a busybody -- exactly because I contribute little to
> QEMU, bisection is a comparatively large part of what I *do* do with QEMU.)

That's fine! I made a small adjustment and you're free to improve
further on the wording.

Paolo


