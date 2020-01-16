Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479A8C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC0F2072E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gq5TZr9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC0F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isBk0-0003al-UI
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 15:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isBif-0001WI-LS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isBia-00082D-L8
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:26:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isBia-00080l-Gu
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579206373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATwMHOBFnMkoUL0Ov4nqFQfte3qrWcDlKu/r7xNwBZg=;
 b=Gq5TZr9uaE0KjdK6ukesb1CR/s18/ZhLDVA1YIz6ep4dF4HzewOEQFOP9RuX1V3KM3crdx
 E8QuK4XUTuGgldwyF42J1JrOSm8xOln9z1bqo2NG9jPQdWgvyz/RlF+9c0iBq6FbjCY1yI
 0Dv3Tkp/rR/auWqhMkRqzvv00FI/99w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-Zd-Q2NpaO--SeAbPwNmNSg-1; Thu, 16 Jan 2020 15:26:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 082EDA0CC1;
 Thu, 16 Jan 2020 20:26:09 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56FF326172;
 Thu, 16 Jan 2020 20:26:08 +0000 (UTC)
Date: Thu, 16 Jan 2020 20:26:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Lieven <pl@kamp.de>
Subject: Re: qemu-4.0.1: vhost_region_add_section:Section rounded to 0 prior
 to previous a0000
Message-ID: <20200116202605.GN3108@work-vm>
References: <985fea06-ede6-dcb7-8829-a48a9416bc09@kamp.de>
 <20200108150458.GC3184@work-vm>
 <ca222a5f-1ec6-477c-ed83-6ef52ea9e97f@kamp.de>
 <20200109184440.GR6795@work-vm>
 <b89e8ba2-49e9-8c0d-1129-116afa76366a@kamp.de>
 <cd316fb8-b56b-2913-8b57-f085ca4426d7@kamp.de>
 <11bd7f7a-9022-6c35-3b92-27d6e66f3295@kamp.de>
MIME-Version: 1.0
In-Reply-To: <11bd7f7a-9022-6c35-3b92-27d6e66f3295@kamp.de>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Zd-Q2NpaO--SeAbPwNmNSg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> Am 16.01.20 um 13:47 schrieb Peter Lieven:
> > Am 13.01.20 um 17:25 schrieb Peter Lieven:
> > > Am 09.01.20 um 19:44 schrieb Dr. David Alan Gilbert:
> > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > Am 08.01.20 um 16:04 schrieb Dr. David Alan Gilbert:
> > > > > > * Peter Lieven (pl@kamp.de) wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > >=20
> > > > > > > I have a Qemu 4.0.1 machine with vhost-net network adapter, t=
hats polluting the log with the above message.
> > > > > > >=20
> > > > > > > Is this something known? Googling revealed the following patc=
h in Nemu (with seems to be a Qemu fork from Intel):
> > > > > > >=20
> > > > > > > https://github.com/intel/nemu/commit/03940ded7f5370ce7492c619=
dccced114ef7f56e
> > > > > > >=20
> > > > > > >=20
> > > > > > > The network stopped functioning. After a live-migration the v=
Server is reachable again.
> > > > > > >=20
> > > > > > >=20
> > > > > > > Any ideas?
> > > > > > What guest are you running and what does your qemu commandline =
look
> > > > > > like?
> > > > >=20
> > > > > Its running debian9. We have hundreds of other VMs with identical=
 setup. Do not know why this one makes trouble.
> > > > Could you extract an 'info mtree' from it - particularly the
> > > > 'address-space: memory' near the top.
> > >=20
> > >=20
> > > Here we go:
> > >=20
> > >=20
> > > address-space: memory
> > > =A0 0000000000000000-ffffffffffffffff (prio 0, i/o): system
> > > =A0=A0=A0 0000000000000000-000000003fffffff (prio 0, i/o): alias ram-=
below-4g @pc.ram 0000000000000000-000000003fffffff
> > > =A0=A0=A0 0000000000000000-ffffffffffffffff (prio -1, i/o): pci
> > > =A0=A0=A0=A0=A0 00000000000a0000-00000000000affff (prio 2, i/o): alia=
s vga.chain4 @vga.vram 0000000000000000-000000000000ffff
> > > =A0=A0=A0=A0=A0 00000000000a0000-00000000000bffff (prio 1, i/o): vga-=
lowmem
> >=20
> >=20
> > What seems special is that the RAM area is prio2. Any idea if this make=
s trouble?
>=20
>=20
> Update from my side. This happens when I have Debian 10 with XFCE when th=
e Graphical User Interface is initialized.
>=20
> I see the log message when I specify -M pc-i440fx-2.9. If I obmit the mac=
hine type the error does not appear.

I can't persuade this to reproduce here on the images I currently have;
but if you can rebuild, can you try the v3 of 'Fix hyperv synic on
vhost' I've just posted?  It turns off the alignment code that's
spitting that error in vhost-kernel cases, so should go away.

Dave

>=20
> Peter
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


