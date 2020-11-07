Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384DCC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F152207C3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahHmCVFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F152207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbPFE-0005KV-Ew
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 09:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kbPDs-0004Sd-50
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kbPDC-0003x5-A1
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604759341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QqexYpRv+Ic3ho8iK51S/boJk6Bk7u0U/6XUBL6x9g=;
 b=ahHmCVFauSzsPz9c9d2tN13pB2HZa5QFafX2oEprOmQuwprZtoGNH6SgUShCYktmeK9vSf
 vicRnbMJfFgC60nEl4eNcw3eV5OPR25brWPSByfoAs6IS4RQc4QDndaJOXXbH10Hwp72AS
 3pbLGY/DNaQRR8zSqKr0HuqkrD4hrhI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-xAVbKD1XP96nKC9NCm3Kkg-1; Sat, 07 Nov 2020 09:28:59 -0500
X-MC-Unique: xAVbKD1XP96nKC9NCm3Kkg-1
Received: by mail-wr1-f72.google.com with SMTP id m20so1776047wrb.21
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 06:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rbBQuW6iXegQF0PsTuXynYHx7lUJmEj+4t80IoTz5ok=;
 b=OZHlezx3JPuz+o8IvAIZIpzM2xYrWPUONFW8daVZTBatiC6euHfqph5NpgV6eSaire
 dUsAT4er5T1vpq+O8TGRGgMaN5LUMB35nt5LrhwAUKrO834KOsjCPvT91uq4mJm6i2Br
 BET8vtYglxrLnygjx0xqTWl3TzyJGEu2B1vuPQdV4Q4Y3kQdZsedy204Y7ztYzkynlIl
 NrwGTVcPXVENAY/P4eHwo+JbnN9MiUlAQS5NfqLffN9QvYcLiI7FVlEJTe9FCGPP6XuE
 yGEeVxjffmvvFOQecnFzAZYEm3Zpu77Qmj1grBnbNLF4vp5nuKdW7VcZUWzJc+u1VatR
 URxA==
X-Gm-Message-State: AOAM533i/8iM2Je9gqAet38eM7tZdxlDltiSL2YloudzkvQxV05FtFbm
 wnvXIEiSLn0R9GjmpyQHi/weFHhhuv0KXYNHsUaC3NG4FrMPQzyvwXa4P1yovgAjvteWPNATEVX
 z5BtI1DtdgljmylY=
X-Received: by 2002:adf:b78b:: with SMTP id s11mr935441wre.42.1604759338193;
 Sat, 07 Nov 2020 06:28:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDL2f07cISuaZvrjcJVy6ipEOX5pfbVVL3/K5RAz0onNf1AhEEX/tm23165E0M8XIUfPzzsA==
X-Received: by 2002:adf:b78b:: with SMTP id s11mr935419wre.42.1604759337987;
 Sat, 07 Nov 2020 06:28:57 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id d3sm6422378wre.91.2020.11.07.06.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 06:28:56 -0800 (PST)
Date: Sat, 7 Nov 2020 09:28:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL v4 44/48] piix4: don't reserve hw resources when hotplug
 is off globally
Message-ID: <20201107092610-mutt-send-email-mst@kernel.org>
References: <20200929071948.281157-1-mst@redhat.com>
 <20200929071948.281157-45-mst@redhat.com>
 <5b79133f-374e-8a8f-6aeb-bd5313dc8eb1@redhat.com>
 <CAARzgwx+n0k9kC15Twy0sj07jcDcPWX6-x2pGDXQ1i8fDU-Leg@mail.gmail.com>
 <56a067f8-945f-cab4-d80e-6706ae446705@redhat.com>
MIME-Version: 1.0
In-Reply-To: <56a067f8-945f-cab4-d80e-6706ae446705@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:59:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 07, 2020 at 03:18:24PM +0100, Philippe Mathieu-Daudé wrote:
> On 11/7/20 1:22 PM, Ani Sinha wrote:
> > On Sat, Nov 7, 2020 at 3:40 PM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 9/29/20 9:22 AM, Michael S. Tsirkin wrote:
> >>> From: Ani Sinha <ani@anisinha.ca>
> >>>
> >>> When acpi hotplug is turned off for both root pci bus as well as for pci
> >>> bridges, we should not generate the related ACPI code for DSDT table or
> >>> initialize related hw ports or reserve hw resources. This change makes
> >>> sure all those operations are turned off in the case ACPI pci hotplug is
> >>> off globally.
> >>>
> >>> In this change, we also make sure ACPI code for the PCNT method are only
> >>> added when bsel is enabled for the corresponding pci bus or bridge hotplug
> >>> is turned on.
> >>
> >> I'm trying to understand the following build failure using gcc 9.3.0
> >> on Ubuntu:
> >>
> >> [2567/3684] Compiling C object
> >> libqemu-x86_64-softmmu.fa.p/hw_i386_acpi-build.c.o
> >> FAILED: libqemu-x86_64-softmmu.fa.p/hw_i386_acpi-build.c.o
> >> ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
> >> ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
> >> in this function [-Werror=maybe-uninitialized]
> >>   496 |         aml_append(parent_scope, method);
> >>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> cc1: all warnings being treated as errors
> >>
> ...
> >>>  static void acpi_get_misc_info(AcpiMiscInfo *info)
> >>> @@ -456,10 +460,12 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >>>      }
> >>>
> >>>      /* Append PCNT method to notify about events on local and child buses.
> >>> -     * Add unconditionally for root since DSDT expects it.
> >>> +     * Add this method for root bus only when hotplug is enabled since DSDT
> >>> +     * expects it.
> >>>       */
> >>> -    method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> >>> -
> >>> +    if (bsel || pcihp_bridge_en) {
> >>> +        method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> >>> +    }
> >>
> >> build_append_pci_bus_devices() is not easy to follow and could certainly
> >> benefit from a refactor.
> > 
> > Hmm, ok will do that in my spare time.
> > 
> >>
> >> So here, before 'method' was always reinitialized. Now not always,
> >> so it can be any value set in the big for() loop before...
> > 
> > In line 467 above, method is initialized when bsel is available or
> > pcihp is enabled. In line 496, it is appended to the parent scope only
> > under those conditions as well. Basically, in hunks
> > 
> > +    if (bsel || pcihp_bridge_en) {
> > +        method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> > +    }
> > 
> > and
> > +
> > +    if (bsel || pcihp_bridge_en) {
> > +        aml_append(parent_scope, method);
> > +    }
> > 
> > the conditions are exactly the same.
> 
> The problem is in the (!bsel && !pcihp_bridge_en) case,
> what 'method' is used there?

Um ... where exactly?


