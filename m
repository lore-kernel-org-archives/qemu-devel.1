Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF95C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CBA20706
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9JuuBeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CBA20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlt7X-0006KI-7J
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlt6y-0005sC-8p
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:53:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlt6w-0005rQ-Ei
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592481217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tFLF00rRehPIcpGNVDVjwWY/6faiQhz1ieyG3mhytKY=;
 b=Q9JuuBeRnaEY+pJV8I+hCrVJYmTdd5Fw1U0FIehtJ+naaUBQpLuMghQz2mUCPiK+DpBT4w
 aWyLJkGOA5ev+eVOJyWDO7fOa8OAhaKmH7hf+qw/xqWSPZaruA+qJipgDa+b38oLHTtmsK
 ogdL0DYo+RfGvwloLwnvP7zIjt8iBEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-_u3t2qDfPJiQMgeZcduvXg-1; Thu, 18 Jun 2020 07:53:35 -0400
X-MC-Unique: _u3t2qDfPJiQMgeZcduvXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05E18107BA6D;
 Thu, 18 Jun 2020 11:53:35 +0000 (UTC)
Received: from gondolin (ovpn-113-9.ams2.redhat.com [10.36.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3773010021B3;
 Thu, 18 Jun 2020 11:53:33 +0000 (UTC)
Date: Thu, 18 Jun 2020 13:53:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <1883560@bugs.launchpad.net>
Subject: Re: [Bug 1883560] [NEW] mips linux-user builds occasionly crash
 randomly only to be fixed by a full clean re-build
Message-ID: <20200618135331.7ec861e9.cohuck@redhat.com>
In-Reply-To: <159223432851.7281.13140123017230519248.malonedeb@gac.canonical.com>
References: <159223432851.7281.13140123017230519248.malonedeb@gac.canonical.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jun 2020 15:18:48 -0000
Alex Benn=C3=A9e <1883560@bugs.launchpad.net> wrote:

> Public bug reported:
>=20
> >From time to time I find check-tcg crashes with a one of the MIPS =20
> binaries. The last time it crashed was running the test:
>=20
>   ./mips64el-linux-user/qemu-mips64el ./tests/tcg/mips64el-linux-
> user/threadcount
>=20
> Inevitably after some time noodling around wondering what could be
> causing this weird behaviour I wonder if it is a build issue. I wipe all
> the mips* build directories, re-run configure and re-build and voila
> problem goes away.
>=20
> It seems there must be some sort of build artefact which isn't being
> properly re-generated on a build update which causes weird problems.
> Additional data point if I:
>=20
>   rm -rf mips64el-linux-user
>   ../../configure
>   make
>=20
> then I see failures in mip32 builds - eg:
>=20
>     GEN     mipsn32el-linux-user/config-target.h
>   In file included from /home/alex/lsrc/qemu.git/linux-user/syscall_defs.=
h:10,
>                    from /home/alex/lsrc/qemu.git/linux-user/qemu.h:16,
>                    from /home/alex/lsrc/qemu.git/linux-user/linuxload.c:5=
:
>   /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:1: error: unter=
minated #ifndef
>    #ifndef LINUX_USER_MIPS64_SYSCALL_NR_H
>=20
>   make[1]: *** [/home/alex/lsrc/qemu.git/rules.mak:69: linux-user/linuxlo=
ad.o] Error 1
>   make[1]: *** Waiting for unfinished jobs....
>=20
> which implies there is a cross dependency between different targets
> somewhere. If I executed:
>=20
>   rm -rf mips*
>=20
> before re-configuring and re-building then everything works again.
>=20
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
>=20
> ** Tags: build linux-user mips
>=20

FWIW, this does not seem to be a mips-only issue: I'm seeing the
threadcount test fail with s390x-linux-user as well, and it also goes
away (only) if I purge the build directory, re-configure, and re-build.


