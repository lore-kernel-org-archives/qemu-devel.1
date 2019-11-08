Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1735C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A0A21924
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iqmy1/Zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A0A21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT57H-0003zi-Ga
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iT56U-0003RB-6s
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iT56S-0002IV-KM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:19:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45093
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iT56R-0002Gs-Bf
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573222746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCjCXQUhnMP26PHu8bjzNLTBBJ9pwChDafOnIZYum9w=;
 b=Iqmy1/Zy19Dqxnmg43IkiFOBG1J0/1UwhJHtMc3AI66hAG/kmaZEWZcbiL4aieii33ANTk
 9ROt05wkfLcWgHstD3BM9XGknkOkIWD86D096DB+dN2ThLogYAE9EcG6WE8tMgMrn8JWgu
 3/I63P6lfzD9z4ZvA+WtpOl0/kvUm54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-PWCeP0PoM_2bCF2O4zgELw-1; Fri, 08 Nov 2019 09:19:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16F20800C72;
 Fri,  8 Nov 2019 14:19:02 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B747C6084E;
 Fri,  8 Nov 2019 14:18:59 +0000 (UTC)
Date: Fri, 8 Nov 2019 15:18:57 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 2/2] qapi: deprecate implicit filters
Message-ID: <20191108141857.GJ9577@angien.pipo.sk>
References: <20191108101655.10611-1-vsementsov@virtuozzo.com>
 <20191108101655.10611-3-vsementsov@virtuozzo.com>
 <20191108132725.GH9577@angien.pipo.sk>
 <f0209640-36fe-ed7c-c58b-0df401364a8d@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <f0209640-36fe-ed7c-c58b-0df401364a8d@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PWCeP0PoM_2bCF2O4zgELw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 13:56:03 +0000, Vladimir Sementsov-Ogievskiy wrote:
> 08.11.2019 16:27, Peter Krempa wrote:
> > On Fri, Nov 08, 2019 at 13:16:55 +0300, Vladimir Sementsov-Ogievskiy wr=
ote:

[...]

> > Note that 'block-commit' and 'drive-mirror' commands are used by libvir=
t
> > in the pre-blockdev era. In those instances we gather statistics of
> > block devices by nesting in the output of query-blockstats and
> > query-block rather than selecting the appropriate info by any other
> > means (e.g. by node name).
> >=20
> > This means that the output MUST stay consistend when block jobs are use=
d
> > and the hack this patch is deprcating will break those.
> >=20
> > Note that in libvirt we don't plan to invest time to add workarounds fo=
r
> > non-blockdev cases since blockdev by itself is complex enough and I'd
> > strongly prefer not having a third code path to care about.
> >=20
> > Given that -blockdev can't be used in all cases (e.g. for sd-cards)
> > which also blocks deprecation of -drive I don't think that hiding of
> > implicit filter nodes can be deprecated until -drive is deprecated.
> >=20
>=20
>=20
> OK, so, we can't deprecate anything around it now.
>=20
> What is the problem with sd-cards?

So the problem was that it was impossible to instantiate it via -device,
but looking at the qemu code base this doesn't seem to be true any more.

I'll have a look whether we can rework the instantiation of sd card
frontends in libvirt somehow or whether it actually ever worked.
Unfortunately the documentation seems to be rather sparse.


