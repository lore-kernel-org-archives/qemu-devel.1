Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34880C43457
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC5621789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQqHYDKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC5621789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbYD-0004LB-2K
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQbWz-0003L0-Lx
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQbWt-0006NI-S4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602185081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFSjo0c01EUQ1pP6mYHcgyIoGJ6wN1RM5YqrV1r8qbk=;
 b=AQqHYDKCZl1Cn+WjsRCeVGuABv+XnjyHdB03rziRDn5ZhEZ4XWC1n6oNiYb/Qsu0zM6kbj
 WzQhT3feNX6ebK30OS2uWHRSmM1usOA+JIuZOIGGU720yy4nJ/RVp5Fyog9FUQElFvcKGe
 zRQFEpicjTd3vMrYiz2Uvpve2Gle2Zw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-9i4jv58KOP-guViKIwa-tg-1; Thu, 08 Oct 2020 15:24:40 -0400
X-MC-Unique: 9i4jv58KOP-guViKIwa-tg-1
Received: by mail-wr1-f71.google.com with SMTP id r16so4243868wrm.18
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 12:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BFSjo0c01EUQ1pP6mYHcgyIoGJ6wN1RM5YqrV1r8qbk=;
 b=QjuRSpN4KQJgFc2R1I8ap3NtYpCNgUkTBIUFLg6bOIEbpypifo6GhRNxqs3O8YMZR3
 xaXG4ktD13+F8gN9nR2VzSq1F2GxS3Bt7LE/rkGisK0w17eUEA31JH5jK38ymUF/QNCM
 ZyV0/yNo65QywgkJPNuJdmfiahbPLEJd5qs7jCagmDFN54BJXIw+K/eD6hQ2b2wFOGob
 C656lShuaf9Zmsv8Y4TXF0p+6DPKgeGGVHeyo5pXHIyuWg13lu59Ry386YtF4Rx+vboI
 cuaNCtiOTKr79ljgZg/RInwkAZVE4mIev3TPvX8BSuDXzcPuavCIXsI2NN3RolSd5qCK
 X5jw==
X-Gm-Message-State: AOAM530HDN6q8BUbfjWt7157l3i7hu8D+j0/qJ7G4APHRwtRks3428+s
 Eu3OR41z6pvKD7AUfbAqfaYcsnkzC+zVuU19zI/YKYVcEHGKnrRL0teB+pKFN84SuLfT+geW5ln
 tydBLnF5aou8a+K8=
X-Received: by 2002:a1c:bb84:: with SMTP id
 l126mr11059476wmf.159.1602185078803; 
 Thu, 08 Oct 2020 12:24:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFB7FowdVa8nonf66j49B3D/JDTw8EX4g9SBKGbSo0ybGfnN2Fa6FDPozq9FwGv+93WYqp9w==
X-Received: by 2002:a1c:bb84:: with SMTP id
 l126mr11059462wmf.159.1602185078496; 
 Thu, 08 Oct 2020 12:24:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id r1sm7216098wro.18.2020.10.08.12.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 12:24:37 -0700 (PDT)
Subject: Re:
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <CAE2XoE_2hL5yJr6BSF+1cQTWBkegL_N1S7AEjx41kNzuS3XfPg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <539ea297-2709-5747-efa8-30495fb76320@redhat.com>
Date: Thu, 8 Oct 2020 21:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_2hL5yJr6BSF+1cQTWBkegL_N1S7AEjx41kNzuS3XfPg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/20 20:30, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> The text files are in tests/qapi-schema.
> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
> "tests/qapi-schema/doc-good.txt.nocr" "--" "perl" "-pe" "$x = chr 13;
> s/$x$//" "tests/qapi-schema/doc-good.txt" && if test -e
> tests/qapi-schema/doc-good.txt.nocr; then printf '%s\n'
> tests/qapi-schema/doc-good.txt.nocr >
> tests/qapi-schema/doc-good.txt.nocr.stamp; fi
> syntax error at -e line 1, near "="
> Execution of -e aborted due to compilation errors.
> make: *** [Makefile.ninja:2555：tests/qapi-schema/doc-
> good.txt.nocr.stamp] 错误 255
> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
> "qemu-version.h" "--" "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> "C:/work/xemu/qemu/scripts/qemu-version.py" "C:/work/xemu/qemu" ""
> "5.1.50" && if test -e qemu-version.h; then printf '%s\n' qemu-version.h
>> qemu-version.h.stamp; fi
> "C:/CI-Tools/msys64/mingw64/bin/python3.exe"
> "C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
> "tests/qapi-schema/doc-good.txt.nocr" "--" "perl" "-pe" "$x = chr 13;
> s/$x$//" "tests/qapi-schema/doc-good.txt" && if test -e
> tests/qapi-schema/doc-good.txt.nocr; then printf '%s\n'
> tests/qapi-schema/doc-good.txt.nocr >
> tests/qapi-schema/doc-good.txt.nocr.stamp; fi
> syntax error at -e line 1, near "="
> Execution of -e aborted due to compilation errors.
> make: *** [Makefile.ninja:2555：tests/qapi-schema/doc-
> good.txt.nocr.stamp] 错误 255

I think I know what's going on, but it's easiest to just switch to
Ninja.  I'll post patches next week.

Paolo


