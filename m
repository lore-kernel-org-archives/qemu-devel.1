Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6028C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD7F208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD7F208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVCtp-0006Pv-Bh
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 06:30:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hVCt2-000627-VE
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hVCt1-0006Ww-VD
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:29:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:60392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hVCt1-0006WN-Qc
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:29:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hVCsz-0002Ft-Gk
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 10:29:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 738E82E80CB
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 10:29:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 May 2019 10:20:08 -0000
From: Marc Brothier <1585533@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: cache-miss-rate json xbzrlecachestats
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bonzini eblake ma-brothier th-huth
X-Launchpad-Bug-Reporter: Marc Brothier (ma-brothier)
X-Launchpad-Bug-Modifier: Marc Brothier (ma-brothier)
References: <20160525084629.27127.82209.malonedeb@gac.canonical.com>
Message-Id: <155895240834.8234.16381986287451393756.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 374d34fa6ac14f770d7fc1371b4ed6f5932d892e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1585533] Re: cache-miss-rate / Invalid JSON
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1585533 <1585533@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not able to test that issue anymore, you can close the ticket.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1585533

Title:
  cache-miss-rate / Invalid JSON

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  We have VMs which were started with an older version than qemu 2.1
  which added "cache-miss-rate" property for XBZRLECacheStats. While
  trying to migrate the VM to a new host which is running a higher
  version (2.3) of Qemu we got an exception:

  virJSONValueFromString:1642 : internal error: cannot parse json {"return"=
: {"expected-downtime": 1, "xbzrle-cache": {"bytes": 0, "cache-size": 67108=
864, "cache-miss-rate": -nan, "pages": 0, "overflow": 0, "cache-miss": 8933=
}, "status": "active", "disk": {"total": 429496729600, "dirty-sync-count": =
0, "remaining": 193896382464, "mbps": 0, "transferred": 235600347136, "dupl=
icate": 0, "dirty-pages-rate": 0, "skipped": 0, "normal-bytes": 0, "normal"=
: 0}, "setup-time": 13, "total-time": 1543124, "ram": {"total": 8599183360,=
 "dirty-sync-count": 4, "remaining": 30695424, "mbps": 830.636997, "transfe=
rred": 3100448901, "duplicate": 1358341, "dirty-pages-rate": 7, "skipped": =
0, "normal-bytes": 3082199040, "normal": 752490}}, "id": "libvirt-186200"}:=
 lexical error: malformed number, a digit is required after the minus sign.
            67108864, "cache-miss-rate": -nan, "pages": 0, "overflow": 0
                       (right here) ------^

  virNetClientStreamRaiseError:191 : stream aborted at client request

  =

  Would it be possible to improve the JSON parser to skip the key if the va=
lue is incorrect instead of throwing an exception? Then hopefully qemu 2.3 =
or higher is able to handle the data without this property, falling back to=
 its default.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1585533/+subscriptions

