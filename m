Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7AFC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3328A24BAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zodOGo0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3328A24BAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXpf2-0004HI-7Z
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:18:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXpdf-0003if-9B
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXpdd-0004aw-BR
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:16:47 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXpdb-0004Wh-MR
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:16:43 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so1638131ote.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mE5DSrBtBGhQY9i3DjoPOfCYZJSgEWCbxwxI/353LqM=;
	b=zodOGo0Q5y+BEWhBkHgvZmTMPNg0iDxIwQV+nRqLVmfR1y+45HWRor/xu6p+BsL+IA
	MPmdmMBTKvlgcX4XU+NCNhWG3f3KrXB9kJjelON9TVIp7+dJgEIihpmlEyra9wUZYbdY
	7okR150Yy7GbyQd1EzPUzaTp8VNdKDyeXPrVItCRS9gXoEBjPzZThOwcihTIL+7UWaTA
	EUgtwY9PNUm8BS8QEgjaJqfQL/miK56tZtHkam35YbO65A8yo4Wy0TLklKFVHq/tCUKG
	zukJS4F886ndGq96/A8n1HTRPDuWLIQ2QP1cYUPPK0hs8Jg1ta4ucrYF3BlqAK+ovSIC
	xMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mE5DSrBtBGhQY9i3DjoPOfCYZJSgEWCbxwxI/353LqM=;
	b=ZXVfEMEXuB5W8o0uRrDOg1oe3D8Iqx8pbO+lREwI6hnj87unaJVmct02UWIPTLg1cc
	y3ZKawyDiPqlbquXQO9cOOO4Qn3U2G2v0TIsCVu3wjaKqUuqiU1mq3XCQHSpRJGqlapC
	1V2odX0QvVokJNDzhfrpzXZW77fcZsDTdhQARKKT0xihdYD4Th7O6eY3P7gK6mzz9kQ7
	p4fWXWnOf//D4mQ1z+VO5rbRIvR4WBE1BDmiqkS2eu9LhVmfKbq2/n3aixrus0RTMtRd
	nQm1knfUmewcRmqd8xXAuPqZy/4U6CpFoK+sWUnsHE4ZbQqmx7KsYblgkV86gqzWdUYJ
	weRw==
X-Gm-Message-State: APjAAAXce9g9CT/uV/ehJbbVdjasN3BVC6zh3h23+Qb7X1z/agxjpTpU
	9aA17LWH3FHAFSvmg/OWXJIPTQ==
X-Google-Smtp-Source: APXvYqy4zZs/798Brd06JU4ZlbEbBOUOscG8NeJIEao+iu5W3ge4ntGG7kd/b86YhblZ+Ol3yLm2YQ==
X-Received: by 2002:a05:6830:104e:: with SMTP id
	b14mr1769929otp.264.1559578602263; 
	Mon, 03 Jun 2019 09:16:42 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	h12sm3790530oti.71.2019.06.03.09.16.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 09:16:41 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190603090635.10631-1-david@redhat.com>
	<20190603090635.10631-17-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cd9fb59f-2e31-d2e2-1a5a-04f1e4bd77f7@linaro.org>
Date: Mon, 3 Jun 2019 11:16:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603090635.10631-17-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 16/22] s390x/tcg: Implement VECTOR FP
 MULTIPLY AND (ADD|SUBTRACT)
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
Cc: Thomas Huth <thuth@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 4:06 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  4 +++
>  target/s390x/insn-data.def      |  4 +++
>  target/s390x/translate_vx.inc.c | 23 ++++++++++++++++
>  target/s390x/vec_fpu_helper.c   | 48 +++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

