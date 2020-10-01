Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33236C47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA9E21531
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgsT8neU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA9E21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNvZy-00032f-Re
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 06:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNvYR-0002Vx-6I
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNvYP-00079c-Oj
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601547073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0jBGbmeL4lcA0BEOQVaUl4HJp9b/4o3tsk7PRGW4L9k=;
 b=UgsT8neUNXLOPknCD4vpDuGPvW7hFr2r2knmZH3WYEB67lFPChZNU+j/x5/hXS0/1fB4na
 i75SVNblidsLpJXAODIOV/MhL/VxjB1k0xaHWrGtX3+/HL1KQSY8Ezq9J9LG4aIE/lSn3S
 3Fzx3gFHFb9P6pKG8fQW01FNVkviJf4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-4wxfMsIIPoCyWO1hwCu3_Q-1; Thu, 01 Oct 2020 06:11:09 -0400
X-MC-Unique: 4wxfMsIIPoCyWO1hwCu3_Q-1
Received: by mail-wm1-f69.google.com with SMTP id t8so748269wmj.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 03:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0jBGbmeL4lcA0BEOQVaUl4HJp9b/4o3tsk7PRGW4L9k=;
 b=i40smpueK83WzwKPLAz/aOtYFW1uPRvfpH8qqKlld4RmOfmvmsxiLIt48VhTQEkN0i
 keHRK0E19Lsg8MQaEIM6npm4EIka/bmoQnDQ43zvbZjXk3k9O9hDaB+LpOja2JDjBrxj
 d/bCh7ZQJMVHitEmgqzgneOl23gqzNR6MS99cux7YAeVOueVTP4N35gKL6q3pT4nRm3Y
 OoTaAXn7OgmQPPGibfxC4Z0LlQcGQBaNETRmbcCO9Jml5bsFdFDtwB4Broo854sfq0tv
 E6075vrVDqOSht7vmBX5XOL1NQ7MXg8cmZex7QK8tccZjSz+H97TejhSl4rgLXsmNUjU
 njIQ==
X-Gm-Message-State: AOAM533rjntAivbPtWsnH9MRw7Kr29q9vNBLkd+eZ2Jtb8da5ewOY/0P
 VR/oh20/F8dR2Nxr0qg3KY7V90Gy4dLnOTZ0FCY4h5Ibzk8q1p6IQTRna70eZVSs82F++4A3oYn
 BdO780ht2EbvUiGY=
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr7824909wrn.113.1601547068298; 
 Thu, 01 Oct 2020 03:11:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL0XqYsU5B0BYMwJkEU2e0WjZOhut4AlqleI0kd95O0dZ7NEpdyEFWGeHp/6+/BXH5Ea9heA==
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr7824887wrn.113.1601547068114; 
 Thu, 01 Oct 2020 03:11:08 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z13sm8054049wro.97.2020.10.01.03.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 03:11:07 -0700 (PDT)
Subject: Re: [PATCH 2/9] hw/block/nvme: fix log page offset check
To: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-3-kbusch@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <981f1254-3a97-8564-38df-377e928e0814@redhat.com>
Date: Thu, 1 Oct 2020 12:11:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930220414.562527-3-kbusch@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 12:04 AM, Keith Busch wrote:
> Return error if the requested offset starts after the size of the log
> being returned. Also, move the check for earlier in the function so
> we're not doing unnecessary calculations.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  hw/block/nvme.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


