Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C043EC433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88ED9206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9qdNVhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88ED9206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Qom-0005nn-Rk
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0QoC-0005MU-PD
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:42:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0QoA-0003Bj-Ts
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595947342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFNqJumkzP4J5RG1BBm7mf9F9wyk4Vpuo8se6fclE+U=;
 b=i9qdNVhzPHze8s0vnbfRKk03jFe92XsdZ+/j2SZMNOeBiU6+M4J/NyW1+uKG1I7FSUNABZ
 ghr2bob8QPuek0/Gl4sKydyDTyNPtyoUZxwroICIxeUUSWlDoOPexm+2IoWNMcNVAH8O1t
 kF2uNKdd6ZwKQmK8Se/6jWIraOntNDw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-bDwEr-veOnSVEPoJ0Szqjw-1; Tue, 28 Jul 2020 10:42:18 -0400
X-MC-Unique: bDwEr-veOnSVEPoJ0Szqjw-1
Received: by mail-wm1-f72.google.com with SMTP id t26so8328598wmn.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HFNqJumkzP4J5RG1BBm7mf9F9wyk4Vpuo8se6fclE+U=;
 b=CA2VAowsW9uswlPgsPn3qIuX0ViGBaDXnBW5MWiS5OJL691hDcvuEqhEUdR2vLakrg
 WGsFTP7bVWxcKbPlX6HvgaTo8tTcIE9FOEjAqa/efL5sGSCTOfTkH86U//1rB8XHqlgJ
 2wIHt0lq8yN7gc4D3Uay8xdjaTLjvaz/pFPGHvNx4/Mbht6JyYL7xlik6K/nNJcQ3/Sj
 0ThaOS6hD1ZrB61HIuMv2t4l7UzQ6LjoVAtwaIR/NXRYNBIKF+GMbt0vS6MOgSGXD0/G
 A4L7uyTgmAiaSQANujzsZc2UFpxgvonTL6fsVBdSdsnUL6DIKC48NL0DJWIBTbbseLGZ
 BFgg==
X-Gm-Message-State: AOAM5334RVHHsMO8saRMvfKFIjCH8YxTD9WWETjmXxZgMs1VhIugaTxP
 DnEl4QJsNXiIrbF5UtO9TaMxINEN3JZkM7BUR+GhAsohnybza0Gid+Bsqrd4Wby6T0lfFVeIAVx
 zdLAVSV0QJh25Wak=
X-Received: by 2002:adf:fb87:: with SMTP id a7mr25230301wrr.390.1595947336718; 
 Tue, 28 Jul 2020 07:42:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxavYZkHDtNyZ7roE9L9IypCr40rlA4II5cZBkyZEW7eKU81B4gtUPAc/cfy68/X7/zWFmaeg==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr25230278wrr.390.1595947336420; 
 Tue, 28 Jul 2020 07:42:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:80b0:f446:bb61:1dbb?
 ([2001:b07:6468:f312:80b0:f446:bb61:1dbb])
 by smtp.gmail.com with ESMTPSA id m8sm17749385wro.75.2020.07.28.07.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 07:42:15 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] qemu-timer: gracefully handle the end of time
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200728141005.28664-1-alex.bennee@linaro.org>
 <20200728141005.28664-2-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f48c70d8-b506-e86c-e0dd-9e0ed2db3d91@redhat.com>
Date: Tue, 28 Jul 2020 16:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728141005.28664-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pavel.dovgaluk@ispras.ru, boost.lists@gmail.com, victor.clement@openwide.fr,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/07/20 16:10, Alex Bennée wrote:
> +    /*
> +     * Check to see if we have run out of time. Most of our time
> +     * sources are nanoseconds since epoch (some time around the fall
> +     * of Babylon 5, the start of the Enterprises five year mission
> +     * and just before the arrival of the great evil ~ 2262CE).
> +     * Although icount based time is ns since the start of emulation
> +     * it is able to skip forward if the device is sleeping (think IoT
> +     * device with a very long heartbeat). Either way we don't really
> +     * handle running out of time so lets catch it and report it here.
> +     */
> +    if (current_time == INT64_MAX) {
> +        qemu_handle_outa_time();
> +        goto out;
> +    }
> +

Doing this here is a bit dangerous, I'd rather do nothing here and
detect the situation in cpus.c where we can do
qemu_system_shutdown_request() (and also do nothing).

Paolo


