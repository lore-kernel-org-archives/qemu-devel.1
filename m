Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3629CC282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E725520859
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USaBHT+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E725520859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHdJW-0006dp-5b
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 19:53:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHdIL-00063k-FR
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHdFF-0002R3-L1
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:48:38 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:36500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hHdFC-0002Nq-NQ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:48:36 -0400
Received: by mail-it1-x144.google.com with SMTP id y10so10476112itc.1
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=6MyEPTck9c7+UN5ESWY6omSJgqYHEe3g8IhfsK70CLw=;
	b=USaBHT+Ck4zarDCC5b8GfNLCACVuWogSS5HUPPTHAkUKQ1xPTAwoO28An+7YBng/rK
	mxjTkZO83PgdgGyqR58IbwLXsSCB4lrPFwH072VbLk+dAeX4qqwKjT9d2z0njK5pECPh
	ApSuC+FvFh5gRqQXkctC0e7HNfjFQFX14UrcVafq5ktv4l+jboa98E49DOdZbKcjSWjh
	wwTfO7yNRcaumtbxvZx+sUMTpGDruL7Me+rGXq3zTe9sA0iiSYugggn9/PN6BO3D/BrW
	Po2VK9aoiYXk6vVTKbDTsnmmCuIfUli+3UbVomB8y6K1ldd5ptljuBBejBQR9whLHBVe
	zaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=6MyEPTck9c7+UN5ESWY6omSJgqYHEe3g8IhfsK70CLw=;
	b=Xf0B78B4Zes1ziUFc3WWPaxwdzAICttgtAZyB/bDIZWmTj/g3E6lFfmUMKguvoEdEt
	vHN093BnIPVYtG4NBZI9ioUFjcvbMEI8jlKgOdSwe8cuOElv49rjpm1bCbUP5cwLDQT8
	nyhtg+KrUGa6J51ZWVxFukx2nM+BBvYH729p+JW8kB7RHOy08Gs3IGF8WoOwE78aIsrw
	PM8WWAofqXyJFEfcZ16xwRBz12vN0mSkoWz/LEAx3GkevEAcEJiyKnpWkjUdmCtCl4wR
	IeUGa68tWoUtdP16J2PST1G1EIGeZf3QAyIUfo8t1r9Mu5UWiFdlDaTvB0y0QtCkd89p
	+MXw==
X-Gm-Message-State: APjAAAWYtjVJGYRVuCWV1rWRs4SXp3yMojZtPgJxehR5FZUIS1KQ0PjV
	gBMbpi5ddukRuheqKhswtr8=
X-Google-Smtp-Source: APXvYqzNYxBqGmWWjG2OwxY7gPkGJsPFkC8MuPHUOJCLI0elMk/Z2AKv7z3cH2sOTL3tzfcMX7tcpg==
X-Received: by 2002:a24:35d4:: with SMTP id k203mr4857684ita.89.1555717711632; 
	Fri, 19 Apr 2019 16:48:31 -0700 (PDT)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	k11sm2896586itk.25.2019.04.19.16.48.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 19 Apr 2019 16:48:30 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <58c00451-f216-610d-4c9c-7437fc07c5bc@twiddle.net>
Date: Fri, 19 Apr 2019 19:48:29 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD8629E0-5E3A-45AB-9C07-4405B658E3A5@gmail.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
	<58c00451-f216-610d-4c9c-7437fc07c5bc@twiddle.net>
To: Richard Henderson <rth@twiddle.net>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::144
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419234829.FHhhFES1ZqT0Ak3WCrXthuEvaCDsGEN-mI4GBYfi3rY@z>


> On Apr 19, 2019, at 2:22 PM, Richard Henderson <rth@twiddle.net> =
wrote:
>=20
> On 4/19/19 3:44 AM, G 3 wrote:
>>=20
>> Here is the error message I see when compiling QEMU:
>>=20
>> CHK version_gen.h
>> make[1]: *** No rule to make target
>> `/Users/John/qemu-git/capstone/libcapstone.a'.  Stop.
>> make: *** [subdir-capstone] Error 2
>=20
> You are configuring with --static?
>=20
> I've seen this before myself -- IMO it's broken distro packaging, in =
that the
> shipped pkgconfig/capstone.pc claims static library support, but the =
static
> library itself wasn't shipped.
>=20
> We should probably work around this in configure, and report the =
packaging bug.

I do not use --static. This is what I use: ./configure =
--target-list=3Dppc-softmmu.

I think this is a bug with configure, or with the capstone repo.=

