Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7037FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDFF20862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCNeP4cf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDFF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGRaz-0005Fv-4e
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGRZD-0004E8-N4
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGRZC-0002GX-6D
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:40:35 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:45450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGRZB-0002GH-TC
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:40:34 -0400
Received: by mail-ot1-x32e.google.com with SMTP id 41so5955202oti.12
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3DHbq/mrGTZhpzyuW81VcvZSLrIPAAvPKJ9PwmjLBDg=;
 b=kCNeP4cfmaaPrEoN6LtciVf5foMJw5mQWwXJhm9pu5nSyg5RFTqO3yqh3j/p8Oagpp
 o7ueJLudZNYwri9Tp7ukLq264P+bm7dvgXko6FbWYevY1ySEYF0Va3m5x2pDEQUa65v5
 Hk/h7k8szTwxfzYxpN36WEs/OoFw3DXhNnPi+Zh09pEWuAw1jv/vCBJ7Y/nt8HwlDTAv
 hN9V1d+VFUkMZ+x74UkvWXxy+6FXWciNVqH0MDx8fUg96abSiFjjRM9ws0oF1qU9cCoW
 osrsREtXStAugUUg+X0IqDKRKkSAEz6JKG5NkgFQYZHXkGN9aIecyBW4dJ7yrUNyh+tJ
 uhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3DHbq/mrGTZhpzyuW81VcvZSLrIPAAvPKJ9PwmjLBDg=;
 b=cmAUFCn+qHrIO5U/FM2bm5zkVuTXmbR/KY2fd9c7l2/zRlVqO4vOiaYllj221o+Q5A
 rD/o7fBjhNxcSXfCd1RIDMfx9IpoNE6YpA2PoYXz4fcKg7a9ttG5eMvhRuNs64PoCYW+
 f9bW2Q95XGCEVbpXoSXMGZoERiU+cj2LeMFNKhL9LDQvtRKaFubCg2/lBz3LZGA5m0vW
 drlMvTjKkQ/wSiYRmK/rK9Fs4OWzyK6mzWu9aPCZsl6CWpWmuDXnpzLRUIJwSbls5o7p
 DbqaWN3pDq6m9iw0XMgSvMKMgPLYU0X0RAPLchgQkSkFt2gSHjpjF51fnsyGlENv5vsl
 110A==
X-Gm-Message-State: APjAAAV2elWsQfmAyqgA23QvJtC31qWYzt0BqqGobQAD4NT+d3SuDDao
 cOZRPpoCZPmbOSENsTv0gz+/0WuU46TqhwuuwSbhyHT79Gk=
X-Google-Smtp-Source: APXvYqy91MNequScy5vi5KOAKxHTBUmCmW8i6y5aDyWu18xiXeV+NOatWE8+5b7xEGG9k0TTHYXTzwp7AqO2XYWjfxo=
X-Received: by 2002:a9d:562:: with SMTP id 89mr11915997otw.232.1570210832656; 
 Fri, 04 Oct 2019 10:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8HGEdHs74-m3Wa7RHU_ZE5g9kEidP-9Z69zhsMkCPRZQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8HGEdHs74-m3Wa7RHU_ZE5g9kEidP-9Z69zhsMkCPRZQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2019 18:40:21 +0100
Message-ID: <CAFEAcA_sTc+EcDU-=kwLTLRL_ZoiXReRCfy1XeDj+4p02B3e8w@mail.gmail.com>
Subject: Re: ptimer use of bottom-half handlers
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Sep 2019 at 11:01, Peter Maydell <peter.maydell@linaro.org> wrote:
> The ptimer API is basically a down-counter (with a lot of bells
> and whistles), with functions to do things like "read current count"
> and "write current count". When the counter hits zero it typically
> reloads, and the ptimer code notifies a callback function in the
> device that's using ptimer. In the current implementation this
> is done using a QEMU bottom-half handler, so ptimer_trigger()
> calls replay_bh_schedule_event() on a QEMUBH that it was passed
> by the device when it was initialized. The comment says this is
> "to avoid reentrancy issues". That's a bit vague, but I assume the
> idea is to avoid the code of the device's 'triggered' callback
> being called from within eg ptimer_set_count(), because the
> device might be in the middle of changing multiple parts of the
> ptimer's state, its own state might not be consistent, etc.

In the course of trying to do some conversions of devices to
the new API I've proposed, I figured out the other part of what
this "to avoid reentrancy issues" probably is referring to:
if the device's 'triggered' callback itself calls a ptimer
function like ptimer_run() then potentially it could recurse:
 ptimer_trigger() -> trigger callback -> ptimer_run() ->
  ptimer_reload() -> ptimer_trigger() -> ...

I need to think a bit more carefully about what is supposed
to happen here and what we want to have happen. I guess at
the moment we'll just schedule the QEMU BH to run again,
so the trigger callback is called again, but not recursively.
So we should probably cause that to happen in the new scheme
(conceptually, something like "the trigger callback is
implicitly considered to be called from within a tx begin/
commit block, so (a) it doesn't need to do begin/commit itself
and (b) if it does something resulting in a repeat trigger
the second call will happen after it returns, not recursively" ?)

thanks
-- PMM

