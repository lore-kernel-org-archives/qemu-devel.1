Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C50FC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1624206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDPa2qHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1624206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvod-0005ZG-LZ
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:48:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iUvfx-0005o4-Vs
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iUvfx-0004yt-41
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:39:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iUvfx-0004yl-03
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573663164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=W5ESZVlgXqZhKNf3qEMg2/MVXve5dMtkBXxq9INumG0=;
 b=cDPa2qHVgp4aSovPGfYLq9VuGxB8G7J1tVQt7VVJbjMbuVtxVX5nXRmmp8tongybFEwmW1
 p3nNCotxQdrw/PmjrNEazLjLLbeX87bvG67L+X6UEA4LTciSsvsNBgBB4Mp1QYboY4JvP/
 bpPiUcufGlqtpPTsZW9z6dZ2/LEwHC0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-73Dp8DiIOK2mmV2AOs7CwQ-1; Wed, 13 Nov 2019 11:39:22 -0500
Received: by mail-wr1-f70.google.com with SMTP id k15so1880812wrp.22
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 08:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zvZLv6HTGcAhBqsOGK77xyvCjpQjhuTLJfyhHW5z87U=;
 b=hjtj8rcb80dTJbERzOc/5oy14mBWd9j80XRaaB5aPg/ix+mEii3HSM1Re+2wINECBr
 Uwaha1qf5Ry4QWGaVouy5Lii3KIbzEGQsMy8ACVcvgjVvtjNHm4AnWlhkX1YJUOzfqDj
 6QDqOXIBdOOPKMwVkiSyuHG4la99DYS2QEbhLSpfYmqhPAhWq+lrgUiPcuIAbtKyhFnu
 Ue3wFbd6OoU7SBwVnHtaGb8ZjymdM2EZe+kx1se7lbZqg2P2wM6UIq869wdaXehK0AQH
 aDBYJ/Ynmtlhzzi7V6DpT28nJFToqb2awyLMEJWWXwg6K5KfHDyCMuetjsx3+GLpIFgy
 do4g==
X-Gm-Message-State: APjAAAXlZO/BrGp8/IF4i/jD+3wDYShnsCUSG4nnQifUOELX1tLhYj9Q
 xpdt7y/VD4AzcBrWvNu/gxav0PKaTnLDSuwMsDCHa1w/UOUfCDpgLb9XmfJeRS10C+g28afVmwS
 ra2a3Aq3l+cpz8Ug=
X-Received: by 2002:adf:9e92:: with SMTP id a18mr3634485wrf.34.1573663161677; 
 Wed, 13 Nov 2019 08:39:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHJJlW/GEZxD9JGnpZA/rt2PfjDQKk6D62Qp6nokew3hXIeD1VMGiBBXumIKC+vNxDpjYnag==
X-Received: by 2002:adf:9e92:: with SMTP id a18mr3634466wrf.34.1573663161388; 
 Wed, 13 Nov 2019 08:39:21 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c?
 ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
 by smtp.gmail.com with ESMTPSA id x6sm3677614wrw.34.2019.11.13.08.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 08:39:20 -0800 (PST)
Subject: Re: [PATCH v1 2/5] docs/devel: rename plugins.rst to tcg-plugins.rst
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191113115952.775-1-alex.bennee@linaro.org>
 <20191113115952.775-3-alex.bennee@linaro.org>
 <9fa870a6-afcd-e00e-b9f2-d26d7661a48e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e45cd589-3054-d83c-d1bd-e9f3e1be8025@redhat.com>
Date: Wed, 13 Nov 2019 17:39:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9fa870a6-afcd-e00e-b9f2-d26d7661a48e@redhat.com>
Content-Language: en-US
X-MC-Unique: 73Dp8DiIOK2mmV2AOs7CwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> What about (other patch):
>=20
> =C2=A0 plugins/ -> tcg/plugins/
>=20
>> =C2=A0 F: tests/plugin
>=20
> tests/plugin/ -> tests/tcg/plugins/

tests/tcg is for code that runs on the target in general, but perhaps
tests/tcg-plugins would make sense.

Paolo


