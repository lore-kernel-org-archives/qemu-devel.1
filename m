Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43261C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1992168B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1992168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profihost.ag
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52007 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRhF6-0002dO-AG
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 14:06:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1hRhDb-0001uL-43
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1hRhDY-0000l4-PH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:04:31 -0400
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:36871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1hRhDX-0000cn-Ds
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:04:28 -0400
Received: (qmail 3349 invoked from network); 17 May 2019 20:04:19 +0200
X-Fcrdns: No
Received: from phoffice.de-nserver.de (HELO [10.242.2.6]) (185.39.223.5)
	(smtp-auth username hostmaster@profihost.com, mechanism plain)
	by cloud1-vm154.de-nserver.de (qpsmtpd/0.92) with
	(ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA;
	Fri, 17 May 2019 20:04:19 +0200
To: qemu-devel <qemu-devel@nongnu.org>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <0ea00eac-b066-e36e-d679-4fa9c4df8935@profihost.ag>
Date: Fri, 17 May 2019 20:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-User-Auth: Auth by hostmaster@profihost.com through 185.39.223.5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic]
X-Received-From: 178.250.10.56
Subject: [Qemu-devel] livepatch kernel to use md-clear without reboot
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

i'm interested if it is possible to livepatch the guest kernel without
reboot.

(host kernel and microcode is patched)

Greets,
Stefan

