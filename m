Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDE9C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49212084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gX82N1zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49212084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDx3l-0000ox-Em
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 16:09:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDx2u-0000XR-GM
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDx2t-0007JA-Bl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:08:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDx2s-0007IS-RJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:08:39 -0400
Received: by mail-oi1-x243.google.com with SMTP id w139so14659427oie.9
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JR/d0CcQIOP0QjsLQybbFXTBU7ILZzpr88JcAPho/4s=;
	b=gX82N1zo++KUvSLNzQMoijdPK0UNKf83/3B8yN9eUkMD3vrzFGcca/KqyCbds6H+Nf
	b3r4o3iwU6etj3WQvfW01WDRHCdR8R6ncH/qyLQwFDVEAOnN4OzFdZpt9k774eAa3aPf
	GmE2HM5apGIgAR2jWpyd1Z8XF5S6O+NQbZT1h65bQBYFX03PWXr713RG6CyRh+CBCwIQ
	kw3kgrjOlKIHExmL7Uce1pXIqTjbj+MvFSCiwX17sAoA6yK5hz5lD5cvgYb4ECw1yfJo
	Fu6lzJYXLMJ1Xga2k7V9Bq3SuYGvZHgGi72EtIjFWX1CZdqd1AQSNXBcBS3uCA+JnoUk
	RKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JR/d0CcQIOP0QjsLQybbFXTBU7ILZzpr88JcAPho/4s=;
	b=sQrmSEG6xajiYMBIpo9p4fjMx1xVypWctukkIrAjiAMeZzWfA0nKOet94rca/r0Xdv
	jLOvPeckh/P8EPP2LmxE5iyJE4KprnEoY31geu7nj+6LGtzvfLFME1MVUkTl9g30PXn2
	+5RSihIsUDt6cg3ZUon2UE5Bmn1jQ8UI8R3VYld0z5Jr1O705POYOpD4Xx7irKTJSyzx
	zBuspMgmvvYX3nmZ2nQUp8bhJriLjtDWXE2atFzx4sq4fl7cbFe3FbSXeCqhazHiG0p5
	XRDofEbuom0o0ZIs4mftep1P2nz7sKQDBThGVZcNTAyk5veezOkR23VYdy93fjjvuO6b
	dSRA==
X-Gm-Message-State: APjAAAU0AnlmuwgtR8a6AlzjxI+q3qfqzh9w4lzj2zOIj4KPGoGWNgP2
	qeCRE3KmFdUibJF/8i6GpUqTfj9NB/ALsQJxlzV3AA==
X-Google-Smtp-Source: APXvYqxfx1K0m++wvO0Jo9g9HKO5WgSGKxQDnal8+ohgCAS2SS1tYB/LZ0t/jRWK4Y+D8DlvhBdCAPz2I0lD98jdIHM=
X-Received: by 2002:aca:e054:: with SMTP id x81mr110454oig.146.1554840517417; 
	Tue, 09 Apr 2019 13:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190409174018.25798-1-armbru@redhat.com>
In-Reply-To: <20190409174018.25798-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 03:08:28 +0700
Message-ID:
 <CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409200828.8M0YgeEzrEZw8kJlNZivu_qudQBarjQRQW964icWi1c@z>

On Wed, 10 Apr 2019 at 00:40, Markus Armbruster <armbru@redhat.com> wrote:
>
> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> computation of @dt_size overflows to a negative number, which then
> gets converted to a very large size_t for g_malloc0() and
> load_image_size().  In the (fortunately improbable) case g_malloc0()
> succeeds and load_image_size() survives, we'd assign the negative
> number to *sizep.  What that would do to the callers I can't say, but
> it's unlikely to be good.
>
> Fix by rejecting images whose size would overflow.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I think this patch is missing some attributions for the
security researchers who found the issue initially.
PJP's patch for this from a couple of weeks back has a
reported-by credit:
https://patchew.org/QEMU/20190322073555.20889-1-ppandit@redhat.com/

thanks
-- PMM

