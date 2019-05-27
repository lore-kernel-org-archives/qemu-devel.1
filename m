Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18A2C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CCE208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CCE208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43039 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVCUu-0001KF-1p
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 06:04:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVCU0-0000wJ-WB
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVCU0-0005mz-3U
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:03:56 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVCTy-0005io-IN
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:03:55 -0400
Received: by mail-wr1-f48.google.com with SMTP id b18so16290807wrq.12
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 03:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xn9c9Piticq2Ejv/INRVOI0Vbfs++F7iSHSj+KetLUg=;
	b=ivlKZy47Xe1L0GCQdAyD0Fb8W52Zrp/4yFQLN4gLAoFRDSHEmr64yj1q0lMpBr0ecK
	bKKGtpf1wpW9Y0D0Y78LG7nrPRUjE2yExmp7SskOH5qg3jBvKcGmEn6DZDnvdEVvITaP
	91R/nGz25kzdb+lfCcLJjY4+rPKBSxuYWxzIqqQEEj5GJFD8PDkDTBtaVeS32IFNiaBR
	BW+YTAfgFYKeqjVEwRlZn+de1BpKazHODbA+3qK8QRgpFbCoZOntfrk4icWNEdVmbBRR
	QyfGs/UPTc8v+N69puWPdT8iwRiXQGvEunNoFQynfjIf4r4q5zJYh6wut00wx2kvD0QL
	50yA==
X-Gm-Message-State: APjAAAV8TKCg+NldKDXVtvUmLlKXJUP5xGTmsUa6iXo7u6+KG4QsRlV2
	tFywXJlRLhpk+b3yWPPOQQYRpNA6cbU=
X-Google-Smtp-Source: APXvYqwVdlbwhTITdXaYsxke4dfIww+yyzW81uyj9jU0GBzqX82DlmOi3xkk72l9EFOrOZlkgM2WNw==
X-Received: by 2002:a5d:6243:: with SMTP id m3mr21208127wrv.41.1558951431416; 
	Mon, 27 May 2019 03:03:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c43e:46a8:e962:cee8?
	([2001:b07:6468:f312:c43e:46a8:e962:cee8])
	by smtp.gmail.com with ESMTPSA id k8sm9085647wrp.74.2019.05.27.03.03.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 03:03:50 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>
References: <87woihi1wl.fsf@dusky.pond.sub.org>
	<20190524185344.GJ10764@habkost.net>
	<87r28k1g4q.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e5372760-7599-3155-44f7-dc704c9cbaa5@redhat.com>
Date: Mon, 27 May 2019 12:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87r28k1g4q.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.48
Subject: Re: [Qemu-devel] qapi/misc.json is too big,
 let's bite off a few chunks
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/19 10:00, Markus Armbruster wrote:
> As long as we don't have an active QOM maintainer[*], the benefit is
> low.
> 
> 
> [*] We need one.  I'm not volunteering.

I think Daniel, Eduardo and I could count as de facto maintainer.  I
guess I could maintain it if I get two partners in crime as reviewers.

Paolo


