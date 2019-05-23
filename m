Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE28C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1501A2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="l6MLb9Iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1501A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTr6Q-0001Jq-3m
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:02:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkir@google.com>) id 1hTr5R-0000JX-Ao
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkir@google.com>) id 1hTr5Q-0005jt-DZ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:01:01 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:35601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rkir@google.com>) id 1hTr5Q-0005fy-3N
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:01:00 -0400
Received: by mail-lj1-x232.google.com with SMTP id h11so6183604ljb.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+QzEOeRDvlb9Co1cBrmR18CCDWktTnyVmr7UKcUzHzs=;
	b=l6MLb9IuCACYAnCZ1tTDjZcmw8Je5zpLtJ1MUgQLijf2jVHJjUeK8iCQiyaOKN0vd3
	108h1Ns21A7P47uux+4uW+mgI2oymN8Vc3Hzn6dyVlU2V6gvLCQvozMPIULjnbqSnJK9
	DLsBGqurjaHCaAArDIrrfUaxMQymJveN2l3Bv18Rr6RBqjZzHffUIxzgXJyHn7iaphgj
	9uW9lO61NYgkeEarjNPlW1dairMbgHCblrbH/newiE56ooBWoMjBZhzog55yuLqUA7IP
	MHVJrqVJDoWvtFJXaTZ1oKM5oI5emMkF8oz9NhXiLsHWrwvIz/wPtaMBwhE2MXxKWkg8
	tI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+QzEOeRDvlb9Co1cBrmR18CCDWktTnyVmr7UKcUzHzs=;
	b=iIieJYUy/VoWN6NHSzz5shyKAWHYC2y96fg+mDgNXSYJjSlZjOd230lKWD3ku7++Pa
	NSmm4G9N0cCx53UiSpWIW9O88oU77L+0FJYimfNDsFQHlZqZpDCxzUvN2dPomvwT7k0k
	baEBppfPxlAebxLM8ADP4N8kvd4+cf4YkOeQiMr4MTbZ3OVNxNstoC6LV1K9MrEsCfoZ
	B+3DWzB3DfTKLGu/R2bfmy/fImt0kdgXwYlZoe2Mut6e2jY1RcMZyANzU1xjyPpsNAxJ
	CqtmDAmg4pxsRk4i2Z9kr4wxjx/PH/x1IRWaUPZ+Z/k9FwmCS8pyaiHwwIKSR+a8mMru
	w1Vw==
X-Gm-Message-State: APjAAAVzY2MnbMfP1cM5FWEq30VTcN4nfsWcwKoRMjWVw5TcufdD56PM
	WkU+AE8MiveYw3Ds2Pkha8y1h7YQHNazkDMWRAvE9w==
X-Google-Smtp-Source: APXvYqwMmoJJiDhrTlOiTiKeJx1UP7GndimVoH/iy3XesA7t15vyLZSRgdfrYxwfXb88AWg4sGutVczgRhFf9kmCKL8=
X-Received: by 2002:a2e:8516:: with SMTP id j22mr19690701lji.119.1558630855798;
	Thu, 23 May 2019 10:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190522222224.244714-1-rkir@google.com>
	<20190523102225.GA2994@work-vm>
In-Reply-To: <20190523102225.GA2994@work-vm>
Date: Thu, 23 May 2019 10:00:44 -0700
Message-ID: <CAOGAQerwpqaP=DKxC+WVdJcGpxnAayfMrwoPP=bBJBBG5Vn87g@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::232
Subject: Re: [Qemu-devel] [PATCH] vmstate: Add VMSTATE_OPAQUE to save/load
 complex data structures
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
From: Roman Kiryanov via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Roman Kiryanov <rkir@google.com>
Cc: Lingfeng Yang <lfy@google.com>, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Dave, thank you for looking.

> Can you give me an example of where you would use it?

We use it in our host memory sharing device. I used the existing
macros for all fields I could, but unfortunately some state does not fit
into them. We use this new macro to save/load memory
allocators (for now we have malloc, but we are working on adding
Vulkan calls). For now the state looks this way:

class Allocator;
unordered_map<int, Allocator *> state;

class MallocAllocator: public Allocator {
    unordered_map<int, vector<char>> state;
};

class VulkanAllocator: public Allocator {
    // TBD
};

>  I've been trying to get rid as many of the open-coded cases as possible

I saw this in the migration document. I used VMSTATE_INT32,
VMSTATE_STRUCT and VMSTATE_STRUCT_VARRAY_ALLOC
where I could.

> Having said that;  would it be easier to pass the get/put functions
> rather than the info ?

Sure, function pointer will be even better, but since VMStateField
takes "const VMStateInfo *", I added this way.

Regards,
Roman.

