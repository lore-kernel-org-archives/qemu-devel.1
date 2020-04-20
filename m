Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61374C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D472206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZ2zeQ9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D472206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXxd-00089g-CB
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54632 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jQXwW-00075u-73
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:02:40 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jQXwU-0005G4-Q7
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:02:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47609
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jQXwU-0005DY-5D
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587394955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhxzKHPdkV1pT2x+QNIdjooBgExnpVNic7X72q3lm7Y=;
 b=hZ2zeQ9TnYPTwtB/tGaG/xBAA2CfieYYT+l8tE37K8TkUJ339/uN5FZn2PwEZjZ13bNl7g
 eKL2et2p6yeTFHR91k3e6AfKE7E4po4LwPtT9KSyLLVEY8GkADau5xCBGNdDZUvX2vPZVD
 Xn2X38FnnBnaye81+st9GLVFoiGDdzc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-Unh29T-ZMU-KEgOnsK5BNA-1; Mon, 20 Apr 2020 11:02:27 -0400
X-MC-Unique: Unh29T-ZMU-KEgOnsK5BNA-1
Received: by mail-wm1-f72.google.com with SMTP id q5so4271253wmc.9
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QOBnP6nfqPIpxrE3ZWtBBWf3ETjn6TWCnm817oNCv48=;
 b=kvnLblcPVwsC/IAT59SR7QOaKdJZ7zkPhJWieWTCj0+rswdeqNmxY621TFOlPar/m+
 7Yh6ml7knDTM/pCIoKhPcS6v+FOLivVBbp6YwD9FT9Bh7XtubEaZL7mFW0VV4RU8tkCP
 lgaxkZ0zOf0xkIy8gLNMPpV7Nh7+v4OTVU124WXIbNsqw+vf+ftrWyhhlI0J0DosIVE0
 hWImbuuIrpwyOT7fopxiwQW+pOGMt6M1Rv4YIh0CVXTb0ruegoWU+fWpnKnAZYN5RzVm
 ToeA4+UvG1PO5O7hbqQzAQa9Ylhu774e+F27WIVcjQrpwKILFoc+Rc/N5iXqGDU1EuxZ
 e72A==
X-Gm-Message-State: AGi0PuYKlPpi2P+DlVCpAD0Fjh4VkpjiJtXHnEUJG+0yo700bGYJcdgL
 8rsN8p0k3579EZgrUOj1oiJsvE+amBPjL4duIgUPczgsrFmFGskVtAo1GMAxvm8gpcLQUoV9SD4
 rrHRF5FUfK0YxWNo=
X-Received: by 2002:adf:e711:: with SMTP id c17mr18168662wrm.334.1587394945807; 
 Mon, 20 Apr 2020 08:02:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypJjrD/Wwa9i3rCA6hNbPMWlLAnDlrcM/4SdFlxXkGRTyHW9h0Pv6k4VpGFZhm8QVwerR+5fhw==
X-Received: by 2002:adf:e711:: with SMTP id c17mr18168635wrm.334.1587394945595; 
 Mon, 20 Apr 2020 08:02:25 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id k8sm1486711wrm.52.2020.04.20.08.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 08:02:25 -0700 (PDT)
Date: Mon, 20 Apr 2020 11:02:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Message-ID: <20200420105936-mutt-send-email-mst@kernel.org>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200420092459.GF346737@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 20, 2020 at 10:24:59AM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Apr 17, 2020 at 12:09:00PM -0400, Michael S. Tsirkin wrote:
> > On Fri, Apr 17, 2020 at 03:36:14PM +0000, Ani Sinha wrote:
> > >=20
> > >=20
> > > > On Apr 17, 2020, at 8:57 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > > >=20
> > > > Is there a real reason to do this? Can't we just limit the
> > > > hotplug control to pcie ports? At some point I'd like us to
> > > > start leaving piix alone..
> > >=20
> > > Yes we really need this feature as want to be able to hot plug device=
s into the guest but prevent customers from hot unplugging them from say Wi=
ndows system tray.
> > >=20
> > > ani
> >=20
> > Problem is, I think this is not something we can support with pcie or s=
hpc.
> > I'm reluctant to add features that only ACPI can support,
> > we are trying to phase that out.
>=20
> >From the upstream POV, there's been no decision / agreement to phase
> out PIIX,

Phase out now.  But I for one would like to focus on keeping PIIX stable
and focus development on q35.  Not bloating PIIX with lots of new
features is IMHO a good way to do that.



> this is purely a RHEL downstream decision & plan. If other
> distros / users have a different POV, and find the feature useful, we
> should accept the patch if it meets the normal QEMU patch requirements.
>=20
> Regards,
> Daniel

Orthogonality of features is important. It is tough to navigate our
feature matrix as it is. Figuring things out if random features
depend on other random features becomes impossible.


> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


