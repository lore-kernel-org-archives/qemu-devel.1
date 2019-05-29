Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F341EC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B492081C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B492081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52223 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVwwa-000407-1f
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:40:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVwvp-0003ee-GL
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVwvn-0001oO-Ra
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:39:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVwvn-0001nL-Jq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:39:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so1535327wro.4
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Gtb9CfRXShL781i5in3DEnSgXEJrI4je5O6XZFU9J+Q=;
	b=bbfGyxAu8S9/QlnYS0XSZ99awf1RpHju4lWmoOe5YQvfICiIhZx7tRAWHWG+spR2yd
	4aWmSwZ/w7ZTmsWzAWu7gz2Xdp9DPGcJNNgIJDiMEooZKsLZ9vFRH7tZhIVC1a1UycQa
	e1lpYKnPY+2mj/ylZAuiNePt2svRUtPZxpSn9PswMabgS18BV1HHn39amDld79579pm2
	cptMoxHN1c5g2nypO4uNTLPXAsMmRQ8NY+zxp84u9i6rQUBIwDG97SqW4vOJT+QP3Zf0
	HaYNozNsOXRIiZdHrHeGUu9CpunUldOMCE6agOobNuVgK/K0neHIM8zKrYRK10TX8HgL
	t6aQ==
X-Gm-Message-State: APjAAAVyTHBFmsDost2uAxpXMeB0Z6tmJKIuUqS/3buJQstzfVItnF+o
	6u5V6HV3Ie3Vps2VRnXDho7B5Q==
X-Google-Smtp-Source: APXvYqzv24nRYhzuXzCoshN3Vrwrte4kdheYYF6KzEZbduZnz7uO2CitUMRJuLRbsGXBJKooruynVA==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr3081811wrn.159.1559129977165; 
	Wed, 29 May 2019 04:39:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553?
	([2001:b07:6468:f312:c92d:f9e8:f150:3553])
	by smtp.gmail.com with ESMTPSA id
	r16sm13436101wrj.13.2019.05.29.04.39.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 04:39:36 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Pavel Dovgalyuk <dovgaluk@ispras.ru>
References: <003a01d51611$6251a2b0$26f4e810$@ru>
	<20190529113045.GE2882@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c55c39b-694b-5d4e-d420-5df0feabc1e8@redhat.com>
Date: Wed, 29 May 2019 13:39:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529113045.GE2882@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] i386: EFER vs 32-bit CPU
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/05/19 13:30, Dr. David Alan Gilbert wrote:
>> Should we add a section for i386, which duplicates efer, or just version_id of the main VMSD should
>> be updated?
> 
> You could do:
> 
> #ifdef TARGET_X86_64
>         VMSTATE_UINT64(env.efer, X86CPU),
>         VMSTATE_UINT64(env.star, X86CPU),
> ...
> 
> to become:
> 
>         VMSTATE_UINT64_TEST(env.efer, X86CPU, efer_needed)
> #ifdef TARGET_X86_64
>         VMSTATE_UINT64(env.star, X86CPU),
> 
> 
> and then make efer_needed a function that returns true if
> TARGET_X86_64 or it's a new machine type that knows about whatever
> you're going to do with it.

I prefer adding a subsection for 32-bit, so that EFER is saved/restored
if nonzero.

Paolo


