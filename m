Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC41C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F60207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTfAdoYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F60207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itTar-0002xL-CD
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itTaE-0002YP-S7
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itTaD-00089u-H9
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:42:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39681
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itTaD-00089b-DQ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579513376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RLV9Dpj7eSrxIibYzl1Xw8RmNClbL2rztdCat3KueN4=;
 b=fTfAdoYVhYNYbT2dB5VULxrXYqQrPWjPgGMDblLimrToMePILxRk131NVSYlsDLID/TTjS
 rKLgwerKpiODhtvy1b3oXDSGCQMcPOt4PRm1pUa3tD45cGW/1H+vBmeFx9NCA6z7a5Wlv7
 J/X8bNAVAoFiJm5XA5aUzCGo+AhmzvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-PBgFGu74MBWPRwAHmTBYcQ-1; Mon, 20 Jan 2020 04:42:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DEE68010C6;
 Mon, 20 Jan 2020 09:42:53 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6575D84DB5;
 Mon, 20 Jan 2020 09:42:52 +0000 (UTC)
Date: Mon, 20 Jan 2020 09:42:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Lieven <pl@kamp.de>
Subject: Re: qemu-4.0.1: vhost_region_add_section:Section rounded to 0 prior
 to previous a0000
Message-ID: <20200120094249.GC2827@work-vm>
References: <20200108150458.GC3184@work-vm>
 <ca222a5f-1ec6-477c-ed83-6ef52ea9e97f@kamp.de>
 <20200109184440.GR6795@work-vm>
 <b89e8ba2-49e9-8c0d-1129-116afa76366a@kamp.de>
 <cd316fb8-b56b-2913-8b57-f085ca4426d7@kamp.de>
 <11bd7f7a-9022-6c35-3b92-27d6e66f3295@kamp.de>
 <20200116202605.GN3108@work-vm>
 <a1bf5cc0-f32d-48eb-35e4-b895458f8ffe@kamp.de>
 <20200117155909.GM3209@work-vm>
 <70f7fc38-61f8-e018-5730-d4d0cb3db639@kamp.de>
MIME-Version: 1.0
In-Reply-To: <70f7fc38-61f8-e018-5730-d4d0cb3db639@kamp.de>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PBgFGu74MBWPRwAHmTBYcQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Lieven (pl@kamp.de) wrote:
> Am 17.01.20 um 16:59 schrieb Dr. David Alan Gilbert:
> > * Peter Lieven (pl@kamp.de) wrote:
> > > Am 16.01.20 um 21:26 schrieb Dr. David Alan Gilbert:
> > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > Am 16.01.20 um 13:47 schrieb Peter Lieven:
> > > > > > Am 13.01.20 um 17:25 schrieb Peter Lieven:
> > > > > > > Am 09.01.20 um 19:44 schrieb Dr. David Alan Gilbert:
> > > > > > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > > > > > Am 08.01.20 um 16:04 schrieb Dr. David Alan Gilbert:
> > > > > > > > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > > > > > > > Hi,
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > I have a Qemu 4.0.1 machine with vhost-net network ad=
apter, thats polluting the log with the above message.
> > > > > > > > > > >=20
> > > > > > > > > > > Is this something known? Googling revealed the follow=
ing patch in Nemu (with seems to be a Qemu fork from Intel):
> > > > > > > > > > >=20
> > > > > > > > > > > https://github.com/intel/nemu/commit/03940ded7f5370ce=
7492c619dccced114ef7f56e
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > The network stopped functioning. After a live-migrati=
on the vServer is reachable again.
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > Any ideas?
> > > > > > > > > > What guest are you running and what does your qemu comm=
andline look
> > > > > > > > > > like?
> > > > > > > > > Its running debian9. We have hundreds of other VMs with i=
dentical setup. Do not know why this one makes trouble.
> > > > > > > > Could you extract an 'info mtree' from it - particularly th=
e
> > > > > > > > 'address-space: memory' near the top.
> > > > > > > Here we go:
> > > > > > >=20
> > > > > > >=20
> > > > > > > address-space: memory
> > > > > > >  =A0 0000000000000000-ffffffffffffffff (prio 0, i/o): system
> > > > > > >  =A0=A0=A0 0000000000000000-000000003fffffff (prio 0, i/o): a=
lias ram-below-4g @pc.ram 0000000000000000-000000003fffffff
> > > > > > >  =A0=A0=A0 0000000000000000-ffffffffffffffff (prio -1, i/o): =
pci
> > > > > > >  =A0=A0=A0=A0=A0 00000000000a0000-00000000000affff (prio 2, i=
/o): alias vga.chain4 @vga.vram 0000000000000000-000000000000ffff
> > > > > > >  =A0=A0=A0=A0=A0 00000000000a0000-00000000000bffff (prio 1, i=
/o): vga-lowmem
> > > > > > What seems special is that the RAM area is prio2. Any idea if t=
his makes trouble?
> > > > > Update from my side. This happens when I have Debian 10 with XFCE=
 when the Graphical User Interface is initialized.
> > > > >=20
> > > > > I see the log message when I specify -M pc-i440fx-2.9. If I obmit=
 the machine type the error does not appear.
> > > > I can't persuade this to reproduce here on the images I currently h=
ave;
> > > > but if you can rebuild, can you try the v3 of 'Fix hyperv synic on
> > > > vhost' I've just posted?  It turns off the alignment code that's
> > > > spitting that error in vhost-kernel cases, so should go away.
> > > Your patch also seems to fix also my issue. No more errors and the ne=
twork keeps responding.
> > Great, can you reply to that post with a Tested-by ?
>=20
>=20
> I was not sure if I should reply since the patch is for a total different=
 issue.
>=20
> Anyway, please feel free to add a
>=20
>=20
> Tested-by: Peter Lieven <pl@kamp.de>
>=20
>=20
> I am currently not subscribed to qemu-devel so I can't reply directly.
>=20

OK, thanks!

Dave

> Best,
>=20
> Peter
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


