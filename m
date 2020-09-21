Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263DFC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69043218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4gqpJ/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69043218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKLOl-0001OR-Da
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKLNW-0000vh-CU
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:57:10 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKLNR-0004wk-Ub
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:57:09 -0400
Received: by mail-ej1-x643.google.com with SMTP id q13so17542832ejo.9
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DG0y9qn/lKIgS0h/nLSEmonQRe3mA2s/LQVbb+04v74=;
 b=x4gqpJ/ddQjg84zAvB3H9GTU3bZNIr0ya1U9tOOKEqB0bHQo1TY/gb5PkEbn7qbYIo
 Ce9bYx9OOZf80n2uGP6JWE3m+rqrAFPdM6cMBm8dAX3wXgIqU/872oCoytlZg1ORUcH7
 fg2krRGYaQ896WoVInHqwJtFOuA9fj0kgndc67dLce6WEB9ITwWV1VOM512PSeL3O9Fq
 8e/6/NAkXGfQiGSR3Xs9eeLrrwB7F9b8bzR8ExNzmV6dpsgQBBiNC64hOgJrPq0t6fcq
 srmjO2lfmvFjHPV4OgSb4bzdlqH3g+kpbgceJD80ye2TUKrhVd7ieCGR0wBhHl8WRJpp
 j9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DG0y9qn/lKIgS0h/nLSEmonQRe3mA2s/LQVbb+04v74=;
 b=YgJhbV8mDaYETyh6ChBhKknfTLVxPKw+62VZPQ2ZwAXNDKWLM9QCMR0F1Qgl0a9gFh
 AtwODNTr1Mj+hDQxyPBb19orn3CYQDhyaiseJFpX3svzZm/pB11NUT783jnIQHScdN94
 ImLk7dFULf1G5P0MhadZ0lliOGiIEj0g9Q+gflUCNs56McE95Mf+u/yo4Hp1UwJO5jP5
 2BCQy5FKQZpEjo5OIVZETI7KHBr+MMGW/KRHp3Xos6/YdPcmfEAX+VbLy9e27ftxPFQq
 3kwAZQ/2D50PIYLvQUc20MzFXLQVwcsXrHXfzmAJqntvCdhFHghSo4zVraWjICWSgIZD
 ZMlA==
X-Gm-Message-State: AOAM532LvTmb74qonK6yyfJVa743MhbeNJUhhU13Kgp1WREuSH0urqAz
 KX/ldaw9nfb71Vs2UQwLtrarOgWt3qGTnqTA6k8jZQ==
X-Google-Smtp-Source: ABdhPJw0LgP03GdSyIadM01l5bAlKeDhpemoUZNC/30a6jLuRo/me7c65vFpVeNQO39AYV7djmuaPbbjHUmtmtcuzkA=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr48863901ejb.85.1600693023380; 
 Mon, 21 Sep 2020 05:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200914084802.4185028-1-armbru@redhat.com>
In-Reply-To: <20200914084802.4185028-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Sep 2020 13:56:52 +0100
Message-ID: <CAFEAcA9qPx=rtNcQ5FJk8a3YjZN7XyD1cJddQbD7Km9fBpm-0A@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Configurable policy for handling deprecated
 interfaces
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Libvirt <libvir-list@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 09:55, Markus Armbruster <armbru@redhat.com> wrote:
>
> New option -compat lets you configure what to do when deprecated
> interfaces get used.  This is intended for testing users of the
> management interfaces.  It is experimental.
>
> -compat deprecated-input=<in-policy> configures what to do when
> deprecated input is received.  Available policies:
>
> * accept: Accept deprecated commands and arguments (default)
> * reject: Reject them
> * crash: Crash
>
> -compat deprecated-output=<out-policy> configures what to do when
> deprecated output is sent.  Available output policies:
>
> * accept: Emit deprecated command results and events (default)
> * hide: Suppress them
>
> For now, -compat covers only deprecated syntactic aspects of QMP.  We
> may want to extend it to cover semantic aspects, CLI, and experimental
> features.

Some bikeshedding on option naming...

If this only covers QMP, should we make the argument to -compat
have a name that expresses that? eg deprecated-qmp-input,
deprecated-qmp-output ?

Also, it seems a bit repetitive to say 'deprecated' here all
the time -- do you have a future use of -compat in mind which
would be to adjust something that is *not* deprecated ? If
not, maybe the 'deprecated' part should be in the option name
rather than in every argument, eg

  -deprecation-compat qmp-input=crash,qmp-output=hide,cli-option=reject

?

thanks
-- PMM

