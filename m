Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7F2C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AC920828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AC920828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgyt1-0005w1-9f
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 17:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35823)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgysB-0005Og-Tz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgysA-0001zZ-AE
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:57:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgysA-0001ye-3h
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:57:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so7728250wru.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 14:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3Lfh4MfNjJQzEXCmP3TvmAVukyahCYG4/bp2G0Vfdzg=;
 b=aAQvsoy/oPbzeLYytDbdIswXawUhgpO+R485jH1OLicmtOqfjN7UpxaX7Fir4y88Ck
 vShJ3YRtSqphPyxT4PW9BFwA8dRDPqxiMLPDuqk0TY8mB8xNvXjZHwUugP3Ra3EgTGVP
 topEh3oQZMc0jcYvdbocj3Ia8F3yPg7PwQRrGOHW3phbSkAVbEs4+cpo1nQf5Z6eXhkY
 WSx6NKbhEUd3ymwW4Vy31we8bdZfEusfmNz/vcvOKjAD/N5lFziUwcZvbSOwGXUx+Liw
 ulv5IGnsNcSR7BLQAqbmGvr7RxJ6k4bdAeMuw13ATakGNwiZotbrDm2EL8C2MhzIcpYG
 z7jg==
X-Gm-Message-State: APjAAAWSxa4n+VGmVHXBSUYrK+r94qW4cc/vD2F/vuH+nhTcTV+EqVkl
 zArPJXEeXCfPOdnGhCfiIe4tlRGKGck=
X-Google-Smtp-Source: APXvYqzLBxwV1XX1xpVFSSVsW7sBDQm1Ou4vReYlMkxutB6OJWEzwZJVGGdX7tYTjnarnPq5uce0YA==
X-Received: by 2002:a5d:6ccc:: with SMTP id c12mr9180856wrc.57.1561759052827; 
 Fri, 28 Jun 2019 14:57:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a5c0:d60f:9764:1c58?
 ([2001:b07:6468:f312:a5c0:d60f:9764:1c58])
 by smtp.gmail.com with ESMTPSA id n125sm3877082wmf.6.2019.06.28.14.57.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 14:57:32 -0700 (PDT)
To: Sergio Lopez <slp@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-5-slp@redhat.com> <20190628194703.GH1862@habkost.net>
 <87mui1wfmr.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <73315689-0d33-e3c6-c640-a264d4326f22@redhat.com>
Date: Fri, 28 Jun 2019 23:57:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87mui1wfmr.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/i386: Introduce the microvm machine
 type
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
Cc: rth@twiddle.net, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/06/19 23:42, Sergio Lopez wrote:
> I though it could be a good idea to have versioning already in place, in
> case we need it in the future. But, perhaps we can do a simple machine
> definition and just add versioning when it's really needed?
> 

I think if the use case is really short-lived VMs, versioning is mostly
unnecessary.

Paolo

