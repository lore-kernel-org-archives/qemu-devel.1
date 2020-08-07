Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE00E20748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuO8kseG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE00E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zRm-0000hR-6j
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zQ2-0007al-0W
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3zPx-0008Bt-HZ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596795363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/PLpStsmLasYsxnSW6lYw+3VkFplJ9d7jhxH2stG9o=;
 b=HuO8kseGIoXyNTfi+KxwQtxAL/MZnT9SrvPyvOqTzW/PeMFhjgIupoBVAGfGUfx8Squdoh
 bd9LfEDpvn1c//Fer9itvHD519QOblq6aJevEeEj8tcp8MmJRZDqPjr+Mwt5LA0P+tPcMT
 rrOrDmBDQAZLysMxa+12wk0AX9LJwkU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-fK_m4AbUPTeKuVpPEVv3NA-1; Fri, 07 Aug 2020 06:16:01 -0400
X-MC-Unique: fK_m4AbUPTeKuVpPEVv3NA-1
Received: by mail-wr1-f69.google.com with SMTP id e14so560716wrr.7
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L/PLpStsmLasYsxnSW6lYw+3VkFplJ9d7jhxH2stG9o=;
 b=pffTKPcW82dDd4Ie91j4Nher01U0rn4T67ZGJ3FHeEerxXaWwcNieIiZXVruY5SgZK
 x5S7Mri003Y8CHzd2o20ZVeNSCHE6pt5MLOiu8ZH6wLu9bTui8qN7NB+G6xnYZMPncCA
 q0UNm3ao4F5U4BUkmvshtbCGbRC446O3tE+CBvN6MkNEbwSMteioV8y156raFuclw+YG
 uF2zjAmND3RqC96Agyv6/vs5ysexyE0jC2kOzhDIxeaFsuF+dOsU65VdriUjeg9lhNha
 Yooq+T76rgH9kuL0pd/2ap+nw1RKi0zBX5/dAbljIivY+FcxQarhSr3wzYRzyjpre6+D
 IvKA==
X-Gm-Message-State: AOAM530wOOI9Va01Sp9dqnQwGoVhDLR0J1JBEsFHzJHrpPNbeSUzb578
 tYVWx26yxJJq1xtunFg6bH0hQIk/Pg6qIdjNU5WrkBkQChCUrn1wRBdgVhd6RWhGh5Ts7k7o9kh
 V6k6mMBjSgrtHgXs=
X-Received: by 2002:adf:b34a:: with SMTP id k10mr11210762wrd.402.1596795360638; 
 Fri, 07 Aug 2020 03:16:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1ih8RlP5biNZ/Rgip/pgBdsgg8TBsuLYIPgOK7JgSXZU1srUoyTtDWWgX/aEAVnOKOPLSkg==
X-Received: by 2002:adf:b34a:: with SMTP id k10mr11210745wrd.402.1596795360361; 
 Fri, 07 Aug 2020 03:16:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id r22sm10144428wmh.45.2020.08.07.03.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 03:15:59 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
 <CAE2XoE_eMv_=zoEe-v1HiqcKX+FNobKSKzV=9eLkJNivnuYg-A@mail.gmail.com>
 <4e8addca-7400-f1a1-ee56-991def2959ae@redhat.com>
 <CAE2XoE9HzvHOQ8odXwiOw+nsYOkwTK+jue1i-mQ6Mo29T+9Rog@mail.gmail.com>
 <c6059e0c-ed50-399f-111b-4d4b96c80e85@redhat.com> <874kpelqjy.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13b9e7e7-c86c-35fe-cdb5-002c93e73448@redhat.com>
Date: Fri, 7 Aug 2020 12:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <874kpelqjy.fsf@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:20:01
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, jsnow@redhat.com,
 Cornelia Huck <cohuck@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 armbru@redhat.com, luoyonggang@gmail.com, stefanha@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 12:05, Alex Bennée wrote:
>> On 07/08/20 10:31, 罗勇刚(Yonggang Luo) wrote:
>>> Any IDE works with meson properly? Does meson have vs code plugin?
>> I'm not sure what the plugin would do.  However note that even with
>> Meson, QEMU would be built with "./configure && make".
> One the subject of IDE's my Emacs tooling (counsel-compile) uses a
> mixture of "make -nqp" and "make help" to probe for potential make
> targets. I assume these are still probable with the meson generated
> files?

With the generated files yes, I have no idea how counsel-compile would
deal with ninja.

Paolo


