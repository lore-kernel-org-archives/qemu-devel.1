Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AB1C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63BA2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIst1Kb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63BA2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvEQ-0000go-DY
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUvDS-000092-Fd
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUvDP-0006ga-N0
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfJtCXCmmdCRg48OPCBRxndOcHP4QR8ZJYw+5Ttjeqk=;
 b=dIst1Kb0lNhAqGhacwCUWlysBtSkIJ6EfnuiR1+2OmvGnGimlYXSD0vZG/nGbdYfMh0lEx
 orjw+IRRINxni3bqWOyA2fmd54s/DEdxGymEGqBIHEPBH5R2X8N6bFm7DsDw5vs0A8j4Hf
 8jHfM2S4pozNeNz1UJFlQ15oV0sAMvI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Oh9PzersO16sTd7FPrCKrw-1; Tue, 20 Oct 2020 13:14:24 -0400
X-MC-Unique: Oh9PzersO16sTd7FPrCKrw-1
Received: by mail-wr1-f72.google.com with SMTP id 47so1061654wrc.19
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dfJtCXCmmdCRg48OPCBRxndOcHP4QR8ZJYw+5Ttjeqk=;
 b=cm/rIcQX5rvGWcMVsliE1OuZsSIkyO+FvmDBKATGkLIm4fdoEkSDRw+Wcr5OqxyuXF
 blYMCs1x81E0srvSA/kI/Hrk4NoYA2Z4A2vWfoOULxM+q8U9kSWSkbunfbZfamiwKwpR
 HRtW7vreBJD/+0e4imTpmIGpT0Wq60RNfj7LLnV1FPvnASeBW05I/L/gnUq4Xs8Doyrn
 aCxvHIIimfSKCQCyMhQWNEbY13susBPv/QekhU/Cc9f7lryxyZ+Kc1PZwo6YsMu+TMVp
 G68oTJ5sY942zVfsRDxhzJZ/lNUTntFEK4R+IQ9lRfV8ccYolVYeBjbYkvPGMk1FanpG
 s0GA==
X-Gm-Message-State: AOAM531/G6kCRCm3eKM7N7T/7FqQK464DmD0V7QQVQHIxHbuGOmzNSB5
 95TSzX43wPSNUn+oMtRTB3BEs8/NFyC3aKXSQGJjcG1aTaWf60iEh2nnZbmxTn9pTXvElTijo6T
 mCo5Zf7V5q8/sHIM=
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr2799312wmq.36.1603214063245; 
 Tue, 20 Oct 2020 10:14:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM/GhicP9qmjl+s5+517NhMHQT7RKFoL/lJ/+v5nTUwltGpwZkWL67uqFZH4g/Ew0TcjLMHg==
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr2799294wmq.36.1603214063010; 
 Tue, 20 Oct 2020 10:14:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id i10sm4474948wrq.27.2020.10.20.10.14.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 10:14:22 -0700 (PDT)
Subject: Re: [PATCH 0/1] Do not stop guest when panic event is received
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
References: <1601606494-1154-1-git-send-email-alejandro.j.jimenez@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74a8c57d-4f2d-64cd-f2d2-32dc88b64f9b@redhat.com>
Date: Tue, 20 Oct 2020 19:14:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1601606494-1154-1-git-send-email-alejandro.j.jimenez@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 04:41, Alejandro Jimenez wrote:
> The fact that the behavior of hv-crash is also affected is why I chose to implement this change as an independent
> option, as opposed to making it a property of the pvpanic device (e.g. -device pvpanic,no-panicstop).
> 
> Please let me know if you have any comments or suggestions.

Hi Alejandro, sorry for the delayed response.

The concept is fine, and I agree this should not be a device property.

On the other hand, we already have many similar options: -no-reboot,
-no-shutdown, -watchdog-action and now --no-panicstop.

I think it's time to group them into a single option:

* -action reboot=pause|shutdown|none
* -action shutdown=pause|poweroff|none
* -action panic=pause|shutdown|none
* -action watchdog=reset|shutdown|poweroff|pause|debug|none|inject-nmi

where the existing options would translate to the new option, like:

* -no-reboot "-action reboot=shutdown"
* -no-shutdown "-action shutdown=pause"

The implementation should be relatively easy too; there's already an
enum WatchdogAction (that can be renamed to e.g. RunstateAction) and a
parsing function select_watchdog_action that can be changed to just
return the RunstateAction.

Would you like to take a look at this?

Thanks,

Paolo


