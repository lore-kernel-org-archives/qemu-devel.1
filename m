Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2638FC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 11:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81C72075A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 11:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujkCEMUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81C72075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib0er-0007fX-1A
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 06:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ib0e7-0007E4-It
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 06:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ib0e3-0003WZ-8V
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 06:10:36 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:38504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ib0dz-0003OA-TD
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 06:10:35 -0500
Received: by mail-ot1-x32f.google.com with SMTP id z25so26907608oti.5
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 03:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a1R1lB/Ra9wsARlIZ1amyZQo3LiyiJKGDrFGB7Tecu4=;
 b=ujkCEMUi+yD4JIUy3efWnH37MhTyz45rp40nFvbQRYB/QbT8wTWcCPZ69xx7Md90wD
 +9BNAFZlWuKwrf6ZrPFKr9iwf0JuxMPPrrceBRGhx0Ui9IH9fSpgv0fbomxAOgGOorhG
 nLuw3O0ZkW4tdku9n96+CgXGrxPWEbmeOMHZdg/yfApw/G2WpM6Dkg1/87rhtvVJWVSe
 xjOcnO7of4rz7yV9gPlYnc5AgPj0r15NsMwqCElzqbK5f68vsswQ3B8Zj6nITQioOu6u
 gy1zIYkPkgO17SAbw2/TlkNM2zgSRxRsxdrAFylkkaqs/C1af5CJUnFjA7OizcFAsGi6
 r1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a1R1lB/Ra9wsARlIZ1amyZQo3LiyiJKGDrFGB7Tecu4=;
 b=hreM/xxJnusR4bC74dYZ8gJNsy0QhEEiLzMuBlWjhpr7x2wTK5fwGJgyMBJqWgmHEg
 wPZeGgP9cTbjYl+GLb871IL3/eIoQDx5Mu6Jz7r5m//8Tl+kulQCNA73wMcEG7FfQfI3
 sYc3eBEFybAHrjEF8g/xQVmvY6MGqqfnw4bJ3lrK2U6kh+yj/cUkR0IpKc+kA5nkONiX
 VUXYCcvS8wdky2ysBO6T2x1SWaIrbHLZH80fdaiizl2yW2pydG8n8q/y7bVzDvhEszDn
 2RbYeAAM8c8XUevfJ9XsmIG1aRRokMKDG0RqhnjL8UglqiZrHuHQ1mph/SyKe3NccuzT
 BrrQ==
X-Gm-Message-State: APjAAAUlD9gyyBh4c1DiyVAJaXxaHWnicxSdkCbVlLISNYNvf3HH5jIM
 LaErlNZ5I9JYApTMtWuuss1TZplfzleXcnxplBTh4g==
X-Google-Smtp-Source: APXvYqyokj7go2Z/LZO1Z3fIPAsR8CzYR0/JxE04UtdbAViPfkxF1IsMYGieeB1uAHK6nyy97ptnjh+ScmI7cPUhIGs=
X-Received: by 2002:a9d:6353:: with SMTP id y19mr14298700otk.135.1575112228803; 
 Sat, 30 Nov 2019 03:10:28 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
 <20191128182705.0635d1d4@redhat.com>
 <CAFEAcA-qA6n49KdHsGLqt422L_b_9xPfSaJB3tATQvRdfKt-xw@mail.gmail.com>
 <20191129132641.4c7da6c5@redhat.com>
 <CAFEAcA_gcxqu+N5iV0L5WLyWmm5yxTFNMtmqQryBgVd4CCCT8A@mail.gmail.com>
 <20191129200545.GG14595@habkost.net>
In-Reply-To: <20191129200545.GG14595@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Nov 2019 11:10:19 +0000
Message-ID: <CAFEAcA-BkETOSpOwBegDcbO3bqxDO_a9xoTB7Fc8Ajw_+CDcFA@mail.gmail.com>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 at 20:05, Eduardo Habkost <ehabkost@redhat.com> wrote:
> So, to summarize the current issues:
>
> 1) realize triggers a plug operation implicitly.
> 2) unplug triggers unrealize implicitly.
>
> Do you expect to see use cases that will require us to implement
> realize-without-plug?

I don't think so, but only because of the oddity that
we put lots of devices on the 'sysbus' and claim that
that's plugging them into the bus. The common case of
'realize' is where one device (say an SoC) has a bunch of child
devices (like UARTs); the SoC's realize method realizes its child
devices. Those devices all end up plugged into the 'sysbus'
but there's no actual bus there, it's fictional and about
the only thing it matters for is reset propagation (which
we don't model right either). A few devices don't live on
buses at all.

> Similarly, do you expect use cases that will require us to
> implement unplug-without-unrealize?

I don't know enough about hotplug to answer this one:
it's essentially what I'm hoping you'd be able to answer.
I vaguely had in mind that eg the user might be able to
create a 'disk' object, plug it into a SCSI bus, then
unplug it from the bus without the disk and all its data
evaporating, and maybe plug it back into the SCSI
bus (or some other SCSI bus) later ? But I don't know
anything about how we expose that kind of thing to the
user via QMP/HMP.

thanks
-- PMM

