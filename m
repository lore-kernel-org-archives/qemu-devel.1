Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F175C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3071220674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwelkd6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3071220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiMn-0002CZ-3K
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaiHx-0002Er-Pv; Mon, 18 May 2020 12:06:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaiHw-0004qb-OH; Mon, 18 May 2020 12:06:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so12607794wru.0;
 Mon, 18 May 2020 09:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nc8u+kw9xx6d2Me7r51tf/V+eAZD6omt37yF0+esBOU=;
 b=nwelkd6DaiyrhP+y/Sh3h2z+sz7nNgkPtzL/5ouRJgDmM6W5CLFfkaEOmuqA6ZZVE4
 5QrFSh4APyYT7Uuch6qdKxbz4EQZ9FNJHb5XniqTdO205iIjM6Oj0qAPAWmiBpaS6Ult
 bhbXNFVUxzKpTtys56H9Er9+CwvzhShqqyAD4VT8rcnbgPE9frM7B/fVU5m+QQO4MNTL
 hXb14KTX+pBZ5E0i4uKJFHRmQl14kK6EdEqte9jpFdVaCnFfk8rmONqonPSv9x1WmDH3
 6KxzwuopypOvexNbMclX0fFe1al4plMoHTIjHfc46WRcS28p3OcDMDDnKCbn+nqpoEL9
 LGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nc8u+kw9xx6d2Me7r51tf/V+eAZD6omt37yF0+esBOU=;
 b=VfKXSchNEg78Tbt9NFLfZuMx8J/ZTzU+jRVc73slEUNbRft6vSBwJel2bnzH7BNbdl
 U7upNouIKUwyqJmj4ZL5ooE13ZV+ooZjFgPa+vdH/9vHEm8uejQlip/mVoYrBmKfq3Nk
 b5LKdCbNW8YPjydjdQNgD9zQhN7bL+FQ3tel8rURtMJEXuIiW/sGLFJkFAuvwm0+EeQW
 QF2Pj4VGuHKu/1CXr5kwOn9BoWBIu+iLL67PFKp/Rm8qmP3eNdlu9BeuobfJgjRkRgxp
 E9Yj9D0qrxT8ayNlfBGhje5vBqoi8IIp/VWX/xwT3O7QdzI44ea/nOadEA7VfGuCtgkY
 9DRw==
X-Gm-Message-State: AOAM532UDGGeK66ESox3W/lzM3EDEeeyb1101wxdAqlTI9IKaTucOa24
 pTwpR3Ug+tzYXh+alBk4gio=
X-Google-Smtp-Source: ABdhPJxsOzhpGs/wB9rpTeByAK7JRmjeM1quaMEPq9P38KIonawmz2fBMN+SSOvDQLJ2X7MR+PqsJg==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr20962424wrn.109.1589818006872; 
 Mon, 18 May 2020 09:06:46 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g6sm17164529wrp.75.2020.05.18.09.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:06:46 -0700 (PDT)
Subject: Re: [RFC PATCH v2 6/7] accel/kvm: Let KVM_EXIT_MMIO return error
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200518155308.15851-1-f4bug@amsat.org>
 <20200518155308.15851-7-f4bug@amsat.org>
 <CAFEAcA8tGgyYgHXT5LVGz675JMq6VWR56H++XO5gtTrcaZiDQQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b86345bc-2fd7-12d9-cb58-3ae92a6b5681@amsat.org>
Date: Mon, 18 May 2020 18:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8tGgyYgHXT5LVGz675JMq6VWR56H++XO5gtTrcaZiDQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 6:01 PM, Peter Maydell wrote:
> On Mon, 18 May 2020 at 16:53, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Give the hypervisor a possibility to catch any error
>> occuring during KVM_EXIT_MMIO.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> RFC because maybe we simply want to ignore this error instead
> 
> The "right" answer is that the kernel should enhance the KVM_EXIT_MMIO
> API to allow userspace to say "sorry, you got a bus error on that
> memory access the guest just tried" (which the kernel then has to
> turn into an appropriate guest exception, or ignore, depending on
> what the architecture requires.) You don't want to set ret to
> non-zero here, because that will cause us to VM_STOP, and I
> suspect that x86 at least is relying on the implict RAZ/WI
> behaviour it currently gets.

OK, similar to the worst case I expected here.
Thank you for the clear explanation :)

> 
> thanks
> -- PMM
> 

