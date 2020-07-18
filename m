Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F01C433ED
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 09:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1430120691
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 09:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4pkrR5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1430120691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwjOT-0007t8-CC
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 05:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwjNt-0007UA-84
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 05:43:57 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:37427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwjNr-0001Sv-GN
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 05:43:56 -0400
Received: by mail-ot1-x332.google.com with SMTP id w17so8675927otl.4
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QaeWJHiDpq6tF/nS+de0oEzYyBtEn9dHB61l8E7jeS4=;
 b=H4pkrR5G4Isi7CmL56t0UzFYqsYiid7uunHAuN4r0qs/TUFpzrvVHlk/wU+VNHgilc
 OhAVTQX5ug7ErELgmPcz7VZsNOZlGt/BqXp5sAOYRAqKFYqxhtu9yGyGm3Q0QTSchRqc
 ghOfwZBu7Op9Lg19H6LsW6cRJ3mxX8boGwklJTldn7Id2IXwA0C3G14B97iqhNDy4MZi
 omhJINMPImF16gk8o8xTxaHT+6LPIO/11QBaFtZpjsksWGMxxiRqv8KV2RWEK1rdg9cu
 Fe/ITf6jymFZmmXCnvrRjmRC/Vdk6DXLGHkeOJCTD0Jf7Ec7QMCQDPFuqhOtc7wtYN9x
 zQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QaeWJHiDpq6tF/nS+de0oEzYyBtEn9dHB61l8E7jeS4=;
 b=SKkNvD33Z3PWXjW7L7XdTHPPxEE+277pY0XScjtmrzX4y+rlP9n3aVyI11FuQ5Tt2B
 byPwWyHviX7A212YoQPQPEy4tCBeSr1aee6aGSA8fzZR1mI5Gca+OiWmwP4v4sx0NmPL
 5jLFB6ky4x1c43GQS8XSxR8HJr6hybX9zmYWv4uFkctv95ECVDlghXOWPbRlRgI0+hqL
 CbrF7gt/wLTpn1zhXKF2gKmtOd99YteZTeDEcF4jd64GmIXNOeyNj4hesNkF7dZZj5dF
 quFePbh9l+wiFrIsc8FScS6AahESviU8dxidyD3TGpneY++4XoBDHJ5H1kqmSSamKlOk
 dQDQ==
X-Gm-Message-State: AOAM532RS7ApfSKegt48H43OF58an6AVYHjNW9rDq94MltUswqGnvqed
 RoVWbUaUfVusA0RGggyjuhiYI2ZS7ROxhANsPYqK6w==
X-Google-Smtp-Source: ABdhPJxt2voHFLhqHtvkot/2WmvW3Kgvnfi1JZiC+4aU1kSnc7CA2Xz3oqrCf/NrsqrrfCJvHvQCCg1ICqVj8j/Jp0M=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr12050929ota.91.1595065434001; 
 Sat, 18 Jul 2020 02:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aXn+E2r1ZFyd1AZnwyvnxB1VsStkJC8vqkhmqZ4JDE_0LwMg@mail.gmail.com>
 <FEBB6630-0908-4097-BA78-ACB12932703A@livius.net>
In-Reply-To: <FEBB6630-0908-4097-BA78-ACB12932703A@livius.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Jul 2020 10:43:43 +0100
Message-ID: <CAFEAcA_yMhW5CSJBSkAn0opSq4on1N=TfEd8w-KZcYD=ABP9Rw@mail.gmail.com>
Subject: Re: instance_init() and the realize() functions
To: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Pratik Parvati <pratikp@vayavyalabs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 18 Jul 2020 at 09:27, Liviu Ionescu <ilg@livius.net> wrote:
> For me it was difficult to draw a line of what initialisations should be =
done in .instance_init and what in .realize, but given that .realise is cal=
led when the whole hierarchy is ready, it might do links between objects, w=
hich are not available when .instance_init is called.

Yeah, we have not been able as a project to come up with a nice
rule for how to do this split. There are a few definite rules:
 * anything that can fail and return an error must go in realize
   (because instance_init has no failure-return mechanism)
 * anything you need to do to set up a QOM property on the
   object must go in instance_init (so that the property can
   be set by the user of the device object before realizing it)
 * anything that changes the state of the simulation must go in
   realize (some QMP monitor commands to introspect objects
   will do instance_init/look at object/delete)
but a lot of things could validly go in either method, and we
haven't set a convention for those cases. (There's a bunch
of inconclusive discussions in the mailing list archives.)

> A simple rule would be for .instance_init to ensure that all members have=
 default values and properties associated with them, and defer all function=
al initialisations to .realize.

Yeah, this is a reasonable default rule. Note that for a lot
of device state struct members (where they correspond to guest
registers state), you want to set their values in the
device's reset method, not in instance_init or realize.
That's because the guest-visible register state needs to
be set back to its initial value on a system reset anyway,
and QEMU guarantees that we will reset a device before
first use.

thanks
-- PMM

