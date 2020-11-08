Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B58C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 01:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC88720704
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 01:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fosshost.org header.i=@fosshost.org header.b="w8OZabc3"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=fosshost.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbZZX-0004iD-OJ
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 20:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <admin@fosshost.org>)
 id 1kbYdJ-0001Pf-IV
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 19:32:37 -0500
Received: from mail.webarch.email ([81.95.52.48]:38196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <admin@fosshost.org>)
 id 1kbYdH-0006vw-3M
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 19:32:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPA id 6AB6F1A85A3C
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 00:32:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fosshost.org;
 s=20200501; t=1604795548;
 h=from:subject:date:message-id:to:mime-version:content-type;
 bh=rTHTgWyQ1czDR7f23YYMAgpXoBhs6HyEduSl/woCp7M=;
 b=w8OZabc3VwbnKVilMI87OSbTCwP0MIPVNJDEIFCc3nNviKG0MnATqGZc/UCfiXFdDh1qXY
 eZym3Tm5l+CxKOAbKvaQwHJ5oC7FwOpUOz90JDs/FU2ZGOHDd92ZCjqodp8xiQv6MMdZ6Y
 eL3n3lX/Ft6+D+4kVxFsx87V/GDIfGQ5ZbtTDwRSDamQsQQcou4jPRibIttezOZKZWGHOy
 U721Hurxjqp093AwLdauZdnIhoquu0tG4+jU7MFqWU4ViwoIkw2ZIqHLx1MJHKJ8uKKbQ4
 2VQPdinL0NM82VQ/oejGtSM+rzyUcqXj5LUZeeLfcQUzWcct90B05S8SGBWk3w==
From: "Fosshost" <admin@fosshost.org>
To: qemu-devel@nongnu.org
User-Agent: SOGoMail 5.0.1
MIME-Version: 1.0
Date: Sun, 08 Nov 2020 00:32:28 +0000
Subject: Fosshost.org
Message-ID: <178-5fa73c80-99-9fe6ad0@194753705>
Content-Type: multipart/alternative;
 boundary="----=_=-_OpenGroupware_org_NGMime-376-1604795548.229883-79------"
X-Last-TLS-Session-Version: None
Received-SPF: none client-ip=81.95.52.48; envelope-from=admin@fosshost.org;
 helo=mail.webarch.email
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 19:32:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 07 Nov 2020 20:32:01 -0500
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

------=_=-_OpenGroupware_org_NGMime-376-1604795548.229883-79------
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Length: 399


Dear all

We would like to donate some hosting to the QEMU project, mainly in par=
t due to the fact that we use it ourselves!=C2=A0

If this is something you would like to explore, please let me know.=C2=A0=
 We look forward to hearing from you.

--=C2=A0
Kind regards,

Thomas Markey
Chief Executive and Founder
Fosshost.org
M: +44 (0) 7731 988 759

You can book a call with me by clicking here

------=_=-_OpenGroupware_org_NGMime-376-1604795548.229883-79------
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Length: 576

<html>Dear all<br /><br />We would like to donate some hosting to the Q=
EMU project, mainly in part due to the fact that we use it ourselves!&n=
bsp;<br /><br />If this is something you would like to explore, please =
let me know.&nbsp; We look forward to hearing from you.<br /><br />--&n=
bsp;<br />Kind regards,<br /><br /><strong>Thomas Markey</strong><br />=
Chief Executive and Founder<br />Fosshost.org<br />M: +44 (0) 7731 988 =
759<br /><br />You can book a call with me by clicking <a href=3D"https=
://calendly.com/fosshostorg/fosshost-call">here</a></html>

------=_=-_OpenGroupware_org_NGMime-376-1604795548.229883-79--------


