Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B3EC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A318420775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7t75x5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A318420775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrSp-0007L4-8R
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDrRn-0005yF-JZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:46:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43769
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDrRl-0003xG-Ep
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599148004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1S+XaYiGMfZXAU02nc9w2sHqX0Hp81Q2rW3eK4E5PM=;
 b=g7t75x5TR2aApCuGqt+tSPHBNTzM49CVCZKTjXTsMZ80EHmwmemZsTGOMp14x50WqpTTIq
 m21Xq/5ZB4Z/Pt1ltyEIJSuDn3nJvmjBWrAXGM7FmwV9hGHIEg5VSqVVQhXN5b07L/aMvK
 TGapNuN/z21ptV3NoLnwAK45LExG7hM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-x1F96kIPPb26QdAz_O9YdQ-1; Thu, 03 Sep 2020 11:46:43 -0400
X-MC-Unique: x1F96kIPPb26QdAz_O9YdQ-1
Received: by mail-wr1-f69.google.com with SMTP id a10so1205450wrw.22
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 08:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L1S+XaYiGMfZXAU02nc9w2sHqX0Hp81Q2rW3eK4E5PM=;
 b=IT/tU0EYDZOi9E0okVezjrEiOzoorOOuIN5uY9SOVlbUe262Eq/s/KM0+gvBWyO+Fv
 PJW8zWzCQIjbEU0827ZgIz4ncNKYi339Ty+lbwLlqpJ6LvBB9+U7OvCySuAwlC2JkvFm
 Iy5SVhZOoCv7S9DllSBMgykwvhiapCpUKMjuGNLDNL9VTbFkgOnGDNpzF7gywY0HrGJk
 ne/TGxsymMnVFxd3C8yInVZY1q/j71CEo8Om/ABHAfEH2lG2KdNwLvaypKS3heCDace7
 txsJPrhQox3kFoaNAZYK/xyIKu4Xa9FY2XJKjW6ITCqTBLCcSfJr5Fx0/bXnAUNjFvj5
 okuQ==
X-Gm-Message-State: AOAM532Zue+6fyhxK3NtXcYGUmVX1/dybO0JNnFq48IUGKEbwyhLMRmo
 nM5nchwkRNg2E/fPrHZi6IFuYmM0WuwBb2VfT1ED9gGtekATZ0DK3UVus7AWmilp1pkesgs0xdc
 l0ADYLHK6aJMKJyA=
X-Received: by 2002:a5d:4246:: with SMTP id s6mr2876451wrr.414.1599148002060; 
 Thu, 03 Sep 2020 08:46:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyccm/053wDqHQ8LV3GtkBVhdWmhAAyo6l1FqwK2F5tX/fl7EqfBl526vPOb96APSGsnCKeXQ==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr2876437wrr.414.1599148001863; 
 Thu, 03 Sep 2020 08:46:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:197c:daa0:48d1:20b2?
 ([2001:b07:6468:f312:197c:daa0:48d1:20b2])
 by smtp.gmail.com with ESMTPSA id u126sm6565129wmu.9.2020.09.03.08.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 08:46:41 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200903110831.353476-1-philmd@redhat.com>
 <658fdd16-33da-af3a-6d8d-f7ea1253f061@redhat.com>
 <CAFEAcA8aOzq8UQwKiyuvJokBT9ui6JWxzf=T8=r13Vuu6+_kkQ@mail.gmail.com>
 <20200903142410.GX2954729@toto>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d030f14b-5b1d-6028-8fdd-5dbc25abdf74@redhat.com>
Date: Thu, 3 Sep 2020 17:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903142410.GX2954729@toto>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Qemu-block <qemu-block@nongnu.org>, Li Qiang <liq3ea@163.com>,
 "Emilio G . Cota" <cota@braap.org>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>, Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 16:24, Edgar E. Iglesias wrote:
>> [*] I do wonder about hardware-device-passthrough setups; I
>> don't think I would care to pass through an arbitrary device
>> to an untrusted guest...
> Hmm, I guess it would make sense to have a configurable option in KVM
> to isolate passthrough devices so they only can DMA to guest RAM...

Passthrough devices are always protected by the IOMMU, anything else
would be obviously insane^H^H^Hecure. :)

Paolo


