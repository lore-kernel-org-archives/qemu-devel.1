Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107EEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF9B20869
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8+PzlRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF9B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagGu-0001Mm-07
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iafWD-0003TV-Dy
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iafW9-0000e3-P1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:37:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iafW9-0000Mj-Kw
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575031017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qm+T1ASCH95EZ3Qw1MlwASDvflxC/HYi5p5Vtox9SuM=;
 b=U8+PzlRMztsNdry+nsb5ECzFd4U7OV6HCLX+BFm72GTJ1ShKA4pjbCCfjtQZtAahmY4YqX
 rati1LsC64rPwQI6kLUDwR2hdq4GyQuZCYVgVj8F6nnF2/Y/YsJZ3Q8ZK5oj0vnNanacXF
 MOlRJ0kEByJoGPGoysn1AVMoIcFKup0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-x-QRIQ6eP1yJD4IbTFTNIQ-1; Fri, 29 Nov 2019 07:36:56 -0500
Received: by mail-wr1-f69.google.com with SMTP id q12so15571258wrr.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Qm+T1ASCH95EZ3Qw1MlwASDvflxC/HYi5p5Vtox9SuM=;
 b=p0D86WDmCHS2vfVBW6AzMh1aKfr8kD8MJJ7eYHVv2ss3JSvmnUT4JchZop/AkmyXgX
 df80zWAiJJ3XshJc7UuqFtuaWDHVBxPbg+QgDIyIEj675T2VQFtztb3eFeU2wJhBpFKX
 mqbZcSWxdsBk9oZx57ZqXxYVcj6lKjs/k/MextVAS0dKLz3i9OEXicysRt2AFt6hrpEm
 F+Hs7ye+7Vi7cxZ5CnaBwqvYTL6yzMpVfI7C07xm2xqIq4oUAd3xtD1hmk8aXM66qKs+
 vBvgYF3L6uE4LK/1AQbocvnbmjgQuuojCI12gdnjnXrylmn2DGjw4+c/bHvP1zwsSvEN
 STSA==
X-Gm-Message-State: APjAAAXzJBKNpXPNDBp8uJcSZwA4Q56VMxyOqQrBfDa8LIcDzVWTpYKT
 4BmPYX92lYwZr2MgnCjv359Kd4y7uPegWI1ek19TiBAun+Tv8q9U+mlAlcICFi605Vfqf1wNLfu
 mC3Ot6PD/h5pRIUPljH0fcXQGZMVUHxo=
X-Received: by 2002:adf:90d0:: with SMTP id i74mr51611007wri.298.1575031014914; 
 Fri, 29 Nov 2019 04:36:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwArhIg+Xa24mInLmTL2NSaJK5dIz19H4h7sFf68AUBvB3I2zEBunH4GO/LpvRm8F1l1T0veAlS5pUUCi++7TA=
X-Received: by 2002:adf:90d0:: with SMTP id i74mr51610980wri.298.1575031014691; 
 Fri, 29 Nov 2019 04:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20191129104457.1991-1-philmd@redhat.com>
 <9e052d2b-50c9-9370-a279-002987375f89@redhat.com>
In-Reply-To: <9e052d2b-50c9-9370-a279-002987375f89@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 29 Nov 2019 13:36:43 +0100
Message-ID: <CAP+75-W4hi7oU636CN9f8d1aqrasxBYywwY7gvcVVSh36jnpOw@mail.gmail.com>
Subject: Re: [PATCH-for-4.2? 0/1] roms/edk2: update submodule to
 edk2-stable201911, fixing low severity CVEs
To: Laszlo Ersek <lersek@redhat.com>
X-MC-Unique: x-QRIQ6eP1yJD4IbTFTNIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Cole Robinson <crobinso@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 1:10 PM Laszlo Ersek <lersek@redhat.com> wrote:
>
> Hi Phil,
>
> On 11/29/19 11:44, Philippe Mathieu-Daud=C3=A9 wrote:
> > I had this commit ready for when the next EDK2 release were go out,
> > which just happened: https://edk2.groups.io/g/devel/message/51502
> >
> > Laszlo doesn't think it's worth the churn to rush to get this update
> > into into 4.2-rc4: https://bugs.launchpad.net/qemu/+bug/1852196/comment=
s/2
> >
> > I agree with Laszlo, users shouldn't use the EDK2 bundled within QEMU
> > in production, and should rather build it from source. However some
> > distributions seem to rely on this convenience way to package EDK2,
> > and few CVEs are fixed in this new release. So it might be worthwhile
> > to get this into 4.2-rc4. Anyhow distributions don't use QEMU stable
> > tag directly and backport patches, so if there is no other rc4 patch,
> > we could skip this for after 4.2, as Laszlo originally planned.
> >
> > Philippe Mathieu-Daud=C3=A9 (1):
> >   roms/edk2: update submodule from edk2-stable201905 to
> >     edk2-stable201911
> >
> >  roms/edk2 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> if we want to do this, then the above diffstat is not enough.
>
> - please evaluate whether we should do something like 9153b9d7401f
> ("roms/Makefile.edk2: update input file list for
> "pc-bios/edk2-licenses.txt"", 2019-06-14)
>
> - we need to rebuild the binaries: 3583cb29f28f ("pc-bios: refresh edk2
> build artifacts for edk2-stable201905", 2019-06-14)
>
> - we should update the README file: 541617cad344 ("pc-bios: update the
> README file with edk2-stable201905 information", 2019-06-14)

Oops sorry for missing all these points, I'll do them.


