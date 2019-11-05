Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A02C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2F321929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYMnsZAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2F321929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5Pc-0004n6-NW
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <christophe.lyon@linaro.org>) id 1iS5Ox-0004Er-IQ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christophe.lyon@linaro.org>) id 1iS5Ow-0005aS-Jz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:26:07 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christophe.lyon@linaro.org>)
 id 1iS5Ow-0005aA-BZ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:26:06 -0500
Received: by mail-lj1-x242.google.com with SMTP id q2so16851442ljg.7
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SroN29kuG2eF9EDpQem3ZYc6XjYoz+CkyAQ3KDhZUZ4=;
 b=SYMnsZAvWGEtWTh0ccMzz9SkHvCke5XP5SsnVVD88Zonn1tE+JJRi3RUudL5s00SZK
 L4M70+miSVL579gvh1+S9P+DTUuITiFhinAUKzDZKQEo+rW2rorqkgoxlSY6CJVPCeme
 BlhUPeNDf64vAuFx0XY8sU2qD23ttIU5daXW4PvAqKGAG/zFjTU7GZztEf6YmMSMncGf
 tEbg63JY2SSVU1PaFB5p8bWWz/k4Cz16lv7ebNriS/YU6lqT9+QYapE8vr49fllXMTN+
 ImuKUfCwLkoy5E18/K2jwEkDm/xmZZzgQj24wN/lLAZYaojdVmRs94MQAZKqgVSLoAzE
 nTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SroN29kuG2eF9EDpQem3ZYc6XjYoz+CkyAQ3KDhZUZ4=;
 b=bvq25nk5Y0pBb3cNHybDQONmS8WBAVCPRGnyKneMbl1GSLh68CnoVawa0J5mdn7Ld7
 OMgC3RzY+zZOTrQgnDr1uihb9qTLhrAo7XmiO39pyPCVBguGoU64x/i7UTjqaqG230tb
 +3R+6vnDjdYSV0o8fbmj9ZRAwd6VWzM+iR/2rtrNhzkrBYW0sxTVmygHVCFBkNIYLlea
 zmK+fW6D7zYHifl+6CDzA6si4Lxkk8wMED5T6Y5E0347K1SgGWmMKIAMBOqJ1CWyDkEX
 T1/NMtREWlUUnSHMJSRYcpQgFNU2d1My7e1fp4filrl5rDww2/NgVp847atm2d1/hQDt
 sgtw==
X-Gm-Message-State: APjAAAVj7eb0F1FBX+9qN/UBt8K7opt7V/shwCf3vWGJ+TW+m2N4OnWb
 GXOf/8w+tsvhAMZqENhek+6yZQNwe9DmlIeL7TbJzA==
X-Google-Smtp-Source: APXvYqxZFr3qjVTqmG2MlNnUf7Z7kKnDv2Q1KFcAGeZPgsKJUOOS46/Uxhd/hH8rrMmYApG962Gtq2Yp1lN3N2LFVpE=
X-Received: by 2002:a2e:91ca:: with SMTP id u10mr22995571ljg.208.1572985564288; 
 Tue, 05 Nov 2019 12:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20191025090841.10299-1-christophe.lyon@linaro.org>
 <CAKdteOZ9dYWhL7GDofCTFuYqN+Z60Z_daUAzDTPdhXODTYP9xw@mail.gmail.com>
 <CAFEAcA_wKJraQ7KW7PNFxf7quQ44w0mvkOaiojobU7s88rNooA@mail.gmail.com>
In-Reply-To: <CAFEAcA_wKJraQ7KW7PNFxf7quQ44w0mvkOaiojobU7s88rNooA@mail.gmail.com>
From: Christophe Lyon <christophe.lyon@linaro.org>
Date: Tue, 5 Nov 2019 21:25:53 +0100
Message-ID: <CAKdteOaEHrkqBFGVADZsnfptz9OMTn85yi_Kj3eOTGDLPQBqRQ@mail.gmail.com>
Subject: Re: [PING] [PATCH 1/1] target/arm: Add support for cortex-m7 CPU
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 21:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 4 Nov 2019 at 16:41, Christophe Lyon <christophe.lyon@linaro.org> wrote:
> >
> > ping?
>
> This is on my list to review, but it's missed softfreeze so
> as a new feature it will go into 5.0 once trunk reopens for
> development at the end of the year, so it's not the
> highest priority for patch review for me I'm afraid.
>

OK, I hoped it was still in time for softfreeze :-(

Thanks for the clarification.

> thanks
> -- PMM

