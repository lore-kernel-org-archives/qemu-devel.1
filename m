Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52249C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF86C2076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOCy1ga3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF86C2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlj5-0007tY-0N
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHliW-0007Ll-7I
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:28:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59988
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHliU-0000ui-EI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600079289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JzI/xpROZ57LEg7G1CZHucwvqZ5QaQm5gS1jG5l6Rtc=;
 b=gOCy1ga3gN/7fueFA4dD6qPSviSaJwP/hgJhXjVJySW1HrydzEEvdl7hyLL3RTQmGMmqgF
 GRDKhNY4+mTRgcDp+9Y3CgduMdVFthARaN5oy4B2xTnlCZlTGn18uMU7mM8c1r7/v25uyR
 LzTlj7DzEvxVc0QgstiZqT57TgQOECQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-JJoOAgBFNIGZxnp-ywV7lg-1; Mon, 14 Sep 2020 06:28:04 -0400
X-MC-Unique: JJoOAgBFNIGZxnp-ywV7lg-1
Received: by mail-ej1-f71.google.com with SMTP id lx11so7849278ejb.19
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 03:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JzI/xpROZ57LEg7G1CZHucwvqZ5QaQm5gS1jG5l6Rtc=;
 b=Q1YB0dq8fwc5VZOCDqlarwn6WDpIeoDCA8orqmaOdXxnjfAhUcQ7+tQCJV5Wo1+2zm
 b37SGIp6VJXvyzVxNqwLF58qJnq/2bFC/WUziCzwy8M1C8N8/RBl/2eSoYZbkHLfmNog
 oR7QuBK598YaWQPTNESaBzqxQlbhNumTVRpVKBwL6KgSvVBKZS/vPfjI/gsQJvLBiGOh
 baEJBOBUexkBCoQCyFYfdfZTcqm7rEyLrtN+LCd8npA3ZTGLtGqBH4uwDilBTMdhjWE2
 qBZama5g48OD/9NFR/PjUNuf9RrjDz9UjLhdlx7cwM8cPasx+1Pzs74Ph4zrrSvpaB7v
 a7Yg==
X-Gm-Message-State: AOAM532S60ld2Gpu6VxKlIp0JyqlMId82OJUH4/Fe5krGYtXAnVHU7H4
 W2SFvtyMrefqS6+PDFGS4ylC9kHi6oE6GWbXU6hOGBolbOsuiIMxQYwcKiVWAv0DKmLrQCGzLo/
 UQQM8EKvezm+WTlU=
X-Received: by 2002:a17:906:d78d:: with SMTP id
 pj13mr14351246ejb.15.1600079283091; 
 Mon, 14 Sep 2020 03:28:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIBohikMgtRYHHLARLWUk7MIhlylmd5+V6TBYCS4wO0xDHA3uMPCdhEm3xWHCKStAoog9y+Q==
X-Received: by 2002:a17:906:d78d:: with SMTP id
 pj13mr14351234ejb.15.1600079282893; 
 Mon, 14 Sep 2020 03:28:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6047:f58e:7d32:2e02?
 ([2001:b07:6468:f312:6047:f58e:7d32:2e02])
 by smtp.gmail.com with ESMTPSA id l7sm9076022edn.32.2020.09.14.03.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 03:28:02 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200913100534.22084-1-pbonzini@redhat.com>
 <20200914095753.GB579094@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e661b2cf-0721-441c-3ce6-573b3eb7950a@redhat.com>
Date: Mon, 14 Sep 2020 12:27:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914095753.GB579094@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/20 11:57, Stefan Hajnoczi wrote:
> On Sun, Sep 13, 2020 at 12:05:31PM +0200, Paolo Bonzini wrote:
>> - because we parse command-line options before meson is available,
>> the introspection output is stored in the source tree.  The output
>> is slightly modified using the "jq" tool in order to ensure that it's
>> stable and that modifications to meson_buildoptions.txt do not cause
>> horrible conflicts.  This is the main reason for the unattractive
>> diffstat (the number of JSON lines added is higher than the number
>> of configure lines removed, though of course the latter are code
>> that must be maintained manually and the former is not).
> 
> Does this add a build dependency on jq? Is it possible to use a Python
> script or even a command-line one-liner instead?

No, only developers need jq and only if they add configure options.
Using Python would certainly be possible, though probably it wouldn't be
a one-liner as for jq.

Paolo


