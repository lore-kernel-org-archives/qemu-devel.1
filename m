Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BD6C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887D9206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyFnoHxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887D9206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDff-0001n6-NF
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jEDet-0001Ip-DI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jEDes-0006Ym-3E
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:57:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jEDer-0006WB-Vh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584457049;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ham8MiA9M6se9eiYHkeJYLxG9Pl1tRk2nLVjyLQCuGw=;
 b=YyFnoHxMf0arQUUARDn2LvouJNatmkSzUIttCIesWrvB536muv5ak0CLm18x/1GGPuunH5
 QDXpwy1n6TTW+yj6wOBhczvqR9oQjQookIX44+4cD9HqSmCFPfS/nq6uFBz3KpLg1lFiWY
 fyqof70altOaQl9X2Jb73BfdV5taPQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-VQIUFB7rMCm7E8V9P5huSw-1; Tue, 17 Mar 2020 10:57:22 -0400
X-MC-Unique: VQIUFB7rMCm7E8V9P5huSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CB4C10CC448;
 Tue, 17 Mar 2020 14:57:16 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82FCF5C1BB;
 Tue, 17 Mar 2020 14:57:07 +0000 (UTC)
Date: Tue, 17 Mar 2020 14:57:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 00/10] Bitmaps patches
Message-ID: <20200317145703.GH2041016@redhat.com>
References: <20200317043819.20197-1-jsnow@redhat.com>
 <CAFEAcA_=DHpNZ+b9Hrim39R74Jik8MKqu8MPJm80wMsQS0FADQ@mail.gmail.com>
 <5805273e-0a2f-850a-a07a-97dac0d7211e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5805273e-0a2f-850a-a07a-97dac0d7211e@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 09:40:00AM -0500, Eric Blake wrote:
> On 3/17/20 9:00 AM, Peter Maydell wrote:
> > On Tue, 17 Mar 2020 at 04:38, John Snow <jsnow@redhat.com> wrote:
>=20
> > >=20
> > >    block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty (2020-03-12 1=
6:36:46 -0400)
> > >=20
> > > ----------------------------------------------------------------
> > > Pull request
> > >=20
> > > ---------------------------------------------------------------
> >=20
> > Hi; this fails to compile with clang:
> >=20
> > /home/petmay01/linaro/qemu-for-merges/nbd/server.c:1937:1: error:
> > unused function 'glib_listautoptr_cleanup_NBDExtentArray'
> > [-Werror,-Wunused-function]
> > G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
> > ^
> > /usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from macro
> > 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
> >    static inline void _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList
> > **_l) { g_list_free_full (*_l, (GDestroyNotify) func); } \
> >                       ^
> > /usr/include/glib-2.0/glib/gmacros.h:443:48: note: expanded from macro
> > '_GLIB_AUTOPTR_LIST_FUNC_NAME'
> > #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName)
> > glib_listautoptr_cleanup_##TypeName
> >                                                 ^
> > <scratch space>:49:1: note: expanded from here
> > glib_listautoptr_cleanup_NBDExtentArray
> > ^
>=20
> Should we add -Wno-unused-function to CFLAGS when dealing with a version =
of
> clang that complains about that version of glib's headers?  Is it fixed i=
n a
> newer version of glib, where we could just backport a newer definition of
> G_DEFINE_AUTOPTR_CLEANUP_FUNC() that adds whatever annotations are needed=
 to
> shut the compiler up?
>=20
> On IRC, danpb pointed me to libvirt's solution:
> https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dcommit;h=3D44e7f029
>=20
> Maybe we just write our own macro wrapper around
> G_DEFINE_AUTOPTR_CLEANUP_FUNC which takes care of adding necessary
> annotations and use that instead (and our macro name might be shorter...)

My preference is to stick with regular glib functions/macros whereever
practical, rather than inventing QEMU replacements which add a knowledge
burden for contributors. That's why we moved to -Wno-unused-function in
libvirt.

I don't feel like -Wno-unused-function looses anything significant, as
the GCC builds will still be reporting unused functions which will
catch majority of cases.

Possibly we could figure out a patch for glib upstream that uses pragma
push/pop to squelch the warning ?  They are quite receptive to patches
IME.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


