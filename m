Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14859C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A7D206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7h+Ynh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A7D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslGH-0006Ic-0w
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jslFI-0004RC-4m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:54:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jslFF-0000W3-6x
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594119275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kbb+6XCP4QqXXv2Sm4IrqgHfBggIh46EwYB2OmGndh4=;
 b=J7h+Ynh9vuphtJ3vBFLmU4iMTbxc/2xF4vVn0f6USpKzDTuucAH71fmfj/ibnGBH5EcVTY
 hhWVue2ok2C6KXpeAM8REBP3hk9mL1tIg7zcpBR+P6YY+HvTfGuylGiw1605S0cRBN7nWg
 Su1YW5BrxB1CkxLYvJME5nsCF4iW9VE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-gC64ud2xPV2odD7mKXfWFQ-1; Tue, 07 Jul 2020 06:54:34 -0400
X-MC-Unique: gC64ud2xPV2odD7mKXfWFQ-1
Received: by mail-wm1-f72.google.com with SMTP id q20so42376199wme.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 03:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kbb+6XCP4QqXXv2Sm4IrqgHfBggIh46EwYB2OmGndh4=;
 b=b8HWh9sGGfRzESQyyxzUkNmRGNuqnOE2gZgUnbxCC/fdcSdnOJBO0CGZYHIDl8F0aP
 THHd8C+WaA5dNL+OSFjqywY62O9dIS5uqKedSA39bQWdq0FpYklN0l+T6nUFTsr1w8+f
 gFZxsYrw1jDydGFFIi2Kb4eUhCZnP7X0TMdZRDY/8wBVSvXAk52JGW2G2Bs/o49cE+lJ
 jWMxHosa85i1+3PlCPWC5gC6C4HC7e/WtHdzWGAqgiYyD1Lf7FtN1xFFVg84AdKx8R+e
 vdDyhF3flGIbJwA0ikeit8bI5DI+0Ouna2q6XX02z6uJaRyXVWyHR+uB1lT3YA7K/TPa
 U/sw==
X-Gm-Message-State: AOAM531BMpY29+3sKA9VGXPQIG7c+/y3n5GP7EG/IsYBn31NsiyPAWc9
 ut+8uutb4+Y5tZmrocfT7LM5kLNcAj2Utub4y9EJXWmszzuneFkExjGg4wQGlpjfpRbS6VJy6FW
 dDXA2X2jpZUZFglk=
X-Received: by 2002:a5d:4202:: with SMTP id n2mr51844054wrq.171.1594119272988; 
 Tue, 07 Jul 2020 03:54:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu6t/kieTQ2hhqH1LiyNqTp9hbCrz1nvGufIHprBNguKKUj5PrxiFxMh8mbpN/+nyERMovtw==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr51844043wrq.171.1594119272735; 
 Tue, 07 Jul 2020 03:54:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46?
 ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
 by smtp.gmail.com with ESMTPSA id c11sm479934wmb.45.2020.07.07.03.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 03:54:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
To: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm>
 <20200109080412-mutt-send-email-mst@kernel.org>
 <20200109132242.GF6795@work-vm>
 <3162676e-da40-7a3f-1777-2ed4f3efffe1@redhat.com>
 <87h814r639.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57b450ab-313d-5582-0ba9-43c1de0c9e75@redhat.com>
Date: Tue, 7 Jul 2020 12:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87h814r639.fsf@vitty.brq.redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, jasowang@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/01/20 16:40, Vitaly Kuznetsov wrote:
>>>>> Do we want a new memory_region_init for that or just to be able to add
>>>>> a flag?
>>>>>
>>>> I think a flag API is preferable since this can apply to any kind of
>>>> region. But can go either way, Paolo's the maintainer there.
>>> (Copying Paolo in)
>>> So what exactly does this flag mean; to me it's 'no vhost' - but is it
>>> actually more general?
>> It has two more effects in addition to no vhost:
>>
>> 1) it is skipped when dumping the guest (is this a good or bad idea for
>> SynIC?)
> Imagine we have an not yet consumed message sitting in message page, or
> a signalled event, do I understand correctly that these are going to get
> lost upon migration? This may not work then -- unless we transfer
> in-QEMU synic state somehow separately.

(Thread necromancy).

This is just dumping (and it should probably be extended to core
dumping, i.e. MADV_DONTDUMP).  Migration is controlled separately with
vmstate_register_ram.

Paolo


