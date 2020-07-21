Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73062C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D48020578
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtvfaGDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D48020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsaR-0005Vz-Bp
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxsZh-0004zA-9w
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:44:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxsZf-0005xw-83
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:44:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id a21so15065976otq.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cwH0eQfXfZXNOrLozsdlWlWjFwPgBN0+LAmx2GMdbsg=;
 b=MtvfaGDbJmYUtgz3ky7JodB0jc8MaWCUsXTNVGdHBCnq+syPIcK5QZs03SES42XSxw
 eCrUIaApvknIJZCuTWFoteeZx2Gc/3/0pSS86rD9PyWLYZGZlTOrnN+6Y/VYK9ihYDMy
 xHagDGLGsGlmKG8qLFUDPTxFxr8CopnBDLRUTdaaYDpk0I9var+cx/KoYzaIwmOWPUtn
 VLjWbs4HQ/QdT8ilHXZ4YtDYJoj82XDHAgmscx9ag48mnreTC9sV5xmFHJ6W6iDZZite
 2XSdhZ2b9gn9qda/ue/qaiGEag+5g1mzT5Y/6w8ywmR/YYptBTohklh2ontmr0taEIij
 Sm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cwH0eQfXfZXNOrLozsdlWlWjFwPgBN0+LAmx2GMdbsg=;
 b=Hy67JokDrXlyVJ1IoN0jZfODzDUizaGSD7A8S11Zb4Daw5FCmUnkYyFUl07oT1Onir
 lU8Ic1vO9QXm8DzvLH/tdMKXt+Y4JT2Btip33rVtbBd9e/GgFgzzyvjZAes3DmgfPa3E
 gvI6BCY+QbKapW2eJ7fXhpF/wlS6KVf7PlMI5SbFmahLQmYAk6pQY3qM6iV8i7pxKVTG
 9PkiC6QeXYWNtNKlE2/pk8KgjsbhHVGgCR8KmdM/0rHMjL9sioQkvhP9sbMBZQiyXxKh
 mB459f6w4agkbh0brxnKYt3rP7QfCpog2B51feeZ8uBBKQkmc4KwpU7a8r9KvrsEYdzl
 c5bQ==
X-Gm-Message-State: AOAM533zJrSoK0t6m7bsHfG5dbl+hgkO5lwMmy+3CoYdBBA0+ylsio+3
 wHtWSEm9mgEKywUkTrTON7fuuDZmwdlncWzXZ4GfIw==
X-Google-Smtp-Source: ABdhPJwDQPA13d2ZzQjtvW/a9CZsKqIECWlMaBkmg5cF3/XcYrT5+8kx/ZgYU7TCnCJNXq2uCr46KkkH/9wOitLl6hA=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr25180370oto.135.1595339089805; 
 Tue, 21 Jul 2020 06:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
 <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
 <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
 <CAKXe6SJb=1YLLGF+TP1fMd95k_WzZd73JeUJv5Sn4EE4m2zP4w@mail.gmail.com>
 <f19f605c-9468-e7eb-f255-60766df2a50c@redhat.com>
 <CAFEAcA-qrpXJtzW=tigyAqQuYFNCBMQK_CZFx6zYkcJa+RuZuw@mail.gmail.com>
 <28d42c0f-99eb-a9c1-e3fc-98f11ee686ab@redhat.com>
In-Reply-To: <28d42c0f-99eb-a9c1-e3fc-98f11ee686ab@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 14:44:37 +0100
Message-ID: <CAFEAcA8ECKgRanHLiFZMDS3fd77ASBkba2nfv+iwnjgSLWnbPw@mail.gmail.com>
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Bug 1886362 <1886362@bugs.launchpad.net>, Li Qiang <liq3ea@gmail.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 14:21, Jason Wang <jasowang@redhat.com> wrote:
> On 2020/7/21 =E4=B8=8B=E5=8D=888:31, Peter Maydell wrote:
> > On Wed, 15 Jul 2020 at 09:36, Jason Wang <jasowang@redhat.com> wrote:
> >> I think the point is to make DMA to MMIO work as real hardware.
> > I wouldn't care to give a 100% guarantee that asking a real
> > h/w device to DMA to itself didn't cause it to misbehave :-)
> > It's more likely to happen-to-work because the DMA engine bit
> > of a real h/w device is going to be decoupled somewhat from
> > the respond-to-memory-transactions-for-registers logic, but
> > it probably wasn't something the designers were actively
> > thinking about either...

> I think some device want such peer to peer transactions:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/driver-api/pci/p2pdma.rst

That's a device DMAing to another device, not DMAing to *itself*
(device-to-another-device DMA should work fine in QEMU). And only
a very few devices will ever be sensible targets of the DMA --
basically things like nvme that have a looks-like-memory area,
or special cases like doorbell registers.

> > Yeah, this is the interesting part for QEMU. How should we
> > structure devices that do DMA so that we can be sure that
> > the device emulation at least doesn't crash? We could have
> > a rule that all devices that do DMA must always postpone
> > all of that DMA to a bottom-half, but that's a lot of
> > refactoring of a lot of device code...
>
>
> It looks to me the issue happens only for device with loopback

I think in principle we have a problem for any device that
(a) has memory mapped registers and (b) does DMA reads
whose address is guest-controlled. Loopback isn't a
requirement -- if the guest programs, say, an RX descriptor
base address to point at the device's own registers, you
get exactly the same kind of unexpected-reentrancy.

thanks
-- PMM

