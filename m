Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD1DC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104EE217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104EE217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPwh-000631-9E
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDPv2-0004Hv-9T
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDPv1-0006Av-Cq
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:18:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDPv1-00069w-6o
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:18:35 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEB5F85540
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:18:33 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id z8so673731wrs.14
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JF9i4LYg17uWM4OsSEKlAKpGc5+pujzd53nms/MZrlA=;
 b=cG6JP48DPwvOgZKg+8cKcd8d1gEzZhScDhf+h0m2NjmhD/OEjyzpBlEmsk9TNpqPWJ
 n94n3HfZWwIZrp+7H69al2LUAIfAa2bbcmPFwNLPfJjEoTXaO2rE8S6Ckmdpv7QYZs8K
 KJxuFWRmVrBBGzMsMHTBWtMighokC95EURqWRPwqIny9WFAlvLWNePo2JosJ89PwIOOs
 zZVWJv2d2JVe5wDtcvfoWnGSXY5j/05XYjv3J/F/vZLTGTXyvUQcSGcMG5YU1choKuNv
 5tbmMIS6V/mg4jUGgdXq+qtfDivO8FYleI9xa0Iy9+/7VbpfiwxLGta4gGLR+8CdetkB
 ecAg==
X-Gm-Message-State: APjAAAWQEGNgjiqk/95YfAJ4J1ImWXmTw1CDZrld3wbB4UbWff/w5uVP
 iNuCq70ykdiZXwmMhv+RXfPDlujkvlWXVEPVRl7iDPmg49B2Z9H5eWmMIPExiLZ0kFSoQFXLN1W
 04pCnpYB9lbQTYEw=
X-Received: by 2002:a7b:ce91:: with SMTP id q17mr2048931wmj.25.1569489512603; 
 Thu, 26 Sep 2019 02:18:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyo/rI7qQQSBj4+fWKVEErAKNi/UCanotxdE6uRt8r6m7IvvqgeI9CJTY5GW9dr+tsjcZrcg==
X-Received: by 2002:a7b:ce91:: with SMTP id q17mr2048913wmj.25.1569489512349; 
 Thu, 26 Sep 2019 02:18:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id b7sm1591003wrj.28.2019.09.26.02.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 02:18:31 -0700 (PDT)
Subject: Re: Questions about the real mode in kvm/qemu
To: Maxim Levitsky <mlevitsk@redhat.com>, Li Qiang <liq3ea@gmail.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
 <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
 <3d3f3a0e6e796260348c66e69e859e1901501ee8.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
Date: Thu, 26 Sep 2019 11:18:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d3f3a0e6e796260348c66e69e859e1901501ee8.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Avi Kivity <avi.kivity@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/09/19 10:59, Maxim Levitsky wrote:
> If you mean to ask if there is a way to let guest access use no
> paging at all, that is access host physical addresses directly, then
> indeed there is no way, since regular non 'unrestricted guest' mode
> required both protected mode and paging, and 'unrestricted guest'
> requires EPT. Academically speaking it is of course possible to
> create paging tables that are 1:1...

Not so academically, it's exactly what KVM does.  However, indeed it
would also be possible to switch out of EPT mode when CR0.PG=0.  I'm not
sure why it was done this way, maybe when the code was written it was
simpler to use the identity map.

Let's see if Avi is listening... :)

Paolo

