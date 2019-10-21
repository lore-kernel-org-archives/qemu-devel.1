Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8134CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B8D205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B8D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaZ7-0007t7-Dc
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMaVg-0004oh-C3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMaVf-0000qu-5v
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57760)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMaVe-0000qk-Vy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:26:19 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C60C44E938
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 16:26:17 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id i10so7567077wrb.20
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qbf8z2yOjzDrGKoSKCSGN0b7ub3PHRaty2i2XPZShbc=;
 b=aw6gF18qgfc/v6yh5vQevacB2t+/GswkN0LziclLZS7xfXhIKmpvpTkZhreuhov8bG
 0BDHSPRLqGLnDe3ecjnFZ5Ko9wnMkXakCnKotjgX/bAAKuwWenCjAsWBkzw08RcErtzp
 /jcPWUKYuqdlvhxxUrW+sOQwJ1GqudO/hNbR3fpjNYuZ6ZS8/GxdIVZHqGfI/pwvbw9V
 LjMm0n2yoMqOchL49+eLFzGt/lk7nrcP/btkZLKxSWFBQb8kAuXnq53Ty6q64Pi/+9S2
 7UJH8twzmbKB0Fa9rNrxTgwMQJaKuvE0tr459cUPFKsgTU+6cv9EVnzNHrLtoK7lDh2e
 e2UQ==
X-Gm-Message-State: APjAAAXSbSLKUS6CV7ISbeQ8uLLAeqil+9lvcCaNoCU8Al0QScFchlGo
 VmneqlCPUb3CnA2yzAqjMwt0+oDi/isPFjgqx1mOlPQtn0PvJ3HFU6mI9p0rxvtgk5AvIMVfJfR
 N1M8FyTlz3L4LJSY=
X-Received: by 2002:a5d:4748:: with SMTP id o8mr12448237wrs.239.1571675176466; 
 Mon, 21 Oct 2019 09:26:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNzGEojpJd6rZbWJBcUhKMf3Yep6MwOE9xk7Pq/OgjhJIbIZ9DhPzHBBaSegjxj4Qk40rSNg==
X-Received: by 2002:a5d:4748:: with SMTP id o8mr12448210wrs.239.1571675176167; 
 Mon, 21 Oct 2019 09:26:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:847b:6afc:17c:89dd?
 ([2001:b07:6468:f312:847b:6afc:17c:89dd])
 by smtp.gmail.com with ESMTPSA id p20sm10668222wmc.23.2019.10.21.09.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 09:26:15 -0700 (PDT)
Subject: Re: [PATCH] i386/kvm: add NoNonArchitecturalCoreSharing Hyper-V
 enlightenment
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20191018163908.10246-1-vkuznets@redhat.com>
 <4d89f852-85bc-8370-5929-848d24b80a6f@redhat.com>
 <878spe197z.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <66f1dd30-3e45-4dc6-ba0a-d52e5aae6501@redhat.com>
Date: Mon, 21 Oct 2019 18:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <878spe197z.fsf@vitty.brq.redhat.com>
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/19 16:09, Vitaly Kuznetsov wrote:
>>> +    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
>>> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_NO_NONARCH_CORESHARING;
>>> +    } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {
>> Do you want to make auto the default if "-cpu host,migratable=off"?  It
>> can be done on top so I started queueing this patch.
> Hm, one thing is that CPUID 0x40000004 doesn't exist if no Hyper-V
> enlightenments are passed so we'll probably have to modify your idea to
> "-cpu host,migratable=off,+any-hyperv-enlightenment" but then the
> question is how conservative are we, like if QEMU command line doesn't
> change can new CPUID flags appear or not? And we'll probably need a way
> to explicitly disable HV_NO_NONARCH_CORESHARING if needed.

I would defer to Eduardo on whether "migratable=off" would allow adding
new CPUID flags.  The follow-up question however is whether we would
benefit from a "+hyperv" option that enables all known Hyper-V
enlightenment for a given machine type.

Paolo

