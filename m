Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEEDC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763B020706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="pZ7Ak5Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763B020706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAB5Z-0006sR-Pm
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kAB1I-0000yO-GX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:52:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kAB1F-00046u-FX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:52:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id 83so8022316wme.4
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8FNepZGEyafOOvrycQSATSk6FoFslj36Kdl7JO4++aU=;
 b=pZ7Ak5Av1l+vN7tnAkISI0ws/sfPycm6ZCSjQ/CyqtvGar3kPZRT3TLzUXLrcsq4+t
 HWRifYxvPFO6D01s2/kcjAsqRgqsp8KMGmAtLteLlR5yiSBY4VNpczb8TvmzjN2N1J9o
 nx0eDi3n6iZQoJSajAc4OkmmECi1mUwWNhA9FlbvXH3t2Y8oaqZt9FDF8kk6UUlQy9rA
 vrVhtO6LAwzw4qX5J5XmgzA425whk/8N488VWf07hxpJGXlV7+LY+vsUqJ5TXDfoyWFs
 EVEOoTvu/57BK4tb+/bbC+NMum4rawHWNROWxEkjyM90LvWMApK+zcm5fNzk/R+/HPGO
 6RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8FNepZGEyafOOvrycQSATSk6FoFslj36Kdl7JO4++aU=;
 b=unmauqKLaiAa2NEM/ARHpDUd4//9D7OyN833ZabPppevKd3XGIyRgC7OidnHSCgaom
 qfADom591MPc0OJVI6U3BAUW3qU3dyTP5WrT65ynC18ZOHeYiiIt2kDcFAv4X5E/05xn
 D3eneJpsEp9Neq/Kog4Onzl1VAS2dDVoYvXto5H/yT4xI7V/zvZcbZ6x0RYOqvCjClXq
 BYp11SG9fwj2vXm0msQAYkKwuaL/Nbzt2IhyGBP9/CCiY3jZlwj9FwsS4IelreAz3Hud
 MTW7eu7SVpcp0yj6exJCkOrcixCfwrx7SngqKcM8FB4tatW+KQ/5GxepJIlmsDbnMbvz
 umVw==
X-Gm-Message-State: AOAM53134oAwwckTiiqzJamvh7Ey0pgMNazpRJV1YoySZyGmlLqq/lAL
 S4DhO87Hjua+mHPtkBVxgYc//q4TX0uNeZ5WRoWcAQ==
X-Google-Smtp-Source: ABdhPJzkl8kjrOc81dbGsBc+1cHJEmJzRO2/6JH7sCAfGuZnR7aDi8eMHhdWKnPr+pq5DQvp/V6zkAHuDfdiiE/7agw=
X-Received: by 2002:a1c:5fd5:: with SMTP id t204mr5746557wmb.137.1598269926837; 
 Mon, 24 Aug 2020 04:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200821123007.3d390d51@redhat.com>
 <2f874496-e9a2-d52f-2c6e-0595cc3ae9cb@redhat.com>
 <20200824133541.0a5fe9a1@redhat.com>
In-Reply-To: <20200824133541.0a5fe9a1@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 24 Aug 2020 17:21:55 +0530
Message-ID: <CAARzgwxLVgMtUR07f5eG45hQ0W9XK1A-SQb1Kvwx2JVS848hmA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] Use ACPI PCI hot-plug for q35
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Laine Stump <laine@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 5:06 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Sat, 22 Aug 2020 16:25:55 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
>
> > +Marcel, Laine, Daniel
> >
> > On 08/21/20 12:30, Igor Mammedov wrote:
> > > On Tue, 18 Aug 2020 23:52:23 +0200
> > > Julia Suvorova <jusual@redhat.com> wrote:
> > >
> > >> PCIe native hot-plug has numerous problems with racing events and
> > >> unpredictable guest behaviour (Windows).
> > > Documenting these misterious problems I've asked for  in previous
> > > review hasn't been addressed.
> > > Pls see v1 for comments and add requested info into cover letter at
> > > least or in a commit message.
> >
> > Igor, I assume you are referring to
> >
> >   http://mid.mail-archive.com/20200715153321.3495e62d@redhat.com
> >
> > and I couldn't agree more.
> >
> > I'd like to understand the specific motivation for this patch series.
> >
> > - I'm very concerned that it could regress various hotplug scenarios
> > with at least OVMF.
> >
> > So minimally I'm hoping that the work is being meticulously tested with
> > OVMF.
> >
> > - I don't recall testing native PCIe hot-*unplug*, but we had repeatedly
> > tested native PCIe plug with both Linux and Windows guests, and in the
> > end, it worked fine. (I recall working with at least Marcel on that; one
> > historical reference I can find now is
> > <https://bugzilla.tianocore.org/show_bug.cgi?id=75>.)
> >
> > I remember users confirming that native PCIe hotplug worked with
> > assigned physical devices even (e.g. GPUs), assuming they made use of
> > the resource reservation capability (e.g. they'd reserve large MMIO64
> > areas during initial enumeration).
> >
> > - I seem to remember that we had tested hotplug on extra root bridges
> > (PXB) too; regressing that -- per the pxb-pcie mention in the blurb,
> > quoted below -- wouldn't be great. At least, please don't flip the big
> > switch so soon (IIUC, there is a big switch being proposed).
>
> I'm suggesting to make ACPI hotplug on q35 opt-in,
> becasue it's only Windows guests that doesn't work well with unplug.
> Linux guests seems to be just fine with native hotplug.
>
> > - The documentation at "docs/pcie.txt" and "docs/pcie_pci_bridge.txt" is
> > chock-full of hotplug references; we had spent days if not weeks for
> > writing and reviewing those. I hope it's being evaluated how much of
> > that is going to need an update.
> >
> > In particular, do we know how this work is going to affect the resource
> > reservation capability?
> My hunch is that should not be affected (but I will not bet on it).
> ACPI hotplug just changes route hotplug event is delivered, and unplug
> happens via ACPI as well. That works around drivers offlining/onlining
> devices in rapid succession during native unplug (that's quite crude
> justification).
>
> So I'd like reasons to be well documented, including what ideas were
> tried to fix or workaround those issues (beside ACPI one), so the next
> time we look at it we don't have to start from ground up.
>
>
> > $ qemu-system-x86_64 -device pcie-root-port,\? | grep reserve
> >   bus-reserve=<uint32>   -  (default: 4294967295)
> >   io-reserve=<size>      -  (default: 18446744073709551615)
> >   mem-reserve=<size>     -  (default: 18446744073709551615)
> >   pref32-reserve=<size>  -  (default: 18446744073709551615)
> >   pref64-reserve=<size>  -  (default: 18446744073709551615)
> >
> > The OVMF-side code (OvmfPkg/PciHotPlugInitDxe) was tough to write. As
> > far as I remember, especially commit fe4049471bdf
> > ("OvmfPkg/PciHotPlugInitDxe: translate QEMU's resource reservation
> > hints", 2017-10-03) had taken a lot of navel-gazing. So the best answer
> > I'm looking for here is "this series does not affect resource
> > reservation at all".
> >
> > - If my message is suggesting that I'm alarmed: that's an
> > understatement. This stuff is a mine-field. A good example is Gerd's
> > (correct!) response "Oh no, please don't" to Igor's question in the v1
> > thread, as to whether the piix4 IO port range could be reused:
> >
> >   http://mid.mail-archive.com/20200715065751.ogchtdqmnn7cxsyi@sirius.home.kraxel.org
> >
> > That kind of "reuse" would have been a catastrophe, because for PCI IO
> > port aperture, OVMF uses [0xC000..0xFFFF] on i440fx, but
> > [0x6000..0xFFFF] on q35:
> >
> >   commit bba734ab4c7c9b4386d39420983bf61484f65dda
> >   Author: Laszlo Ersek <lersek@redhat.com>
> >   Date:   Mon May 9 22:54:36 2016 +0200
> >
> >       OvmfPkg/PlatformPei: provide 10 * 4KB of PCI IO Port space on Q35
> >
> >       This can accommodate 10 bridges (including root bridges, PCIe upstream and
> >       downstream ports, etc -- see
> >       <https://bugzilla.redhat.com/show_bug.cgi?id=1333238#c12> for more
> >       details).
> >
> >       10 is not a whole lot, but closer to the architectural limit of 15 than
> >       our current 4, so it can be considered a stop-gap solution until all
> >       guests manage to migrate to virtio-1.0, and no longer need PCI IO BARs
> >       behind PCIe downstream ports.
> >
> >       Cc: Gabriel Somlo <somlo@cmu.edu>
> >       Cc: Jordan Justen <jordan.l.justen@intel.com>
> >       Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1333238
> >       Contributed-under: TianoCore Contribution Agreement 1.0
> >       Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> >       Reviewed-by: Jordan Justen <jordan.l.justen@intel.com>
> >       Tested-by: Gabriel Somlo <somlo@cmu.edu>
> >
> > - If native PCIe hot-unplug is not working well (or at all) right now,
> > then I guess I can't just summarily say "we had better drop this like
> > hot potato".
> >
> > But then, if we are committed to *juggling* that potato, we should at
> > least document the use case / motivation / current issues meticulously,
> > please. Do we have a public BZ at least?
> >
> > - The other work, with regard to *disabling* unplug, which seems to be
> > progressing in parallel, is similarly in need of a good explanation, in
> > my opinion:
> >
> >   http://mid.mail-archive.com/20200820092157.17792-1-ani@anisinha.ca
> >
> > Yes, I have read Laine's long email, linked from the QEMU cover letter:
> >
> >   https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> >
> > The whole use case "prevent guest admins from unplugging virtual
> > devices" still doesn't make any sense to me. How is "some cloud admins
> > don't want that" acceptable at face value, without further explanation?
> My take on it that, Windows always exposes unplug icon, and lets VM users
> to unplug PCI devices. Notably, user is able to click away the only NIC
> VM was configured with.

Correct. Also sometimes the admins may not want some other PCI devices
to be hot unpluggable such as the balloon device.

>
> Unfortunatly the 'feature' can't be fixed on guest side,

It can be using driver hacks but they are very operating system
specific and also needs to be applied per VM everytime they are
powered on.

that's why
> hypervisors implement such hack to disable ACPI hotplug. Which I guess
> is backed by demand from users deploying Windows virtual desktops.
>
> PS:
> I'd made PCI hotplug opt-in, since not everyone needs it.
> But that ship sailed long ago.
>
>
>
> >
> > Thanks
> > Laszlo
> >
> > >
> > >
> > >> Switching to ACPI hot-plug for now.
> > >>
> > >> Tested on RHEL 8 and Windows 2019.
> > >> pxb-pcie is not yet supported.
> > >>
> > >> v2:
> > >>     * new ioport range for acpiphp [Gerd]
> > >>     * drop find_pci_host() [Igor]
> > >>     * explain magic numbers in _OSC [Igor]
> > >>     * drop build_q35_pci_hotplug() wrapper [Igor]
> > >>
> > >> Julia Suvorova (4):
> > >>   hw/acpi/ich9: Trace ich9_gpe_readb()/writeb()
> > >>   hw/i386/acpi-build: Add ACPI PCI hot-plug methods to q35
> > >>   hw/i386/acpi-build: Turn off support of PCIe native hot-plug and SHPC
> > >>     in _OSC
> > >>   hw/acpi/ich9: Enable ACPI PCI hot-plug
> > >>
> > >>  hw/i386/acpi-build.h    | 12 ++++++++++
> > >>  include/hw/acpi/ich9.h  |  3 +++
> > >>  include/hw/acpi/pcihp.h |  3 ++-
> > >>  hw/acpi/ich9.c          | 52 ++++++++++++++++++++++++++++++++++++++++-
> > >>  hw/acpi/pcihp.c         | 15 ++++++++----
> > >>  hw/acpi/piix4.c         |  2 +-
> > >>  hw/i386/acpi-build.c    | 48 +++++++++++++++++++++++--------------
> > >>  hw/i386/pc.c            |  1 +
> > >>  hw/acpi/trace-events    |  4 ++++
> > >>  9 files changed, 114 insertions(+), 26 deletions(-)
> > >>
> > >
> > >
> >
>

