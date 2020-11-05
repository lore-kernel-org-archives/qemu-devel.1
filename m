Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FAAC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E47620786
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MvjcCyPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E47620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kai2d-0003gQ-QZ
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kahyo-0008Vo-CQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:19:19 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:42572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kahyj-0001Lu-UY
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:19:17 -0500
Received: by mail-ej1-x636.google.com with SMTP id i19so3420773ejx.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 08:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=awXdLBfZrIVki424fgNQtxrkeH3KNqNYqk1M5HpaX+0=;
 b=MvjcCyPd1Kvyf2tOCdQVNP9oEoF/m2YmxVw0iCGqS4NcKENX3CybXH03U1wHNZrhKC
 YwQUOZqE8qDP/V+RBlHyiigH1dXf4uYGeUzxxhRpZ2PvY4DJFkIFxvTSNhVpMcnxgVuj
 2U8yOCtrJrms8lhqKsoNwziUA1oO8R+QjibopSY8/GJXmzLczf4fSr3OWrMuKBUX0N5n
 T5i9fcbZ6u0WIHIgaPK9+j1v9DVN4mB+/ziDiHApcQUf048UzizXslf4ksItqpa3dn2P
 EmaSZdfnYOYtXxPrmDXOmL6HYwpiuKZjHsmQNiabngcZ2rJ9Or3512dGacuMyBHl24bl
 qzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=awXdLBfZrIVki424fgNQtxrkeH3KNqNYqk1M5HpaX+0=;
 b=Ygi80nTU5xWTtpAwaSpgBcuCQxf85p69essZMKHpdS7UbtGdZe3W5ImSVwBR1emaYE
 nCfAya4Iz6DB1l8IsqXPKNqkTqU5fLEbg3fCL0rdvx5DXkvk1clRfJMvR8S/C/eCImFZ
 jMXGsNlmlY7veRQVa1vM1y4lnK0fRnTZ+PqF4YhsWlbRku04BQou/kilQxm+twM5zDgf
 cLUB/N7TS2hBiOXOW8JXX2TGuBYNsb3pO9Am4y9FYOQjl5pCuUsu2R2cdF8KmKAXujnA
 Ok8sYvWtdd/VMk2HDlRdH+auFxfh7amqeXqNNGe5x28RoY5qEDRJyvU5QQbeApBNm+8v
 ELWg==
X-Gm-Message-State: AOAM533jASpLV6P2kdMJEB+8fD7ZbQprpF0QRv/OhiMNtrWxqWhX8At4
 izzWWzCBw87iOw5xTIontLFVij9BfX6OnrvVadjeOg==
X-Google-Smtp-Source: ABdhPJzAufjSrLBAzvwG7g1TGxg9aBZUJZjEOM4dobecpMRT1H/AvoF7Do30cCCdRwvYliQdnHDIF1zus4mSpDQvAHE=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr2913979ejb.85.1604593151118; 
 Thu, 05 Nov 2020 08:19:11 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+F1CJ7KpB8C6-_+Gdh6twqjjRMweERUapw4tfjKyMqa6AM0w@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ7KpB8C6-_+Gdh6twqjjRMweERUapw4tfjKyMqa6AM0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2020 16:19:00 +0000
Message-ID: <CAFEAcA86UyXfir3JA3E2vuJNZBGOhbxzvomemaCLg6uwOB3c8Q@mail.gmail.com>
Subject: Re: Documents not in sphinx toctree
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: Pankaj Gupta <pagupta@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Nov 2020 at 16:14, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> By running sphinx over the docs/ directory (like readthedocs.org presumab=
ly does), it finds a couple of rst documents that are not referenced:
> - cpu-hotplug.rst
> - microvm.rst
> - pr-manager.rst
> - virtio-net-failover.rst
> - virtio-pmem.rst
>
> Shouldn't they be?

These all need to be moved into the correct manual. That
might involve splitting them into several pieces so that
the different pieces can go into different manuals.

The difficulty is that this requires attention from somebody
who has at least some vague idea of the contents and who
can move them around appropriately.

In the meantime, they're in exactly the same boat as
the various *.txt documents in docs/ -- old stuff
that doesn't end up in the user-facing manuals and which
nobody's got round to properly integrating into the docs yet.

> If not (I wonder why), there should be a way to explicitly
> exclude those, and avoid extra warnings.

The only thing that runs sphinx directly on the docs
is readthedocs, and it doesn't care about warnings :-)

thanks
-- PMM

