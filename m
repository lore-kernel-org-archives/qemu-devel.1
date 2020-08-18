Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9752C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8487F206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 11:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYWL/+Oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8487F206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zWS-0003c1-Oq
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 07:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7zUH-0002CI-Oe
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 07:09:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33359
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7zUF-00075z-CM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 07:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597748942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ArG9a3FHYt3qOmjj8GJ+d3J1T8RHFzC1XLJxjQx/c2w=;
 b=XYWL/+OoPtBuKKJJ6ubTyg/nVgcQ2YSv4xeU0nKhjoNgrphdhz+X7wnAsBWnsLpH4L6l5a
 MHWWQotcA1NlKUVZkupnt3wTsp7bH0le0nfUkcoDXkAcKyRIxpBzL6jEW9u7ESXb9s9XBE
 0wMZvDPhfJ6yF1prLiG5BaPhofiGI4I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-3j-TdM3rPOqAVfKTI8W_hg-1; Tue, 18 Aug 2020 07:08:54 -0400
X-MC-Unique: 3j-TdM3rPOqAVfKTI8W_hg-1
Received: by mail-wm1-f72.google.com with SMTP id z10so7265093wmi.8
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 04:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ArG9a3FHYt3qOmjj8GJ+d3J1T8RHFzC1XLJxjQx/c2w=;
 b=ZbvSrsuV3UtIIutC7Rg/2E0ghlnA+a/TywfE5e+ktCjTjscb/Dono5ifAVPwFsudYQ
 i1ZxOFvD0+xgygMciIU3PLjDlEjjjXS1HFooHSr7ScdZHv7BMzZ0vC2+Q/vX+T7gU5dK
 Nsy4+OkfpCK1tdD4Fe+ZkpNQECOw9BzmssTAchKw75ljRWfxzCj9DOG1vpj5D1QN83Hr
 +sT53KSiL+cYh1x6ACpOkjQLyWtl5DPMHdhsauw0MmgHPyBUgCyCD2aM/5uAHR5qKnoS
 34HqGDxKv6OHsrtsgUl3um8bGORVx0aGjAHVNvQmwwFWUcwaK6FJ/CrwNov/GW0RMx3y
 AwEw==
X-Gm-Message-State: AOAM5324sGBw4bQPiGpsT/YDsqJQkhhrTBGhxBzcpbLvmbu2vtvyunPJ
 vaBzLN5XDWGB+AW2blFfGOU96qdWiZGrmRbt/qg3PqFlGNkrtFNb38klqTdkpmezqqiNpBiBxMb
 UXZgVsT3wYzRvq0E=
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr18870774wrn.385.1597748933288; 
 Tue, 18 Aug 2020 04:08:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLEn0pmmYxwgUSwubpiD/XfqiIIAznuy+n618brtQScHZIWDu5I+FANAuJcGlWqmXkjL3XAA==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr18870754wrn.385.1597748933006; 
 Tue, 18 Aug 2020 04:08:53 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r206sm33712692wma.6.2020.08.18.04.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 04:08:52 -0700 (PDT)
Subject: Re: [PATCH v3 000/150] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
 <20200818115907.74f353e0.cohuck@redhat.com>
 <79afeb13-85cc-32f2-7e56-7a98a58bed8f@redhat.com>
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
Message-ID: <bcf9e13a-0244-6125-aa05-80fc67289eca@redhat.com>
Date: Tue, 18 Aug 2020 13:08:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <79afeb13-85cc-32f2-7e56-7a98a58bed8f@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 8/18/20 12:25 PM, Paolo Bonzini wrote:
> On 18/08/20 11:59, Cornelia Huck wrote:
>> On Mon, 17 Aug 2020 16:34:53 +0200
>> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>> - Simplified/rewrote handling of the modules variable [Howard]
>>> - Fixed access to gdb-xml files [Howard]
>>> - Fixed cross-compilation failure due to mingw prefix [Howard]
>>> - Fixed SDL2 detection on cross compiles [Howard]
>>> - Fixed sub-makefiles that include config-host.mak
>>>
>>> You can find it at the usual place, https://gitlab.com/bonzini/qemu.git
>>> branch meson-poc-next.
>>
>> Builds (on x86 & s390x), runs (this time with the right binary ;), and
>> passes make check, make check-tcg, and kvm unit tests (s390x) for me.
>>
> 
> Great, I'll do the last tests here and send a pull request.

What about the 2 patchew errors?

../src/meson.build:227:2: ERROR: 'sdl2' is not a config-tool dependency

ERROR: meson setup failed



../src/meson.build:547:0: ERROR: Program 'scripts/tracetool.py' not found

ERROR: meson setup failed


