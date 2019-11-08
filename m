Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F22C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8AF1214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AF1214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0cr-0000Gc-R8
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iT0aN-00074d-Jg
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iT0aM-0005dK-IM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:29:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iT0aM-0005cj-Ch
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:29:42 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44455C057F31
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 09:29:41 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id u2so2868146wrm.7
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 01:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dQN2vNzmS0M0w3q0mOiGj2oYcHSHlWjz4/wY/RFn8Dc=;
 b=LnE40tQuhDMM279sO2l/SyUaMgCv/SB9MpAxcsfGQ8gSoxQkodq63PxzADpkEebs1b
 LEKbKQZhjxXhVmuBFZsIE5cjH6XV8EmwsRcxn+QuWPQpPopGAxzJ7/rsue1ED5KKsaFE
 nltrbrzGdPkO9wf8hPPdIi9piU8pgiVKEjPu1rfpF3TZZK/6+n9KS50tjHjxFbrOcs2d
 h8BH8Wx7h3IwHWMaXhu0P674D/rtYD+Nmg39UFI+gsQzp/+kEmb0wkVXJnqbb7fewsLh
 53VN1+GnXoB+Eer3P9ECJw2ynfeeokz0ut9CHKiiP/rMs0MXJzGpJuqXwRGgc1rWoY+u
 wgsw==
X-Gm-Message-State: APjAAAUiKktHNYeM7pSbIXUCtGxcenaP67v8T3cA4Mkjqxa4WHsaSA8o
 irxr3EHp8utNzPxnJG97ggM7ONXRsfFapNGZSr0OYtaM6bXLloglb4oyBrAMP6Axpd3GOixauru
 2+CfqAI0WaKc96bA=
X-Received: by 2002:adf:db41:: with SMTP id f1mr7025810wrj.351.1573205379903; 
 Fri, 08 Nov 2019 01:29:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwfczljF4ZPaRlnWoHuHjLFXlM/NZeeuZfaBOMvw/Zk2O0d9iKlNNdSMRgooMqLxwAiSr73g==
X-Received: by 2002:adf:db41:: with SMTP id f1mr7025784wrj.351.1573205379601; 
 Fri, 08 Nov 2019 01:29:39 -0800 (PST)
Received: from [192.168.42.35] (mob-109-112-129-250.net.vodafone.it.
 [109.112.129.250])
 by smtp.gmail.com with ESMTPSA id p10sm6359577wmi.44.2019.11.08.01.29.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 01:29:39 -0800 (PST)
Subject: Re: QEMU HTML documentation now on qemu.org
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191106161928.GA353373@stefanha-x1.localdomain>
 <20191107100606.GA120292@redhat.com>
 <CAJSP0QX6awKBSx_idYfXB85e09Tp6gKLRvO+zrk-+zrOiySC-w@mail.gmail.com>
 <20191107160142.GH120292@redhat.com>
 <20191108084130.GA375005@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7361f6d8-e60c-e8ba-cb4c-9b4ec89e3c16@redhat.com>
Date: Fri, 8 Nov 2019 10:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191108084130.GA375005@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/19 09:41, Stefan Hajnoczi wrote:
>> If we're not storing the generated docs in git, then when
>> pushing to qemu-web.git we need to ensure we preserve the
>> extra /docs dir content in some manner.
> For qemu.git/master the built docs might change every day.  Committing
> them to qemu-web.git seems like overkill.  I'll send a documentation.md
> patch for qemu-web.git instead that simply links to
> wiki.qemu.org/docs/.

I think this is a good first step.  Perhaps in the long term we want to
have docs.qemu.org/latest/ link to the latest release,
docs.qemu.org/unstable/ rebuilt from master, etc.

Paolo

