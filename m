Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7161BC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4935C2239E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 16:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4935C2239E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpxHD-0006uB-Ab
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 12:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55874)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hpxGz-0006Vs-8f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hpxGy-0002ji-4j
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hpxGx-0002iA-Ut
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 12:04:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F14585539
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 16:04:12 +0000 (UTC)
Received: from redhat.com (unknown [10.36.112.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21832102481D;
 Tue, 23 Jul 2019 16:04:10 +0000 (UTC)
Date: Tue, 23 Jul 2019 17:04:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190723160408.GF3778@redhat.com>
References: <20190723154856.17348-1-berrange@redhat.com>
 <20190723154856.17348-2-berrange@redhat.com>
 <bc905731-fa27-83ee-bc31-19b01fb797c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc905731-fa27-83ee-bc31-19b01fb797c9@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 23 Jul 2019 16:04:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for 4.2 1/3] glib: bump min required glib
 library version to 2.48
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 06:02:43PM +0200, Thomas Huth wrote:
> On 23/07/2019 17.48, Daniel P. Berrang=C3=A9 wrote:
> > Per supported platforms doc[1], the various min glib on relevant dist=
ros is:
> >=20
> >   RHEL-8: 2.56.1
> >   RHEL-7: 2.50.3
> >   Debian (Buster): 2.58.3
> >   Debian (Stretch): 2.50.3
> >   OpenBSD (Ports): 2.58.3
> >   FreeBSD (Ports): 2.56.3
> >   OpenSUSE Leap 15: 2.54.3
> >   SLE12-SP2: 2.48.2
> >   Ubuntu (Xenial): 2.48.0
> >   macOS (Homebrew): 2.56.0
> >=20
> > This suggests that a minimum glib of 2.48 is a reasonable target.
> >=20
> > Compared to the previous version bump in
> >=20
> >   commit e7b3af81597db1a6b55f2c15d030d703c6b2c6ac
> >   Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >   Date:   Fri May 4 15:34:46 2018 +0100
> >=20
> >     glib: bump min required glib library version to 2.40
> >=20
> > This will result in us dropping support for Debian Jessie and
> > Ubuntu 14.04.
> >=20
> > As per the commit message 14.04 was already outside our list
> > of supported build platforms and an exception was only made
> > because one of the build hosts used during merge testing was
> > stuck on 14.04.
> >=20
> > Debian Jessie is justified to drop because we only aim to
> > support at most 2 major versions of Debian at any time. This
> > means Buster and Stretch at this time.
> >=20
> > The g_strv_contains compat code is dropped as this API is
> > present since 2.44
> >=20
> > The g_assert_cmpmem compat code is dropped as this API is
> > present since 2.46
> >=20
> > [1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platfo=
rms
> >=20
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20
> Sorry, my memory fails ... when did I review this patch?

Doh, sorry - cut & paste screwup. I'll drop this line.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

