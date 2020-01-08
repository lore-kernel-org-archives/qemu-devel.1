Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3770C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0D820692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0D820692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBhn-0003OP-Qw
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1ipBeT-0000Ki-OY
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1ipBeS-0005Au-Dn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:45:37 -0500
Received: from kerio.kamp.de ([195.62.97.192]:54474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1ipBeS-00054U-29
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:45:36 -0500
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Wed, 8 Jan 2020 14:45:23 +0100
Received: (qmail 49015 invoked from network); 8 Jan 2020 13:45:24 -0000
Received: from ac1.vpn.kamp-intra.net (HELO ?172.20.250.1?)
 (pl@kamp.de@::ffff:172.20.250.1)
 by submission.kamp.de with ESMTPS (AES128-SHA encrypted) ESMTPA;
 8 Jan 2020 13:45:24 -0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Peter Lieven <pl@kamp.de>
Subject: qemu-4.0.1: vhost_region_add_section:Section rounded to 0 prior to
 previous a0000
Message-ID: <985fea06-ede6-dcb7-8829-a48a9416bc09@kamp.de>
Date: Wed, 8 Jan 2020 14:45:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 195.62.97.192
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

Hi,


I have a Qemu 4.0.1 machine with vhost-net network adapter, thats polluting the log with the above message.

Is this something known? Googling revealed the following patch in Nemu (with seems to be a Qemu fork from Intel):

https://github.com/intel/nemu/commit/03940ded7f5370ce7492c619dccced114ef7f56e


The network stopped functioning. After a live-migration the vServer is reachable again.


Any ideas?


Thanks,

Peter




