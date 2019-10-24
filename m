Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C44CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5D120856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5D120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZqX-0006Xr-Oz
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iNZEX-0005qy-9g
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iNZEW-000793-2R
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iNZEV-00078q-Pu
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:16:40 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9DD7EC049E10
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:16:38 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id c6so12519014wrp.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 02:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VivKpTHoxE+emTgbme/pZY4V9GTSG6CaUTYBfHgIylg=;
 b=DtwD9zyZopvdHoNoGM+gILrIN+mhHpBblMDFiIVILau24dL+jp1pPle68ASkGIR+W8
 Nt4bBL5myDpfpAytXky+Z+WA0yMM76Epo4HPIb2Zveg21ufoKDxJs90VUWeKwoB+N6f/
 h5qoAII0omQ1Q8TUe8D078+QaSf8OGOY2EGW8+290HBoKualWf7l3ymTs9yiduw0rgoR
 x21i3SX/0SEPKu1obYDPB/ukKepS34LUpyvpowTZiu9iYIjAkhewx0kUDYjMqU6gD1ZL
 iquwjzBS/L/k4hbUwu1/ws2iaBSeaFIJODUcDSCHvCOUcH47vWRH2wFDbmA1EeIZQ7gQ
 dYxA==
X-Gm-Message-State: APjAAAUwX6kQ86tvkIniP7KaqL1ksQEGW1f/AODqf2A77zWUFtAwdRQb
 Kl9XNZb8dVj0vJhJ4oVur49ZXRvQyJVYRXZdYuEULQE6JP9+ckvouimKpDJcnJHava1jhDDHUDJ
 j/xd08tgPnIwMtDs=
X-Received: by 2002:a05:600c:490:: with SMTP id
 d16mr3961865wme.7.1571908597187; 
 Thu, 24 Oct 2019 02:16:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcI6nzDA+E5CnEDSF+vAoKKdQyEGcVKwYEV8gG3tCTapMCBEOTYq9dVWAukcawOimWXVypkQ==
X-Received: by 2002:a05:600c:490:: with SMTP id
 d16mr3961848wme.7.1571908596895; 
 Thu, 24 Oct 2019 02:16:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6887:47f9:72a7:24e6?
 ([2001:b07:6468:f312:6887:47f9:72a7:24e6])
 by smtp.gmail.com with ESMTPSA id v16sm23114590wrt.12.2019.10.24.02.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 02:16:36 -0700 (PDT)
Subject: Re: [PATCH v1 07/19] cirrus.yml: reduce scope of MacOS build
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
 <20191022191704.6134-8-alex.bennee@linaro.org>
 <CAFEAcA9jeb_KBy9jMrFoY9=fp0+7YqNU8WrhRr7zxAk308MFXQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a36f9497-2bed-eb2f-d2ec-8df25de508b0@redhat.com>
Date: Thu, 24 Oct 2019 11:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9jeb_KBy9jMrFoY9=fp0+7YqNU8WrhRr7zxAk308MFXQ@mail.gmail.com>
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/19 11:02, Peter Maydell wrote:
>> --- a/.cirrus.yml
>> +++ b/.cirrus.yml
>> @@ -1,5 +1,6 @@
>>  env:
>>    CIRRUS_CLONE_DEPTH: 1
>> +  MACOS_ARCHES: i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu
> I don't know whether Cirrus is our long-term plan for doing
> CI of OSX (maybe we'll be using Gitlab and some runner on an
> OSX platform??),

My plan was to deploy Patchew on a Macincloud instance.

Paolo

 but as a general point: since OSX is one of
> the non-Linux hosts it's therefore worth making sure our
> compile-coverage is as wide as possible, not narrow. It's
> safe(r) to have narrow coverage of x86-Linux because people
> catch issues with that anyway, but it's exactly the less
> common platforms like OSX, the BSDs, odd architectures that
> we want to be compile/make-check testing as much of our code
> as possible.


