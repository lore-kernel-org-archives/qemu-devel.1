Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5140AC4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47D720848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="enKuV/fE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47D720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDdY-0004Ue-LH
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNDWd-00067W-0W
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:10:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kNDWY-0003gl-Fd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:10:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so4924572wrt.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1UdY5OqsQ+Can+bRpsaxh1QpgPhjT2IysX/4V2tpIgw=;
 b=enKuV/fE+phv7JwqwbVI2WtkeKWWBKlhvX2wc8VdDvlmTONtz4YnuqKqYBFicREqnN
 UyUFf5zKaLRbYxquNOMvcREG2ThfXjUaVYFOeWoD6b8F6g8+ss+99UQKYdRKYfvw2jsU
 L5vBgaQr4qq5U1Sx7qOCOWxE/W8ndo3xgK/9FbJ6mb7uucuWnr9fEIqwz493E/c0yzjL
 o03vfH3oaHl40o0DJabtrg8sexD2P/QMSuf+OMnuzSgGsRBU+gDOpPhMUSUWNWPpQxa+
 9l1gIVhQKzMSileZwRQCzkqkcmYChDy5m7VttinD/WThI2sMHetqsvPHXTW+77e9sgh3
 JUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1UdY5OqsQ+Can+bRpsaxh1QpgPhjT2IysX/4V2tpIgw=;
 b=Pq9i3eXC70YwkleSwPp6t5GpZE4hfqlF3nT4pNIRLI1tfMgiPA0shNbyZZpiMxMPph
 BpUaDY2EABNxnc7oy87IAazODU1M5jWMiA8Zwxy4actVCifODwkzWdzpKc9Jdi8cxVBl
 nrhRLFQQYZp1r8Jmn+eMnHHzxxEwxynsydzqywpdfUNWwcWZotn8Swj4BKpYjeP/bVDL
 9+0dU7uANs76Ti647mMUQtUphXBOxqIjksg86+HooP+91Q8hY8CJYIrx6ZqTslrO7O3H
 rZov81B78NvOQOJaleyRfi1MihnxLSRzgKuwAsw9ATr/3YSwKF+MP/vpsfEOUXuUm6bY
 ANWQ==
X-Gm-Message-State: AOAM532g0VootOnOzSMy173LdqlVfs6VYBzBg6/ie87LNNLRInni8pMV
 jkZW+4tWPgWtWRM89ME0RI2ZLFmUuHNPeSOdSwaRHw==
X-Google-Smtp-Source: ABdhPJwTBLnu4XKysJz7VpvaaOiKoBvE1p0NkJ9iy6n9dWfvNr9xPyzCx78lb1AcEANeiGl8EzwaIrAvkRiuaF4fjIg=
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr3410250wrm.291.1601377820985; 
 Tue, 29 Sep 2020 04:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200929032619-mutt-send-email-mst@kernel.org>
 <CAARzgwz7x6uinPQ+oC+yAuFCbQEWhQuDmGU73E5NZ2WCH_C_kA@mail.gmail.com>
 <CAARzgwwxjjCAVsFB6_987pa1Z_in2G50rViYiRGVae-c_wn6xQ@mail.gmail.com>
 <20200929053823-mutt-send-email-mst@kernel.org>
 <CAARzgwxBcTDkK7QhHP=_mpYoAYYgRY+d6o+2SCSP-haBPDttwA@mail.gmail.com>
 <CAARzgwy8QNw=OD6cOEkDY-x9mC10ry+NTdCH2gNKuLXp8bAAyg@mail.gmail.com>
 <CAARzgwyNPZB5PGc-B9vDn9V-uEwVCiCvXgvamMaGTvBCPJQiCg@mail.gmail.com>
 <20200929063539-mutt-send-email-mst@kernel.org>
 <CAARzgwz6iTsO9Z1ACAHmbSteGYfetDgnSRYc-xnaqjYyJ4yEHA@mail.gmail.com>
 <CAARzgwwvuFi94dva6tvHtk9uFBDVYNOaGs1CFP6kwN3ezipd9w@mail.gmail.com>
 <20200929065602-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200929065602-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 29 Sep 2020 16:40:09 +0530
Message-ID: <CAARzgwwZPMtP-F6UTyiPt+neRzy70++r=DmC1u4JJe7QS4TAcg@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x443.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 4:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 29, 2020 at 04:20:15PM +0530, Ani Sinha wrote:
> >  as
> >
> > On Tue, Sep 29, 2020 at 4:11 PM Ani Sinha <ani@anisinha.ca> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 4:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 29, 2020 at 04:02:07PM +0530, Ani Sinha wrote:
> > > > > On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > > > >
> > > > > > In your pull request the following patch is completely screwed up:
> > > > > >
> > > > > > commit cda2006eded0ed91974e1d9e7f9f288e65812a3e
> > > > > > Author: Ani Sinha <ani@anisinha.ca>
> > > > > > Date:   Tue Sep 29 03:22:52 2020 -0400
> > > > > >
> > > > > >     tests/acpi: update golden master DSDT binary table blobs for q35
> > > > > >
> > > > > >
> > > > > > This is not my patch. It has all sorts of changes which does not
> > > > > > belong there. Can you please check?
> > > > >
> > > > > See https://patchew.org/QEMU/20200929071948.281157-1-mst@redhat.com/20200929071948.281157-46-mst@redhat.com/
> > > >
> > > >
> > > > I had to regenerate the binary, yes. That's par for the course.
> > > > But it looks like I added disasssembled files. Will fix up and drop,
> > > > thanks for noticing this.
> >
> > It's probably worthwhile to regenerate DSDT.hpbrroot as well and then
> > do the diff and compare.
>
> They are all regenerated by tests/data/acpi/rebuild-expected-aml.sh
>
> What is important is to check the changes and not trust them blindly.

Yes what I meant was if you are regenerating the source blob with
which you are diff-ing, you should generate the destination blob as
well so that we can compare apples to apples.

>
> Do you see anything unexpected? It is easy to run
>
> tests/data/acpi/disassemle-aml.sh -o <output directory>
>
> on multiple versions and see what is going on.
> Care to do this?
>
>
> --
> MST
>

