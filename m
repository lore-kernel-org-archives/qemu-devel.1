Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A978FC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221AA20702
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk5UdeM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221AA20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYZ8K-0003fM-LO
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYZ79-0003GD-RX
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYZ77-0007cw-MG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604082419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TNVsONCS63Bv18o+iHIVLYpxtU/HscspA/fzt6Hf0Q=;
 b=Lk5UdeM5Dr7FLieJ5Uqs9V+V+sCc5Jf8fGmjZxbtuRdRoFjm5rONuUdFZsSx31dZSxd8E0
 i7wkfiNTt+r5sYqA5TfgVuh6MOeSPlMNTZQgxBF2/VDALRGRTvfWtcYM9RI5Wpa2diDspv
 1B14JEmfrQHEkbeDvKujAa/HinMR4i0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-93IaNfrTMtmJi2GIBnmMkA-1; Fri, 30 Oct 2020 14:26:55 -0400
X-MC-Unique: 93IaNfrTMtmJi2GIBnmMkA-1
Received: by mail-ed1-f72.google.com with SMTP id n16so2980171edw.19
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/TNVsONCS63Bv18o+iHIVLYpxtU/HscspA/fzt6Hf0Q=;
 b=EfWWp4/dgxtJaOIwqpYHP831+xSyrp5W6WwR97MQR6EUdZbTemHIw92sbexh+AwHo0
 jke+AnYAQkikGbAcPLVbICc+jqHuoRgMLJqSnHklJMY/EiT10nvq6RNMShPrvE/KNyzC
 mF8p4dSdPEAmFSeV8M/Q2MRCnK0HJSh7mufCUvokXbQczBNqfLpI0BK2Z35Z9ycs/Rwq
 G9pq0NAB+LN9qLY4ot6OTZZU2t/KjR/vKO+76iXGsbCTDnW8BG+AWTFxp5pvnzvkWji2
 InxuCwsP3W3n2vFpt/Mi751lc5meiIpADKQZ9TnbcUPUA3kEkUkh+FhwU4Zr62tgqXlq
 GqBQ==
X-Gm-Message-State: AOAM531KXfNtQ1ls41xPY3iSBodKkx88x3gt3aEAFrhR+MkC3bVeZBYi
 RmWn/npnNqW2cbCU5tUHDrRELhQxXiPtpKncvBFKkNWT3yO64iwADN+f0zZIQGaC2TBhART9PJ6
 mR+kqLAL6nPdvW34=
X-Received: by 2002:a17:906:3582:: with SMTP id
 o2mr3735764ejb.518.1604082414606; 
 Fri, 30 Oct 2020 11:26:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrWldb6fa9yUPzrlYRqgpkqZapBiTXH19HZgEnuz4ZQWR5xxASGWh7oeaO6DGN+2zRQWCsnw==
X-Received: by 2002:a17:906:3582:: with SMTP id
 o2mr3735746ejb.518.1604082414398; 
 Fri, 30 Oct 2020 11:26:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id g1sm2271474ejz.52.2020.10.30.11.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 11:26:53 -0700 (PDT)
Subject: Re: [PATCH v2 00/19] Mirror map JIT memory for TCG
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201030004921.721096-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb1417e8-7bd2-5304-b168-51708987279f@redhat.com>
Date: Fri, 30 Oct 2020 19:26:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/10/20 01:49, Richard Henderson wrote:
> Fourth, I have renamed the command-line parameter to "split-rwx".

Stupid observation, but wouldn't it be "split-wx"?

Thanks,

Paolo

> I don't think this is perfect, and I'm not even sure if it's better
> than "mirror-jit".  What this has done, though, is left the code
> with inconsistant language -- "mirror" in some places, "split" in
> others.  I'll clean that up once we know decide on naming.


