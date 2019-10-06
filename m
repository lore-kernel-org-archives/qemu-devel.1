Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE9AC4360C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 16:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C7E20835
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 16:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C7E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iH94a-0001ba-Rh
	for qemu-devel@archiver.kernel.org; Sun, 06 Oct 2019 12:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iH93g-0000qV-UT
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 12:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iH93f-0004Kk-RM
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 12:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iH93f-0004K7-Lg
 for qemu-devel@nongnu.org; Sun, 06 Oct 2019 12:06:55 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8031B368CF
 for <qemu-devel@nongnu.org>; Sun,  6 Oct 2019 16:06:54 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w2so5811977wrn.4
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2019 09:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oKS4PwtC/FKhU5W3hAhSP7Bqng+IBYveqm80kdVRSfE=;
 b=nU2i5XzOaRhY2YLHnArSLjjKo2SIX+7lnz2ZkDmoyYKcnQjjMQuYOrD+xQSTAGSzFZ
 +4ihesRTF4CX3fnbh0q4ZqO+D2oVdDjAJRFaCHKJX0ErsiWRdnEmSg9uJQVgYa0lugjJ
 ZAS1bFX3qcep/gx8RrmOwLI18fdIsfLN/MeN39q/WDkGUlyvYWlPVBpZM/wEEILlu+rZ
 lGj8qcjiprNIpFrlNDamhOL83KoFGM1zigjmdW3sETW2Pr9mNAmnGy3U2WDbyBwTu6wF
 SyE9C/hgs2ivDdrdPTnCo0qpGLaVGyEt1pWofx9d8jbyfosQ2fnglFBu1xE1MXin4neq
 jEsw==
X-Gm-Message-State: APjAAAU2UacpRIyV71miJqESrqP4FXUjsBaeKv8VinbawguWyS7HDkTe
 g3zOJrL+VR1mCbzBInFmOaY3qpGYezbmEf+5Inhh+unskWqVK3PgyyTGBPqI5sVI6OtbUXuJWKJ
 uPVo9v/+dEvHGVgA=
X-Received: by 2002:a7b:c403:: with SMTP id k3mr18341814wmi.89.1570378013216; 
 Sun, 06 Oct 2019 09:06:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyepQlMErKxTd68T0eCrSFOmRIvPIo6GG7eeMbgrARFk4KwCC9HK162I7YOjiPd387vpFbFg==
X-Received: by 2002:a7b:c403:: with SMTP id k3mr18341800wmi.89.1570378012956; 
 Sun, 06 Oct 2019 09:06:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e876:e214:dc8e:2846?
 ([2001:b07:6468:f312:e876:e214:dc8e:2846])
 by smtp.gmail.com with ESMTPSA id y3sm26943510wmg.2.2019.10.06.09.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Oct 2019 09:06:52 -0700 (PDT)
Subject: Re: [PATCH] tests/docker: only enable ubsan for test-clang
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <1569939264-12539-1-git-send-email-pbonzini@redhat.com>
 <7a5238e3-cbbf-da16-eb58-e5474c6245e8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bb885f16-bfb6-088e-2066-65364b533b61@redhat.com>
Date: Sun, 6 Oct 2019 18:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7a5238e3-cbbf-da16-eb58-e5474c6245e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/19 19:59, John Snow wrote:
> 
> it looked quite like --enable-sanitizers was indeed the same as
> -fsanitize=undefined; or at least was a superset of such.
> 
> I suppose the argument you're making here is that we *only* want ubsan
> for test-clang?
> 
> (I guess so, since test-debug also stipulates that clang be used; but
> enables debug.)
> 
> In this case, is there a use for test-clang at all, actually?

Yes, test-clang checks that clang-specific warnings do not fire.
Enabling ubsan isn't particularly useful in this respect, but it's okay
for me to keep it.

Paolo

