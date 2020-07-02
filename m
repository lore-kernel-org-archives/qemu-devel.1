Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C129C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D862075D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZG3jiiV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D862075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwna-00015y-Bd
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqwmd-0000Bi-3R
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:49:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqwmb-0000O5-4F
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:49:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id z2so5333315wrp.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 03:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2F6lcGvLmFa0e9xgXAjlmesqhyKxwu86lXj5HPfoHpk=;
 b=ZG3jiiV0s5jma/xPA8pj+NufZbOr9Hz3n1iE0E5j2QmHzO7N4SzjjF+8nUo8fT1hla
 WPXP4os2WYhIKtp6/K2IAqgYVP4Niw13loWGZGF3Gi05+1xC/oEyHVhDJSjqUFpLtWe6
 k/5JumfT5KhL2sfXio9xCce/pzMcmWC5uaQcY9FfgK094hhhDewscfPbs/wrO0gnAF1I
 35GZY7tm78C0R91UqAD8zODzpZSAnJ1y5x02YiJag65SQH5EWXQMC5SyG5+NNHXtF2re
 awmcqjYy4yvNo0LQswnmx88b+hUGnQquAD52Fd5rzea258LWN0y6R884RKrwe9yhgWE2
 veyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2F6lcGvLmFa0e9xgXAjlmesqhyKxwu86lXj5HPfoHpk=;
 b=SiJVORdh5irRaqinngjMnHxdpjxiOQWqJN3m4L1twPAz5DSTCzVgambMHT8BdiOnrW
 PZUQD7WNTrHpLMIRHByWJcBab/4yTbOttp8aTSjnNIlr2L4D9S53+YbtJUCbVgWGUPYs
 /zg3OF8+cgaadRI2RefR8S8e/RI5aZpTVWKq+fYaVPj/esDgCi+xobjCEfn5pLAvzBnn
 PaJU0a5ZNzDAT60tgHEn5bRwn0MsTtste3MFiFlrMAKKsEwZf3CfHwJws7GK9yIzbYKK
 cR2INgP277PXCW6iodCB2Pkupoe98CBcvVM+bYlxkcHnAgyf/KFm9Xo1SzAOBzC4z+fD
 CABg==
X-Gm-Message-State: AOAM531zStBFSEVxxokcpAveC/inYRhAyYyYVGSiHqgzahIdiSbeLTGH
 CeeJL6ZtaoD2wJQ0RpbfSBAcbA==
X-Google-Smtp-Source: ABdhPJycBD/ZJKVFjLhmhv4aBcrOFpN6zChXoP6zGW9IkfdSldep87bkAg8iMpJTRv+3OwDMFS2GQg==
X-Received: by 2002:adf:f707:: with SMTP id r7mr30533789wrp.70.1593686971466; 
 Thu, 02 Jul 2020 03:49:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g14sm6371536wrw.83.2020.07.02.03.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 03:49:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADB321FF7E;
 Thu,  2 Jul 2020 11:49:29 +0100 (BST)
References: <20200701182100.26930-1-philmd@redhat.com>
 <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
 <70b04307-fe22-c9bd-3194-f2612d41e197@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU
 created
In-reply-to: <70b04307-fe22-c9bd-3194-f2612d41e197@redhat.com>
Date: Thu, 02 Jul 2020 11:49:29 +0100
Message-ID: <87r1tup4xy.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1878645 <1878645@bugs.launchpad.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Philippe =?utf-8?Q?Mathieu-D?= =?utf-8?Q?aud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 01/07/20 22:35, Peter Maydell wrote:
>> For the monitor, that
>> would be the current "default cpu" as set by the "cpu"
>> command (cf monitor_set_cpu()). The bug here will be that
>> somewhere along the line we are probably missing plumbing
>> sufficient to pass down "which CPU do we want".
>
> Yeah, the fix is probably to add a functions that returns either
> current_cpu or the monitor CPU, and use it in device emulation if
> applicable.
>
> The problem with current_cpu is that it affects stuff like run_on_cpu,
> and that is guaranteed to cause havoc to code that expects to run on a
> given CPU and therefore doesn't use locks.

IIRC the original reported bug was in a APM callback which was triggered
by an MMIO operation. Currently we don't expose the current cpu via the
memory dispatch routines. Should we to ensure there is always something
valid there?

>
> Paolo


--=20
Alex Benn=C3=A9e

