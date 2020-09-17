Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B066FC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289822075E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsNChcS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289822075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIu5y-0000jO-3c
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIu45-0007FP-1j
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIu43-0005KY-4V
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600349705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a5O+ntZ40lDF/EEkzGkTCPRjFFkf/IG+57/2e2B2Bj4=;
 b=KsNChcS5yl9zw9SDCXa+hZL634nmfTP4xu63mBjfKu0PnZmWW4MQwi8nVc/tqUD11LZ/vS
 ea3xiLUaDT4F11hD1KCERLQg/mAsBK1lTJrAHKjE4fdzPDIxiwqs1DnIqAjYPYHL4Mtcxm
 glX5LzvRlcN3lCc/4vvhPaRNPXxjDuc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-487TiUfPPwe0T6JYI3r-zA-1; Thu, 17 Sep 2020 09:35:04 -0400
X-MC-Unique: 487TiUfPPwe0T6JYI3r-zA-1
Received: by mail-wm1-f69.google.com with SMTP id a25so539061wmb.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 06:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=a5O+ntZ40lDF/EEkzGkTCPRjFFkf/IG+57/2e2B2Bj4=;
 b=ha8GS198FWpfiBzjtOd5PP3xU1qwWdIHkOxbrHn9lKSvWMDKvVKg7dZd2a4kAfo+Ge
 2K+WNF5OGehn7Ndh0m1VkhoEEJdz5rZpjHYOe9pVb5ur2IzULd8Nex6PWrOtHa+6wmDe
 7WTLSr83t6His0Y3SmfPXtA+i7fivCQSs3Irvx7DCFVNK1L5LlTAC1CTvpXpRaw4IyOr
 4WVsjZz/vHTQxxLQ62bd63mkXQmUukOQIQ0T4SeWKB+ePlCjxYDrFWhZv/CYV9+CM9Q9
 rVP0b4XktaZ4J4udoSC8i3upSncF/L9I6E8aQGRk0WfymWfJfG4i8YOmyxWq0JxmojB6
 UtPw==
X-Gm-Message-State: AOAM5313/M7AkTms0yr74ArSibImi0775bDP+Wd3UP20RM//scs+3jy1
 zgRLcTjZZ2xO/dPDzjPFMYCq/0pCr6b5aEwLafIibR5ctto5WnNM7bsHi90GPL4T77uZzq3oEi+
 7ub1JE061L7XVM8g=
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr31682141wrs.36.1600349702949; 
 Thu, 17 Sep 2020 06:35:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCcEzY9yrUZEFRYzmk8dQCkDqagZeCNtWR8Mmj32oIh5Ubltuik2lRgyF4gEmdITCtDc9HgA==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr31682121wrs.36.1600349702716; 
 Thu, 17 Sep 2020 06:35:02 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 92sm41435882wra.19.2020.09.17.06.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 06:35:02 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] ui/spice-app: don't use qemu_chr_open_spice_port
 directly
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200917101320.25285-1-kraxel@redhat.com>
 <20200917101320.25285-2-kraxel@redhat.com>
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
Message-ID: <b11b271f-57b5-61a7-4849-601b14483e26@redhat.com>
Date: Thu, 17 Sep 2020 15:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917101320.25285-2-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 12:13 PM, Gerd Hoffmann wrote:
> Save the parent object's open function pointer in the (new)
> VCChardevClass struct instead before overwriting it, so we
> can look it up when needed.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/spice-app.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


