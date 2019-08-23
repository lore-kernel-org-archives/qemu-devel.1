Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583C621897
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583C621897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18Pa-0002M1-KN
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i18Oe-0001rh-UN
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i18Od-00069p-Sz
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37687)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i18Od-00069C-NL
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:10:23 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B6FCD81DE7
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 12:10:22 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id o13so4703427wrx.20
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IwmrwqWT+fwPBAmTmy9X1J7mh+AkX++46Vilf9Re3Eo=;
 b=qz38CVui39qo7xk6/6weEoUO262ulnOdNTZwQE0D/3zCWF1gIegRM19aC0ptZwj8J2
 cwQUvT9EhV+fzgkliYKSXNoJmvRFfDhFQZpUhbMMaQerwQmbIKOw/9LblAVp/SWFjkUl
 yc586eEg9GE2qRgCxWiDXZQ2VIgLEUwUH7YrE+YZjFqNdlC5qTfiSothOeahud/pnJQS
 6/IH8+QbYHUqE063Thd4TZBhAzNVFJGzExEdX47nLx4fa3TlMDh9ZUg8KkEVHl/YkdTl
 ghxZDHCwpTMdHm2vteUv8hilizGHPAx5RgtDjPKkCbpnq6hHrXbemKtXurJrlDGjGEht
 N7BQ==
X-Gm-Message-State: APjAAAVMM9ULuuv4GDWm/UWaPlyNy315B+i8lxRWEPITV9Su24yPbuAB
 Q3F6SjkInAlgoktovjmFmHrecAL+HaNGJ5YU6fk1SYQU5tw5ElLgEdxxvwg5EIhGlinc8o8/Vwb
 yWmZQU85yh2ZMFe8=
X-Received: by 2002:adf:fac1:: with SMTP id a1mr5083733wrs.56.1566562221434;
 Fri, 23 Aug 2019 05:10:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQCFw4dte1Y5M8B+FCbLR/JzN/LgqeR3nJhSxMWDpCAhGgULCPJ/y7ZC+vzK+JD3ch+CzCaQ==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr5083694wrs.56.1566562221181;
 Fri, 23 Aug 2019 05:10:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4566:f1b0:32e7:463f?
 ([2001:b07:6468:f312:4566:f1b0:32e7:463f])
 by smtp.gmail.com with ESMTPSA id s192sm2300458wme.17.2019.08.23.05.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2019 05:10:20 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
 <9492af41-2125-9543-203a-312f0cd9087c@redhat.com>
 <CAFEAcA__BNnW4oSyv4iTAd7rsMUfcjyNJgk0nOwbkRQtmLj9jQ@mail.gmail.com>
 <dd473e9b-716d-cd9f-47bd-433d2b17687d@redhat.com>
 <CAFEAcA81qUSMqpMTCrs9-vgj7Wmji2dCDkYrQ91wxmhTiP83Xw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dd60f779-8349-1d0d-eb86-645e2e1b0808@redhat.com>
Date: Fri, 23 Aug 2019 14:10:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81qUSMqpMTCrs9-vgj7Wmji2dCDkYrQ91wxmhTiP83Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] modules-test: fix const cast
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/08/19 14:07, Peter Maydell wrote:
>> Are you going to apply this and "[PATCH] modules-test: ui-spice-app is
>> not built as module" to qemu.git directly?
> Is the other one also needed as a build fix ?

Yes, otherwise the test fails (it didn't fail in the meson tree).

> I was planning to apply this one directly, yes, but I was
> waiting to see if you and Thomas wanted to agree any change
> to the commit message.

Just "Fix build failure with --enable-modules" would be as verbose as it
needs to be, I guess.

Paolo

