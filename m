Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF4DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBFB21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2pWzgYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBFB21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxcR-0000lw-P3
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iNxbR-0007cU-Fh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iNxbO-0006ty-Uu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:17:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iNxbO-0006s6-Rl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572002274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=0wKZblacToH6n1rkuAWNUJHJ5bhnxpoO7+VwXymZSoA=;
 b=N2pWzgYdydSdtdmT/0mgeIHqKxrSXEzxnKiZQLrLTV8U9vW149PVOh4VR1KRk6sUd4krgR
 mPC5/CWcSs2WVxh6pLYhbejI0AsZ9r/NErR8+Y9mhv+H5kHQoAq5zdBgKgoRVFKvc4D1k2
 81ZqM3hXt7V1Zd25Xt97kml4LlE22g0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-W09nDKGpMzCob1mO2f-nuw-1; Fri, 25 Oct 2019 07:17:52 -0400
Received: by mail-wr1-f69.google.com with SMTP id f4so895538wrj.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oEckf66nvmRsAgv7lv1oiSBH8FYpgYbxlTP9pYND2uQ=;
 b=rz5c3sgJcX9+yi/eIoOO2LPv4HF0JYS68/lYY9KKzSB3TvaU4lJWn15zRl0dOwKAOW
 jrat7YNMLkT9t2kqtGvpb15Klb9D0sE0eaDGw3FZcaacOu8Lq7SLogNUXWxvi4MmsgUh
 uq29mgXlDErFaKZgijL0CDutHTpvpZ2cydfyFF91Apw/W9L8XeVUTXde+qTWQIkeRNoh
 TQVRo54M+ptvp6DPwUecvWkJ29Qq2kELcHB8Vitjxd6Ye0L0EVUT8JLYMDdTbSwdclw9
 Q3fHdI6WfHue34Wa6L4SvWVkZXj3NryB8gWnxe8R/JfPqp+MUSxI9Aypscdbn8MmNJlQ
 lXzQ==
X-Gm-Message-State: APjAAAXgIVOJbg5rBWnwRYbvZgPWF4+j7GJSwhKUWv/5mosl9/sHozEP
 N/EXh9tubSw6XrcFMOoyPrncJp+aRWxFEShku+uwQ97bIE0KSWNNollccilR/q5L5p3pAhKfMXT
 vkLqoMj4Sv4ruQiw=
X-Received: by 2002:a5d:404d:: with SMTP id w13mr2617194wrp.185.1572002271043; 
 Fri, 25 Oct 2019 04:17:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqRfNfrTKzCzDTbswkTWr8oUoI4YMUe3ZRUv6uKtDsir/WQ5OBQ6djISDJrL9J+B1tIKME9Q==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr2617174wrp.185.1572002270796; 
 Fri, 25 Oct 2019 04:17:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9c7b:17ec:2a40:d29?
 ([2001:b07:6468:f312:9c7b:17ec:2a40:d29])
 by smtp.gmail.com with ESMTPSA id d199sm2047171wmd.35.2019.10.25.04.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 04:17:49 -0700 (PDT)
Subject: Re: [PULL 00/39] Misc (mostly x86) patches for 2019-10-24
To: Peter Maydell <peter.maydell@linaro.org>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-1gWa8qRK85i+MP-UixiPq7NPHw+8kn6KPq6VQMtRt4g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d599e5c5-0963-bf02-df88-0e01ee739c93@redhat.com>
Date: Fri, 25 Oct 2019 13:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-1gWa8qRK85i+MP-UixiPq7NPHw+8kn6KPq6VQMtRt4g@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: W09nDKGpMzCob1mO2f-nuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/10/19 12:46, Peter Maydell wrote:
>=20
> x86_register_ferr_irq() is defined in target/i386/fpu_helper.c,
> which is only built if CONFIG_TCG, but the callers don't
> seem to be similarly guarded and there's no stub fallback.

Indeed, thanks.  I'll add an "if (tcg_enabled())" since this feature is
not supported by accelerators other than TCG.

Paolo


