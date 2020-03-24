Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E261C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F28920870
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiiDKhxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F28920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGghp-0007qg-B6
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jGgh1-0006wK-Lm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jGgh0-0007y8-8S
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:21:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50051)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jGgh0-0007xF-4d
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585045313;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3yxtwcMlctdtfq7BWs5kZ9x71ciFUoeC+cl5RmIodE=;
 b=WiiDKhxtpUUEewnv1cpbN2RiTK3ijK7WrUVkMmaLd0ZlzwlzrO27kXCtbPOprYogffMA2W
 dXxHJoqWPf25RoFCWVsnxzkvorXcOZ4oWi1zpjdHTVOlPn1/3KHUqAxY7yNkPVl9Jo8AH2
 +qsXjPxauhXYgkbFXUsvHkk8T8Hd/vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-ksSSGnsJPbKFero573-1aw-1; Tue, 24 Mar 2020 06:21:49 -0400
X-MC-Unique: ksSSGnsJPbKFero573-1aw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8413118B9FC1;
 Tue, 24 Mar 2020 10:21:48 +0000 (UTC)
Received: from redhat.com (ovpn-112-208.ams2.redhat.com [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AFD16266E;
 Tue, 24 Mar 2020 10:21:41 +0000 (UTC)
Date: Tue, 24 Mar 2020 10:21:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] iotests: drop group file
Message-ID: <20200324102138.GD3597586@redhat.com>
References: <20200324074156.5330-1-vsementsov@virtuozzo.com>
 <20200324093629.GC5417@linux.fritz.box>
 <9ef27fe0-ef6e-ede7-7d8e-bc5331cd907e@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <9ef27fe0-ef6e-ede7-7d8e-bc5331cd907e@virtuozzo.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 01:02:18PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 24.03.2020 12:36, Kevin Wolf wrote:
> > Am 24.03.2020 um 08:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > When sending iotests to upstream or do patch porting from one branch
> > > to another we very often have to resolve conflicts in group file, as
> > > many absolutely independent features are intersecting by this file.
> > > These conflicts are simple, but imagine how much time we all have
> > > already spent on resolving them? Let's finally get rid of group file.
> > >=20
> > > This patch transposes group info: instead of collecting it in one fil=
e,
> > > let each test define its groups by itself.
> > >=20
> > > Several steps are done to achive it:
> > >=20
> > > 1. Define groups in test files automatically:
> > >=20
> > >      grep '^[0-9]\{3\} ' group | while read line; do
> > >          file=3D$(awk '{print $1}' <<< "$line");
> > >          groups=3D$(sed -e 's/^... //' <<< "$line");
> > >          awk "NR=3D=3D2{print \"# group: $groups\"}1" $file > tmp;
> > >          cat tmp > $file;
> > >      done
> > >=20
> > > 2. Copy groups documentation into docs/devel/testing.rst, which alrea=
dy
> > >     has a section about iotests.
> > >=20
> > > 3. Modify check script to work without group file.
> > >=20
> > >     Here is a logic change: before, even if test do not belong to any
> > >     group (only iotest 142 currently) it should be defined in group
> > >     file. Now, test is not forced to define any group. Instead check
> > >     considers all files with names matching [0-9][0-9][0-9] as tests.
> >=20
> > This has both a positive and a negative effect: Now you don't have to
> > modify another file when you add a new test, but it will be picked up
> > automatically. However, if you want to disable a test, you could
> > previously just remove it from groups (or comment it out), and now you
> > have to delete the test instead.
>=20
> Hmm. Probably, you could add it to group "disabled", and run check -x dis=
abled.

As a developer you don't really want to be making changes to git tracked
files in order to temporarily skip a test, as then git reports them as
modified & you risk accidentally committing throwaway changes.

Better to have a separate groups.local file to record local overrides
in a non-tracked file.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


