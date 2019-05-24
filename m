Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECE8C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551B720675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551B720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58632 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUF4E-0001Da-HF
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:37:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUF1T-000712-QF
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUF1R-0006Ka-D1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:34:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hUF1P-0006DJ-QI
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:34:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id e2so2175659wrv.6
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 11:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Xpixv2AXYzqgNNAYGB0WmdPhwIwdheNSkozH8K5Er8Q=;
	b=eTbl66p0fhpk0Krx5pZJiv5MT6b/3Knbamz3atkOGwt2ey8EmZFVdtfydE5JeZpvr5
	TNttCFO5oiWr1P9z3xnYHEXUDj39Pg/SwUyZSdf/jsWkaIzglJvBHjY5jaD/Jze/8GvY
	FQbBEhSJtzIghSxv1DwW9/yEvHSlK525TCP5YqTxT7A7cVeWBai3uhBlEuwyFvffucS1
	XyOXAifskLhLvdDmZ/xXusidFQNiMx/JBN9Vch3dz/S+vxP8TG1GZZGgoSqR+qQIvah7
	mb2n4+YKu/9OIc6Aqx0ot2/Xrg9KFHNvl9BLBePFHuO5OQTYBM652BbMqPAjchteWP8x
	pniA==
X-Gm-Message-State: APjAAAUy0dkrurXIMozC+CfW3QZrJorMq4Qg7SoFWcDPVc9HTv8ZHPoE
	Uq4Uveaxb95XN8Fi1Yk2eAdkOQ==
X-Google-Smtp-Source: APXvYqxy3uLG54ooPmRIo9PksCYyGuI/xWYsx436yctkTuyuqdI0DGAVdlRxkDKIlafMNyEPFA8mJw==
X-Received: by 2002:adf:e344:: with SMTP id n4mr12317569wrj.192.1558722864634; 
	Fri, 24 May 2019 11:34:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4d53:18d:3ffd:370?
	([2001:b07:6468:f312:4d53:18d:3ffd:370])
	by smtp.gmail.com with ESMTPSA id x1sm5101251wrp.35.2019.05.24.11.34.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 11:34:23 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
	<e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
	<87pnobrg37.fsf@dusky.pond.sub.org>
	<CAFEAcA8db=UsyU_kRBoatFT2ULQBqL318xRhg+CV4D_7hV76Og@mail.gmail.com>
	<7e468375-ca5f-0048-789e-c41d09065eeb@redhat.com>
	<20190521203712.GO10764@habkost.net>
	<dff30917-557a-cf41-e82e-03465d0209aa@redhat.com>
	<8a936e5b-9e27-b1a2-dc3c-fa0190d54923@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1351764e-ee0f-c863-de38-010314ca7003@redhat.com>
Date: Fri, 24 May 2019 20:34:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8a936e5b-9e27-b1a2-dc3c-fa0190d54923@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/05/19 14:20, John Snow wrote:
> OK, if that's where we're at! I just saw the RFC from Peter Maydell and
> assumed we were a little further along the decision making process, but
> maybe not. I'll stay tuned.

For the decision making, yes; I think there's consensus to use
kerneldoc.  For the "debugging and seeing if anything has changed in 2.5
years", no.

Testing the patch that Eduardo posted will help Gabriel, Eduardo and
everyone else decide whether to patch kerneldoc or rather change the API
doc comments style.  (Personally I am in favor of patching; the
different coding conventions make using vanilla kerneldoc awkward, and
there are several thousands of lines of existing doc comments which
would require a transition.)

Paolo

