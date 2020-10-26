Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172EEC56201
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A04241A4
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Feibt3AH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A04241A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX44y-0007Zz-Lh
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX447-0006gk-1u
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX444-0004pO-A4
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603724738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHM4+mmAZtyfq3EjcokjHlHxRtBF+C2s2E+htYNn5EM=;
 b=Feibt3AHLXQ/+1u4023q48G6afVdj1jIXoBCk/BN4JJoT5S1JU6yRz4lcS1PJh2LGrJQj7
 RyM01/1rSXWSRfePDGGCNYkFimDfZN8h6B9ay+TmT27HtHHQcrk2EBcqtrKVzTF9cXFAMX
 qp74dxX3424lk5tZeh9pk0CVSZ0RyNo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-bO9k2ZV3P4udGpA30XGWug-1; Mon, 26 Oct 2020 11:05:37 -0400
X-MC-Unique: bO9k2ZV3P4udGpA30XGWug-1
Received: by mail-wm1-f71.google.com with SMTP id b68so4253955wme.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 08:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EHM4+mmAZtyfq3EjcokjHlHxRtBF+C2s2E+htYNn5EM=;
 b=M5HoQrS/mMiIZ62l3Oudp8EhFv7Ee4+bOF6aOdkoGwtdFuz2eqNV+HsFW4VuLzLMkB
 zy7fB2rv/gOOw2rbKPmXSrqK9Px9IZJkV56KizOkMPQhI8A+A4mVzD4jQPAPHmxjE8ld
 bt8zL9o+sAVMi5DcJF0fr8nPzR8/PoAeRSoD4ILOEbQhxy4f5Q4e2EuwYShITC2wdXAb
 ioFIQ0rIiOj8TbmiGy5jUFz6iYkXs/C5OqsniEqmskgqIVX1gCm+nG/DzxRmywoywwHZ
 w8qMNQMlUB7KhnKK94N+8C1odht+i7jnb2rq6Mn4Onofy1vsSx603attGvk/aRedI2z7
 YjHg==
X-Gm-Message-State: AOAM533drEzg0xHBNBsZb+u7z26wgQktWnevaQ6uLiidT3IoAzRiy/Xi
 ye/MDQfVynFYhdzdxhP8xpDNRdPLqwCPDYTe4wCQdQJrFLa9ZTihybbbQD07UG/HDPBvaRFHFbk
 6T78rzOdhIVoV4E0=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr16511899wmj.146.1603724735256; 
 Mon, 26 Oct 2020 08:05:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu3W9r4Z0ZbwHP0xPa+mZ/DJN4M/TPWndOfCWyZSYkOpngzVf0QiiLHvA3DSvZucK0W8+D9w==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr16511867wmj.146.1603724734977; 
 Mon, 26 Oct 2020 08:05:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id z11sm22198863wrh.70.2020.10.26.08.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 08:05:34 -0700 (PDT)
Subject: Re: [PATCH 02/15] digic: stash firmware into DigicState
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-3-pbonzini@redhat.com>
 <CAFEAcA_VYpdo+KBxTkBfDzoOh7eCUrhFTxeh0VXpMB4Yv89NFA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <418224c9-b690-43ef-4da9-bcea18eb9f55@redhat.com>
Date: Mon, 26 Oct 2020 16:05:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_VYpdo+KBxTkBfDzoOh7eCUrhFTxeh0VXpMB4Yv89NFA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/20 15:44, Peter Maydell wrote:
> Anyway, rather than stashing the firmware filename in the
> DigicState, you could lift the "decide whether to use
> machine->firmware or the def_filename" choice up to
> the callsites in digic4_board_init():
> 
>     if (board->add_rom0) {
>         board->add_rom0(s, DIGIC4_ROM0_BASE,
>                         machine->firmware ?: board->rom0_def_filename);
>     }
> (and similarly for rom1).
> 
> Then you can delete the
>     if (bios_name) {
>         filename = bios_name;
>     } else {
>         filename = def_filename;
>     }
> block from digic_load_rom() and rename the arguments of
> digic_load_rom() and digic4_add_k8p3215uqb_rom() to just
> "filename" rather than "def_filename".
> 
> Doing it that way avoids passing things around that we don't
> need to, and makes it clear in the digic4_board_init() code
> that we're doing something a bit suspect in possibly using
> the machine->firmware file twice -- if we ever need to fix
> that bug then it'll be a simple change to the logic in that
> one function.

Much better indeed, thanks!

Paolo


