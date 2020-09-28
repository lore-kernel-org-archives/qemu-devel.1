Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298DFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D202074A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrJXw1CY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D202074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwNJ-0008Lz-0Q
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 12:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMwLg-0007Lg-9e
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMwLe-0002Y7-MM
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:49:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601311797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WibqonV0YFHeDOMHwEY3hL+NjJgu+fLNGMCXF/aW0w=;
 b=BrJXw1CYNby1GE+tuHJ2tvZXTEwfDd3LcADRdvDWMoFGgPOYzMMqBe6sKIHvvU3sZQj8PQ
 fery3pvsF3CoOjfQNq1y5Ene818bpSiQ6iUo5Cs5LCs4NOT2L9VTzrgKOWmtoq1UZxvkQz
 6oo3PG3TMwYvKc4nPo1hJqXGpAevdeE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-TZ57OTOjOGG4SjNvBBrLSg-1; Mon, 28 Sep 2020 12:49:55 -0400
X-MC-Unique: TZ57OTOjOGG4SjNvBBrLSg-1
Received: by mail-wr1-f69.google.com with SMTP id a10so616050wrw.22
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 09:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/WibqonV0YFHeDOMHwEY3hL+NjJgu+fLNGMCXF/aW0w=;
 b=q4ZkPM7Zn7qW75dO8t3UiArVP/q4aJe4kqjUxJC5+leEwYjDaQoydmm5nSSJrrKwkR
 uUY/UmFEjGIC9qA6+m+275Z9Pxd/F7gyH+plQr4SvlOTVxUIaiO4isBBvDYxHOkkbF+C
 dlxB2e+1rILBk1UNdYg5coCUCm1xwVmYVXTVOKALAggQPTc7ONTyJPrGrYOm8GUQKh/v
 OQALF7o26N9HSx4O8KLCgH9JMLrAm/ykyqTiHYp+br5iW4Mekm0bHHP/Ni0h4Nypn98v
 XwI9LLOAPALTsjiliYZ6jPsgY5/qp9cdV2gxt4RbmlJTtXabC/7qzaZ389zE0WOEHT+d
 pcNw==
X-Gm-Message-State: AOAM533L7JcxGezgZYvQxi8JA2WoewwQOzw6jfub/bkyh/E2is73jodv
 G01+D3ruiYI3SxfeKH6+WxcgC4RXE54V/7c1CP2uTUoteRn/SggCsFP+9T7OL5WJJY1fHRRi7RT
 ZNfWYbS+fyxa9gF0=
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr2530937wrq.381.1601311794791; 
 Mon, 28 Sep 2020 09:49:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFMlS1l/GH2Wom8FR5A3jjB5UVs2stU9v85xw3C71g8BIzUBIipQWQ21I2zopH0FuGpPS2Xw==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr2530915wrq.381.1601311794550; 
 Mon, 28 Sep 2020 09:49:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4f8:dc3e:26e3:38c7?
 ([2001:b07:6468:f312:f4f8:dc3e:26e3:38c7])
 by smtp.gmail.com with ESMTPSA id o4sm2060216wrv.86.2020.09.28.09.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 09:49:53 -0700 (PDT)
Subject: Re: [PATCH 1/3] qemu/compiler: Simplify as all compilers support
 attribute 'gnu_printf'
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200928125859.734287-1-philmd@redhat.com>
 <20200928125859.734287-2-philmd@redhat.com>
 <20200928140448.GH2230076@redhat.com>
 <CAFEAcA9THz32JdqVF8JykQebw=ub50vY1RMNV+zLuzSHmAcP0g@mail.gmail.com>
 <20200928142322.GJ2230076@redhat.com>
 <CAFEAcA8dSc+L5Xv=sV_C-wtpddoYq7dZd2UN_-X6KgunxkZQAQ@mail.gmail.com>
 <20200928143914.GK2230076@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a08d86e3-25ef-1f0f-ee91-651628fbb20b@redhat.com>
Date: Mon, 28 Sep 2020 18:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200928143914.GK2230076@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/09/20 16:39, Daniel P. Berrangé wrote:
> Looks like 2.58.0, which is still a fair bit newer than our 2.48 min.
> 
> NB, only the macro changed - they were using GNU printf impl for many
> many years before that but simply had the wrong macro definition
> 
> We can just sacrifice -Wformat checking for Windows builds when using
> old GLib. People building natively on Windows with MSys probably have
> brand new GLib, and those using Fedora mingw / Debian MXE also have
> pretty new GLib.

In the past we also had different minimal GLib versions for Windows and
POSIX systems.

Paolo


