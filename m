Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD41DC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C352081C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqmgJzc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C352081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2fe-0005KS-Dj
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:11:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT2WT-0006eb-CN
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT2WS-0003NY-4n
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:01:33 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:40418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT2WR-0003Mz-Ud
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:01:32 -0400
Received: by mail-ot1-x329.google.com with SMTP id u11so15898100otq.7
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=i3pmNUokdSPzrXl5GpdoEGmFzwFoMlpkJKZfb60Rdt8=;
	b=lqmgJzc3XST3HFyp3UQAKywhj8qqcdtvSqNFOX+uxTf/brpTNOCqNFA2uUXyb1KrNt
	g62+yOrEjCQ9dNkG0PQ4I3vik0hSgtyNwPiBX1fLYSYrd1mud7lB4Ojx0pzJcUw5+Z0y
	/wPFW/VOWD9X6CdEag2Kiut6MEMHeK2IIF588RkmvwhaBrxNGKMeIHD5WzAZ454mr6t+
	1IPVXKbI8mh+5Aaf5ORFjdpUJ46fXaVvU+3LCNZdajLSMDVL4LJDZWzmE017rVlorH94
	5w3mnNTEbHvZkC3gzAix6HSr64rfmBjTubhujFIalMzLEyQc8+NHEK9ZRiNf0nrqH1xy
	qPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=i3pmNUokdSPzrXl5GpdoEGmFzwFoMlpkJKZfb60Rdt8=;
	b=h12ehbiZ4dALv+2tVnKLXzY1Oz6z94ddBPohAWuulXkeOchRBTL9HCEkzEDgCAhNCm
	DmkQFkNQnSbTP8S3S/aMsgwPivdDI8qOjDShDr+qKtOpC9eQ1BFR7Zb3I2A6S/qnfQcb
	Jf7L5fh658Rf++EoFpDAUm9QUbxUj7A6ppDklhPZMsgs4MFORf3WMJLMYqyYs3RpKgS7
	YCz4so4W91ZxWufNK2e8xprGaoVjyPTaY9hpamAaiD21KakE5dvnvSSL79i/zWytZ7xN
	F/sKXTaDBaHK+CwjA90FPb73NViKlalbSQYumRuuXbHeGLif35LEVyEQCePy1+p4+NC2
	Eteg==
X-Gm-Message-State: APjAAAXlDX/HVnIVJeQoXBE4ZOwWV1j17/dJHsKk8IfdIGhOv6oBR6QG
	X2S2JxKGzuoYTzJ+NCoS1QG0k6R3Ljztxs9A1XewxQ==
X-Google-Smtp-Source: APXvYqyhuKTdxxjlf0ZyG4RLQGFji0MJCzCrqptwbh+IGbDI5b7pcSjtSCeNDodUGGIwGFG/07B4YqS06Fx96c5DzKk=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr19251062otq.221.1558436491278; 
	Tue, 21 May 2019 04:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190520175837.4561-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190520175837.4561-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 12:01:20 +0100
Message-ID: <CAFEAcA-RRZ+GC6FL2V7U09SY4zUA1rE8f9JvM-3XQ2sLRLj1Ew@mail.gmail.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [PULL 0/9] target/xtensa queue
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

On Mon, 20 May 2019 at 18:58, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following batch of updates to target/xtensa:
>
> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20190520-xtensa
>
> for you to fetch changes up to b345e140534ea17814b02bdf8798f18db6295304:
>
>   target/xtensa: implement exclusive access option (2019-05-15 10:31:52 -0700)
>
> ----------------------------------------------------------------
> target/xtensa: SR reorganization and options for modern cores
>
> Reorganize special register handling to support configurations with
> conflicting SR definitions.
>
> Implement options used by the modern xtensa cores:
> - memory protection unit;
> - block prefetch;
> - exclusive access
>
> Add special register definitions and IRQ types for ECC/parity,
> gather/scatter and IDMA.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

