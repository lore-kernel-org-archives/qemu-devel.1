Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19034C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AE12075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 05:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wm4QfZyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AE12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM3pg-0007eX-0u
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 01:00:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hM3oo-0007GR-UN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hM3om-0005M9-Bd
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:59:38 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hM3od-0004d2-74
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:59:29 -0400
Received: by mail-pf1-x442.google.com with SMTP id z28so542015pfk.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 21:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ovGO+GzjcQWvIJziFUmPcYAhqzAzAlEkW/IQQtjAylk=;
	b=Wm4QfZyMQeBFv7/fHndIspvcJmI050gf8EALbOQnAxFNFh0DsFbCObnTrHsmH5R9Rk
	iyQJ/t7xLLIEq2rVI6zppo2bZPrsvSY0n7kIXdbLD4/VhojYH3F0vhOc6Hd2PfEh0eyq
	VtLH7mYDAYowRra9kZMw0n30m7bReYGx734pTsI2yGjnufdr6VyExJ5PyNNRzC+NsiWs
	UwilJp2UlFhon0V1mjHAXQRwVE+vt0+76fy+y6vwxiGsOEOscvIBp+nwGgpAbqLKnA7G
	fvLAnnrlb4QNwctzkfVEbS3JGQwke/4SAO71CpgB7T30CGoVzTFABGHUdy2guAFwUuw8
	lrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ovGO+GzjcQWvIJziFUmPcYAhqzAzAlEkW/IQQtjAylk=;
	b=X7RnwoABTPOLiLGCjo3lkdUo2sCG0NYBLRVyrJx4kCOKm6zuqWXlEMlDnhzp0nB9Ow
	ET3c/rVu8s1ml4YMIxoZ0GQoKGiZivNv3GrZycTccNLOoPvWk0GgOtreWsZAnup/nume
	c8VSIigscV7uFQq2ZpZeOzbrrNALvO5fgVat/OecLiMzfirOQdlpbMc+j0UEqboi0whj
	wjLkKjaQCYJHE3M/p7wI/Q9OWAkGaMyX284NXnRSQVGaNlxONGsalabohXgj5Ms4o45Q
	jMw+7GIENQKHmvqef/LUaQ1eKIcqwPipyD2s9EP1kAafDdvBIF4LlAleBm0lpmMeBYWN
	HXBg==
X-Gm-Message-State: APjAAAXGJ1BOIQPPcv6U1uSoiGCSGKmoZ9YCunX/ueu3h2YzS/FLAp9n
	/ndK9uyhzoyAN2MqEsfRuoN1NQ==
X-Google-Smtp-Source: APXvYqwyHvRKFNr8UVmegJFSWsSckjfmd5l30QsQvPK/TZYX+OsCFUmhE8ooa/XcGaCOwzD+Ct+3Hw==
X-Received: by 2002:a62:1a84:: with SMTP id a126mr1905821pfa.52.1556773152233; 
	Wed, 01 May 2019 21:59:12 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	l188sm626495pfl.108.2019.05.01.21.59.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 21:59:11 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190502040459.GE13618@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5aca63b1-72e9-9402-8828-d2dd054b3313@linaro.org>
Date: Wed, 1 May 2019 21:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502040459.GE13618@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for
 ppc64le
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
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, alex.bennee@linaro.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502045909.RuJRjLr34xGC2HI6uOGcRFpb9ygpzSv0Wlw7hGhadOY@z>

On 5/1/19 9:04 PM, David Gibson wrote:
> I've staged this tentatively in ppc-for-4.1.  However while it removes
> the "Invalid ELF image" message I still get:
> 
>   TEST    test-mmap (4096 byte pages) on ppc64le
> test-mmap: Invalid argument
> make[2]: *** [/home/dwg/qemu/tests/tcg/multiarch/Makefile.target:35: run-test-mmap-4096] Error 255
> make[2]: Target 'run' not remade because of errors.
> make[1]: *** [/home/dwg/qemu/tests/tcg/Makefile.include:71: run-guest-tests] Error 2
> make: *** [/home/dwg/qemu/tests/Makefile.include:1079: run-tcg-tests-ppc64le-linux-user] Error 2
> 
> Running on a POWER9 host.  Do you see that as well?

Yes.

It's a semi-bogus test, really.  We can't run test-mmap
with a page size smaller than that of the host, and of
course ppc64le uses 64k pages.

This needs a different set of cleanups.  ;-)


r~


