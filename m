Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866CDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CB62071C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDiah+Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CB62071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWetu-0008BY-CR
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWeko-0008Sb-HL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWekn-0000oW-8W
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:59:34 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWekn-0000oI-2m
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:59:33 -0500
Received: by mail-ot1-x342.google.com with SMTP id c14so7128755oth.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 02:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TUB26YM/DVjXyeoAperdcdSrXEe4rvmsdYM15SPILSY=;
 b=fDiah+RuIlgrzo+pOEFVall4f5LDZaX3ymgiI2WMlj/zOuas/d1vio3Y268m3dfR4/
 y1KUEegqmOn44K7JYYLxFrCtZbw8+38IsdVXFhcn7cqcHHw6b0kNmzgSpufY7BdU5M2H
 P6N2nnaK6OeHBsDtBjZ+4dleVBcbD58zMfVoCUcnn63IOYbWavLYKkOOPpDSvYZoT3be
 Sf6tEOEPCHPVcXqJrRYRtUAnj7W5/CzCXj6R5K5/pc0hnsAjD96W1gTxWseCHvHIjp60
 h6YVVnCwG3d0WCU1uF8B6irxbSsKpKukvKO6oPRrzQDneyxg98mDfLkufLb5+FJMS7iH
 2kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TUB26YM/DVjXyeoAperdcdSrXEe4rvmsdYM15SPILSY=;
 b=ciAyWGcoQx4M6+wiomX0Ezo1COZdR8byHQ1ifvfjhJNY9ksqbiDhESe3GyoNwCwg0Y
 9XsWE0jDfmQrypwXRAkxKwaFtccorlXR4UwXocNzSEQsyziHQRZtW4QAI4yBJZZveXMZ
 F5THKf5IvCugLWzWgbZV/nnc4kEGUzt0GXKT7dvQr+IIlom2U8MxL1PleHpkuMiWMLCh
 bA/8YS4MlYQWI1Z5PazNTJ+XvuYcyH+iVJy6bi56KAMfGNQwZVTX0/vCPbOCVIC817m9
 zNtEjY2tR03nNtQoSBJCaMoHtvl4vU+w8NvrnrxKusfRJ6znKTE+483vR1zWGcO8fJRQ
 HSzg==
X-Gm-Message-State: APjAAAW0gE5/AucSj5zdEUMm3vNyQ4ges+ueoMdZetTeMw1l7Z889x62
 +Cy22XxHF2clLEfG8bkreqa5QF0tYy0GB3WggwDK1w==
X-Google-Smtp-Source: APXvYqyDv5wC6DJbyKyws0CjRUcKMw37StcvTj+d2we8k2LSOxi/6D7Dqx/yw/VCjbnKDKO9S19QfGNUae25Elnpglc=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr20215785otq.221.1574074771717; 
 Mon, 18 Nov 2019 02:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20191108110714.7475-1-david@redhat.com>
 <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
 <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
 <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
 <CAFEAcA-Q7H9sZjN-PcMMDHQU41yN1RdXhNY5KqMh7E6xh0yjgA@mail.gmail.com>
 <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
In-Reply-To: <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 10:59:20 +0000
Message-ID: <CAFEAcA-o_emMYWyewLD3Pn65pGrqW=5qy=+PqAED75JeSTLTxA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 10:56, David Hildenbrand <david@redhat.com> wrote:
>
> On 18.11.19 11:53, Peter Maydell wrote:
> > On Mon, 18 Nov 2019 at 10:47, David Hildenbrand <david@redhat.com> wrote:
> >> My personal opinion: "max" really means "all features". If we want an
> >> automatic way to specify something you requested ("give me something
> >> that's going to work") we either have to change the definition of the
> >> max model for alla rchitectures or introduce something that really
> >> matches the "no -cpu specified" - e.g., "best".
> >
> > I don't strongly object to 'max' including deprecated features,
> > but I do definitely object to 'max' including by default any
> > experimental (x- prefix) features. Those should never be
> > enabled (whatever the '-cpu foo' name) unless the user has
> > specifically opted into them: that's the point of the x- prefix.
> > We need to be able to tell from the command line whether it's
> > got any non-standard weirdness enabled.
>
> I'll let Eduardo respond to that, as we don't really have experimental
> features on s390x, especially under KVM ("host" corresponds to "max").

Yeah, I would expect that if the kernel has fixed the KVM
interface to a feature then it wouldn't be experimental.
Experimental mostly will apply to TCG, where we might
have implementations based on a draft version of an
architecture specification (like the riscv hypervisor spec)
that could incompatibly change in future.

thanks
-- PMM

