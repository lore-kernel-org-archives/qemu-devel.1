Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2ECC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 22:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0562086D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 22:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRAnMnr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0562086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43505 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF4n5-0004nH-PF
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 18:36:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4mD-0003xq-Mt
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 18:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4mC-0001yH-PM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 18:36:05 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF4mC-0001xa-DN
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 18:36:04 -0400
Received: by mail-pl1-x641.google.com with SMTP id bf11so5758612plb.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=PZCeBjItQInoElzrGaMI+DiLYZvS7zxqbK+0CB0ZXqo=;
	b=mRAnMnr79fI7GPRvH4jGPhk1zdHHLvUPkgCi80zGkXMdD6UygHaeGoYlKMikcwEBlj
	tXEF3J9wTjXO8MljdVG0TJkLy9gcZoYNRS7mLeRx8cHaymI0WTr+6lEwl1DzQ/A92d+E
	z+dm9hY9TUhukbqZiOOjfvH3u3czs/8FMT2lqD/nxONuOSw6dw0NyAfgkDywWXQmKjkq
	0Tm5XoyZ9ZOrS7Hzg3Zqr76fLD+Ot695Jp48kVHko4EWjuHdEWu7fr3lVZNtrrvMAFih
	Bh/i7hotqnB2cGRJ5sXP7mwa8DqChRL3OWPmcopWb7lFMdVN+/nQfY8SGa3IHo8nFx+6
	r8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=PZCeBjItQInoElzrGaMI+DiLYZvS7zxqbK+0CB0ZXqo=;
	b=ftVnLkK6xnzR8ifFGvEWctdvJ/m+e/QO1CbS5Pc9nIumPvXIzdbMYXvWsOSXgbbH1x
	CDFhBW2SIYiZGlYIvyIZm76J82e9e5/QNeKt/LVr/d/yGhhlVisVGVjEdvSfgtJ/tKuX
	ChiFnMykaK6BimOJ0aSZCcBcWfw7hW5xRhp5kcr1blZ3O29qWB8BfNovFEJmYQuRpW3u
	Ss0R7ojYv3j3tdTR9w7edBSGFg1LZtYTnKRqXe6Wq53ckokQSZD9G+Y3OwqIMbJTP1cj
	a+PCSiSKLN7ZwZGga7BxhUHHd5g1A0unHAUiZWrt0n0I2E4dLkrNLrRRqXsqfMHPVBT9
	SFHQ==
X-Gm-Message-State: APjAAAWnDL0T6r85xpnxO1Rqrg1ZWQutwhcqwbd4ruiUfHJ364PCx/zT
	qhttNQ/o4QQ+MNYtWmfsfSm7tQ==
X-Google-Smtp-Source: APXvYqxH+EQz3zGoPN3lw/CD+rDtvv9qMED9wQVRRNQ4oARYMWx/6DoSkXB8Vq1YZzSrkNrBIAe/VQ==
X-Received: by 2002:a17:902:be09:: with SMTP id
	r9mr57964800pls.215.1555108563197; 
	Fri, 12 Apr 2019 15:36:03 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	p81sm69992106pfi.186.2019.04.12.15.36.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 15:36:02 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <60923e15-5529-04fa-125c-0c2adabbaf87@linaro.org>
Date: Fri, 12 Apr 2019 12:35:59 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-9-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v1 08/41] s390x/tcg: Implement VECTOR
 AVERAGE LOGICAL
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412223559.rhE5ZVXcuuQ5_WacNsRw2z35nrVgWm_JyXwN179AkqY@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Similar to VECTOR AVERAGE but without sign extension.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 48 +++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 16 +++++++++++
>  4 files changed, 68 insertions(+)

The vector expansion for vavg applies here too, except with shri instead of
sari.  And of course you code is correct as-is.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

