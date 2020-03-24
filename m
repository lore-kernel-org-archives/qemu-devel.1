Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A13CC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0561920775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBxdhj0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0561920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGfzw-0007DV-7s
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 05:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jGfzD-0006RE-3A
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jGfzB-0008Db-P6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:36:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42801)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jGfzB-0008DK-LZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585042597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NB4zX02uVE5wSNq4BnTcQOsEodNAO85ZZBPqEkqDag=;
 b=VBxdhj0TqSgGUbG94Tqg4NeNuvIc7srhyCbFFKkl7JVW7RbjtEl4belKfQzmn5cHVLG1MD
 bpSULeOUGofl7/p9icF48A3WBVA15bsNiVjU3xSTg7b1p+2Ux/eZ/4ELaLrXsDZoYjzLOm
 pqe1G66INZZ1aDIare5cp8l8zOBrxAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-5gJ-OXgFN9qrFP9_FtUTag-1; Tue, 24 Mar 2020 05:36:33 -0400
X-MC-Unique: 5gJ-OXgFN9qrFP9_FtUTag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 675E4477;
 Tue, 24 Mar 2020 09:36:32 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-119.ams2.redhat.com [10.36.113.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B15F5C1A1;
 Tue, 24 Mar 2020 09:36:30 +0000 (UTC)
Date: Tue, 24 Mar 2020 10:36:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] iotests: drop group file
Message-ID: <20200324093629.GC5417@linux.fritz.box>
References: <20200324074156.5330-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200324074156.5330-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-block@nongnu.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.03.2020 um 08:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> When sending iotests to upstream or do patch porting from one branch
> to another we very often have to resolve conflicts in group file, as
> many absolutely independent features are intersecting by this file.
> These conflicts are simple, but imagine how much time we all have
> already spent on resolving them? Let's finally get rid of group file.
>=20
> This patch transposes group info: instead of collecting it in one file,
> let each test define its groups by itself.
>=20
> Several steps are done to achive it:
>=20
> 1. Define groups in test files automatically:
>=20
>     grep '^[0-9]\{3\} ' group | while read line; do
>         file=3D$(awk '{print $1}' <<< "$line");
>         groups=3D$(sed -e 's/^... //' <<< "$line");
>         awk "NR=3D=3D2{print \"# group: $groups\"}1" $file > tmp;
>         cat tmp > $file;
>     done
>=20
> 2. Copy groups documentation into docs/devel/testing.rst, which already
>    has a section about iotests.
>=20
> 3. Modify check script to work without group file.
>=20
>    Here is a logic change: before, even if test do not belong to any
>    group (only iotest 142 currently) it should be defined in group
>    file. Now, test is not forced to define any group. Instead check
>    considers all files with names matching [0-9][0-9][0-9] as tests.

This has both a positive and a negative effect: Now you don't have to
modify another file when you add a new test, but it will be picked up
automatically. However, if you want to disable a test, you could
previously just remove it from groups (or comment it out), and now you
have to delete the test instead.

Downstream, I think we still disable a few tests because we're compiling
out features that are required for some tests to pass, and deleting the
test cases completely would probably move conflicts just to a different
place.

So I think we need a method to distuingish an enabled test that is in no
group from a disabled test.

>    check script is also refactored to make it simple to do next cool
>    thing about iotests: allow meaningful names for test-case files.

This one would also require us to be able to distinguish test case files
from arbitrary other files.

> -#
> -# test-group association ... one line per test
> -#
> -001 rw auto quick
> -002 rw auto quick
> -003 rw auto
> -004 rw auto quick
> -005 img auto quick
> -# 006 was removed, do not reuse

We lose these comments without a replacement. I wonder whether it's
important or if we can think of another way to make sure that numbers
aren't reused. (I'm not completely sure any more why we decided that we
don't want to reuse numbers. Maybe because of backports?)

Kevin


