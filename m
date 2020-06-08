Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470BEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 21:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB1F2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 21:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wiaJN0Ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB1F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiOxm-00025q-8G
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 17:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiOvf-0001Aj-CK
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 17:03:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiOvc-0000ME-Cd
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 17:03:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so18996879wru.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=X7EBP+35QqbGl+pVb0ITW8dWiI/5qK/WY7IDOAskjKU=;
 b=wiaJN0ObY4ms2dXDSX0EPiQ9hNLq6SdmUVYb+xhzWAF0E+1UxzyNfzdaobcHdJnfCT
 MrPAw7cEeKx+I5NA0W3b3J8ZYbAQfS73kHeKsCzVU5GcXGmFYiUwWGB8/odDui0iAS0e
 EUtmG3nF1UbH6cjerH+zRsNFwwvhsK3gtdsE28eDWsG2fFrCdQz9XrpXT7kMQcvNkYV1
 hnROs8Pv0+PkW3PanvvP3BSwXOws8kCTMJlwxQDV9saRDN5GuEwyCxkSc0eZdgecADNr
 ElHxwJfuD0e4ngW6pG+AkJrmQ7sqGJvdLF57voRlvWkMRo+F1buX9UyxxWBLe+VxlYIG
 oeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=X7EBP+35QqbGl+pVb0ITW8dWiI/5qK/WY7IDOAskjKU=;
 b=qgkZeq0Ky4b8q4TGig+ZXO5/FMhJBfYsAavOWoE6iGbdgubWz8MlTWJQJWm2e1pX4f
 pEvLEx+ytis7h7oir4Pzk/TQuy60vE9GbLdQv772yw+yqs4iXzny2pJBavsx3T6O1TIn
 XcDxHWhsPDkbfs0LScRfvktnctaXgZKVMiU9G6JQZGJF6GuapEJ6AatuR2ECgBdjb60l
 hox+U3X+WEQ979XnkT7HDRELj6GAD//8vXsyIIfT1wcwCehGCcHZibDcx/NM1DpfukUY
 8EXqNmHfnE85G02YZtxdbfJdvIP2IZlHlawW07u3gpddYLJP94e4Cnmz0VVaQNN5gf78
 /j2A==
X-Gm-Message-State: AOAM531UGMJARBZ1Xs1JtWeLO/R+VKVszhkGiFIDPkz3ZwJJzoPbToHH
 fiJ2IkiZRXEa7ejSHgcETBitng==
X-Google-Smtp-Source: ABdhPJyxtvpsUfdd4iCXe3Zm+lZCOnGuGx/UdvtZXM8Lvd6Xmb5m/FqHnxqaJwdMEk7EwZ8q+oDiUg==
X-Received: by 2002:adf:f512:: with SMTP id q18mr760317wro.38.1591650209992;
 Mon, 08 Jun 2020 14:03:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o10sm890924wrq.40.2020.06.08.14.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 14:03:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D5761FF7E;
 Mon,  8 Jun 2020 22:03:27 +0100 (BST)
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006051901480.13777@digraph.polyomino.org.uk>
 <87a71d5wub.fsf@linaro.org>
 <alpine.DEB.2.21.2006081648430.23637@digraph.polyomino.org.uk>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 6/7] target/i386: reimplement fprem1 using floatx80
 operations
In-reply-to: <alpine.DEB.2.21.2006081648430.23637@digraph.polyomino.org.uk>
Date: Mon, 08 Jun 2020 22:03:27 +0100
Message-ID: <877dwh5kyo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, qemu-devel@nongnu.org,
 laurent@vivier.eu, pbonzini@redhat.com, aurelien@aurel32.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joseph Myers <joseph@codesourcery.com> writes:

> On Mon, 8 Jun 2020, Alex Benn=C3=A9e wrote:
>
>> > +    uint8_t old_flags =3D save_exception_flags(env);
>>=20
>> Hmm where did this come from:
>
> This series assumes all my other recent x87 fixes (11 such patches in=20
> three series that aren't yet on master, there's also a single patch for=20
> pcmpxstrx which is independent of those) are already present.

Ahh - it's ok to keep a patch that is currently queued in your series
until such time as it's merged. You can also just reference the original
series in your cover letter or supply a branch reference to aid with
application.

--=20
Alex Benn=C3=A9e

