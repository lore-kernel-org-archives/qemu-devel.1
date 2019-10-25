Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E67DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4598621872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fihWnzUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4598621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6f8-0000GR-Ki
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO6cJ-0007Zy-IS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO6cI-0002M9-Bd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:55:27 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:40696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO6cI-0002LR-6Z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:55:26 -0400
Received: by mail-yb1-xb41.google.com with SMTP id d12so1455122ybn.7
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F+cqaKV9NxF3xHqGha8zUZqlSPpzkiq6PFuMuKFS9wo=;
 b=fihWnzUIYMX8oJIry8N1uFX0Jxiuye3vhbuiO4gOMGiCB2GexPOetusPpF/amKaEI+
 CMOby8iFLTM/oRErmEuNkag1Niii6WGRF0ayJzsudbwEd5MSDMvTsuedf24AgVNDXRrg
 FAc+e+feghHAlv94StG/v833A/zn44s5JPUe2TZoBlV6R5C/vbgkrM+swYDuEWFmhWkb
 R/aT4qRwf3w2VyNue2CjwnDwGYIVSihfE5nrtHXMVyOddzMHU0QS9dsfE/vteQcB/S/M
 RDFjbGKvXSPWPYc6cogAOTzXVF4ZJMsVvfIhz+tp6A4iqtLV1KPSMJSvkpV1zxTi0zSd
 PVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F+cqaKV9NxF3xHqGha8zUZqlSPpzkiq6PFuMuKFS9wo=;
 b=kBGc0IFcYpRbPI0vmemK/5mjWMR+9+Fe9UT8xB/+Rw0Dab3A9ABFQytwVfcicd1/T4
 mp3w2YsrXZ7gUq4DAeENW5nZn2t6jMIXXGQybiMCfZmC5hMCnNzuliqklVrH7kso5SP8
 Mc3gJa1SAQGn8vJchsfrvFFXKP2joJovhWCihZv6xSnvCQwgAbU98QhaM2AB8z8vmopL
 p0ZqHjERwduCprMz8ynf98ye+FdfYKgiZmVvelr0WuK96h8EtUAFQkk/v2mUw7yVfLIy
 hldDJ1uW8JazXNm1ZMzYqOLeg474EZ8+3nC3aBimR9//K5tcpKTMudd/ch5I1zjWdtRU
 bFow==
X-Gm-Message-State: APjAAAUnBlObmQEbPZ1onOJCjEdfnzlUrzNMJqUfVvolGEyJ+JEnAPTw
 0IkvWEZ8+l1ZEIvgxC8ocQ4kpw==
X-Google-Smtp-Source: APXvYqy/HLcLvEJdqE31hIG0Nw+2weZazF3AABU+9L1M3h+AQK0Z52RdatoiDHJtaZTIG8EeVj8FAA==
X-Received: by 2002:a25:df4d:: with SMTP id w74mr5041984ybg.513.1572036924217; 
 Fri, 25 Oct 2019 13:55:24 -0700 (PDT)
Received: from [172.20.40.202] ([206.121.8.178])
 by smtp.gmail.com with ESMTPSA id q131sm1411218ywg.60.2019.10.25.13.55.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Oct 2019 13:55:23 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] tcg/LICENSE: Remove no-longer-true statement that
 TCG is BSD-licensed
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191025155848.17362-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <10107792-8aef-533e-93ff-39c636eb4691@linaro.org>
Date: Fri, 25 Oct 2019 16:55:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025155848.17362-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/19 11:58 AM, Peter Maydell wrote:
> Since 2008 the tcg/LICENSE file has not changed: it claims that
> everything under tcg/ is BSD-licensed.
> 
> This is not true and hasn't been true for years: in 2013 we
> accepted the tcg/aarch64 target code under a GPLv2-or-later
> license statement. We also have generic vector optimisation
> code under the LGPL2.1-or-later, and the TCI backend is
> GPLv2-or-later. Further, many of the files are not BSD
> licensed but MIT licensed.
> 
> We don't really consider the tcg subdirectory to be a distinct
> part of QEMU anyway.
> 
> This patchset adds explicit licensing/copyright comments to
> the three files which were missing them, removes the
> inaccurate tcg/LICENSE file, and updates the top-level
> LICENSE file to be more accurate about the current state
> of the licenses used in the code in tcg/.
> 
> If we want a policy that tcg/ code has a restricted
> permitted set of licenses, then we really need to have
> this enforced by checkpatch -- history demonstrates that
> just writing it in tcg/LICENSE does not prevent code under
> other licenses getting in. In the v1 email thread nobody
> seemed to be very strongly arguing for this, though, and
> at this point we would need to make an active effort to
> track down contributors and get relicensing statements.
> If anybody wants to push that effort now would be a good
> time to volunteer :-)
> 
> Note on the licensing for the tcg-target.opc.h files:
>  * I've used the same license as the rest of the relevant
>    backend, which is to say GPL2-or-later for tcg/aarch64
>    and MIT for tcg/i386 and tcg/ppc.
>  * In all 3 cases, the only people who've made contributions
>    to the files are Richard Henderson and (for aarch64) Alex Bennée
> 
> Richard, Alex -- an acked-by for the relevant patches would
> be nice (or if you intended a different license for the
> contributions than I have assumed please say so!)

No, I had no intention to put things under a different license.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

for the lot.  Since I'm having to re-spin the last tcg pull for a win32
failure, I'll include this as well.


r~

