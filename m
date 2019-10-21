Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD2ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F572084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F572084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbBv-0005bo-GM
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMbBA-00059g-Vg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMbB8-0006GV-Cn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43393)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMbB8-0006EZ-7H
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:09:10 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2E5EC04AC69
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 17:09:08 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id o10so7628039wrm.22
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oG/4Ft2nwDmu43dRz229mvV+iGdJe44EzN+PQDOEsRI=;
 b=LTDnsSmXaaMhULxsOb0PVmdWGk8eoULPcMvGHSfjCo3iuaFk2Q63/QNtJdiiLVEei6
 TZsvgWXqKE1pmdQdKSJzIMxDXpBY9W7TLCAbZdmUyFBVxhymXXNJZtWV3fdAtqdYqtBH
 BdJdsQDEu1VNRmT0fmdTRyrOqsojonBNXxIvpFKKQjnXk47DIChqM5vhSEmZ3fwiLLxq
 VIJgga7hRE9mOD6evNdGo/dJAuNNh2Qf4yPC+q+vjVdZTxwk0W9HGlmTin0THKvkpX33
 MZTKh68/vhK6lcQkGVCD/7ou6uTG7jI+6ksuOR+kbSCQsw0mFYTs3iiQvB5ulcqDrU4M
 hsbg==
X-Gm-Message-State: APjAAAW8pL/+3wdvvEkJVbXhuB6hku/uOITMoVuXgcrRcLV26dL91PrQ
 WktgMa0VBmKUX7r1GFR4WmJQx77z7i7lHM+umeQvC7OWI1a+0CMiX1V9InwUJ+mGRMFvL1u3Ry5
 +HwTn9pCNJPeqV48=
X-Received: by 2002:adf:a547:: with SMTP id j7mr20469905wrb.154.1571677747445; 
 Mon, 21 Oct 2019 10:09:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdi60utLoAcuRQgWWL6AS+UU4OZNoGL3vtf8hBKroUqXQvzW+3UpXDc+3fovQrxYhOjZ7wzg==
X-Received: by 2002:adf:a547:: with SMTP id j7mr20469881wrb.154.1571677747199; 
 Mon, 21 Oct 2019 10:09:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:847b:6afc:17c:89dd?
 ([2001:b07:6468:f312:847b:6afc:17c:89dd])
 by smtp.gmail.com with ESMTPSA id u1sm15793245wrp.56.2019.10.21.10.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:09:06 -0700 (PDT)
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <CAFEAcA_PO7vaxGVpfW2bqRvB9XtDA8uk_6Tw7SauwrbHfJOjxw@mail.gmail.com>
 <20191021164611.GT4336@redhat.com>
 <CAFEAcA8O8vb9Rauo99Dfqg3X63VEANcqjAqwJeXUEvAy3wHXGA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ffe59d19-dc2c-8d3c-de44-b5191fe3855b@redhat.com>
Date: Mon, 21 Oct 2019 19:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8O8vb9Rauo99Dfqg3X63VEANcqjAqwJeXUEvAy3wHXGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Claudio Fontana <claudio.fontana@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/19 18:55, Peter Maydell wrote:
> There's two parts to this:
>  (1) is what we say in LICENSE what we actually have in practice?
>  (answer: clearly "no")
>  (2) as a policy, do we want to be stricter about the license
>  for code contributed to tcg/ than to the rest of the codebase?
>  (which is what this patch is trying to flush out answers to)
> 

... and from these points of view, your patch is definitely an improvement.

Paolo

