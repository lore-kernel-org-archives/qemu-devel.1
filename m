Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182AFC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA76B20692
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvBrpL+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA76B20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNm6M-0007ZA-W0
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jNm5m-00071E-1W
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1jNm5l-0003Bd-7Z
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:32:45 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1jNm5l-0003BR-0Y
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:32:45 -0400
Received: by mail-pf1-x443.google.com with SMTP id b72so3758086pfb.11
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=2yqgEIJzwZCDhho7Hk8eIQlX5ubYWa70MSY9D51bc/8=;
 b=MvBrpL+S4Llq1/QSpeXkF6VXHTCuU1GruYGgB/S9P3SK8spbJsGu44rputm3ZHwgk5
 5xjmXvhbSmPOpJY0aU8EaoHTcxAoz3GgF+V/Q0Oj4dCd+xoPZtf8I7K0muNL5DDnEzej
 r+HkganaEgmoVmR8Inf4hCAGsenUOFRqvV4lhiuq/0KTINHp8pkp35gsYZiDQ5rqED1+
 ipqcyZ7B19dwWo2WMXalrE5rHnqZ5pnJhO1/eX8G5r44PZgTLMaroRB++KKo0l7pXRBk
 yKjD9mPRoPKQ8cFN4TpE8+EszKxWe11VIUxA/grigazigRoc2YS4hKrufnxbROlKOE2/
 Y/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2yqgEIJzwZCDhho7Hk8eIQlX5ubYWa70MSY9D51bc/8=;
 b=nKWWxkg6119LiQSUyv7aM+bGBmo4ahwZe0X12iiApNO5ndhCztf0OnNTCnSWxpmE7/
 mV+ymmc/7cX1saa6GlM17T9xh4N1X7io86VLiuIchNyxZM19OMfQXOwbNIRrZYsz25x/
 owmoB2/m6jOA4ASkwGCaxcjY1ZmA3INRzQb9K4MPe96MYo5JwzxF/Fbmxm9SJ767+m50
 TG/DZPYvqDKu2jMgtBaPcy34OjkF2N7/gJM6dOK2nXH+nlPHYIXHjE/4UK57vMhyYXRC
 T9VxwtFrZErdWSDZYXRyRxdRFGSHNvajvcURi4ZlyUrjwdo9PLJgOq4j1MxSuG6SLkgm
 dN1w==
X-Gm-Message-State: AGi0PuZk/nL/libx8gT+Obf8Mbrz82wfRxL7JDfJEcnp1RRMUOWuHHJt
 I4wrkclErJBWEZSP8BpcGSI=
X-Google-Smtp-Source: APiQypJkteY0GB4Ixe8SKb5pylA9uOBxIpxfn9MuD0RKqBEEglTvx3ix+Os8WSpiv3oLvLm2C09W7Q==
X-Received: by 2002:a63:9902:: with SMTP id d2mr4916684pge.8.1586734363845;
 Sun, 12 Apr 2020 16:32:43 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id s137sm7273612pfs.45.2020.04.12.16.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 16:32:42 -0700 (PDT)
Date: Mon, 13 Apr 2020 07:32:37 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] gdbstub: Fix segment fault for i386 and m68k
Message-ID: <20200412233237.6xxfvtdnqkp225yo@mail.google.com>
References: <20200412104421.77975-1-changbin.du@gmail.com>
 <df254e55-88ba-2d49-7397-c68562367f4e@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df254e55-88ba-2d49-7397-c68562367f4e@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Changbin Du <changbin.du@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 02:58:56PM +0200, Laurent Vivier wrote:
> CC: Alex Bennée
> 
> The one for m68k is already queued by Alex.
>
Great. I will send x86 fix only. Thanks!

> Thanks,
> Laurent
> 
-- 
Cheers,
Changbin Du

