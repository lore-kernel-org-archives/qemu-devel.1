Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709CBC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD88B20674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1bLcC43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD88B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjoi-0008Lf-I4
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPjnh-0007RT-Pq
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPjng-0004n3-2m
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601978547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vAENly9NmVlqB1Z3Mbo6oX+7z5Jy7wy13ryOGTkcBDU=;
 b=K1bLcC439C98Mi75Puks2ZLFYwU0t18CjWDlfW4MfnwjeAbXxjIo3uPoi4ODHc1jV9Gruf
 ss8q578npHUzEwuOIlaTHc4bPifPBNZ03FLBmCUdWznMH4+1BRtdWfd9qNY9xDgH/or5Lx
 fvCvcawlOS7PMAx9eHisjOmyIn9yYxI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-yMgRO6yPNGO7R0C85sjyzg-1; Tue, 06 Oct 2020 06:02:25 -0400
X-MC-Unique: yMgRO6yPNGO7R0C85sjyzg-1
Received: by mail-wm1-f72.google.com with SMTP id r19so913668wmh.9
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 03:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vAENly9NmVlqB1Z3Mbo6oX+7z5Jy7wy13ryOGTkcBDU=;
 b=sKx8yurZx9AQ+Pnlh3tE7x5WXjs98Y7UnuwO60I/QSC0Cmakd8GBxs1azbXpyM+x4d
 hn9TBkS3Qyn8x79zcrFLBNhWxE+sIE1HSbDolkLh/efShT6gNFkna3UMHu+yLgU0jJ+b
 QvWLg3w4Nn4y0np2+7snv89naYXUvPTw0+k9gdLgDsgFAYusDQ4J/4RyN2kesybnJbna
 6JB5zl5CdUcPeiIhqkBAn/aJC5PwglcZTgRh2fm7aw83qHNDr3G+7VSDIBwFsiU12tAx
 D09fUdVThs5zMJEkpLzXZN4GnMXT8aC8Zl7I5gJl8D12JZQ4lD0GHYhpchgDZih6oW2q
 fn0w==
X-Gm-Message-State: AOAM531sbHtUO4ROHiVGGhrQzhP4agCMkY/6+sPYNvsJS22oqziGF2aS
 bTwAnkedCG3O0G2EmpDuvopr+2XeQQNpiIF77O7lal3hEGtwYPfz6iJJxAvxZik1wnEGXbQsAc9
 Uzmf5XuUoccAfwv8=
X-Received: by 2002:a1c:5401:: with SMTP id i1mr3900803wmb.124.1601978544027; 
 Tue, 06 Oct 2020 03:02:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQIK5XnUIbikkOVQCzWj+lVYWpTd6j241sNzO1bvdnOsAv9QsOLYyMkqF/HlWDr7/NIxafCQ==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr3900777wmb.124.1601978543762; 
 Tue, 06 Oct 2020 03:02:23 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q18sm3514634wre.78.2020.10.06.03.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 03:02:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] softmmu: move more files to softmmu/
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20201006091922.331832-1-pbonzini@redhat.com>
 <20201006091922.331832-2-pbonzini@redhat.com>
 <27899e4f-a1a0-919b-f0b2-26c73adaa6e@eik.bme.hu>
 <679db184-662c-9175-b0f3-e22d26328f59@redhat.com>
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
Message-ID: <b884fd02-d27c-0043-db6f-76fd179211b7@redhat.com>
Date: Tue, 6 Oct 2020 12:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <679db184-662c-9175-b0f3-e22d26328f59@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 11:54 AM, Paolo Bonzini wrote:
> On 06/10/20 11:43, BALATON Zoltan wrote:
>>
>> The name of this dir may be misleading. I think it originally stood
>> for the actual MMU emulation but now it seems everything related to
>> system emulation is dumped here. Is it better to keep MMU emulation
>> separate and put other files in a "sysemu" dir or rename this dir if
>> it keeps mixing MMU emulation and system emulation parts? (I think
>> the MMU emulation is a weak part of QEMU regarding performance so it
>> would be better to keep that cleanly separated so that it's easier to
>> analyse and optimise it in the future, which is more difficult if
>> it's mixed with other parts where it's not even clear what
>> constitutes the actual MMU emulation. So I vote for keeping it
>> separate.)
> 
> I agree that softmmu/ should have been called sysemu/.  But I think it's
> unnecessary churn to do that now.

It is not necessary, but there are so many files moved around recently
so it is not a bad time to clarify it neither :)

OTOH yes many files have been moved around recently, so we might wait
for the next release before attacking this cleanup.

> 
> Paolo
> 
> 


