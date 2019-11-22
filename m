Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45162C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F79C2070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1qC6Se9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F79C2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY5zv-0005GC-1y
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iY5yf-0004X9-Vw
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iY5ye-000607-2T
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:15:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iY5yc-0005xm-QE
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574417745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZhSMq8IjUe1QgSwcyQLAAw0XNYDc5owleo66ELKG2E=;
 b=P1qC6Se97MI7qd6sPAFLCa/KK1n4v0h5JVcno9JWocM9udxxa6qnsMkSQ9+IuQAY2ojCko
 ZGKlQvZN7RlEqVyBiKtsw5rJ7heyGnQFf8X/GiXbNgJaQpaJgh0gQ7E/bxBMLtEGnPgxyB
 E3xa3x+C1DTwQEMDGGKLNxDPPA4kcm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-Lue5DvlBMi-ihL3J05KiAQ-1; Fri, 22 Nov 2019 05:15:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45363802678;
 Fri, 22 Nov 2019 10:15:35 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2653860141;
 Fri, 22 Nov 2019 10:15:30 +0000 (UTC)
Date: Fri, 22 Nov 2019 10:15:28 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 0/9] RFC: [for 5.0]: HMP monitor handlers cleanups
Message-ID: <20191122101528.GB2785@work-vm>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120185850.18986-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Lue5DvlBMi-ihL3J05KiAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Maxim Levitsky (mlevitsk@redhat.com) wrote:
> This patch series is bunch of cleanups
> to the hmp monitor code.
>=20
> This series only touched blockdev related hmp handlers.

Hi Maxim,
  This looks mostly OK to me from the HMP side - with one change;
can you please move the blockdev-hmp-cmds.c into either monitor/ or
block/; with that


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

we also need a corresponding review by a block person.

Dave


> No functional changes expected other that
> light error message changes by the last patch.
>=20
> This was inspired by this bugzilla:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1719169
>=20
> Basically some users still parse hmp error messages,
> and they would like to have them prefixed with 'Error:'
>=20
> In commit 66363e9a43f649360a3f74d2805c9f864da027eb we added
> the hmp_handle_error which does exactl that but some hmp handlers
> don't use it.
>=20
> In this patch series, I moved all the block related hmp handlers
> into blockdev-hmp-cmds.c, and then made them use this function
> to report the errors.
>=20
> I hope I didn't change too much code, I just felt that if
> I touch this code, I can also make it easier to find these
> handlers, that were scattered over 3 different files.
>=20
> Best regards,
> =09Maxim Levitsky
>=20
> Maxim Levitsky (9):
>   monitor: uninline add_init_drive
>   monitor: rename device-hotplug.c to blockdev-hmp-cmds.c
>   monitor: move hmp_drive_del and hmp_commit to blockdev-hmp-cmds.c
>   monitor: move hmp_drive_mirror and hmp_drive_backup to
>     blockdev-hmp-cmds.c
>   monitor: move hmp_block_job* to blockdev-hmp-cmd.c
>   monitor: move hmp_snapshot_* to blockdev-hmp-cmds.c
>   monitor: move remaining hmp_block* functions to blockdev-hmp-cmds.c
>   monitor: move hmp_info_block* to blockdev-hmp-cmds.c
>   monitor/hmp: Prefer to use hmp_handle_error for error reporting in
>     block hmp commands
>=20
>  MAINTAINERS         |   1 +
>  Makefile.objs       |   4 +-
>  blockdev-hmp-cmds.c | 656 ++++++++++++++++++++++++++++++++++++++++++++
>  blockdev.c          |  95 -------
>  device-hotplug.c    |  91 ------
>  monitor/hmp-cmds.c  | 465 -------------------------------
>  6 files changed, 659 insertions(+), 653 deletions(-)
>  create mode 100644 blockdev-hmp-cmds.c
>  delete mode 100644 device-hotplug.c
>=20
> --=20
> 2.17.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


