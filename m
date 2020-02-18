Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1332C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD2024649
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvXEqdCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD2024649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j45W6-0002hv-S6
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j45VA-0001Av-Co
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j45V8-0002sr-Jo
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:13:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j45V8-0002ri-5o
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582042412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUcg10FdEyJIOkhd/+uHQ8iOxzxoVvPYFFS92dJuc98=;
 b=OvXEqdCg32rxDChSC7w+zU6gBGb796utAFxhWWzf4bv3TSTM99ZHyRzIqKw1xS+QPrDyD2
 qbZAoMqFrlLIy6vB9qjtRTknlRHDKsL+ih2jaUzf4HqNCwkIxqvruTYldBn28AD9OMyHbb
 Ep+efsCl7tPRxiEDeQ7RpgP1vESdgpE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-Pf4Kw3SROU2UMHlIdD3egw-1; Tue, 18 Feb 2020 11:13:30 -0500
Received: by mail-wm1-f72.google.com with SMTP id o24so274294wmh.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aUcg10FdEyJIOkhd/+uHQ8iOxzxoVvPYFFS92dJuc98=;
 b=O4vM9ChI0OjifF05BPPl8RKg2n1WrVjjei6oxcSpmERRNoHj1Y2t0r9+iM3ndKA9lH
 4HWySy/qJlbZ+cdnltcyUARz6y8mi30e9JhhQdDRKVKUN7edRajboIy2PaZcp36nHx/H
 bhvFgzvDyXheBOTOv5ZYMdyFzmE3wMs51XWa0w+84C6sM7ggPgmtpkmeKX0C/MS6mDnY
 34uHyRdOGYHiogcrwZg/bsuCHxTJ3ZW9scanIa2KwB/qC7NuwPNY0keEMjCIO2NDGKJn
 5F+XWoEwpjrBqEwysXxwvfGw9cg/GvocuAduWcOhO9xtfCuSFyTCNfxGRloWb0ekueCt
 In3w==
X-Gm-Message-State: APjAAAVVG0+n/h9EUdPEYlutJmjJduVIeI6eXoZPts0eJ9NmxU1HETYz
 4T52CTn9YsO4EwV6BjycyL5K9IaBvCfihVbIuvIxLl277GM3CfhEbRwnIlaxrdNIc6TECjeLXO0
 FpeuDDBC8sMhQeOk=
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr28817000wrv.240.1582042409155; 
 Tue, 18 Feb 2020 08:13:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXedi7AlcavweAMf9+HWzGYgsGQvODoyFLpJ3gqcUvGuepwCqYrQV3b+k+aJVwDB3HEPYLpA==
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr28816980wrv.240.1582042408937; 
 Tue, 18 Feb 2020 08:13:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id x6sm6698593wrr.6.2020.02.18.08.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 08:13:28 -0800 (PST)
Subject: Re: [PATCH RFC] target/i386: filter out VMX_PIN_BASED_POSTED_INTR
 when enabling SynIC
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20200218144415.94722-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b4b46c2-e2cf-a3d5-70e4-c8772bf6734f@redhat.com>
Date: Tue, 18 Feb 2020 17:13:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200218144415.94722-1-vkuznets@redhat.com>
Content-Language: en-US
X-MC-Unique: Pf4Kw3SROU2UMHlIdD3egw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Liran Alon <liran.alon@oracle.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/02/20 15:44, Vitaly Kuznetsov wrote:
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> RFC: This is somewhat similar to eVMCS breakage and it is likely possible
> to fix this in KVM. I decided to try QEMU first as this is a single
> control and unlike eVMCS we don't need to keep a list of things to disable.

I think you should disable "virtual-interrupt delivery" instead (which
in turn requires "process posted interrupts" to be zero).  That is the
one that is incompatible with AutoEOI interrupts.

The ugly part about fixing this in QEMU is that in theory it would be
still possible to emulate virtual interrupt delivery and posted
interrupts, because they operate on a completely disjoint APIC
configuration than the host's.  I'm not sure we want to go there though,
so I'm thinking that again a KVM implementation is better.  It
acknowledges that this is just a limitation (workaround for a bug) in KVM.

Paolo


