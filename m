Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEFAC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07719206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dt0RblWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07719206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AVK-00063L-6n
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j5AUO-0005Kl-7R
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j5AUN-00032S-0H
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:45:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44206
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j5AUM-00032F-S9
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582299914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbDoKszJJ0iuYZhKPXvDqEXL223tVh4pRgIp1H/FYzQ=;
 b=Dt0RblWkNPG6MSqc7eXJJ0O3BWHLeC0G+zC9uK0CHFnNYq0zQF46JocDceyAFoV7cdb+tC
 dadqFcXeCEq9yleErKrHVbMaMxM9K5z3Nz0kW7yBr3pqbCt8crRKQTjYh/W/FviCX1Zp01
 a4DQXX/SDCvpH6+JFgIuVORNXpdQIRU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-GO37OjR8OjKPXtfSR2PmQg-1; Fri, 21 Feb 2020 10:45:10 -0500
X-MC-Unique: GO37OjR8OjKPXtfSR2PmQg-1
Received: by mail-qt1-f199.google.com with SMTP id t4so2052422qtd.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jvfQlqWDgWKBy2rM7H3TEHtDStgpHcnet+bgeOxS/W8=;
 b=TOjvC0xcXU9gzwRz7PtCMvI8gSV0vGrLIztC+8R3TWBm7f/ERm+8qoR7dfUzihPhzV
 2kSo4eiOAnVn14c7+VRUUwXp4VVbim8rgL2Zp477WvkWM9+TZeXitLTfk0ayvjdLqINt
 E0GGH+GHJNzP7XEAcMld50Iqc5Z3N42jmQTalQqKv600+sq13eKsmgWuTHD6GC/Zo1zv
 Cn7iUE7NoTE++lP3x+EGeEko1RNSOrO5LIbdTVrnmVX6IsXXMBUynJ6qO/GL3eqjFcfH
 +NZcak3BMOiuTiMK8dPbE6BQTtul9mhw6wUXjFWVfraN1uVGf2LkKOyfY+hQHsZ6pyYu
 C1LA==
X-Gm-Message-State: APjAAAXdeHghfhyHDJ64LdpH4Vjdc3qFvt2T+kQ2DGI9ilKNiC4BCZoX
 C8WqUjGVtdu6iRPu2bGpqE2sa1r/wUSbjiZ0PeO9EwTtUMcsN0HjTTUmPm5nRPzeVCZ66681AD0
 nJoZsg9M7ixQZTVE=
X-Received: by 2002:a05:6214:209:: with SMTP id
 i9mr30819739qvt.54.1582299910315; 
 Fri, 21 Feb 2020 07:45:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwT1/SoBzoWgEjVjF9l1wQH1p82WNgtcO+1S17DjBpjnlYys9mIomxxowjxxuFmz3X49X5Dpw==
X-Received: by 2002:a05:6214:209:: with SMTP id
 i9mr30819724qvt.54.1582299910120; 
 Fri, 21 Feb 2020 07:45:10 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id d20sm1719674qto.2.2020.02.21.07.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 07:45:09 -0800 (PST)
Date: Fri, 21 Feb 2020 10:45:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] pcie_root_port: Add disable_hotplug option
Message-ID: <20200221103700-mutt-send-email-mst@kernel.org>
References: <20200218161717.386723-1-jusual@redhat.com>
 <d872dcc7-9275-1354-ce6a-7dd52ac33929@redhat.com>
 <CAMDeoFVQis-UXKpGZNJkD9NqyozwUxW+nn_h6iv+f-EgkLeRKw@mail.gmail.com>
 <9ea6a6b9-778d-78a8-1909-dce1ed98a24d@redhat.com>
 <20200218223104-mutt-send-email-mst@kernel.org>
 <CAMDeoFUcAbjvii2wtFKO06cEjxV4-xc1Cz1x5xyM=LGWoA+4iA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDeoFUcAbjvii2wtFKO06cEjxV4-xc1Cz1x5xyM=LGWoA+4iA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laine Stump <laine@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 01:21:10PM +0100, Julia Suvorova wrote:
> On Wed, Feb 19, 2020 at 4:47 AM Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >
> > On Tue, Feb 18, 2020 at 10:02:19PM -0500, Laine Stump wrote:
> > > Also, is there a rhyme/reason for some options having true/false, and=
 some
> > > being off/on? disable-acs seems to be true/false, but disable-modern =
is
> > > on/off. Doesn't make any difference to me in the end, but just though=
t I'd
> > > bring it up in case there might be a reason to use on/off instead of
> > > true/false for this one.
> >
> > Some places accept on/off, some true/false, some on/off/true/false
> > others on/off/yes/no and others on/off/true/false/yes/no.
> >
> > In this case both user visitor machinery. Which I *think*
> > means on/off is the safe choice and true/false can be
> > broken in some places.
> >
> > We really should clean up this mess ... Julia, what do you think?
> > Let's make them all support all options?
>=20
> Options already support all of on/off/true/false/yes/no as long as
> they are defined as boolean (look at parse_type_bool()). That is, you
> can use disable-modern with yes/no/true/false too.
> The only problem is with types OnOffSplit and OnOffAuto (as in disable-le=
gacy).

Right. Not only that though - parse_option_bool can only handle
on/off. target/sparc/cpu.c can handle on/off and true/false.
JSON bool is only true/false.
As you said OnOffSplit and OnOffAuto are on/off.

And from documentation POV, it's all over the place.



--=20
MST


