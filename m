Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C301DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8999C206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnFiAXOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8999C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Ue8-000681-Ey
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2UdM-0005SQ-5x
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 03:11:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50182
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2UdK-0003tv-Mt
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 03:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596438701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZGWNvQoyphBRtgfVpcmeCuGB8r273RcUlzahaXuspg=;
 b=HnFiAXOf2E+fZBHjf22ba8F1iDjpgAsYZiByqwiLlHN6ZIxeEBqj6FmsDkgAz/A2c9D5V4
 oumU/sf41AOq3FlopqZHoY+7tq2VOuknYObpvDnQpPEB+Ww/mR9y/a+gDdZzo86uicRAn0
 wgxg8mPxIcCv3+cI1dX+JWYmigp/Nts=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-2gHbwLGQPOyIcFmv_MREmw-1; Mon, 03 Aug 2020 03:11:39 -0400
X-MC-Unique: 2gHbwLGQPOyIcFmv_MREmw-1
Received: by mail-wm1-f71.google.com with SMTP id q15so5171922wmj.6
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 00:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ZGWNvQoyphBRtgfVpcmeCuGB8r273RcUlzahaXuspg=;
 b=IFuBOwtpjO2GnsPRvhFS7v54JBnM4TlYGFZJpgtwlMYDvNgxoWuj40zyW/fralelMn
 XhG8ingrdu7ndHUvlJZJYudw/krynYtxV3iu47rUmv2Qg8ljBZN8IPOc62aoq3+L8/+F
 ofQZ3PqCXy8zCZMdibaE82aVr8ActrcMPv6JNJbX92qCgNO9tDoE30WwNI6y7/Q6yx/1
 fftFJjKXsECFZUe0YEMRrbHjObl4F48GIawauutsEimLCuVZWkfVP9QsWb8DWxhR8ulj
 hdIOFdJDJgSJOPTEqrRXm8cmVZ93HE/RdpU1+JVkC21plal0jieedrEIdKsUONimgKNu
 FybQ==
X-Gm-Message-State: AOAM533kvTscYjjbihrxTZBx7SKzauPoZKCCzXxsi6YDMENK6ss4v/UH
 S/otkJ+cdnQfZeeZ77DXiDTWXDNEdDtMQuNhPhvMFwkLGVQSSakyiyXYXtr6Hzz15tJqIqb3uwz
 qcJt461YQkf36h0Y=
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr14303108wmg.128.1596438698479; 
 Mon, 03 Aug 2020 00:11:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7UTbFhiLzvKExqQSbdqJpaUaBYVq4oO5Ia6vl0XS8Z34ys23gZ+uiPSakKxV468TfCLab9Q==
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr14303087wmg.128.1596438698216; 
 Mon, 03 Aug 2020 00:11:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:310b:68e5:c01a:3778?
 ([2001:b07:6468:f312:310b:68e5:c01a:3778])
 by smtp.gmail.com with ESMTPSA id l81sm22081463wmf.4.2020.08.03.00.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 00:11:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] accel/tcg: interrupt/exception handling uses
 bql_interrupt flag
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-3-robert.foley@linaro.org>
 <67497c73-d2b9-941e-471d-de0ccd61bb7f@redhat.com>
 <CAEyhzFuPNsC3xVPG9bFEbfUPq6MW26STdr-OtKzGsfKykK2FuA@mail.gmail.com>
 <CABgObfbHMsn7yR9GiYGUmrHr6o2LZT+xdw+915R6zNi29reRzQ@mail.gmail.com>
 <87ft95yqq1.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86d2f7e4-dd44-75c9-817a-b7afa90b4f38@redhat.com>
Date: Mon, 3 Aug 2020 09:11:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87ft95yqq1.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Puhov <peter.puhov@linaro.org>, Richard Henderson <rth@twiddle.net>,
 "Emilio G. Cota" <cota@braap.org>, Robert Foley <robert.foley@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/08/20 18:09, Alex Bennée wrote:
> I originally suggested keeping the locking choice up in the main loop
> because I suspect most guests will stick to BQL IRQs until they find it
> is a bottle neck.

True, but the main loop is already complicated and conditional locking
is pretty much impossible to reason on and (in the future) do static
analysis on.

Paolo


