Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF9325355
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMdard1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF9325355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSO43-0001Ju-LR
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSO3H-0000P4-Oj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSO3E-0001bw-Ke
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602609926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbWcn9OeBj8yeziF3lwXdH+BSdG0hLsOEHC5Ins7Mws=;
 b=iMdard1vIyZy8BNARPkyIFHlK7fJIIDes87p59FYL7hQQ22xdelM5MZS7JnRinuxcWC2PR
 EvzmTO+5ZF5PKE4hXA3o4IJvn6PP5sPsOl5vo3A13EKXP8HOGoBTZKcdr8WdpGAKsi003C
 nQZw3fQ/NMDAWnzeSX3yg2m0JaUbjTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-7-zyjwI2PGqR2ZDJXzu0eQ-1; Tue, 13 Oct 2020 13:25:25 -0400
X-MC-Unique: 7-zyjwI2PGqR2ZDJXzu0eQ-1
Received: by mail-wm1-f72.google.com with SMTP id l15so26634wmh.9
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 10:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LbWcn9OeBj8yeziF3lwXdH+BSdG0hLsOEHC5Ins7Mws=;
 b=o1SsKe3YqzQNms2NezElIz6dnGnYuJfU9C7gal56bWumCcmS24Jr8jpP1HANdFywme
 SMXL6NpPqs/WDY7wX6gm0iIPKvUSmm0FxdVHTtkNG0oeJRJLRAnCZwBUv0jK1a0/tnU7
 DBPzNKr1W/PP8x6yRNrzilkaxsv10fdKl9URHfA/Z2wmaiytEig3tsGSoJSPTQwx8Hry
 kqnALr2Sv9ovFo84ynxsZgUKR3PAE7X0c4+OsNDe8tRPuLkAqYD8ztxYMeap/A1T04fP
 O4J49D0p6Be7gnGATtaYGiN0OH1Wgxf2AHFf9oiW963m+oX+aBrGWnGxmUrfmin53xO+
 Epkw==
X-Gm-Message-State: AOAM532zVTrX6YFLp2kE8Fw/nIDWrKy5kxPeTO9xxSkHL1wlMZEU+Kej
 ArZaKzl4se86Lyi6w1edcEcmJXFU6YGPrK8cAnWEQBF2B6bCSRhwkeFQV6p55MxXYA5GQiYAijA
 ieRAvax2GmpLsZuE=
X-Received: by 2002:adf:ff88:: with SMTP id j8mr775798wrr.69.1602609923929;
 Tue, 13 Oct 2020 10:25:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhzZD1b/aVJw/S0ceTt1VM3eFS4CAWh2dw2bhhcU5Wj+rjOOFVpY32XAc+mtIj392swn0O/g==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr775777wrr.69.1602609923684;
 Tue, 13 Oct 2020 10:25:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:61dd:85cb:23fc:fd54?
 ([2001:b07:6468:f312:61dd:85cb:23fc:fd54])
 by smtp.gmail.com with ESMTPSA id u81sm378604wmg.43.2020.10.13.10.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 10:25:21 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] replay: do not build if TCG is not available
To: Claudio Fontana <cfontana@suse.de>
References: <20201013143806.14321-1-cfontana@suse.de>
 <20201013143806.14321-4-cfontana@suse.de>
 <edc078b6-71b4-0650-1c23-fd437cd3fd25@redhat.com>
 <4dd4ba40-159c-d581-1dbb-93a79bb06b8b@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <496ee664-bf68-f6c9-f943-02b5ab122c1b@redhat.com>
Date: Tue, 13 Oct 2020 19:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4dd4ba40-159c-d581-1dbb-93a79bb06b8b@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/20 19:17, Claudio Fontana wrote:
>> This is definitely better, but I'll defer to Kevin with respect to the
>> naming of the function; having a bdrv_* function that has nothing to do
>> with the block layer is still smelly of a sub-optimal API, and I'm not
>> sure why the API change belongs in the series.
>>
>> Paolo
>>
> Hi Paolo,
> 
> I am not attached to the specific name, if someone has a better naming / proposes a better prefix I will replace of course.

Can you just unbreak TCG in this series, and we can then revisit the
topic of functional code in stubs later?

Paolo


