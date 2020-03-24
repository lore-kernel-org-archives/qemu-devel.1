Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URI_NOVOWEL,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9B9C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EF72070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EE/aBqyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EF72070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgEn-0000hC-Mt
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 05:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jGgE4-0008Dz-M6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jGgE3-0003bS-3Y
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:52:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52581)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jGgE2-0003b3-UH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585043518;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzV+tRgv43biuKPT0qoPlbdSGIpV1aQkiiEWtfcf5zY=;
 b=EE/aBqyTIVGhvA6lrEQIhMQW1XyPeB+nqoOOLvE0pjafDRXs88D/Hmeb81J6PTv0gS5zFD
 2xLEXNwVeHAaXm/M6d3gjkrux6gEbmS0a1vaKlQCaJp4tfSBKMdl81QdKl/5i/6d5uL178
 ointgmIQCLOsH8DabP3VW+5VzpbDheU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-z1TiBgWjMH2C92d-G6L5AQ-1; Tue, 24 Mar 2020 05:51:48 -0400
X-MC-Unique: z1TiBgWjMH2C92d-G6L5AQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65879477;
 Tue, 24 Mar 2020 09:51:47 +0000 (UTC)
Received: from redhat.com (ovpn-112-208.ams2.redhat.com [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4CFA9128E;
 Tue, 24 Mar 2020 09:51:45 +0000 (UTC)
Date: Tue, 24 Mar 2020 09:51:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] iotests: drop group file
Message-ID: <20200324095142.GC3597586@redhat.com>
References: <20200324074156.5330-1-vsementsov@virtuozzo.com>
 <20200324093629.GC5417@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200324093629.GC5417@linux.fritz.box>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 10:36:29AM +0100, Kevin Wolf wrote:
> Am 24.03.2020 um 08:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > When sending iotests to upstream or do patch porting from one branch
> > to another we very often have to resolve conflicts in group file, as
> > many absolutely independent features are intersecting by this file.
> > These conflicts are simple, but imagine how much time we all have
> > already spent on resolving them? Let's finally get rid of group file.
> >=20
> > This patch transposes group info: instead of collecting it in one file,
> > let each test define its groups by itself.
> >=20
> > Several steps are done to achive it:
> >=20
> > 1. Define groups in test files automatically:
> >=20
> >     grep '^[0-9]\{3\} ' group | while read line; do
> >         file=3D$(awk '{print $1}' <<< "$line");
> >         groups=3D$(sed -e 's/^... //' <<< "$line");
> >         awk "NR=3D=3D2{print \"# group: $groups\"}1" $file > tmp;
> >         cat tmp > $file;
> >     done
> >=20
> > 2. Copy groups documentation into docs/devel/testing.rst, which already
> >    has a section about iotests.
> >=20
> > 3. Modify check script to work without group file.
> >=20
> >    Here is a logic change: before, even if test do not belong to any
> >    group (only iotest 142 currently) it should be defined in group
> >    file. Now, test is not forced to define any group. Instead check
> >    considers all files with names matching [0-9][0-9][0-9] as tests.
>=20
> This has both a positive and a negative effect: Now you don't have to
> modify another file when you add a new test, but it will be picked up
> automatically. However, if you want to disable a test, you could
> previously just remove it from groups (or comment it out), and now you
> have to delete the test instead.
>=20
> Downstream, I think we still disable a few tests because we're compiling
> out features that are required for some tests to pass, and deleting the
> test cases completely would probably move conflicts just to a different
> place.
>=20
> So I think we need a method to distuingish an enabled test that is in no
> group from a disabled test.


Can we just have a file "blacklist.local" (which doesn't exist by default)
where you list tests to skip locally ?

Or a "group.local" such that any info in this group.local file will replace
the default info extracted from the test file ?

> >    check script is also refactored to make it simple to do next cool
> >    thing about iotests: allow meaningful names for test-case files.
>=20
> This one would also require us to be able to distinguish test case files
> from arbitrary other files.

A test-XXXXXXXXX.sh or a XXXXXX.test  naming convention ?

> > -#
> > -# test-group association ... one line per test
> > -#
> > -001 rw auto quick
> > -002 rw auto quick
> > -003 rw auto
> > -004 rw auto quick
> > -005 img auto quick
> > -# 006 was removed, do not reuse
>=20
> We lose these comments without a replacement. I wonder whether it's
> important or if we can think of another way to make sure that numbers
> aren't reused. (I'm not completely sure any more why we decided that we
> don't want to reuse numbers. Maybe because of backports?)

The key goal of the patch is to avoid conflicts from clashing changes
between branches. To full achieve that goal we need to both avoid
touching the shared groups file, but more than than, we must avoid
creating clashing test filenames.

If we keep using 3-digit filenames then the goal of this patch is
not achieved, as the risk of clashes is still higher. IOW, we must
switch to a more verbose naming convention to increase the entropy
and thus eliminate risk of clashes. If this is done, then the idea
of reserving previously used test names ceases to be something to
worry about.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


