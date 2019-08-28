Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1789DC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB462217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB462217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34O8-00010m-Bj
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1i33SU-0007Kf-4R
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1i33SS-0007qa-HM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:18:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1i33SS-0007pg-93
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:18:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D88ACC049D62;
 Wed, 28 Aug 2019 19:18:14 +0000 (UTC)
Received: from localhost (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF9654139;
 Wed, 28 Aug 2019 19:18:09 +0000 (UTC)
Date: Wed, 28 Aug 2019 20:18:08 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org, nbd@other.debian.org, libguestfs@redhat.com,
 virt-tools-list@redhat.com
Message-ID: <20190828191808.GC7304@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 28 Aug 2019 19:18:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] ANNOUNCE: libnbd 1.0 & nbdkit 1.14 - high performance
 NBD client and server
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm pleased to announce the joint release of libnbd 1.0 and nbdkit 1.14.
These are a high performance NBD client library and server.


Key features of libnbd:

 * Synchronous API for ease of use.
 * Asynchronous API for writing non-blocking, multithreaded clients.
   You can mix both APIs freely.
 * High performance.
 * Minimal dependencies for the basic library.
 * Well-documented, stable API.
 * Bindings in several programming languages.
 * Shell (nbdsh) for command line and scripting.

Git: https://github.com/libguestfs/libnbd
Download: http://download.libguestfs.org/libnbd/1.0-stable/
Fedora: https://koji.fedoraproject.org/koji/packageinfo?packageID=3D28807


Key features of nbdkit:

 * Multithreaded NBD server written in C with good performance.
 * Minimal dependencies for the basic server.
 * Liberal license (BSD) allows nbdkit to be linked to proprietary
   libraries or included in proprietary code.
 * Well-documented, simple plugin API with a stable ABI guarantee.
   Lets you export =E2=80=9Cunconventional=E2=80=9D block devices easily.
 * You can write plugins in C, Lua, Perl, Python, OCaml, Ruby, Rust,
   shell script or Tcl.
 * Filters can be stacked in front of plugins to transform the output.

Git: https://github.com/libguestfs/nbdkit
Download: http://download.libguestfs.org/nbdkit/1.14-stable/
Fedora: https://koji.fedoraproject.org/koji/packageinfo?packageID=3D16469

Release notes for nbdkit 1.14:

Server performance improvements: Nagle's algorithm is disabled;
instead MSG_MORE is used to control when outgoing packets are sent.
Ramdisk plugins now support more efficient zeroing.  (Eric Blake).

Plugins can now select their thread model at run time.  Thread model
selection is not finalized until after the config stage (Eric Blake).

The server supports NBD_CMD_CACHE for prefetching.  Plugins and
filters have been updated to implement this where it makes sense (Eric
Blake).

Low level pthread lock failures now call abort().  This should never
happen in real situations (Eric Blake).

The server will not advertize multi-conn support if the internal
thread model is serialized, avoiding a possible deadlock in some
clients (Eric Blake).

New server option =E2=80=98--no-sr=E2=80=99 can be used to disable struct=
ured replies
(Eric Blake).

The server will now refuse to start if stdin/stdout/stderr are closed,
to avoid potential issues with file descriptor handling in plugins
(Eric Blake).

=E2=80=98$uri=E2=80=99 can be used to specify an NBD URI in =E2=80=98--ru=
n=E2=80=99 parameters (Eric
Blake).

New =E2=80=98stats=E2=80=99 filter displays elapsed statistics about NBD =
operations,
such as the number of bytes read and written.

New =E2=80=98nocache=E2=80=99 filter which disables cache requests, used =
to determine
how effective they are (Eric Blake).

New =E2=80=98noparallel=E2=80=99 filter which can be used to override the=
 plugin=E2=80=99s own
choice of thread model.  Used to determine how the thread model
affects performance, or to serialize plugins if required (Eric Blake).

New =E2=80=98cacheextents=E2=80=99 filter to cache extents requests, espe=
cially useful
with VDDK which has a slow implementation of extents (Martin
Kletzander).

In the =E2=80=98full=E2=80=99, =E2=80=98memory=E2=80=99, =E2=80=98null=E2=
=80=99, =E2=80=98pattern=E2=80=99 and =E2=80=98random=E2=80=99 plugins, t=
he
size=3D prefix can be omitted, ie: nbdkit memory 1G (instead of size=3D1G=
)

The =E2=80=98nbd=E2=80=99 plugin has multiple enhancements: It may be bui=
lt using
libnbd instead of constructing raw NBD packets; NBD_OPT_GO is
supported; add structured reads; implement NBD_CMD_BLOCK_STATUS;
support TCP sockets; forward NBD_CMD_CACHE; retry connections; shared
connections; magic =E2=80=98uri=E2=80=99 parameter; TLS support (Eric Bla=
ke).

The =E2=80=98vddk=E2=80=99 plugin now reports hole extents correctly when=
 using the
=E2=80=98single-link=E2=80=99 flag (Martin Kletzander).

The =E2=80=98cache=E2=80=99 and =E2=80=98cow=E2=80=99 filters now avoid c=
opying data through a bounce
buffer when it is already sufficiently aligned (Eric Blake).

Filters (such as the delay and rate filter) which sleep no longer
cause long delays when the server is shut down (Eric Blake).

Multiple fixes to the =E2=80=98rust=E2=80=99 plugin (Martin Kletzander).

Multiple enhancements and clean ups to the test suite which should
make tests better and more reliable.

OCaml plugins can now use =E2=80=98parse_size=E2=80=99, =E2=80=98parse_bo=
ol=E2=80=99, =E2=80=98read_password=E2=80=99
calls, and there is also a new example plugin.

On platforms which lack atomic O_CLOEXEC support the most serialized
thread model is always selected to avoid leaking file descriptors
(Eric Blake).



--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

