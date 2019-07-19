Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5337CC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A04C2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhAlfqen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A04C2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUZo-0004ts-C0
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hoUZf-0004VQ-3q
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hoUZP-0005Pw-Th
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:13:19 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hoUZF-0003Km-W6
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:13:12 -0400
Received: by mail-qt1-x843.google.com with SMTP id y26so31308130qto.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FWhoowb9WO83N3KJLf1rStI9k2VbrsEscqF3/WJDFSk=;
 b=PhAlfqenqNlGOxq3Y5Y9/oaReq3AlNwPqTYlPbiz/nB2BLQHYtgOd7wE8OvoSg7Xc1
 XCcKVb5V0wLYZnGK4jqI0Ipq+knQgBBNN2Ky8+dRte1IEKeCEpTF7sA/UU8wvfrv2N2v
 V4iCm5HpojbnRtZu2msKliHTcPsL/rvoCpxOFF9XpCvvs/1Jl3RwzHeofGRJeehLzNWF
 FaGSgyzSARM0oJHC3pywTfk8trCWHZxnld4+y/htdgX6yNQ6y81PXl2CuzHN7w2RcnfJ
 VN1xuV+GcqgzKGbo4hu7NxlYS87Hexdbqa+v8Um+UA2Vjy1CnETe7akkpztRNIJb77An
 6jUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FWhoowb9WO83N3KJLf1rStI9k2VbrsEscqF3/WJDFSk=;
 b=lxGiBbs4pRpN1trSrFQEyPzfAX3GW9Nrdz8RfHjx8dhfkhsz1T5FqbGypJNlnDZC10
 0nGZ56YTV1JAjpyczrDvjXZuzU+PGDLNWrBmWCTkYMM2WEhEXne1XwLuEe+8p6jXlnPm
 Ty/1fV225+l/LLus/SR2fd/ukEmR2FnM1WHhg1rQeeZu13QnNuHyc6l4A/zabc3u2Hnb
 R1qgNNzQagzMaaPLqRtCfBbNzybd2fFXTUqvi/VNbZh8Ppguda821ALxOhoJWrANhzUe
 ToyDO6WGDk8h5DLKXh94NEcIZPzGXov48wHjB7Hbb8Aijqw+d5/eZm29i38lxAFTdxgK
 LwFw==
X-Gm-Message-State: APjAAAXDPmXpiGn3jjm2gxQImH8IAzahCKSzrjKkuX1wwSiCqfRifkns
 HLGZwdhb2ayIMyL2hYjqGHBKM3QVyzzEK1ilJ60=
X-Google-Smtp-Source: APXvYqwh45SfchrJ93eldqJ8mAg2Q9MJNCT/1w5HcX8D/orJN195bsNab76lPco4rRaPDD7CTtiYEEaUj2SpYXhrfBE=
X-Received: by 2002:ac8:525a:: with SMTP id y26mr37423506qtn.378.1563548981015; 
 Fri, 19 Jul 2019 08:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190702121106.28374-1-slp@redhat.com>
 <20190703095825.GE11844@stefanha-x1.localdomain>
 <87d0i7tlkl.fsf@redhat.com> <20190719102915.GG18585@stefanha-x1.localdomain>
 <8736j2p22w.fsf@redhat.com>
In-Reply-To: <8736j2p22w.fsf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 19 Jul 2019 16:09:29 +0100
Message-ID: <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 2:48 PM Sergio Lopez <slp@redhat.com> wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
> > On Thu, Jul 18, 2019 at 05:21:46PM +0200, Sergio Lopez wrote:
> >>
> >> Stefan Hajnoczi <stefanha@gmail.com> writes:
> >>
> >> > On Tue, Jul 02, 2019 at 02:11:02PM +0200, Sergio Lopez wrote:
> >>  --------------
> >>  | Conclusion |
> >>  --------------
> >>
> >> The average boot time of microvm is a third of Q35's (115ms vs. 363ms),
> >> and is smaller on all sections (QEMU initialization, firmware overhead
> >> and kernel start-to-user).
> >>
> >> Microvm's memory tree is also visibly simpler, significantly reducing
> >> the exposed surface to the guest.
> >>
> >> While we can certainly work on making Q35 smaller, I definitely think
> >> it's better (and way safer!) having a specialized machine type for a
> >> specific use case, than a minimal Q35 whose behavior significantly
> >> diverges from a conventional Q35.
> >
> > Interesting, so not a 10x difference!  This might be amenable to
> > optimization.
> >
> > My concern with microvm is that it's so limited that few users will be
> > able to benefit from the reduced attack surface and faster startup time.
> > I think it's worth investigating slimming down Q35 further first.
> >
> > In terms of startup time the first step would be profiling Q35 kernel
> > startup to find out what's taking so long (firmware initialization, PCI
> > probing, etc)?
>
> Some findings:
>
>  1. Exposing the TSC_DEADLINE CPU flag (i.e. using "-cpu host") saves a
>     whooping 120ms by avoiding the APIC timer calibration at
>     arch/x86/kernel/apic/apic.c:calibrate_APIC_clock
>
> Average boot time with "-cpu host"
>  qemu_init_end: 76.408950
>  linux_start_kernel: 116.166142 (+39.757192)
>  linux_start_user: 242.954347 (+126.788205)
>
> Average boot time with default "cpu"
>  qemu_init_end: 77.467852
>  linux_start_kernel: 116.688472 (+39.22062)
>  linux_start_user: 363.033365 (+246.344893)

\o/

>  2. The other 130ms are a direct result of PCI and ACPI presence (tested
>     with a kernel without support for those elements). I'll publish some
>     detailed numbers next week.

Here are the Kata Containers kernel parameters:

var kernelParams = []Param{
        {"tsc", "reliable"},
        {"no_timer_check", ""},
        {"rcupdate.rcu_expedited", "1"},
        {"i8042.direct", "1"},
        {"i8042.dumbkbd", "1"},
        {"i8042.nopnp", "1"},
        {"i8042.noaux", "1"},
        {"noreplace-smp", ""},
        {"reboot", "k"},
        {"console", "hvc0"},
        {"console", "hvc1"},
        {"iommu", "off"},
        {"cryptomgr.notests", ""},
        {"net.ifnames", "0"},
        {"pci", "lastbus=0"},
}

pci lastbus=0 looks interesting and so do some of the others :).

Stefan

