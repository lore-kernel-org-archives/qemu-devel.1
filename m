Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC474C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E208920848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCgWpy+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E208920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTT95-00072F-Np
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kTT8E-0006aT-U4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:03:06 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:40002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kTT8C-0006HE-PE
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:03:06 -0400
Received: by mail-lf1-x143.google.com with SMTP id a9so3817282lfc.7
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zv8iWa+xTqVtDgllI7gt6Ed7/TcekXXbJ1P2Kb3yK1g=;
 b=DCgWpy+eENccUPCa6eQgRmQx9F7+4oB0IQ+N0/6Gvhb8lFeGqBg91jEnDlISyaA4Xx
 IN3s+LFSouxDHdQBViSY4/IOhsg6NpUufQfyiKZYtMt/s712yMKlj1ht34wThTzi99WL
 NOTyxO2jQcSJxcnmYNVrjTRb8ZmhFb3M6ypnG7cczfm4HtWqPg0FbnHzpkHod20SKSCv
 oDzGZjcI4LNve/aq5UzLtTGwH1Izza5cx6tgU3221OgG5kb9LG5uZzATT/sjnqJVTtN5
 VFhMpDBwP/UDLg+nccjTpoAKytj7LrYXA7+qbPe/xZDZbBzXBardumWBj3kMPfnOA7xT
 A3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zv8iWa+xTqVtDgllI7gt6Ed7/TcekXXbJ1P2Kb3yK1g=;
 b=RE2iDMr4XPvwvT/7DR6f7pM1WchPhQjPSjXkXZzszO52EaONw7qEvZ9WKcJpwar4/v
 863GTv23Py4P7fHqOLhDpwXrbfF0M6NP+QdhyZmWnObJDShu0KqffhGNz4jkWS/X5IUq
 O8kYgQVKxAOJ7J2vkLMU3lNeEXttTD1J3mJmJR1dovbEyZPqe9bVBHQln0llgGoHh6JY
 F+XuefBl/nA1x7XTk83F2vs+jmEwkpUUAu5wILYgvrzJRJfixoMerRDqEJMnkqjziehz
 5EqIg7FhBM4q9a/xjBVbp8r7jKlHHWmqODOZtp7PW4orbTwcm0k56/gxSZxez+8GPxbc
 REwg==
X-Gm-Message-State: AOAM530oOq37QubupuxrRzDvV2mYyFOzNwgIkIDAGqANFH5PG/0/CX76
 /GeYutjwTaPqFqPpI9jbhVFngI2wFr4nzDs7D38=
X-Google-Smtp-Source: ABdhPJyGL/Yooebd0519+/4KTDkpfCwS6mxLkqyhD7ELt7L7HAP7ohf1M4H2M4NZPZEOuj0GEptsIJL8YN5hFbti6Ew=
X-Received: by 2002:ac2:4ed0:: with SMTP id p16mr1681945lfr.554.1602867782406; 
 Fri, 16 Oct 2020 10:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201013190506.3325-1-jandryuk@gmail.com>
 <20201016153708.GB3105841@perard.uk.xensource.com>
 <CAKf6xpssB-FGwiEhLqV8OFjBGuP4LKYh+9Pj_Bj7p5U2CJSw=g@mail.gmail.com>
 <20201016164428.GC3105841@perard.uk.xensource.com>
In-Reply-To: <20201016164428.GC3105841@perard.uk.xensource.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Fri, 16 Oct 2020 13:02:50 -0400
Message-ID: <CAKf6xpst6xpMytFf_Pqi9-Y5TqhcfGp5odq=DEA-hBBjdSHMWw@mail.gmail.com>
Subject: Re: [PATCH] hw/xen: Set suppress-vmdesc for Xen machines
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=jandryuk@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 12:44 PM Anthony PERARD
<anthony.perard@citrix.com> wrote:
>
> On Fri, Oct 16, 2020 at 12:01:47PM -0400, Jason Andryuk wrote:
> > On Fri, Oct 16, 2020 at 11:38 AM Anthony PERARD
> > <anthony.perard@citrix.com> wrote:
> > >
> > > On Tue, Oct 13, 2020 at 03:05:06PM -0400, Jason Andryuk wrote:
> > > > xen-save-devices-state doesn't currently generate a vmdesc, so restore
> > > > always triggers "Expected vmdescription section, but got 0".  This is
> > > > not a problem when restore comes from a file.  However, when QEMU runs
> > > > in a linux stubdom and comes over a console, EOF is not received.  This
> > > > causes a delay restoring - though it does restore.
> > > >
> > > > Setting suppress-vmdesc skips looking for the vmdesc during restore and
> > > > avoids the wait.
> > >
> > > suppress-vmdesc is only used during restore, right? So starting a guest
> > > without it, saving the guest and restoring the guest with
> > > suppress-vmdesc=on added will work as intended? (I'm checking that migration
> > > across update of QEMU will work.)
> >
> > vmdesc is a json description of the migration stream that comes after
> > the QEMU migration stream.  For our purposes, <migration
> > stream><vmdesc json blob>.  Normal QEMU savevm will generate it,
> > unless suppress-vmdesc is set.  QEMU restore will read it because:
> > "Try to read in the VMDESC section as well, so that dumping tools that
> > intercept our migration stream have the chance to see it."
> >
> > Xen save does not go through savevm, but instead
> > xen-save-devices-state, which is a subset of the QEMU savevm.  It
> > skips RAM since that is read out through Xen interfaces.  Xen uses
> > xen-load-devices-state to restore device state.  That goes through the
> > common qemu_loadvm_state which tries to read the vmdesc stream.
> >
> > For Xen, yes, suppress-vmdesc only matters for the restore case, and
> > it suppresses the attempt to read the vmdesc.  I think every Xen
> > restore currently has "Expected vmdescription section, but got -1" in
> > the -dm.log since the vmdesc is missing.  I have not tested restoring
> > across this change, but since it just controls reading and discarding
> > the vmdesc stream, I don't think it will break migration across
> > update.
>
> Thanks for the explanation.
>
> Acked-by: Anthony PERARD <anthony.perard@citrix.com>
>
> Do you think you could send a patch for libxl as well? Since libxl in
> some cases may use the "pc machine instead of "xenfv". I can send the
> patch otherwise.

I should be able to, yes.

Regards,
Jason

