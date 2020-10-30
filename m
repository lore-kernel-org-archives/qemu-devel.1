Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D738C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C62720A8B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h83/VWsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C62720A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYZ1F-0001Ck-11
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYYzn-00006y-3r
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYYzk-0006Rz-7M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604081961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+otaRU2gP4U02a2ScMfKwqGBsiesPcR+asjYlLJ4hM4=;
 b=h83/VWsWYSceEsXyyGWlE+d1fYQ1HzyqJn9Pph/EvOItkYVI8UUSbYtPzXh/7v6PcJIOJF
 qkqDW9DV5YOInICVtxvVluhalO6Ol7w+8MX9t1D5SHBUswtFqbHtHLiACertwuswWthqUk
 lFb7hqL9FMp/ovrNgLSluomGBMmEco8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-Vu-MywaYP4Wm-ciJgVzzjA-1; Fri, 30 Oct 2020 14:19:17 -0400
X-MC-Unique: Vu-MywaYP4Wm-ciJgVzzjA-1
Received: by mail-ej1-f69.google.com with SMTP id mm21so2730779ejb.18
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+otaRU2gP4U02a2ScMfKwqGBsiesPcR+asjYlLJ4hM4=;
 b=NfpdbDXHNjEeE6hgzYtCm5PGGyrguB0+Bsnhw5q8L6fPKjMtWYMzXQcVGE01lPtHCK
 zh+nuPSkqrRWeAf+MfkL+OC/YpSp9h/weiCR749asH6DHt7aO0Yl8f5x4Q54o6DWsWj7
 JWprrh862rTY5osxmmS6z0BEk7QSEx6HaRtRiC/NwK6s7gTeG1IymS8k3xbG0T8zqgfy
 1tklualPcyWxr/5BwRE/uEuJE6OsrovE2cN15GnmPwhQtQ+TmJZafP/OfGU5d5TNCuzr
 xcg47DRmwKAJZNvriS3c4HXhNlOhuZkshBUWsa8fBV5jHm3CoLSxG+9GIiWMEg7dTM+n
 1RVQ==
X-Gm-Message-State: AOAM5321hIZfBfaBklMzuUb+z8OSRtwd5tPlyxPMztN1AuUVwWqxJjyI
 PSUYplg8YqKtwjJG5HabvaXwAEfKYmCgPC8CUwWXNH4YtJCVfDtxVHQaCuPMMYo09MU8a+fW0f2
 +r9yVllBCy+yNH+M=
X-Received: by 2002:a17:906:8398:: with SMTP id
 p24mr3853240ejx.401.1604081956148; 
 Fri, 30 Oct 2020 11:19:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuNl2PsEyJPWR/2hpGNcs1dyFDqh8Exn4xQgWFXU66BLsqpPiTBqn8HY0hnw7ROBkIJS9mGA==
X-Received: by 2002:a17:906:8398:: with SMTP id
 p24mr3853220ejx.401.1604081955893; 
 Fri, 30 Oct 2020 11:19:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id op24sm3242411ejb.56.2020.10.30.11.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 11:19:15 -0700 (PDT)
Subject: Re: [PATCH v10 10/10] vfio: Don't issue full 2^64 unmap
To: Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-11-jean-philippe@linaro.org>
 <20201008152214.3cb1425b@w520.home>
 <20201030062513-mutt-send-email-mst@kernel.org>
 <20201030112622.0edaa660@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49788b62-ee5d-0b6f-36ff-3c2ba144df39@redhat.com>
Date: Fri, 30 Oct 2020 19:19:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030112622.0edaa660@w520.home>
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, bbhushan2@marvell.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/10/20 18:26, Alex Williamson wrote:
>>  
>>      if (try_unmap) {
>> +        if (llsize == int128_2_64()) {
>> +            /* The unmap ioctl doesn't accept a full 64-bit span. */
>> +            llsize = int128_rshift(llsize, 1);
>> +            ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
>> +            if (ret) {
>> +                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>> +                             "0x%"HWADDR_PRIx") = %d (%m)",
>> +                             container, iova, int128_get64(llsize), ret);
>> +            }
>> +            iova += int128_get64(llsize);
>> +        }
>>          ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
>>          if (ret) {
>>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "  
> We're still susceptible that splitting the range in two could result in
> unmap calls that attempt to bisect a mapping that spans both ranges.
> Both unmap calls would fail in that case.  I think we could solve this
> more completely with a high water marker, but this probably good enough
> for now.
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>  

Could it also be fixed by passing an Int128 to vfio_dma_unmap?

Paolo


