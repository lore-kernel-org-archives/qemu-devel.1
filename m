Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56207C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DF320674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6w6aPdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DF320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4kA-0007So-Ol
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc4jG-0006gw-Fi
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:48:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc4jC-0008QP-TQ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604918930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjIW7SNSQYr8EJyuUd9g1avOYFsF3nB3CS3kzOxLyyk=;
 b=S6w6aPdJoKOyPphg350VgmTdQTj7RQi5Iw7WQwgzc0uDjji807qzcXnE49eXB/UzKn0Pb+
 cHmgfE0+NwZy7m1j/L1nLtFuYHA6uOHhIdQ4yoivRYrUHyORIGSkL6/BdWcb9xtJPsu9ET
 YzA5SKav4uGK9VWaj0S49vRQdpKZbls=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-7dfwd-t8MHeWVbfsxN6VLg-1; Mon, 09 Nov 2020 05:48:45 -0500
X-MC-Unique: 7dfwd-t8MHeWVbfsxN6VLg-1
Received: by mail-ed1-f69.google.com with SMTP id y99so2559164ede.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 02:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xjIW7SNSQYr8EJyuUd9g1avOYFsF3nB3CS3kzOxLyyk=;
 b=W0/L98VhE4WHouspG646qxtPZwNgoROWizB4AMxAWfmO0ERv8UFws5s33pE85peSwc
 ozvxVzuFRD3kEz6ZmJasctIt8nvyhkuu/i/QK+yGqOJpDtfeS7rRJRckaRVd4iO5Rp4N
 JIrbDdSh3y9ItuDpHhiNMUOKZ7cZHxTr49CC51ckEbjql8RkAFAL++aTQXJgay7yz5E0
 t4Cdq3WZPp7rVYrqxkwZLDSvb9w0yUTZlG6EQN1n1cOHRnN55EY+wJGtAgByc2Z2TBBJ
 7HIWetHvyTqySs7YUDM5+v5X8qCYHLstGv349FlmsVwWWklB27hY/JkKVzOVRuPVA5lC
 YSGg==
X-Gm-Message-State: AOAM530IIZHKUyxvDxK90jU7QD22+ZI59wAf8WgzlH6STTIhbLWi8tbY
 5Xu3kai+oouW53dFgCbKIbR1FpyEoynGSpgSOirksSfbHSenBIshVFzk0ogJXsFgSASFY8EMOx8
 S97p9bXWl/c/03Sk=
X-Received: by 2002:aa7:d493:: with SMTP id b19mr14195403edr.279.1604918923958; 
 Mon, 09 Nov 2020 02:48:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGyjQcEQHuJsGmMR3q+M3Aam01DGov0mbzg5FjFye+7zH2MQwsAALof2H5gUNEjktm/dAhgg==
X-Received: by 2002:aa7:d493:: with SMTP id b19mr14195386edr.279.1604918923751; 
 Mon, 09 Nov 2020 02:48:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id j9sm6432834edv.92.2020.11.09.02.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 02:48:43 -0800 (PST)
Subject: Re: [PATCH 1/3] accel: Only include TCG stubs in user-mode only builds
To: Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201109094547.2456385-1-f4bug@amsat.org>
 <20201109094547.2456385-2-f4bug@amsat.org>
 <e9837717-b010-077e-2d68-0f03300793c4@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49ae582b-1b4d-9a0e-118c-fb4bcb714bdd@redhat.com>
Date: Mon, 9 Nov 2020 11:48:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e9837717-b010-077e-2d68-0f03300793c4@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 10:55, Claudio Fontana wrote:
> Ciao Philippe,
> 
> I thought that the pattern used by Paolo was, recurse always, and put
> the check inside the recursed dir meson.build . Paolo did you indeed
> intend meson use this way?

Generally yeah, I preferred to recurse always.  In this specific case, 
however, an even bigger qualm with the patch is that the patch content 
does not match the commit message.

I also don't understand why it's useful, because patch 2 makes 
everything conditional on CONFIG_SOFTMMU.

Paolo


