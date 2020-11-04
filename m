Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC0CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE58020735
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPsfgB1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE58020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaL2l-0008Fa-1m
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaKzk-0003Yx-PN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:46:44 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:47082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaKzf-0003KZ-3I
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:46:44 -0500
Received: by mail-ej1-x62e.google.com with SMTP id w13so16933256eju.13
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uI4J0IBPpGYeAtKbKoE6VcIEv469KyGNMy6/KYbehno=;
 b=PPsfgB1DGqUyTpTkIrMVoYASDF3V1ZkPUujfvCPSHL1nLYeqgFzNpO5Su0DvPsN7l1
 +mM1BSNshYu8znS9JmBVVYy1PkVgpgB1qebyq7Vf+YJnaAdDFjnMK5261KQzMLF0Gx3p
 e4tzw7ZFEEP2ZflN8ROJMaU4WpC+zTHZnRqM7GVrO9KqZaoxJvyUe/SD6Kxsd0hDEwPa
 K5J4amOunbuA+hCM3iC1L95xyet79zIFjI+4kiXr9pwoLrVeYIb3tFtRr/e3Sml3+KcT
 iJCoSM9ORduTAy9pw4rGo3U8Ic4Ybgih8NG3WuN53Rl0HRTJHBncyfiaHWUs34CjXz9L
 GHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uI4J0IBPpGYeAtKbKoE6VcIEv469KyGNMy6/KYbehno=;
 b=Vih8uwGmEeqD+aKuiR5C5XRTiujut1+H6d5mDNrmMg1Ur4TKAT12eYO35SvoDwrJYO
 YYt1FOsVX4HJ+QztFwGRCsD5I2AJI+V1SD/eq2oJ55u3vII9U/DqFIezJI7+/l6vcRr1
 2ViDTOooaKCbfEbEgyB3KVzeztRlWJ9mAcF1cLq9GLM3wmfdudQ64Q1SE/QvxaNFt6oY
 PwYntH7Y3u0RW5GmN41wrebo0XbsZ4Wo3fqwWa3gj2avQ7xhhsAwCEeh65OEx8OSoNrk
 6V84y7W0z+cMXtVx/wLkNKcFtJ6AQ2050uZn30bn0Ay/OmxIY4mPUH1ukVmKurQtRhwi
 1TGw==
X-Gm-Message-State: AOAM5317EZt4AaD+IX6WyvfABPm+CKWkYn0kqtRUMcO0Fw0ONHmh7oAl
 w4AR0W0PoaUJ/HZY97k5/obU4Othom64NP7DeAUprQ==
X-Google-Smtp-Source: ABdhPJyFQPf6c2nOS5Kh9FuDcxTYATBSEG3YrJdUmbSyqRwvRyi2CwZpaTTI5vN5MEigU7rlgiKsjMd7Rcm/ayRdFEQ=
X-Received: by 2002:a17:906:6949:: with SMTP id
 c9mr13380746ejs.482.1604504797635; 
 Wed, 04 Nov 2020 07:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20201022161938.7clfymu6a3zl46s2@mozz.bu.edu>
 <20201022162416.iccjosbeg753qbzc@mozz.bu.edu>
 <20201022163925.GE428835@redhat.com>
 <p2qq7p64-r88p-s228-133q-n770po2ssonp@erqung.pbz>
 <20201104152506.abplvggv2ll36m6v@mozz.bu.edu>
In-Reply-To: <20201104152506.abplvggv2ll36m6v@mozz.bu.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 15:46:26 +0000
Message-ID: <CAFEAcA84Awk26JgRB90R5M9=R66XXR5eWs47pwZ6Oq0V7A34TA@mail.gmail.com>
Subject: Re: Ramping up Continuous Fuzzing of Virtual Devices in QEMU
To: Alexander Bulekov <alxndr@bu.edu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, 0ops@0ops.net,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 P J P <ppandit@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Dima Stepanov <dimastep@yandex-team.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 at 15:26, Alexander Bulekov <alxndr@bu.edu> wrote:
> If I understand correctly, this is analogous to what happens with
> Coverity reports. Access to Coverity is closed (not sure if there is a
> process to apply for access). It also seems that there is a push to fix
> CID issues prior to new releases. Maybe a similar process can be used for
> fuzzing?

Coverity is only closed in the sense that you have to request
an account on the website. Anybody who's a QEMU developer
can look at the reports.

The attempt to fix CID issues works because:
 * Coverity reports a fairly small number of issues, so
   "fix them all" is relatively tractable, and then once you
   get down to "no outstanding issues" the only new ones
   that get found are for new changes to QEMU (not entirely
   true, but close enough)
 * Mostly issues are reported soon after the offending code
   goes into the tree, so it's often possible to quickly
   identify the patch that introduced the issue and ask
   the person who wrote that patch to fix the bug
 * Coverity reports are categorized by kind-of-failure,
   so it's easy to prioritize important stuff (buffer overflows)
   and leave less significant stuff (dead code) for later
 * Coverity's reports include the automated analysis of
   why Coverity thinks there's an issue -- this is not
   always right but it's a solid head start on "what's the
   bug here" compared to just having a repro case and an
   assertion-failure message
 * There's a set of people who care enough about Coverity
   reports to put the time in to fixing them...

thanks
-- PMM

