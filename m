Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F873C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAF1229F9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAF1229F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfFA-0005SJ-3e
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42030)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hqfEr-0004zA-Lz
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hqfEp-00025R-Fp
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:01:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:51684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hqfEl-00022G-0y
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:00:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hqfEZ-0004L9-H6
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 15:00:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7DCFC2E8053
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 15:00:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jul 2019 14:54:57 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1837909@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: crobinso marcandre-lureau philmd
X-Launchpad-Bug-Reporter: Cole Robinson (crobinso)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <156406441263.18058.18411127090440261548.malonedeb@gac.canonical.com>
Message-Id: <9674376a-61fa-c845-46ae-701d65fc174f@redhat.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 3a0464b8e13c729f9578bd4e4d8e93be0da2b817
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1837909] [NEW] test-char fails if host has no
 network interfaces
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1837909 <1837909@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190725145457.z0-eq63qpbvJfCEx9rMmqmUlvFqqagzwuv3Cy2DOSJ0@z>

On 7/25/19 4:20 PM, Cole Robinson wrote:
> Public bug reported:
> =

> # ./tests/test-char =

> # random seed: R02S8602535bf831a74bca571d8c416d8161
> 1..34
> # Start of char tests
> ...
> ok 12 /char/websocket
> # Start of stdio tests
> # End of stdio tests
> # Start of socket tests
> # Start of server tests
> # Start of mainloop tests
> Unexpected error in inet_parse_connect_saddr() at util/qemu-sockets.c:421:
> # =

> # address resolution failed for 127.0.0.1:42275: Name or service not known
> # =

> =

> Aborted (core dumped)
> =

> =

> # ip a
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host =

>        valid_lft forever preferred_lft forever
> =

> =

> This seems to be related to use of AI_ADDRCONFIG in qemu-sockets.c inet_p=
arse_connect_saddr, dropping it fixes the test. 'man getaddrinfo' makes it =
sound like AI_ADDRCONFIG requires the host to have a non-loopback ipv4 or i=
pv6 address available

GETADDRINFO(3)

  If hints.ai_flags includes the AI_ADDRCONFIG flag, then IPv4
  addresses are returned in the list pointed to by res only if
  the local system has at least one IPv4 address configured, and
  IPv6 addresses are returned only if the local system has at
  least one IPv6 address configured.  The loopback address is not
  considered for this case as valid as a configured address.
  This flag is useful on, for example, IPv4-only systems, to
  ensure  that  getaddrinfo() does not return IPv6 socket addresses
  that would always fail in connect(2) or bind(2).

I'm a little confused, and I don't feel fluent enough with English to be
sure that "only if A and only if B" is equivalent to "requires (A or
B)". Maybe the man page should use 'or' instead of 'and' here...

> This host setup may seem niche, but it is what the 'mock' RPM build tool
> has by default. In Fedora we run the test suite during the RPM build, so
> the failing test causes a bit of pain for certain workflows

Would this diff snippet help?

-- >8 --
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index a5092dbd12..9ad775270d 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -417,7 +417,7 @@ static struct addrinfo
*inet_parse_connect_saddr(InetSocketAddress *saddr,
         ai.ai_flags &=3D ~AI_V4MAPPED;
         rc =3D getaddrinfo(saddr->host, saddr->port, &ai, &res);
     }
-    if (rc !=3D 0) {
+    if (rc and rc !=3D EAI_NONAME) {
         error_setg(errp, "address resolution failed for %s:%s: %s",
                    saddr->host, saddr->port, gai_strerror(rc));
         return NULL;
---

> =

> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1837909

Title:
  test-char fails if host has no network interfaces

Status in QEMU:
  New

Bug description:
  # ./tests/test-char =

  # random seed: R02S8602535bf831a74bca571d8c416d8161
  1..34
  # Start of char tests
  ...
  ok 12 /char/websocket
  # Start of stdio tests
  # End of stdio tests
  # Start of socket tests
  # Start of server tests
  # Start of mainloop tests
  Unexpected error in inet_parse_connect_saddr() at util/qemu-sockets.c:421:
  # =

  # address resolution failed for 127.0.0.1:42275: Name or service not known
  # =


  Aborted (core dumped)

  =

  # ip a
  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default qlen 1000
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
      inet 127.0.0.1/8 scope host lo
         valid_lft forever preferred_lft forever
      inet6 ::1/128 scope host =

         valid_lft forever preferred_lft forever

  =

  This seems to be related to use of AI_ADDRCONFIG in qemu-sockets.c inet_p=
arse_connect_saddr, dropping it fixes the test. 'man getaddrinfo' makes it =
sound like AI_ADDRCONFIG requires the host to have a non-loopback ipv4 or i=
pv6 address available

  This host setup may seem niche, but it is what the 'mock' RPM build
  tool has by default. In Fedora we run the test suite during the RPM
  build, so the failing test causes a bit of pain for certain workflows

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1837909/+subscriptions

