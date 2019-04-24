Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD15C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 11:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE0B2175B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 11:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE0B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFoB-0004sf-Kz
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 07:11:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJFiO-0008E7-2C
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hJFdv-0006c0-TJ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:00:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hJFdv-0006Xl-Ky
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:00:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5249BD4784;
	Wed, 24 Apr 2019 11:00:45 +0000 (UTC)
Received: from localhost (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5481F5D704;
	Wed, 24 Apr 2019 11:00:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 13:00:39 +0200
Message-Id: <20190424110041.8175-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 24 Apr 2019 11:00:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/2] slirp: move slirp as git submodule
 project
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
Cc: samuel.thibault@ens-lyon.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424110039.sJ2PKXHChc-TfnI8gcSept1f4Eptqvs2EnC67b-Wtgs@z>

Hi,

v2:
 - add a patch to pass CFLAGS/LDFLAGS
 - order diff files to ease reviewing
 - drop RFC status

Marc-Andr=C3=A9 Lureau (2):
  build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
  build-sys: move slirp as git submodule project

 configure              |   11 +-
 .gitmodules            |    3 +
 slirp/src/bootp.h      |  129 ----
 slirp/src/debug.h      |   46 --
 slirp/src/dhcpv6.h     |   53 --
 slirp/src/if.h         |   21 -
 slirp/src/ip.h         |  242 -------
 slirp/src/ip6.h        |  160 -----
 slirp/src/ip6_icmp.h   |  232 ------
 slirp/src/ip_icmp.h    |  166 -----
 slirp/src/libslirp.h   |  118 ---
 slirp/src/main.h       |   16 -
 slirp/src/mbuf.h       |  127 ----
 slirp/src/misc.h       |   66 --
 slirp/src/ncsi-pkt.h   |  445 ------------
 slirp/src/qtailq.h     |  194 -----
 slirp/src/sbuf.h       |   27 -
 slirp/src/slirp.h      |  275 -------
 slirp/src/socket.h     |  160 -----
 slirp/src/stream.h     |   35 -
 slirp/src/tcp.h        |  181 -----
 slirp/src/tcp_timer.h  |  128 ----
 slirp/src/tcp_var.h    |  162 -----
 slirp/src/tcpip.h      |  102 ---
 slirp/src/tftp.h       |   52 --
 slirp/src/udp.h        |   92 ---
 slirp/src/util.h       |  175 -----
 slirp/src/vmstate.h    |  409 -----------
 slirp/src/arp_table.c  |   92 ---
 slirp/src/bootp.c      |  371 ----------
 slirp/src/cksum.c      |  161 -----
 slirp/src/dhcpv6.c     |  224 ------
 slirp/src/dnssearch.c  |  311 --------
 slirp/src/if.c         |  218 ------
 slirp/src/ip6_icmp.c   |  438 -----------
 slirp/src/ip6_input.c  |   78 --
 slirp/src/ip6_output.c |   39 -
 slirp/src/ip_icmp.c    |  470 ------------
 slirp/src/ip_input.c   |  469 ------------
 slirp/src/ip_output.c  |  170 -----
 slirp/src/mbuf.c       |  235 ------
 slirp/src/misc.c       |  321 ---------
 slirp/src/ncsi.c       |  194 -----
 slirp/src/ndp_table.c  |   87 ---
 slirp/src/sbuf.c       |  186 -----
 slirp/src/slirp.c      | 1118 -----------------------------
 slirp/src/socket.c     |  945 ------------------------
 slirp/src/state.c      |  388 ----------
 slirp/src/stream.c     |  120 ----
 slirp/src/tcp_input.c  | 1554 ----------------------------------------
 slirp/src/tcp_output.c |  522 --------------
 slirp/src/tcp_subr.c   |  987 -------------------------
 slirp/src/tcp_timer.c  |  294 --------
 slirp/src/tftp.c       |  463 ------------
 slirp/src/udp.c        |  363 ----------
 slirp/src/udp6.c       |  173 -----
 slirp/src/util.c       |  368 ----------
 slirp/src/vmstate.c    |  441 ------------
 Makefile               |    2 +-
 slirp                  |    1 +
 slirp/COPYRIGHT        |   62 --
 slirp/Makefile         |   47 --
 62 files changed, 14 insertions(+), 15725 deletions(-)
 delete mode 100644 slirp/src/bootp.h
 delete mode 100644 slirp/src/debug.h
 delete mode 100644 slirp/src/dhcpv6.h
 delete mode 100644 slirp/src/if.h
 delete mode 100644 slirp/src/ip.h
 delete mode 100644 slirp/src/ip6.h
 delete mode 100644 slirp/src/ip6_icmp.h
 delete mode 100644 slirp/src/ip_icmp.h
 delete mode 100644 slirp/src/libslirp.h
 delete mode 100644 slirp/src/main.h
 delete mode 100644 slirp/src/mbuf.h
 delete mode 100644 slirp/src/misc.h
 delete mode 100644 slirp/src/ncsi-pkt.h
 delete mode 100644 slirp/src/qtailq.h
 delete mode 100644 slirp/src/sbuf.h
 delete mode 100644 slirp/src/slirp.h
 delete mode 100644 slirp/src/socket.h
 delete mode 100644 slirp/src/stream.h
 delete mode 100644 slirp/src/tcp.h
 delete mode 100644 slirp/src/tcp_timer.h
 delete mode 100644 slirp/src/tcp_var.h
 delete mode 100644 slirp/src/tcpip.h
 delete mode 100644 slirp/src/tftp.h
 delete mode 100644 slirp/src/udp.h
 delete mode 100644 slirp/src/util.h
 delete mode 100644 slirp/src/vmstate.h
 delete mode 100644 slirp/src/arp_table.c
 delete mode 100644 slirp/src/bootp.c
 delete mode 100644 slirp/src/cksum.c
 delete mode 100644 slirp/src/dhcpv6.c
 delete mode 100644 slirp/src/dnssearch.c
 delete mode 100644 slirp/src/if.c
 delete mode 100644 slirp/src/ip6_icmp.c
 delete mode 100644 slirp/src/ip6_input.c
 delete mode 100644 slirp/src/ip6_output.c
 delete mode 100644 slirp/src/ip_icmp.c
 delete mode 100644 slirp/src/ip_input.c
 delete mode 100644 slirp/src/ip_output.c
 delete mode 100644 slirp/src/mbuf.c
 delete mode 100644 slirp/src/misc.c
 delete mode 100644 slirp/src/ncsi.c
 delete mode 100644 slirp/src/ndp_table.c
 delete mode 100644 slirp/src/sbuf.c
 delete mode 100644 slirp/src/slirp.c
 delete mode 100644 slirp/src/socket.c
 delete mode 100644 slirp/src/state.c
 delete mode 100644 slirp/src/stream.c
 delete mode 100644 slirp/src/tcp_input.c
 delete mode 100644 slirp/src/tcp_output.c
 delete mode 100644 slirp/src/tcp_subr.c
 delete mode 100644 slirp/src/tcp_timer.c
 delete mode 100644 slirp/src/tftp.c
 delete mode 100644 slirp/src/udp.c
 delete mode 100644 slirp/src/udp6.c
 delete mode 100644 slirp/src/util.c
 delete mode 100644 slirp/src/vmstate.c
 create mode 160000 slirp
 delete mode 100644 slirp/COPYRIGHT
 delete mode 100644 slirp/Makefile

--=20
2.21.0.313.ge35b8cb8e2


