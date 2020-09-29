Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F1C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C77207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdD/IUrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C77207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDMB-0001KV-3B
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDKi-0000Qr-Dl
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNDKd-00021R-O4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:58:08 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601377082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RNJnOxHcmHDVxv4jHUsyC5GDX7HzIvN6PDIK0W1s5jQ=;
 b=bdD/IUrBIhmCAX+mws7+cmv/vbxhgNzlrssDi/g1M1TZtw0CctnE9YN/aH6e+mcTnU5RiR
 r3G/6KGNH6DksP/o2pi3pCqWth55bOZzhnZc3ot5kZFVj+WEywUB130U2slKkHP6af29eF
 fginBcQ6r1fcmb8LrQ4Nn26SG91fBtc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-8KWdeWL3M0WK4YgRdTKqRA-1; Tue, 29 Sep 2020 06:58:01 -0400
X-MC-Unique: 8KWdeWL3M0WK4YgRdTKqRA-1
Received: by mail-wr1-f69.google.com with SMTP id o6so1594953wrp.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RNJnOxHcmHDVxv4jHUsyC5GDX7HzIvN6PDIK0W1s5jQ=;
 b=n8JFyNHdJNOGevzY1J9zCJDJ28ui/cekPj9WwzyC4I3qlTQlA/40pYVwuCKSw/ItyW
 3zY2J2n5mzWXEIEBxROY+W23a3eMvztIfd3eFGugkpT+XoEInmWtM6qBOc+Xoz0a3TTQ
 bq0jzMg1I9ThQ/AFm9gx8JmB6rcBhtyZfO2dq7FyoAU4xspP1P1kfuP5a/E3M4rO20F3
 DqMXQjU83upiJUMkJ1TEr4luAP7lT27b7hju6c76ZqiPiCCVsnnKITRti+gymQXHedsE
 CfhSPEhZrFdupNi8YcICewwRoWYpoGnGZmRyljMGWg4nfZsIIMkKnhaOIO44A59578hs
 6fjw==
X-Gm-Message-State: AOAM533MWP1xONSiTHHN6xAlScGL/B+wb0ivfSaSJoOQpWs/tXHXLkEC
 O7hoIrlSy/ytGt5jVvd7ADuF60BEF5Q0gwX3I3Q554DooziXFhcgmTCwdfMIw9f0BAaXd+xglxs
 uUeq+Oog7Z9Y6P5A=
X-Received: by 2002:adf:828f:: with SMTP id 15mr3533745wrc.49.1601377079691;
 Tue, 29 Sep 2020 03:57:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsQY95kgoYBrgsv22P6yUHS8wR4VVPRWeZhqINaeZuhxE7N+yC6tOcGjZIrVAEC8uKg9Qh+A==
X-Received: by 2002:adf:828f:: with SMTP id 15mr3533733wrc.49.1601377079473;
 Tue, 29 Sep 2020 03:57:59 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id x17sm6297778wrg.57.2020.09.29.03.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 03:57:58 -0700 (PDT)
Date: Tue, 29 Sep 2020 06:57:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
Message-ID: <20200929065602-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <CAARzgwwvuFi94dva6tvHtk9uFBDVYNOaGs1CFP6kwN3ezipd9w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 04:20:15PM +0530, Ani Sinha wrote:
>  as
> 
> On Tue, Sep 29, 2020 at 4:11 PM Ani Sinha <ani@anisinha.ca> wrote:
> >
> > On Tue, Sep 29, 2020 at 4:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 04:02:07PM +0530, Ani Sinha wrote:
> > > > On Tue, Sep 29, 2020 at 4:00 PM Ani Sinha <ani@anisinha.ca> wrote:
> > > > >
> > > > > In your pull request the following patch is completely screwed up:
> > > > >
> > > > > commit cda2006eded0ed91974e1d9e7f9f288e65812a3e
> > > > > Author: Ani Sinha <ani@anisinha.ca>
> > > > > Date:   Tue Sep 29 03:22:52 2020 -0400
> > > > >
> > > > >     tests/acpi: update golden master DSDT binary table blobs for q35
> > > > >
> > > > >
> > > > > This is not my patch. It has all sorts of changes which does not
> > > > > belong there. Can you please check?
> > > >
> > > > See https://patchew.org/QEMU/20200929071948.281157-1-mst@redhat.com/20200929071948.281157-46-mst@redhat.com/
> > >
> > >
> > > I had to regenerate the binary, yes. That's par for the course.
> > > But it looks like I added disasssembled files. Will fix up and drop,
> > > thanks for noticing this.
> 
> It's probably worthwhile to regenerate DSDT.hpbrroot as well and then
> do the diff and compare.

They are all regenerated by tests/data/acpi/rebuild-expected-aml.sh

What is important is to check the changes and not trust them blindly.

Do you see anything unexpected? It is easy to run

tests/data/acpi/disassemle-aml.sh -o <output directory>

on multiple versions and see what is going on.
Care to do this?


-- 
MST


