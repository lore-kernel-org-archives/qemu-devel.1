Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF72DC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2007A20674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwkVmJgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2007A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjgv-0003IU-5g
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPjfv-0002qM-Ge
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPjft-0003hP-RB
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601978064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pX9m99dwdoz0rkc+rPW1wPTim3vD1BUP0V/jLp3duy4=;
 b=MwkVmJggnlZw8KveO5i/7JA/+91HNmh61sRi4+Jl3fnuYQGNHJkjnwImUTy5WuyhHSox6s
 WaBv8Qm77+gmpf+wosSPjfD2frV4bTvbZlZadxB46iPaejGydKxLdHCB4qB+ESpjtWHljN
 AH2CnC+zaoM90hJjV6dDdH90YJaljIg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-mLehZftSPuCpsRcg8jeo_g-1; Tue, 06 Oct 2020 05:54:22 -0400
X-MC-Unique: mLehZftSPuCpsRcg8jeo_g-1
Received: by mail-wr1-f71.google.com with SMTP id 47so2869456wrc.19
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 02:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pX9m99dwdoz0rkc+rPW1wPTim3vD1BUP0V/jLp3duy4=;
 b=NxBNdStrLoQayzo4RvYwup12y2d55t0cEsseSC+6xxNBRR5vM1zQRNJ0b5G5e/mSFK
 Db4SD6TwnAnN8ZThnOJnXoNx0+OjW3ePcqTPHebibHzRAKCMX7hUru4fP8gpidqcDQ63
 DiFUUOck8hqP6sLoIpaJXF0h+Y68Wr9Y+/Iq/xiJ35ve0M2u9L2vVCCmAHmFh5rcPyOD
 wExNdR2QLbmqQ6HjhZ2/gOjKuOXy/rfUr3/yQ2K9qDq/d84vCxqKMXsC32+WAlIWQXTB
 bZ+tYu9jVsRVGhtIPj/yPhMve9VckFMNg9+6H/UrJtI0+PYwKk47urhEfK0clvBk0FSI
 gUTA==
X-Gm-Message-State: AOAM5328gMjDwUtaYH5fuSpJEKiE6GzuvkIP5ne+tgkbgnybhiESPwET
 iSmjkhv31Uhg1djeOBZ86U2Jxf4D9TEW1AyDKdo86kvGrw2aoE4DZnd94XVCRK/C3q2w5yv+R9R
 ykO38S35if76jv7M=
X-Received: by 2002:adf:e704:: with SMTP id c4mr2046819wrm.24.1601978061436;
 Tue, 06 Oct 2020 02:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZDeWY7Ssm5/TedVxjBih09duMWJxbiPOUDG5+0YrCDEhoInU6vrb+gYSSrxUkgWxV445dcw==
X-Received: by 2002:adf:e704:: with SMTP id c4mr2046798wrm.24.1601978061229;
 Tue, 06 Oct 2020 02:54:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id f12sm3050265wmf.26.2020.10.06.02.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:54:20 -0700 (PDT)
Subject: Re: [PATCH 1/2] softmmu: move more files to softmmu/
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20201006091922.331832-1-pbonzini@redhat.com>
 <20201006091922.331832-2-pbonzini@redhat.com>
 <27899e4f-a1a0-919b-f0b2-26c73adaa6e@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <679db184-662c-9175-b0f3-e22d26328f59@redhat.com>
Date: Tue, 6 Oct 2020 11:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <27899e4f-a1a0-919b-f0b2-26c73adaa6e@eik.bme.hu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 11:43, BALATON Zoltan wrote:
> 
> The name of this dir may be misleading. I think it originally stood
> for the actual MMU emulation but now it seems everything related to
> system emulation is dumped here. Is it better to keep MMU emulation
> separate and put other files in a "sysemu" dir or rename this dir if
> it keeps mixing MMU emulation and system emulation parts? (I think
> the MMU emulation is a weak part of QEMU regarding performance so it
> would be better to keep that cleanly separated so that it's easier to
> analyse and optimise it in the future, which is more difficult if
> it's mixed with other parts where it's not even clear what
> constitutes the actual MMU emulation. So I vote for keeping it
> separate.)

I agree that softmmu/ should have been called sysemu/.  But I think it's
unnecessary churn to do that now.

Paolo


