Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A30C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5AC206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6DnYPh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5AC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlcA-0006bM-IF
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1irkhR-0000xP-To
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1irkhO-0005pt-FW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:35:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1irkhO-0005oJ-AT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579102512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/uTMn24Zke4DRuhEw7wyZIybd89ak3R1ZI5+FRteL8=;
 b=X6DnYPh/lpFiUVhDNsafA10R8XCBd1hS3TldemyxxNIXpY5N8d0MitlVO5vrqBCG6z6TUo
 PdAN5dOG4BRQzHFWS84lRrbnn3gEJ+A6WynJY5Jb7LuGGmXsUqVutFk1KHi2HwTVDGcPgi
 3URailnTVVsBm+NRMc6Y6ntj/UiWoDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-VBWK8jUzPMWpm1R8SUoEOQ-1; Wed, 15 Jan 2020 10:35:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C3F6928C3C;
 Wed, 15 Jan 2020 15:35:07 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 063EC675AF;
 Wed, 15 Jan 2020 15:34:55 +0000 (UTC)
Date: Wed, 15 Jan 2020 16:34:53 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [libvirt] [PATCH v2 82/86] numa: forbid '-numa node, mem' for
 5.0 and newer machine types
Message-ID: <20200115153453.GL3243410@angien.pipo.sk>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-83-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-83-git-send-email-imammedo@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: VBWK8jUzPMWpm1R8SUoEOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 16:07:37 +0100, Igor Mammedov wrote:
> Deprecation period is ran out and it's a time to flip the switch
> introduced by cd5ff8333a.
> Disable legacy option for new machine types and amend documentation.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: peter.maydell@linaro.org
> CC: ehabkost@redhat.com
> CC: marcel.apfelbaum@gmail.com
> CC: mst@redhat.com
> CC: pbonzini@redhat.com
> CC: rth@twiddle.net
> CC: david@gibson.dropbear.id.au
> CC: libvir-list@redhat.com
> CC: qemu-arm@nongnu.org
> CC: qemu-ppc@nongnu.org
> ---
>  hw/arm/virt.c        |  2 +-
>  hw/core/numa.c       |  6 ++++++
>  hw/i386/pc.c         |  1 -
>  hw/i386/pc_piix.c    |  1 +
>  hw/i386/pc_q35.c     |  1 +
>  hw/ppc/spapr.c       |  2 +-
>  qemu-deprecated.texi | 16 ----------------
>  qemu-options.hx      |  8 ++++----
>  8 files changed, 14 insertions(+), 23 deletions(-)

I'm afraid nobody bothered to fix it yet:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1783355


