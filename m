Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF7E21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkU9y8as"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF7E21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSwko-0000q7-IR
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwjo-0000Hk-0r; Thu, 15 Oct 2020 02:27:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwjm-00037f-FE; Thu, 15 Oct 2020 02:27:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id b127so2147742wmb.3;
 Wed, 14 Oct 2020 23:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Vdg3bUTto/sjo1eiIJ296BUUoKBb4dl3GcuqrIGJN6w=;
 b=CkU9y8asWiaZn6Pewz2lZLGsDKUgyf3PiJ/TaOUVP2BSfxTba1tj9Wf6yAOeUjFfS0
 q0cO/1SBscr3t2jKDYj7rvp8jDE5fIQneLwNXoEeGMY3pBmqPUaOQHvFsfLJSfVTieCd
 9GilUDxv0ZGac4JcQPI93yEXb4Ujn6xfFfbsWuKRaGl6H+ygBkhtyg5Mutwq5ahpSG5P
 Zn3Uyxx5MzyRt7wnmoOOj2dL0lUTX2VYtb1IwDqRU6mYbIdtJSa8xQAyO+rly4y6gw6D
 88e6HeDOCKxyHb/cvuJSRnEUqtqAyc/bmCpJITBfZAX5IF+w+dLBC2AWHM+XbJoryVtG
 8yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vdg3bUTto/sjo1eiIJ296BUUoKBb4dl3GcuqrIGJN6w=;
 b=P97c93Nnsc5+IopvVmGpm7ODUi2mkkCuyeW6GamHHsDm0JPkcbBSvpJ+ef0epV5IYa
 cV5Z+hO0pmBiHfzzPRKV1BGAYWEAPwPYcckfMSPNchp6jj1pyxinuez/ba17CmZmn8iO
 gPLpYut72WlEunOmhI0Rgmoou/eppuD3yxqIruDgfZHZ0ZqOsaYXpRnIMCkBWRxc9PMl
 ufG2WN4Th6dZjifETBXWbbvtsdZU2Vo5nO4UNGHVyqxmX/n3Rcdahh6LOxGrwJ5QcapT
 SEh7RgR9B8wH4838j3yPcHmMcR6sUZFakk7ugm15MAiXNQzao6NzKCHI5MYqIavvxxp2
 yhww==
X-Gm-Message-State: AOAM530ymO4sNO4jHYYZvwqo82AeArDCgd3JKxY0bhnlEuHcCLA7eaEM
 6IBNkbnWYZZf/ZidRYMfM2o=
X-Google-Smtp-Source: ABdhPJyCXD4iKdq+3XOfbBAx/1sdckKdRifRKgL0LUDWjknq6DK+mDk3SIEVFJRvcVv2IALkvEi7Xw==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr2316157wme.116.1602743260643; 
 Wed, 14 Oct 2020 23:27:40 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2803995wme.38.2020.10.14.23.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 23:27:39 -0700 (PDT)
Subject: Re: [RFC PATCH 3/6] hw/sd/sdcard: Do not use legal address '0' for
 INVALID_ADDRESS
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200918174117.180057-1-f4bug@amsat.org>
 <20200918174117.180057-4-f4bug@amsat.org> <874knra5fk.fsf@dusky.pond.sub.org>
 <6384105c-65ca-60f8-4fa0-afd2e46b144a@redhat.com>
 <87pn6f48xx.fsf@dusky.pond.sub.org> <20200921122400.GI3221@work-vm>
 <e88a8f34-ec08-f6b1-05b6-d91c447ee1ed@redhat.com>
 <87363byxp0.fsf@dusky.pond.sub.org>
 <CABgObfbVsN-eh0eb3QUuk1qQ2mU92y80EjP-PVi-oV=mz0UAnw@mail.gmail.com>
 <87ft79lvf0.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <16160828-afda-0cd2-5e00-5c2d840815d6@amsat.org>
Date: Thu, 15 Oct 2020 08:27:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87ft79lvf0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Kevin O'Connor <kevin@koconnor.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 4:48 PM, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> I think we can just bite the bullet and bump the version number. Just like
>> not all boards are created equal in terms of migration compatibility,
>> neither are all devices.

Great. I'll add that to the commit description.

>>
>> Unfortunately pflash is among those that need some care, but we have much
>> more leeway with sdhci-pci.
> 
> No objection.
> 


