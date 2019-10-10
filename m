Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4410C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A4C206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A4C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWX7-0004bc-5g
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iIWWG-0004Cr-IZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iIWWF-0001EP-6q
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47014)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iIWWF-0001E0-16
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:22:07 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03CD98763B
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:22:06 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v18so2597838wro.16
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CZRifIUMbB0CRV9D/v6QxjMqHNm+4ZQRP80fyHtI1IM=;
 b=E3UtYkiogjgiOU7BqKef9iKvCl+Ad7QILz3qI1WOHjh7DfAJXHDBINLaYJ0gfLUK/5
 TmK0kI/pSYhrEBwuddZtfjGu3zVyIyDfqHW4Ck5nWZuZqFVuglGYFE3BxtOBgRKFZSy3
 1dhdotu9BLLkv1eV8ITJZmYufzE2OlBkrcT/V4HJj9TyIjSZRND5+3HpO3WYsz3/Dr93
 +nieLQNuxVHonGK5hC7pFwFsu6tliaMTOVcugSEgXITFB/i7Oziz5DZx8gdw6NGFRpLU
 jdHWfFPeYNUqzQWXmmG/kRYQq6K6eXaygJWfmrPyW39IQdL0+sPPMaaVALNB0NsCdldL
 kv7w==
X-Gm-Message-State: APjAAAWjq3joGng4sF72e4/KFXCutkIIh99pJeYZ2SlfBo+eEbjbXvmY
 2Rt9VaMQSeX1FphmUrZ4MY7FB5LJSOCwgIUOLWZo9/Cs73Aw2qfXy3TDTdTTy/8k3Fvyfn/nM+8
 BdnPXvGVlJgoZTGM=
X-Received: by 2002:a5d:670b:: with SMTP id o11mr5824191wru.31.1570706524693; 
 Thu, 10 Oct 2019 04:22:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqEU0QaBXMWcD6pE2ZtHJ+rZ6rmQvpHWFOvbU4R9JcqhqorX0fQoMmR+moH0HJPkReYl2uTA==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr5824173wru.31.1570706524470; 
 Thu, 10 Oct 2019 04:22:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e?
 ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
 by smtp.gmail.com with ESMTPSA id f83sm7056641wmf.43.2019.10.10.04.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 04:22:03 -0700 (PDT)
Subject: Re: [PATCH] error: Fix -msg timestamp default
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191010081508.8978-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <167c9b31-7592-de9f-a1a3-e79d8e66fc5c@redhat.com>
Date: Thu, 10 Oct 2019 13:22:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010081508.8978-1-armbru@redhat.com>
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
Cc: msmarduch@digitalocean.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'll queue this patch.

On 10/10/19 10:15, Markus Armbruster wrote:
> -bool enable_timestamp_msg;

Would you like me to also rename his enable_guestname_msg variable to
error_with_guest_name?

Paolo

