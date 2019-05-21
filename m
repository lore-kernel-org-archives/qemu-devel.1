Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFECC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622792081C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622792081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51484 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2c6-0002Ei-Ed
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:07:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT2Qz-0001aq-JA
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT2Qy-000666-N2
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:55:53 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hT2Qy-0005wm-HN
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:55:52 -0400
Received: by mail-wr1-f44.google.com with SMTP id s17so18077878wru.3
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=BFI4fVR7q1UVGYZox0NGxV0eb+6lCiDzgo9F8ljSESM=;
	b=snVV7Z9RG4IeKKcFDMO93646wNs9w+AY5nt22fTyrNuKnQtRhyi9Zw4ohcjLKTZedV
	bW1Vq1vb8DhcXM4JJ0RgJAHwPNy5gVd+YvP7o5GBcKK0XRm+9Ozit6AdP90wHtZkO2na
	M+LJ6sOTneouRtN41ze04AssXF66jWYYJ9evPpSiGBPGCe5DYBfExvFXq25EXOtCfqJ+
	pERVKf3LSw2nleSWiCA6YqYzVJ24zKvILnXY2yH2FYkBz/VER4IedWk5UCX5NT3cv7sp
	NK06zkq724oILK8FMR0kKvTNMryfpWnuPFP4fw3AVJEFJdb++Gs+y7cGm9V+zYtvUbHn
	Smsg==
X-Gm-Message-State: APjAAAXAZSPGLWwCfCNkvXebocoDyVM5h/ZFXT4zHgd40ExdwxbOWeSt
	wDJj2dIhUMt23DYYicAvdvqP4w==
X-Google-Smtp-Source: APXvYqya6fCoHBiRYiVcU0sYAHuOQ13ygmgnhXDB1hJLck+abOmXVHSUiz4scb9i+CLa5d6qfnaysA==
X-Received: by 2002:a05:6000:1201:: with SMTP id
	e1mr48184075wrx.136.1558436140078; 
	Tue, 21 May 2019 03:55:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id
	w185sm2620930wma.39.2019.05.21.03.55.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 03:55:39 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
Date: Tue, 21 May 2019 12:55:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521085350.GF25835@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.44
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
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/19 10:53, Daniel P. Berrangé wrote:
> Hawkmoth seems pretty attractive in its output format, but doesn't appear
> to be part of either Debian or Fedora distros, so we would have to bundle
> it in QEMU I expect.  My big concern there is that there have only been
> 2 contributors to Hawkmoth in its entire 3 year existance, which makes
> me fear for its long term viability if the main author gives up.

On the plus side, I think the main author is among the people that
pushed rST and Sphinx in the kernel, so it's plausible that in the
future the kernel will pick Hawkmoth.  I agree that we should check with
him about his plans.

> QEMU should pick a tool which is well established / widely used & thus
> stands a good chance of being maintained for the long term, as we don't
> want to end up relying on abandonware in 5 years time.  The kernel-doc
> project is not widely used, but its main user is significant enough that
> it isn't likely to die through lack of maintainers.

A couple years ago I didn't have problems modifying kerneldoc for QEMU's
syntax, it was a 10 lines patch.  Unfortunately I cannot find it anymore.

Paolo

