Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A9C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD192070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD192070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHs2Y-0004eC-55
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 12:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iHry6-0008SH-CJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iHry5-0000TO-90
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:04:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iHry5-0000Rc-35
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:04:09 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD7BB9B284
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 16:04:07 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k4so9200480wru.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 09:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MdUjv1wz6a+TmCSH/uKuHv7YSpyCcEFbmfP7SGZy2+Y=;
 b=D4/O+ogmmGj3ZcVV+I8dMf2T8qROCRGjz1zwzhRAgPUmO24s1iH1mniCOtzT2CYJho
 Nc7EBIwhuHitBclloneZeBosjbXLUogqQDemTEEoMZmtQ1ZvEeWxuK7i4AxKWy10TyA6
 Hip+KwzT+UQOouFiLrHqVBgPQKJJjXMf8BZSDpbNsojbUeY5Ru3Zpy4xq0W8qhVdGFTq
 BVdKuiujLKbBIchlNwTUu8VALOl7KCJd87HAH2Cb0mxB5fEDcY7rYeZRDrsy1js0AK73
 Zgoz3crUhrmlt9tw3N28Lq22lfmOJntLbm5pOfl/Z57W6EskQeFA+BJA2uLUwDJpaTk+
 Q3aA==
X-Gm-Message-State: APjAAAX8QEQz4bUtCVRWce/j77GCxNtvEnpZVxeJxsUaDdjT223EkgSO
 S+aebXiTlQMTOxAncYXzlm1W24KTplK8U39omm0oJSLzC5UquDqbMgxCR+xz2ANoECfBFInBJUr
 QujbQCRAeARAIue8=
X-Received: by 2002:a1c:f011:: with SMTP id a17mr4299243wmb.18.1570550646428; 
 Tue, 08 Oct 2019 09:04:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwoQctdt9ue/mHNaqI6m6lnzJQNtk0WMvhfpgZmzLGHkFgrHM0ARdvmRR9AQfY6mwUSWLqD7g==
X-Received: by 2002:a1c:f011:: with SMTP id a17mr4299220wmb.18.1570550646133; 
 Tue, 08 Oct 2019 09:04:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b0:55d4:57da:3527?
 ([2001:b07:6468:f312:f4b0:55d4:57da:3527])
 by smtp.gmail.com with ESMTPSA id b5sm3130822wmj.18.2019.10.08.09.04.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 09:04:05 -0700 (PDT)
Subject: Re: [PATCH v2] Makefile: Remove generated files when doing
 'distclean' (and 'clean')
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20191008082815.8267-1-thuth@redhat.com>
 <CAL1e-=gYkhM99Ee0LxZJ5dCjeEdC08G4_Tm3WCZpCSWvJ=b26Q@mail.gmail.com>
 <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
 <CAFEAcA_+V7SNsxPSgsd04s8f7PnP3qdyXMp6NvS2inHjE08pJw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ce8a2b1b-6104-761e-6c67-0467c0e168dd@redhat.com>
Date: Tue, 8 Oct 2019 18:04:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_+V7SNsxPSgsd04s8f7PnP3qdyXMp6NvS2inHjE08pJw@mail.gmail.com>
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/19 14:41, Peter Maydell wrote:
> The autoconf manual suggests some heuristics:
>  - If make built it, and it is commonly something that one would want
>    to rebuild (for instance, a .o file), then mostlyclean should delete it.
>  - Otherwise, if make built it, then clean should delete it.
>  - If configure built it, then distclean should delete it.
>  - If the maintainer built it (for instance, a .info file), then
>    maintainer-clean should delete it. However maintainer-clean should
>    not delete anything that needs to exist in order to run
> './configure && make'.
> 
> Not all of that applies for QEMU, but it seems like a reasonable
> set of ideas.

Right, considering we don't have mostlyclean, it boils down to "if make
built it, then clean should delete it; if configure built it, then
distclean should delete it".

Paolo

