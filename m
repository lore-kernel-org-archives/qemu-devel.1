Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32AFC10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2DA2084E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2b5pCqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2DA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44587 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6bK-0005xr-Rh
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:32:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6aG-0005ey-ET
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6aF-0001Bg-HE
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:31:52 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6aF-0001As-3U
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:31:51 -0400
Received: by mail-pg1-x542.google.com with SMTP id k19so5948402pgh.0
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=kJ0N9oNuyXWBZ15FcJ398STCVgsXd08IXozWFZ8tAsU=;
	b=L2b5pCqE2TXKHI2of1ZymvpWywErE9TgFmlUUcAIZiXMwL/SWPBKz/jKDP9UzEBH1W
	tMd6S3Enuae0r/sDvA1d5w3cZpk86C0CrVRkQ1G+BPVf0joh0ma5dJxHEvrDdNRsAgWk
	gn9hJwiMD53V0KOHTSq6x25B++BC89uRpOCveeQvHSsb5fX2qGZZabnvPf2H22y4Rm4+
	4QOLacAkhC5xNuEPPe3+KgFVLRRELFSlkh6AXa1AgRTb6sFgEeIOmXuszTEFqdxoPye1
	Aih0J2tXarsamyBx/T1pMdV5xB5rmv5FtwK9VZFRWtAWjBmga6ToFLy5XrdV4gXhu37+
	zGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kJ0N9oNuyXWBZ15FcJ398STCVgsXd08IXozWFZ8tAsU=;
	b=RQYkGNtni9gIC3IpF4mEe8/V/1zkaG1QKBaLfyT3qez0TOQa9rwUkbg4oZ6bao86kK
	7edx4OJme+TkxZgardKZUQYESljJW3wm1EzBMUvshmRzYiNBDTWWB8Mead5MuNHomKUt
	D9AzlsSuXrMjGNj+VSzryCmBgHP6Ex0qqssA2NeNVyCOjVP7Nbw5NFi22DlJRP0i4zlC
	Lj19PL45CzMhqAD4l60yJ12GkB7lCC3Z86dPhNncbnzEaIGsuUpbutD5Pm0HoEYYkfQr
	h9B6yzjjAtNYFhSV8LHvMdXCTZu3cV+uUZ9bxM+LFG2MpQlPyompPpphJn3NHSXnEEEr
	PlEg==
X-Gm-Message-State: APjAAAWM3Ceg6R9Sh7XSlgpdW1gG0X1V7QntdVXa7SbrW3NEDXE8IR1G
	nQRqu67Xukjd+n9b5vtiQK+Ckg==
X-Google-Smtp-Source: APXvYqzIJy6akq4yyUplmsOK9s7m64t9yg3gsADKBC2vg5UsMDUSv0trNANcl42CUbSx60EwaM7JmQ==
X-Received: by 2002:a65:408b:: with SMTP id t11mr53352228pgp.372.1555115510176;
	Fri, 12 Apr 2019 17:31:50 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	t129sm58034698pfb.127.2019.04.12.17.31.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:31:49 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-30-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <07c96b48-c3f9-096c-1cd6-d95bce3c3ccd@linaro.org>
Date: Fri, 12 Apr 2019 14:31:46 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-30-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v1 29/41] s390x/tcg: Implement VECTOR
 ELEMENT SHIFT
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
Message-ID: <20190413003146.ZTL4QEbq9j4lr8YyTTeNUfRPBiFr6ZRY2G2u9NMpBIQ@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Only for one special case we can reuse real gvec helpers. Mostly
> rely on oom helpers.
> 
> One important thing to take care of is always to properly mask of
> unused bits from the shift count.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  18 +++++
>  target/s390x/insn-data.def      |   9 +++
>  target/s390x/translate_vx.inc.c | 113 ++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   |  99 ++++++++++++++++++++++++++++
>  4 files changed, 239 insertions(+)

Again, I should fill out these in gvec...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


