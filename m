Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22401C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4592084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiwVPdHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4592084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSezp-0002Xx-2K
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 05:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iSeyn-0001td-EI
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ard.biesheuvel@linaro.org>) id 1iSeyj-0001Hj-9I
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:25:29 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
 id 1iSeyi-00015I-MV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:25:25 -0500
Received: by mail-wm1-x336.google.com with SMTP id q70so1860494wme.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qAdGETN6AixEqw+ThOSssQbz6q56ocX/c6J8cAihWig=;
 b=EiwVPdHxSxG04If6SrQjC03OgSWjUnB9hiG0bwTKeoH7Z8sTsKsneDW86ZtZIMp41w
 nVaQConMSHp94cgKobmgpfsqvYTaP/3XB4vYS0Lphq8cH1deKqEMMyXlsSGe2pyFsBfh
 shvA1T6bzI6T7nNoeKPO7f48dzXqFLXJ4ZEkJnaYcWusF8ZC9lzpT8ccB5oqCb9sQdOq
 6EKyGFBtputXZVP5yS16zv5skRqeEl1JauhufcAogR/VEqcVt+jyef+Aelhd4NU9BgMM
 iKQhJtcjb2BEidKE4iqFRPT/adGdHpU3KrebMytX/QQQELMbndT9ivIiOkrc4GOJyyzQ
 elsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qAdGETN6AixEqw+ThOSssQbz6q56ocX/c6J8cAihWig=;
 b=lcf7qhEbw/pTF4MGQrsjeVfjGuiSQSZDrvvNIOQ3WGU3K7keXPoWWVUwHvPJYHAy7n
 EQErQ/lxdUsNTaryK00KpVzIs0FgTUwHPG0VlbJK1u8GK9HDN6Ses5fN7uyYI/CkAhf4
 ILL3h9RF7J1hsQx8fj4rEYOAuCZCfBE2v7uWYFHXWM5IuqVM0PEMJ67HPOp4+xbx9r0Y
 NA+2OWk3X3GBq5d0czBkm2y0+BG6wp6KVx46879Rr1JC/HkqjmWEb6aoZ0q2pEl/tOYw
 ACJIsQEJzy6d9hq+YPutaW7isNhsV+iAwtmk9MiiL/A8/NcjfWdOukiQ99DlIt/tnPDx
 VowA==
X-Gm-Message-State: APjAAAWmkakzuE+/KVnj+lgrRTF55LV72aXn1yFLQDGLkiOZP2PbeIr+
 xnO8+mXHVg3aJp9z4Ic5a+hhu4vz4k0LHLuEumu1Mg==
X-Google-Smtp-Source: APXvYqy3QX1Gh2dO9py3eFifZjoRwObsWWYZcYFqejsGOV3ObuHly0OTAWUTrRrnWnadTzer6aWiSfKShJghuXaIqz4=
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr2181483wmf.10.1573122321759; 
 Thu, 07 Nov 2019 02:25:21 -0800 (PST)
MIME-Version: 1.0
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
In-Reply-To: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 7 Nov 2019 11:25:10 +0100
Message-ID: <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

Thanks for starting this thread.


On Thu, 7 Nov 2019 at 11:11, Laszlo Ersek <lersek@redhat.com> wrote:
>
> Hi,
>
> related TianoCore BZ:
>
>   https://bugzilla.tianocore.org/show_bug.cgi?id=1871
>
> (I'm starting this thread separately because at least some of the topics
> are specific to QEMU, and I didn't want to litter the BZ with a
> discussion that may not be interesting to all participants CC'd on the
> BZ. I am keeping people CC'd on this initial posting; please speak up if
> you'd like to be dropped from the email thread.)
>
> QEMU provides guests with the virtio-rng device, and the OVMF and
> ArmVirtQemu* edk2 platforms build EFI_RNG_PROTOCOL on top of that
> device. But, that doesn't seem enough for all edk2 use cases.
>
> Also, virtio-rng (hence EFI_RNG_PROTOCOL too) is optional, and its
> absence may affect some other use cases.
>
>
> (1) For UEFI HTTPS boot, TLS would likely benefit from good quality
> entropy. If the VM config includes virtio-rng (hence the guest firmware
> has EFI_RNG_PROTOCOL), then it should be used as a part of HTTPS boot.
>
> However, what if virtio-rng (hence EFI_RNG_PROTOCOL) are absent? Should
> UEFI HTTPS boot be disabled completely (or prevented / rejected
> somehow), blaming lack of good entropy? Or should TLS silently fall back
> to "mixing some counters [such as TSC] together and applying a
> deterministic cryptographic transformation"?
>
> IOW, knowing that the TLS setup may not be based on good quality
> entropy, should we allow related firmware services to "degrade silently"
> (not functionally, but potentially in security), or should we deny the
> services altogether?
>

TLS uses a source of randomness to establish symmetric session keys
for encryption. So it really depends on the use case whether HTTPS is
used for authentication or for confidentiality, and it seems to me
that it would typically be the former. So disabling HTTPS boot in this
case seems counterproductive to me.

>
> (2) It looks like the SMM driver implementing the privileged part of the
> UEFI variable runtime service could need access to good quality entropy,
> while running in SMM; in the future.
>
> This looks problematic on QEMU. Entropy is a valuable resource, and
> whatever resource SMM drivers depend on, should not be possible for e.g.
> a 3rd party UEFI driver (or even for the runtime OS) to exhaust.
> Therefore, it's not *only* the case that SMM drivers must not consume
> EFI_RNG_PROTOCOL (which exists at a less critical privilege level, i.e.
> outside of SMM/SMRAM), but also that SMM drivers must not depend on the
> same piece of *hardware* that feeds EFI_RNG_PROTOCOL.
>

The typical model is to seed a DRBG [deterministic pseudorandom
sequence generator] using a sufficient amount of high quality entropy.
Once you have done that, it is rather hard to exhaust a DRBG - it is a
mathematical construction that is designed to last for a long time (<=
2^48 invocations [not bytes] according to the NIST spec), after which
it does not degrade although it may have generated so much output that
its internal state may be inferred if you have captured enough of it
(which is a rather theoretical issue IMHO)

The problem is that using the output of a DRBG as a seed is
non-trivial - the spec describes ways to do this, but wiring
virtio-rng to a DRBG in the host and using its output to seed a DRBG
in the guest is slighly problematic.

So it seems to me that the correct way to model this is to make the
host's true entropy source a shared resource like any other.

> Furthermore, assuming we dedicate a hardware entropy device specifically
> to SMM drivers, such a device cannot be PCI(e). It would have to be a
> platform device at a fixed location (IO port or MMIO) that is only
> accessible to such guest code that executes in SMM. IOW, device access
> would have to be restricted similarly to pflash. (In fact the variable
> SMM driver will need, AIUI, the entropy for encrypting various variable
> contents, which are then written into pflash.)
>
> Alternatively, CPU instructions could exist that return entropy, and are
> executable only inside SMM. It seems that e.g. RDRAND can be trapped in
> guests ("A VMEXIT due to RDRAND will have exit reason 57 (decimal)").
> Then KVM / QEMU could provide any particular implementation we wanted --
> for example an exception could be injected unless RDRAND had been
> executed from within SMM. Unfortunately, such an arbitrary restriction
> (of RDRAND to SMM) would diverge from the Intel SDM, and would likely
> break other (non-SMM) guest code.
>
> Does a platform device that is dynamically detectable and usable in SMM
> only seem like an acceptable design for QEMU?
>

