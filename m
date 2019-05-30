Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B9EC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07A7257F6
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZdO4Sz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07A7257F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIzU-0000yw-4g
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:13:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWItS-0004vE-7x
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWItR-0005Xl-6b
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:06:46 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:33093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWItQ-0005TP-IJ
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:06:45 -0400
Received: by mail-oi1-x229.google.com with SMTP id q186so4632004oia.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pyhXN2i+pDIiwlvBhD4LQ1zeQlRIT6Q8mV1OZTQr6fU=;
	b=XZdO4Sz4Coy+fMctX9L+G9ptsAStaRC9NhXNS66/+EG0GxXxABO/QNhqUviQEXgT/1
	YHkmW8uGEXNvvIVLUbfMi2512XBgRltp6KvnV2F8vGtAK6TDMJjJQc/ZLqrQ+OWeWfze
	8j56Ua2vSZLhh+0Hi3rit1tiZ0WEwUQnMzECbHK6Gj9ZAf36J4dSeWwqjohXGs+wBlLB
	Zm2drs94O6WozKG5wi0nLfufQEENaM8GHDRVX9P0YoOsEsrQmHwaOQbuBXCFzDTPKnnu
	fcrJXhwhpdGheijUH5UZ6qTPSPT9RP4reyr3PcR/roswpwPX5K5E6ZMBSiC9apLrhlBw
	cU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pyhXN2i+pDIiwlvBhD4LQ1zeQlRIT6Q8mV1OZTQr6fU=;
	b=ue1WGLg49fJ6Z9gfrMWZNkcKpM9sG2GB96qBp6hHT9C6AEgusvSEoOB6VfNNwD2w0M
	SflYLhjWNDCZZgjB6ZHhAzKDE33YTfupSlQ2jTigkgORJTGo3kkhZGDaSNuxBNKUSVmG
	uqE5fZSEEYljqMkmyW3QjX86rf2zbj5ajTsZFklip97Wi1/20fhqhxVZso403seVXd3r
	ZmFJjI9gHMO6+nwveFBPCxgG2wa7v/L/PnrYma6L6I05ZCGrBI66QiLm5tnllZgpyNem
	xPk2271tcRwOoLRlkoPR80zVg1G3YZr2rxYatuvVsZZoABRzfjRpj1XWSFfXUTsPnoER
	fGfg==
X-Gm-Message-State: APjAAAX2DScU81opmV0xJKoGS26DyZKD+lSxnUDnmCbKp9dkdupkkovD
	Ycflf6bhxKI2igLSN0Fl4jtWii+QQH4ZtGtnqXRa/w==
X-Google-Smtp-Source: APXvYqxHAx/HrULQZ8Dpni8uRDBSTWTIjlEug0bDWYZ1KkgB/xniUacWG3d9IgitppDeejlrp3iwAbT8pMa+B6aMeF0=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr2109800oif.98.1559214401276; 
	Thu, 30 May 2019 04:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190522134726.19225-1-armbru@redhat.com>
	<20190522134726.19225-2-armbru@redhat.com>
In-Reply-To: <20190522134726.19225-2-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 12:06:30 +0100
Message-ID: <CAFEAcA86DBtQCDAF8p5cyyHBxzgv99xYEdqMDgaCWMYEtR-Cew@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL 1/5] qemu-bridge-helper: Fix misuse of
 isspace()
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 14:49, Markus Armbruster <armbru@redhat.com> wrote:
>
> parse_acl_file() passes char values to isspace().  Undefined behavior
> when the value is negative.  Not a security issue, because the
> characters come from trusted $prefix/etc/qemu/bridge.conf and the
> files it includes.
>
> Furthermore, isspace()'s locale-dependence means qemu-bridge-helper
> uses the user's locale for parsing $prefix/etc/bridge.conf.  Feels
> wrong.
>
> Use g_ascii_isspace() instead.  This fixes the undefined behavior, and
> makes parsing of $prefix/etc/bridge.conf locale-independent.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20190514180311.16028-2-armbru@redhat.com>
> ---
>  qemu-bridge-helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Coverity complains about this change (CID 1401706) because
it doesn't have enough information to know that the table
lookup g_ascii_isspace does is always safe:

  tainted_data: Using tainted variable
   (guchar)*(argend - 1) as an index to pointer g_ascii_table.

We know this is OK because we know the table is big enough that
a guchar index can't possibly overrun, but because the table
is declared in the glib header file as
  GLIB_VAR const guint16 * const g_ascii_table;
Coverity has no idea of its size and is being pessimistic.

I've squashed the Coverity issue as a false-positive, but I
mention it here in case you thought it worth trying to write
something in coverity-model.c to provide a better model of
the glib function.

thanks
-- PMM

