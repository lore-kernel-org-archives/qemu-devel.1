Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5DCC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696DC2464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiozvRk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696DC2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGHs-0002wI-SR
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1idF3u-00061v-Ko
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1idF3t-0003Xa-GB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:58:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25551
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1idF3r-0003VY-Ft
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0eE1Ell3ER1XzngozBueUW3DTe4Cka2OH3WB8BQShA=;
 b=OiozvRk/bcfU7ynOcqSNFVR6qotlolnhmENWS8/CiqiHsMm3r7rjcGu0sYWXv+j7d9zg5f
 dlqDuAiVdpW1x4hSHxw6DoYA9rt79wVdd4n6dOl2joS25NfuES7PI4N6yhryrpibABwmNr
 xwso3mzlexqzFjlhW6P2eBk7pvfL5qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-0nMwB1tYMc6cLRruGrdLnA-1; Fri, 06 Dec 2019 05:57:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C49C41005502
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 10:57:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB17960BF4;
 Fri,  6 Dec 2019 10:57:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CC19416E18; Fri,  6 Dec 2019 11:57:41 +0100 (CET)
Date: Fri, 6 Dec 2019 11:57:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/3] Remove deprecated pc-0.x machine types and related
 hacks
Message-ID: <20191206105741.zeckqevl3gglgdhg@sirius.home.kraxel.org>
References: <20191205160652.23493-1-thuth@redhat.com>
 <874kyeosmg.fsf@dusky.pond.sub.org>
 <a25c0ae9-38cf-8a8f-730e-b618ad05bb7b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a25c0ae9-38cf-8a8f-730e-b618ad05bb7b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0nMwB1tYMc6cLRruGrdLnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > $ git-grep pc-0
> > hw/display/vga-pci.c:        /* compatibility with pc-0.13 and older */
> > hw/display/vga.c:    /* With pc-0.12 and below we map both the PCI BAR =
and the fixed VBE region,
> > hw/display/vmware_vga.c:        /* compatibility with pc-0.13 and older=
 */
>=20
> These are the "rombar" hacks that I've mentioned above. The question is
> whether we want to remove them or whether I should just adjust the commen=
ts?

Hmm.  All that cruft ...

vga maps the framebuffer @ 0xe0000000 with rombar=3Doff. It's an alias of
the pci memory bar.  rombar=3Doff is basically a flag for "really old
firmware" here, vgabios used to have that address hardcoded, a decade
ago.  We fixed that roughly the same timeframe where we switched to
seabios, which in turn allowed us to place the vgabios in the pci rom
bar (instead of copying it to 0xa000 in guest ram).  Which is probably
the reason why we have only one switch for both.

I don't expect anyone actually sets the rombar property for vga devices
(it's more common for NICs, for network boot tweaks), so I guess we can
get away with simply dropping the hacks in vga-pci.c and vmware_vga.c.
The comment in vga.c is not fully correct though, isa-vga needs that
too, so we have to keep vga_init_vbe for the time being ...

cheers,
  Gerd


