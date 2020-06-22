Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B29C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6242068F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Doz+kke4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6242068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMPi-0005OM-VM
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnMOv-0004g1-2e
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:22:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnMOs-0002CQ-KV
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592832133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlIATJVdzbCRm7cOXhINUcDChuz0LbUkILhnecVURQI=;
 b=Doz+kke46bCXzwLye87sasTKNeCYcnlUul9m/TC9ohvc1EEoAxnRTizakIueItYVpRazDm
 Yp6tWBEg7be5w0RWn5uzJDF1zrRK8eZ4LUelLSjKsUgbra0e8iXAnrlmQlpr7e+yA4Iiy1
 /5uVND62dPD1/YiOCVYcaiOmAMOxaAA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-_8PquIt7McibbRjGZ7aUSw-1; Mon, 22 Jun 2020 09:22:08 -0400
X-MC-Unique: _8PquIt7McibbRjGZ7aUSw-1
Received: by mail-wr1-f70.google.com with SMTP id o25so8955847wro.16
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 06:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NlIATJVdzbCRm7cOXhINUcDChuz0LbUkILhnecVURQI=;
 b=kgeOM7TrtMgBJtQdmy0Shq3U7sSZxyt3VCAQXu1cdUZiL5ShZjZhB5zhMnEo0aWbwv
 Z+oEpiEijoURe5tm/VVeczxFd2Uf08eIl1vDmcz+YSczHFQHY/sd8rKuIOTrgtc+QRFB
 l5sEoY3kDt6QA0L7WBWArTQyJr6wcCrjJnpQ3C2hDObCMWmasp35ZJf0fVDfKJ1DiZA5
 AJJMXBCM4Lq66dc41ZSrCXVdIK1lnOpm56rKEwQ/Dekgwu9P8Nwls/HG/sE4rdFdS1GC
 v3v1GUuzjW0KQ54rFtCZULnhrpzWF8u9rHyJyoUhM8T6I4G2sjwarxqmeOK+vy61Eii/
 MQ+g==
X-Gm-Message-State: AOAM530lvOY1b2xcy+tKhD3Z9/cvCAHrl8bPdrdVL8qA3k/Y2vqWJmkb
 SQs5JG4jgPxhYWYrou6dauOq8kZYJ40TJ7fR6s2hQOH9wjo6vDK9fj/n2ZnSrjRo7lql5iB4foq
 NkdJsWcwZN1HOL40=
X-Received: by 2002:a5d:6150:: with SMTP id y16mr20418968wrt.219.1592832127668; 
 Mon, 22 Jun 2020 06:22:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG6TOJh0wDpxo7kY5iKXK835Y1V2jcLc6Flef4gNf93COl+Ti98ROjv8KsJdlxY+gJJa/XuA==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr20418936wrt.219.1592832127467; 
 Mon, 22 Jun 2020 06:22:07 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id n19sm16286285wmi.33.2020.06.22.06.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 06:22:07 -0700 (PDT)
Subject: Re: [PATCH v3 11/19] audio: deprecate -soundhw pcspk
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
References: <20200622112914.30454-1-kraxel@redhat.com>
 <20200622112914.30454-12-kraxel@redhat.com>
 <47fe0fd8-ab19-b35d-0808-d9a83201c530@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4df07eb8-0352-3976-67a2-d49a4fb482da@redhat.com>
Date: Mon, 22 Jun 2020 15:22:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <47fe0fd8-ab19-b35d-0808-d9a83201c530@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/06/20 14:59, Thomas Huth wrote:
>> +static int pcspk_audio_init_soundhw(ISABus *bus)
>> +{
>> +    PCSpkState *s = pcspk_state;
>> +
>> +    warn_report("'-soundhw pcspk' is deprecated, "
>> +                "please set a backend using '-global isa-pcspk.audiodev=<name>' instead");
>> +    return pcspk_audio_init(s);
>> +}
> While "-soundhw pcspk" is quite easy to use for the average user, I
> think the "-global" options will be quite hard to figure out, especially
> once this deprecation message got removed again when -soundhw has been
> deleted. Could you maybe add a description how to configure the
> pc-speaker to docs/system/target-i386-desc.rst.inc, too?

-nic is an example of how a single option can work great for both
built-in and custom devices, and perhaps we could design something like
that for audio.  For example you could have

	# configure a builtin or default audio device
	# and an ALSA audiodev
	-sound alsa

	# configure an external audio device and a PA audiodev
	# options other than "model" go to audiodev
	-sound pa,model=sb16,fixed-settings=off

For more information: https://www.qemu.org/2018/05/31/nic-parameter/

I think we can go ahead with the deprecation, but -global and -device
are probably not good enough a replacement for actual removal.

Paolo


