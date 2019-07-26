Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8925BC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8CF22C7E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8CF22C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwVM-00008K-Lu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51359)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqwV9-00083h-Fp
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqwV8-0006Kk-GO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:26:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqwV8-0006Bw-AM
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:26:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so37578527wme.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q+oWH/lOElaqbnOZuAMvJ1Z4i+kZvaUG2j2o1tOHmT0=;
 b=mkWlccYLTJOy/OpmeBTfd3dhKkb3zMhuWoycaih8KTCxTlNtRBr0OsZ+VoqCWoVvdB
 gSaRwzbLU6zR9XUJ5i2xBs8zC4qcLE3lv7SN1l3qnicifPIIX5igbTE67S+ksQg1FXgH
 Za3lQcakaHtaosrbbhvTCfHtE0Q9iXgdQo7fLVq8gRHSFs+6iawOegxaJ09vcG/6EbEZ
 oFO25St6OeLq6QTXpY8ysZmCcUqCQ6vHHCHRUI0mj45sPExzWgoBQmSYVqov4xR9LSDT
 Ep5nTKIEpHZyj4PyLmK266cthpiHJoPlrMUDLPZ+6d/pKd8tT8yObYFM3wqN/35hu0l9
 Lbww==
X-Gm-Message-State: APjAAAWFPx4JQZ71zaUrMQV42+xnJPI+wl8wseMhnZzRAynLQgiSNiIC
 INF2awMHDSnUS/5wBSWn8R9pzQ==
X-Google-Smtp-Source: APXvYqw2+hcxm7wpeRltK02IoL3BIPdrJlanITRwYpQ5R38VFkZSIFn3j6NS5d8RddAFEVEzSV+8Bw==
X-Received: by 2002:a1c:ca14:: with SMTP id a20mr42211047wmg.71.1564133215103; 
 Fri, 26 Jul 2019 02:26:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id b15sm67878742wrt.77.2019.07.26.02.26.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 02:26:54 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
 <1564123667210.66446@bt.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3a893408-e864-cb3b-d86c-b6cf7b50cc39@redhat.com>
Date: Fri, 26 Jul 2019 11:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564123667210.66446@bt.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v5 11/15] memory: Single byte swap along
 the I/O path
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 mst@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 laurent@vivier.eu, Alistair.Francis@wdc.com, edgar.iglesias@gmail.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/07/19 08:47, tony.nguyen@bt.com wrote:
> +        op = SIZE_MEMOP(size);
> +        if (need_bswap(big_endian)) {
> +            op ^= MO_BSWAP;
> +        }

And this has the same issue as the first version.  It should be

	op = SIZE_MEMOP(size) | (big_endian ? MO_BE : MO_LE);

and everything should work.  If it doesn't (and indeed it doesn't :)) it
means you have bugs somewhere else.

Paolo

