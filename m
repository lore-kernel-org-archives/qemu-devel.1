Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C2720708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFA3FFAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C2720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWIB-0008Iy-7B
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtWHV-0007U6-Hi
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:08:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59086
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtWHT-0008Lw-ST
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594300082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=NY+76HegLybdsR4rxxaThrUV8vVEPzpKvANIGOHUq/8=;
 b=AFA3FFAER7OkU+dwp698+obUJ82LI0sUw7nAbW1aXQMMJWwvCmLTLlwTtmsx+zdDzQUXs4
 oVFFBX6CqHWgkPMm7AWgf0rwK2eMLydZBYNFWF1XKSclPL0dAHHbYUvdcpx2DqUNOSTsms
 xiMBBLyXImzLXUoZJPtStZjXMkIQNDk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-4aNj5BmsN0WIMGYreKWRJg-1; Thu, 09 Jul 2020 09:08:01 -0400
X-MC-Unique: 4aNj5BmsN0WIMGYreKWRJg-1
Received: by mail-wm1-f69.google.com with SMTP id e15so2080982wme.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 06:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:autocrypt:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=NY+76HegLybdsR4rxxaThrUV8vVEPzpKvANIGOHUq/8=;
 b=L6dEHcg+5Tspew3gXnaRSAlFu4MgdzNqmQ0dUFnxS+uuQxaCVC0Dq1oyrpSXHYWofx
 ymffNQ02YHRcJT/MV3yqnDJ18Wi8H866bwbviKE0oswWWLpQFCzrHFr/wNdoYlP3avrS
 MtwGB3aotyYuZgdm9D0NLWuH/QRWyikoJ3EQKdNC4tP/PvW2fLB1Vn5tLgOEoVx9Ke2l
 6ZX4ySvW/0GA3E6x+lmBX5Ix7abfsdSU/PkMfc3gHVsBt7DYNvP2TPYExTrYgnETaKSQ
 u3d1/l5eLUjsaJt1v7DxVIuNsJNQMjDcFj4mwPAp7fesGkhLRVOzngipVHVOmP4Edvrh
 a7pQ==
X-Gm-Message-State: AOAM532T0KptwKcKgvahAPMR+GNKKVtTYjunNteiSzIZTllDM2iNbUpS
 xi2UAh6DD5VglqGeMu+FjeNVTbSmu64cHVPKrM2iCVklxoNeOWf7XTa7Bcq/RVp3x96IG1Me6Z4
 Nr6ujhozQ1h065M8=
X-Received: by 2002:a1c:f609:: with SMTP id w9mr14158815wmc.150.1594300080024; 
 Thu, 09 Jul 2020 06:08:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAAEIEw87QS9ljgkkhq3vCe5S19DY8N4CThwNwgQr1uG1c1TWpupH77A/Zcsnnd/RrWaqLUw==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr14158789wmc.150.1594300079781; 
 Thu, 09 Jul 2020 06:07:59 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id n16sm5084804wra.19.2020.07.09.06.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 06:07:59 -0700 (PDT)
To: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: Updates on libcapstone?
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
Message-ID: <16ea7c6b-d959-9df2-0603-d07e40ff4021@redhat.com>
Date: Thu, 9 Jul 2020 15:07:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

We are using libcapstone since almost 3 years for the arm/i386/ppc
'base' architectures.
The library is still optional in ./configure.
I wonder if we can make it a strong requisite, this way we could
get rid of disas/{arm.c,arm-a64.cc,i386.c,ppc.c} and the disas/libvixl
submodule, then having C++ compiler is not necessary anymore.

As of the release 4.0, the list of supported architectures is:

"ARM, ARM64 (ARMv8), Ethereum VM, M68K, Mips, PPC, Sparc, SystemZ,
TMS320C64X, M680X, XCore and X86 (including X86_64)."

m68k/mips/sparc/s390x are other candidates.

I remember you had a series related to capstone, but eventually there
was a problem so you postponed it until some patches were merged
upstream, do you remember?

Thanks for any update,

Phil.


