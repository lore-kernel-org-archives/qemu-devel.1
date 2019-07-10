Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74262C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCC220838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsWG/clM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCC220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl88c-0002ue-Dm
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 04:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59004)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hl87u-0002NE-H4
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hl87t-0003jX-MC
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:38:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hl87t-0003hB-Fd
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:38:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id h19so4101658wme.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0qgvnQJsm4ZzzK9Mc63vPLRegdkd+F+aGSI1jgLMHM4=;
 b=NsWG/clMwdEDY54JVTHe/gw2hFOsjoxT33YAjEpiZGyYYrYVt+/WOnXbCDp/N76k9Q
 pfobEdr0ZAggLrejDIxAtgnw89jt6DlZzX0W/ia+nER0xBdGeUK/tGgNk6G7i5jRB3st
 jZg24xD1GwtMsqPOo/T4JvCva6QG6xbbzfN/IS0t2JXFzd+ifnsBgp0FFRyMjX6NXYhN
 TMtqEslmP2frXhuFJ24K/TZ0yCakAggnVDtRftIL17Tnzr2VozEjT0uTvcTEWV5uIMFB
 mpQgFhnKs1F1IvAyLWu2hyp88gCi46FIIWR/9QJvVYXpKFLnAcI5mlfUI0YHTVBXRhPP
 gmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0qgvnQJsm4ZzzK9Mc63vPLRegdkd+F+aGSI1jgLMHM4=;
 b=HHER4o9tdOo6BwqvzD8xwMOSXoEJvHpJu0zqLpwOKQ2KZ1DK6ijc0YG30ZIPnQpqtM
 j0IrXxwCq+D5VFrPfvYHDwKdrWRhTfbUzmFmed49pl4g8btRVwPtOXN+sDjmPxjfd/wk
 XOkV4P8NBChNQbMIDME1E3eYcDqn5xSlHkeAsrs+zD7Ydmq4S2GNxvpVypTRVrcYCM//
 CkuIt/pxHvcljGw+aw41vmwH1ywMQEUIagKff1ad4zJzp07477gofX7bZHY2Af3a62Z1
 koCacuOytBeWBtlbYeoqCAx1hSpz9xRngBaabyoKBfekar+gbpQi851tRYFjPEOdtsc5
 OiYg==
X-Gm-Message-State: APjAAAWhdGKI/zZMwh/pLWaEXgICwzIL24WZVucQX1lX2VKNrPZ7I99g
 exQ23WwEfJjR312PeHDI/O2Abw==
X-Google-Smtp-Source: APXvYqweJZ8S06NxlAptElxYmjhUqVPm0hTWJhf3jrsnjwnm1nuFCScleLKfnWoMuGdI27L2rnGtzg==
X-Received: by 2002:a1c:dc46:: with SMTP id t67mr3715367wmg.159.1562747935698; 
 Wed, 10 Jul 2019 01:38:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p4sm1494168wrs.35.2019.07.10.01.38.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 01:38:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B2DC31FF87;
 Wed, 10 Jul 2019 09:38:54 +0100 (BST)
References: <20190705160421.19015-1-alex.bennee@linaro.org>
 <20190705160421.19015-4-alex.bennee@linaro.org>
 <b42c405b-1b20-28b4-07c0-24df9a183e16@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <b42c405b-1b20-28b4-07c0-24df9a183e16@linaro.org>
Date: Wed, 10 Jul 2019 09:38:54 +0100
Message-ID: <87pnmie129.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 3/5] tests/tcg: fix diff-out pass to
 properly report failure
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/5/19 6:04 PM, Alex Benn=C3=A9e wrote:
>> +diff-out =3D $(call quiet-command, diff -q $1.out $2 || \
>> +				 (diff -u $1.out $2 | head -n 10 && false), \
>
> What about (set -o pipefail; diff ... | head) ?
> I think we already rely on bash, right?

I don't think so - we assume POSIX shell for configure and AFAICT we
don't do anything special in the make system to set the shell type to
bash.

--
Alex Benn=C3=A9e

