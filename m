Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01517C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC984206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1U4iqu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC984206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO25m-0004YX-27
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:33:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hO1tw-0001Ka-9o
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hO1to-0005KB-9z
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:20:59 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hO1tl-0005G6-Sl
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:20:56 -0400
Received: by mail-pg1-x544.google.com with SMTP id i21so8462298pgi.12
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=8GQCTCi6FQCiA8yJ/BYy6tKyf9cs5j3L5/oeRONp0wA=;
	b=k1U4iqu2W++GrGnmjgkc1nkgPc7KfjCdZTl0efy7qqA3CLs2RI/upU7RoxoVhlhg3r
	vx5Eimyx0bNzbNb1B04ry3tihl8Jsq7CY2mxIEDXrwKsZuAm6gbx1IPmsBiJGcHszLux
	lwbSbz3LRWJicUeEdKwlWPi3HHmaHWb0AJR2D31UC2Y3JeK1I92v6JGwP7iWx/L00gGy
	Yok1msJqtl+TZl1eVM3Vi5Uvd+96rpdVTk5rbE/h8S964nhWPWv89vETkKRpIqspznhU
	j7JvqzZ050xWIA3EwPincOa2OrhTi40Mf4Ux915nugADtI1bmE34ljrvr40Ik5PQWksA
	/U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8GQCTCi6FQCiA8yJ/BYy6tKyf9cs5j3L5/oeRONp0wA=;
	b=f2WmWxQ1/XCDygH8GgWRLQkCNVFPesSv+t1LSy6OLBDezY/XoEyx98z5LzkFoNaqEu
	VtpSIO7+OSV5Pj7U1gHMLZA1G38WUaRTYInTxEtexy42RFC1Vl8wO3r5fh+zl5iRXgx4
	nL3Jd2OBEyEnCWX+C0bSjiDR3xlHGP6tK5mdbr6PeKjoBVbFDSi2BTw8XLPnEVflem1B
	W8V8rxeehsvX3ADgt/HziMUT24b57N0BKK0MOD91t2JQMoGclAD0sgeHYouv1dU4GItS
	3/qoFcmmLAF5RIFgpLjUlS1oZ6Jxdk4HMCX98NMO8lNGmk8kQLZbIt7cnSiSnXSeuEhn
	AIbQ==
X-Gm-Message-State: APjAAAUEwKXczJaFcNCNqLQymxh7juntVLUTNgIJvt9wgkYLQWYDe2d8
	hEZqXyE/qTtWJfP9cxg2Wjajvw==
X-Google-Smtp-Source: APXvYqwRNL6KirCrM0FsxDRUFWYLUVLl5OnwI+PVMmfObH4esm1lMvR/WsVpT9IcgdJ/JPFvEz+ZDQ==
X-Received: by 2002:a63:6942:: with SMTP id e63mr39643272pgc.102.1557242448673;
	Tue, 07 May 2019 08:20:48 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	d15sm18137750pfr.179.2019.05.07.08.20.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 08:20:47 -0700 (PDT)
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
References: <20190503154613.4192-1-kchamart@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <11de0045-e015-1a02-8366-81e30d5b5395@linaro.org>
Date: Tue, 7 May 2019 08:20:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503154613.4192-1-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] VirtIO-RNG: Update default entropy source
 to `/dev/urandom`
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
Cc: amit@kernel.org, rjones@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/3/19 8:46 AM, Kashyap Chamarthy wrote:
> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> source of entropy, and that source needs to be "non-blocking", like
> `/dev/urandom`.  However, currently QEMU defaults to the problematic
> `/dev/random`, which is "blocking" (as in, it waits until sufficient
> entropy is available).
> 
> So change the entropy source to the recommended `/dev/urandom`.
> 
> Related discussion in these[1][2] past threads.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
>     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724.html
>     -- "[RFC] Virtio RNG: Consider changing the default entropy source to
>        /dev/urandom"
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  backends/rng-random.c | 2 +-
>  qemu-options.hx       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I would also like to point out

  https://patchwork.ozlabs.org/project/qemu-devel/list/?series=97063
  "[PATCH v4 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"

Which, if used in more rng backends, would remove direct use of either
/dev/urandom or /dev/random and instead be handled by one of the crypto
libraries against which we link.

Which in turn may be implemented by getrandom(2) instead of the legacy /dev/files.

Which would, I suppose, deprecate the file= option entirely.


r~


PS: I'm not sure what the difference between backends/rng* is supposed to be,
and whether that distinction is relevant.

