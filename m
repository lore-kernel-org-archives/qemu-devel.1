Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE359C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F928206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSuLRoNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F928206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPDF-0007hg-E1
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOPBj-0005uG-0B
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOPBh-0004aq-Go
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601660984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qE2vgyc55FZTYFofewcNWIc54bfVQoSgZCgD3DQVjY=;
 b=YSuLRoNU10Q4hVd4Y6p7Db3accbxHcqAYSxl138/jdqGczwbC99i+4/GiFWtzu7BrVRdfQ
 zWWtbsVL32H2tOpC5FTJu4Kkd6marQ74bXUx3z6A9Y4k5Aqzf4lu+Vtlgwor6zcYRKfPYP
 EAbFhbcdhtaqfcZ+spgosLmVOQjwB+w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-4mD4oN-jO82spQ3M3yCsQA-1; Fri, 02 Oct 2020 13:49:41 -0400
X-MC-Unique: 4mD4oN-jO82spQ3M3yCsQA-1
Received: by mail-wm1-f70.google.com with SMTP id b14so664128wmj.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5qE2vgyc55FZTYFofewcNWIc54bfVQoSgZCgD3DQVjY=;
 b=oLLJB8jjt3/RNqWZLG2x24jKkCUSFXggP1RW8vZ63mKL/bEk6nnFWzyp6nvXQa0JU1
 dy4QLq72j6NRy3qzyX8QgKH2hevCIaUpfkz++BodrbdMiOlCCF/1YEoxxmOsHsKr3wgZ
 gecttV9GATchlQbpc7K7Wmi8HdGKWyi0YLaRp2UMc9y0lBGc6ZHaUX4GY2mtDe3O7Cni
 xmmu5RXLy4As//7v8+DGLT62q9quh4k9gt3Fm8fybO3naRTiBeNF0sTMCdVtjB1d3Zp3
 Lm3FxLARK0FEx7qaVYMkxg7dHl9nIrf6vZfa085putKdjOn9e/1idQRL8+5SMvTyl9kE
 07mw==
X-Gm-Message-State: AOAM532P9Fz+QQVdg00KxcZ42LJBBFfR4/nA3K0B1W/mdCb5KxHSsxWC
 fsZk+iH2n8RMwYtBLsf2mGBFzganrqoWC69L/oOKaUhKG+A1+snr8rFoD8ASgDtuGmCwrOODbPb
 mjs4N/EenAwxx2t0=
X-Received: by 2002:a1c:35c1:: with SMTP id c184mr4058525wma.161.1601660979946; 
 Fri, 02 Oct 2020 10:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8hPwIg2uuzLrr2Y+awvnnqdRrU3UBD+qVOWDe1bxu+eV9oCUjXERnPZnrQqZ4huKZ+xfKQA==
X-Received: by 2002:a1c:35c1:: with SMTP id c184mr4058505wma.161.1601660979698; 
 Fri, 02 Oct 2020 10:49:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id f14sm2717666wme.22.2020.10.02.10.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 10:49:39 -0700 (PDT)
Subject: Re: [PATCH v6 2/4] curses: Fixes compiler error that complain don't
 have langinfo.h on msys2/mingw
To: luoyonggang@gmail.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20201001173230.829-1-luoyonggang@gmail.com>
 <20201001173230.829-3-luoyonggang@gmail.com>
 <20201002153559.GJ2338114@redhat.com>
 <CAE2XoE_z3j+_+Oh1Kn-GSAT4q0_nXnT0sLHMLCw0+r1o0WBJSA@mail.gmail.com>
 <20201002164232.GO2338114@redhat.com>
 <CAE2XoE_+ERRdDgGcisNj0WWMU=rCs49PrikVw6Tk+Ov2TC0+Tw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7998dac5-0bd6-a552-30d4-c567805ad1ed@redhat.com>
Date: Fri, 2 Oct 2020 19:49:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_+ERRdDgGcisNj0WWMU=rCs49PrikVw6Tk+Ov2TC0+Tw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 19:47, 罗勇刚(Yonggang Luo) wrote:
> Because the configure script change far more complicated than you
> imgaine. And I post that before

Daniel is literally asking for a two-line change:

diff --git a/configure b/configure
index fee5faa054..ffd72b571d 100755
--- a/configure
+++ b/configure
@@ -3671,7 +3671,6 @@ if test "$curses" != "no" ; then
 #include <locale.h>
 #include <curses.h>
 #include <wchar.h>
-#include <langinfo.h>
 int main(void) {
   const char *codeset;
   wchar_t wch = L'w';
@@ -3680,7 +3679,6 @@ int main(void) {
   addwstr(L"wide chars\n");
   addnwstr(&wch, 1);
   add_wch(WACS_DEGREE);
-  codeset = nl_langinfo(CODESET);
   return codeset != 0;
 }
 EOF

Paolo


