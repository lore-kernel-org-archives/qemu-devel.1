Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4091C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 22:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25E020644
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 22:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25E020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMKF1-000635-Vs
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 18:31:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hMKDb-00053x-BE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 18:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hMKDZ-0005Kj-S5
	for qemu-devel@nongnu.org; Thu, 02 May 2019 18:30:19 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:39162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hMKDZ-0005IY-Iu
	for qemu-devel@nongnu.org; Thu, 02 May 2019 18:30:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id A685F5F2D;
	Fri,  3 May 2019 00:30:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F4AKz26eTjug; Fri,  3 May 2019 00:30:13 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 4F4045EE1;
	Fri,  3 May 2019 00:30:13 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hMKDU-0007kc-3G; Fri, 03 May 2019 00:30:12 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri,  3 May 2019 00:30:05 +0200
Message-Id: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: [Qemu-devel] [PULL 0/2] slirp: move slirp as git submodule project
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com,
	jan.kiszka@siemens.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502223005.Yiwzf8YY0h5aoPBLflfTzfbMJMGmSzLD3R1TZnDazYg@z>

The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41=
df:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-05-02 12:04:51 +0100)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 7c57bdd82026ba03f3158bbcd841afde7c2dc43a:

  build-sys: move slirp as git submodule project (2019-05-03 00:15:37 +02=
00)

----------------------------------------------------------------
slirp: move slirp as git submodule project

Marc-Andr=C3=A9 Lureau (2):
  build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
  build-sys: move slirp as git submodule project

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (2):
      build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
      build-sys: move slirp as git submodule project

 .gitmodules               |    3 +
 Makefile                  |    2 +-
 configure                 |   11 +-
 scripts/archive-source.sh |    2 +-
 slirp                     |    1 +
 slirp/COPYRIGHT           |   62 --
 slirp/Makefile            |   47 --
 slirp/src/arp_table.c     |   92 ---
 slirp/src/bootp.c         |  371 -----------
 slirp/src/bootp.h         |  129 ----
 slirp/src/cksum.c         |  161 -----
 slirp/src/debug.h         |   46 --
 slirp/src/dhcpv6.c        |  224 -------
 slirp/src/dhcpv6.h        |   53 --
 slirp/src/dnssearch.c     |  311 ---------
 slirp/src/if.c            |  218 -------
 slirp/src/if.h            |   21 -
 slirp/src/ip.h            |  242 -------
 slirp/src/ip6.h           |  160 -----
 slirp/src/ip6_icmp.c      |  438 -------------
 slirp/src/ip6_icmp.h      |  232 -------
 slirp/src/ip6_input.c     |   78 ---
 slirp/src/ip6_output.c    |   39 --
 slirp/src/ip_icmp.c       |  470 --------------
 slirp/src/ip_icmp.h       |  166 -----
 slirp/src/ip_input.c      |  469 --------------
 slirp/src/ip_output.c     |  170 -----
 slirp/src/libslirp.h      |  118 ----
 slirp/src/main.h          |   16 -
 slirp/src/mbuf.c          |  235 -------
 slirp/src/mbuf.h          |  127 ----
 slirp/src/misc.c          |  321 ----------
 slirp/src/misc.h          |   66 --
 slirp/src/ncsi-pkt.h      |  445 -------------
 slirp/src/ncsi.c          |  194 ------
 slirp/src/ndp_table.c     |   87 ---
 slirp/src/qtailq.h        |  194 ------
 slirp/src/sbuf.c          |  186 ------
 slirp/src/sbuf.h          |   27 -
 slirp/src/slirp.c         | 1118 --------------------------------
 slirp/src/slirp.h         |  275 --------
 slirp/src/socket.c        |  945 ---------------------------
 slirp/src/socket.h        |  160 -----
 slirp/src/state.c         |  388 -----------
 slirp/src/stream.c        |  120 ----
 slirp/src/stream.h        |   35 -
 slirp/src/tcp.h           |  181 ------
 slirp/src/tcp_input.c     | 1554 ---------------------------------------=
------
 slirp/src/tcp_output.c    |  522 ---------------
 slirp/src/tcp_subr.c      |  987 ----------------------------
 slirp/src/tcp_timer.c     |  294 ---------
 slirp/src/tcp_timer.h     |  128 ----
 slirp/src/tcp_var.h       |  162 -----
 slirp/src/tcpip.h         |  102 ---
 slirp/src/tftp.c          |  463 --------------
 slirp/src/tftp.h          |   52 --
 slirp/src/udp.c           |  363 -----------
 slirp/src/udp.h           |   92 ---
 slirp/src/udp6.c          |  173 -----
 slirp/src/util.c          |  368 -----------
 slirp/src/util.h          |  175 -----
 slirp/src/vmstate.c       |  441 -------------
 slirp/src/vmstate.h       |  409 ------------
 63 files changed, 15 insertions(+), 15726 deletions(-)
 create mode 160000 slirp
 delete mode 100644 slirp/COPYRIGHT
 delete mode 100644 slirp/Makefile
 delete mode 100644 slirp/src/arp_table.c
 delete mode 100644 slirp/src/bootp.c
 delete mode 100644 slirp/src/bootp.h
 delete mode 100644 slirp/src/cksum.c
 delete mode 100644 slirp/src/debug.h
 delete mode 100644 slirp/src/dhcpv6.c
 delete mode 100644 slirp/src/dhcpv6.h
 delete mode 100644 slirp/src/dnssearch.c
 delete mode 100644 slirp/src/if.c
 delete mode 100644 slirp/src/if.h
 delete mode 100644 slirp/src/ip.h
 delete mode 100644 slirp/src/ip6.h
 delete mode 100644 slirp/src/ip6_icmp.c
 delete mode 100644 slirp/src/ip6_icmp.h
 delete mode 100644 slirp/src/ip6_input.c
 delete mode 100644 slirp/src/ip6_output.c
 delete mode 100644 slirp/src/ip_icmp.c
 delete mode 100644 slirp/src/ip_icmp.h
 delete mode 100644 slirp/src/ip_input.c
 delete mode 100644 slirp/src/ip_output.c
 delete mode 100644 slirp/src/libslirp.h
 delete mode 100644 slirp/src/main.h
 delete mode 100644 slirp/src/mbuf.c
 delete mode 100644 slirp/src/mbuf.h
 delete mode 100644 slirp/src/misc.c
 delete mode 100644 slirp/src/misc.h
 delete mode 100644 slirp/src/ncsi-pkt.h
 delete mode 100644 slirp/src/ncsi.c
 delete mode 100644 slirp/src/ndp_table.c
 delete mode 100644 slirp/src/qtailq.h
 delete mode 100644 slirp/src/sbuf.c
 delete mode 100644 slirp/src/sbuf.h
 delete mode 100644 slirp/src/slirp.c
 delete mode 100644 slirp/src/slirp.h
 delete mode 100644 slirp/src/socket.c
 delete mode 100644 slirp/src/socket.h
 delete mode 100644 slirp/src/state.c
 delete mode 100644 slirp/src/stream.c
 delete mode 100644 slirp/src/stream.h
 delete mode 100644 slirp/src/tcp.h
 delete mode 100644 slirp/src/tcp_input.c
 delete mode 100644 slirp/src/tcp_output.c
 delete mode 100644 slirp/src/tcp_subr.c
 delete mode 100644 slirp/src/tcp_timer.c
 delete mode 100644 slirp/src/tcp_timer.h
 delete mode 100644 slirp/src/tcp_var.h
 delete mode 100644 slirp/src/tcpip.h
 delete mode 100644 slirp/src/tftp.c
 delete mode 100644 slirp/src/tftp.h
 delete mode 100644 slirp/src/udp.c
 delete mode 100644 slirp/src/udp.h
 delete mode 100644 slirp/src/udp6.c
 delete mode 100644 slirp/src/util.c
 delete mode 100644 slirp/src/util.h
 delete mode 100644 slirp/src/vmstate.c
 delete mode 100644 slirp/src/vmstate.h

