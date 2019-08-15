Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B4BC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED1E20644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED1E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIJJ-0004nc-NW
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1hyIG5-0000qx-7a
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1hyIFz-0004cw-Ff
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1hyIFw-0004Xs-Qs
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:05:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 790F3EB9C4;
 Thu, 15 Aug 2019 16:05:34 +0000 (UTC)
Received: from localhost (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF4E1EA;
 Thu, 15 Aug 2019 16:05:29 +0000 (UTC)
Date: Thu, 15 Aug 2019 17:05:28 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190815160528.GA31491@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 15 Aug 2019 16:05:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] ANNOUNCE: libnbd 0.9.8 - prerelease of high
 performance NBD client library
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
Cc: nbd@other.debian.org, libguestfs@redhat.com, virt-tools-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm pleased to announce a new high performance Network Block Device
(NBD) client library called libnbd.  It's written in C and there are
also bindings available for Python, OCaml and (soon) Rust.

0.9.8 is the third pre-release before the stable 1.0 version where we
freeze the API, so feedback on API-related issues is very welcome now.

Download:       http://download.libguestfs.org/libnbd/
Documentation:  https://github.com/libguestfs/libnbd/blob/master/docs/lib=
nbd.pod
Fedora package: https://koji.fedoraproject.org/koji/packageinfo?packageID=
=3D28807
Debian package: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D93322=
3
Git repo:       https://github.com/libguestfs/libnbd
Mailing list:   libguestfs@redhat.com (no subscription required)

Here are some of the things you can do with this library ...

Connect to an NBD server and grab the first sector of the disk:
https://github.com/libguestfs/libnbd/blob/a5f8fd2f0f48e9cf2487e23750b55f6=
7b166014f/examples/simple-fetch-first-sector.c#L14

High performance multi-threaded reads and writes, with multiple
connections and multiple commands in flight on each connection:
https://github.com/libguestfs/libnbd/blob/master/examples/threaded-reads-=
and-writes.c

Integrate with glib main loop:
https://github.com/libguestfs/libnbd/blob/master/examples/glib-main-loop.=
c

Connect to an NBD server from an interactive shell:

  $ nbdkit -f linuxdisk . &
  $ nbdsh --connect nbd://localhost

  Welcome to nbdsh, the shell for interacting with
  Network Block Device (NBD) servers.

  nbd> h.get_size()
  716266496
  nbd> buf =3D h.pread (512, 0)
  nbd> print ("%r" % buf)
  [prints the first sector]

Use =E2=80=98fio=E2=80=99 to benchmark an NBD server:

  $ nbdkit -U - memory size=3D256M \
        --run 'export unixsocket ; fio examples/nbd.fio '

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

