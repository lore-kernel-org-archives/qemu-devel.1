Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C800C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFC521775
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ucw8gfPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFC521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8o2R-00042s-5c
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j8o1k-0003Yr-GC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j8o1i-0002h8-W9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:34:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j8o1i-0002gj-SG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583166881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUlT0TAemZzyCbo4afCbc8kRhIGUkP6o0Gf8ItGFrMg=;
 b=Ucw8gfPiEt8oKrSnBjc73vbl40HRm7oAW4AtRKVmFfyJ4vz1rJJUM6C6UstlwHPZ/2N2Yf
 cnolYsLtPMZdiFlMD4eyWweMZmZiC11osk4kXOGSdkd/o3XE09EzcpXJkhIBCfyC4qspgX
 JyOdqdQ2udNrYRY8DvSfbAWaqr8p2UM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-mATUe6TUMoGmq5RQX0NHgg-1; Mon, 02 Mar 2020 11:34:38 -0500
X-MC-Unique: mATUe6TUMoGmq5RQX0NHgg-1
Received: by mail-wm1-f71.google.com with SMTP id j130so19223wmj.9
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 08:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AUlT0TAemZzyCbo4afCbc8kRhIGUkP6o0Gf8ItGFrMg=;
 b=Xv+Fbe2q9PHf2fPjhjpUyT0sG3Z2PpX3KtPEuMiR/7OuCPrQoRJQR3I4jA8XXMhCEM
 solZNk7j/gyzq36Y0oXNQ6vqonls2D1TyTfy8ggv6UF0mEyYTSKYqYnOkBG05nnRslA2
 ByG0MzXRblUko0C2ZLKEECyPFtyazikny+oPODAWlaK6ae4igOd19obPsosJhRolhYEy
 PMugEvnjiXlq2JFjF+4GrIM2Lz2WK9DPbvEkMEnjA929alW3lMjCcPKsbWWqocOrmJG4
 xpkHgoKyGif+UN7A9qNLFIDiovUFYoWlE8jsqHbiGZ1jde72Lp+fV8kCmLxHitR2ni+d
 Jvqg==
X-Gm-Message-State: ANhLgQ0S1SBGxKawMoRlEXpwp/wCHYglqFiSoTTBbVi+4k8OJCd1+ro1
 EkJ3mOjNvyOkB8Z3VY5M8Nh/nq8wBPuq6DeEmCgC2m5pKdIac4UPdhqfboeFPatnjZjNBTz8rHk
 FvnbdNPvXX9JqPHI=
X-Received: by 2002:a05:600c:2154:: with SMTP id
 v20mr201313wml.175.1583166876807; 
 Mon, 02 Mar 2020 08:34:36 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu/LhxtksYtSmCsauMKQxZBtKYV/cQ26PZ1/QzFgBiivXaX/KzjivCYfz5XRTIrPcVAonvp6g==
X-Received: by 2002:a05:600c:2154:: with SMTP id
 v20mr201298wml.175.1583166876551; 
 Mon, 02 Mar 2020 08:34:36 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
 by smtp.gmail.com with ESMTPSA id z13sm998609wrv.94.2020.03.02.08.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 08:34:36 -0800 (PST)
Subject: Re: [PATCH] memory: Fix start offset for bitmap log_clear hook
To: Matt Borgerson <contact@mborgerson.com>, Peter Xu <peterx@redhat.com>
References: <20200218101910.6593-1-contact@mborgerson.com>
 <20200218165343.GB1408806@xz-x1>
 <CADc=-s4nkB6ieakmiRuogygT7dzjb3q--noAWEALrrSOG+ZN2w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dea85039-5bf2-8de6-471a-8e4bd56f1166@redhat.com>
Date: Mon, 2 Mar 2020 17:34:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CADc=-s4nkB6ieakmiRuogygT7dzjb3q--noAWEALrrSOG+ZN2w@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/02/20 21:46, Matt Borgerson wrote:
> [ ping ]
> 
> Hi Paolo, would you mind taking a quick look at this patch for
> memory.c to consider
> it for merge? This resolves an issue with dirty bits not being cleared
> as expected.
> 
> Here's the Patchwork link: http://patchwork.ozlabs.org/patch/1240121/
> 
> Thanks for your time!

Yes, I queued it now.

Thanks!

Paolo


