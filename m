Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9879020787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEJsGqyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9879020787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaeyM-0005K2-PH
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 08:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaexh-0004VS-Gy
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:33:41 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaexg-0001Cr-EE
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:33:41 -0400
Received: by mail-oi1-x244.google.com with SMTP id o7so8816712oif.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j8twICL20wBYfNSmXVxxJlz/7cs3MAitDiVHLFGOHlM=;
 b=HEJsGqyQ7isfzZ48gNhbSsDKW61fWE0ft+NlUZRLsp2LcVwd0QRo3LwQgHlRuQSUuv
 ol9v4rw7V+4+DQmH/BrI5qh1dNin8ZOEghxoAy70yd9tLH3w6/ckQV3JfWqI/L45Yldw
 W90hiDJQrbz2nrWl9D2DWc95J+a3Z/wpsQYDbJ4ftklOjmfEVmJ8/dveNvx9FiS2Wo1F
 ukAedt9QOo3JVJwvZBY41PtyCHR0b8TljAuE1mitu75aMEoUKGXx4ZiJfnPPYryFKHW1
 1NTg0WSFIm23kbKIxFi1Q0QEcZP+1ey4bVcqk1cunctOdv66IQH5EnCeiGccWkbnSYmE
 Nylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j8twICL20wBYfNSmXVxxJlz/7cs3MAitDiVHLFGOHlM=;
 b=ZVgLAegMsKCfZNHdp2RHRqULX1OqYk80RHZAd+vsU+vTKwMYSnkUqPtvmRnGd1d791
 54JmUJagcgjLn9SjmQ7uJ6N9fajylTc9h3CvDVjPgRlwAH3wubG6CRirFN25ZTc6ir35
 YHh4PBdsX1x8oRS18iT55lqJsza7n/1bY3KIFFpOkqkppCX+UiN2WAerZRRCjPOuI92G
 v+BIFbwiPSA/IyJJlvzKv4WKeKXBy4ByTt204cxq/EDaOtYFyBFnIMFCgmxUYw8aix33
 ErJ9u5bNaqRWXBa74xeTE6D7TGUUDTBfnq0Ybib6FgtysoDWYGRHk9aVwMr1dlJM4YHg
 adCQ==
X-Gm-Message-State: AOAM5323ZvhHluxmslfhtYE5aEZeM3frQzZQUqoUMQY0YXjZ25xgtbWD
 sQL2EwbQ7uKcjhjVP7i68IWSqVtRdLsXEZ+Bdw2dWg==
X-Google-Smtp-Source: ABdhPJzUIAcpcBrPtGladKc34ZBDmwEFyhVzr9DLXdRTRlcAiiI/2XlBdYLrPim5hR/Muvu+lKe3VE9IVwfGpRCBTK8=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr9913368oih.48.1589805219040; 
 Mon, 18 May 2020 05:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200517164817.5371-1-f4bug@amsat.org>
 <CAFEAcA81dq=DZO-ao80j6saWutsBD8Lka+0M_Lu77e44BdO5Tw@mail.gmail.com>
 <9ee5e925-284a-9d5f-4890-b1d35eee9d7b@amsat.org>
In-Reply-To: <9ee5e925-284a-9d5f-4890-b1d35eee9d7b@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 13:33:28 +0100
Message-ID: <CAFEAcA819P2w9xqXNsYmFruXv8i9TLS3QKGsO9+ywp64eC=MrQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] exec/memory: Enforce checking MemTxResult values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 12:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 5/18/20 11:46 AM, Peter Maydell wrote:
> > Not necessarily a bad idea, but don't we have an awful
> > lot of places that ignore the result that we'd need
> > to fix first?
>
> Yes, there are various places to fix. I wanted to have a preview first,
> and not start working on this if it is later rejected. Most of the cases
> are hardware specific and require studying each hardware behavior.

Well, patches that fix "we should check and handle errors but
we don't" bugs are pretty uncontroversial.

How ugly does the code for "call the function and deliberately ignore
the result in a way that doesn't trigger the warning" look ? Assuming
it's reasonably straightforward to write code for a device that
really does ignore the transaction status then I don't think that
there would be a problem with adding the warn-unused-result attributes,
if and when we got all the existing instances fixed.

The other part of this is really just priorities: it seems
likely that a lot of the places which ignore the return code
are going to be in devices which we don't care strongly
about, so if fixing them all is going to take a long time
because we have to look up the details of dozens of obscure
bits of hardware, then maybe there's more important cleanup
we might prefer to do first. It depends a bit on whether
there are 30 of these callsites, or 3...

thanks
-- PMM

