Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEDCC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 19:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F23205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 19:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pz05wJ43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F23205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSncK-0000X5-18
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 15:06:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clabbe.montjoie@gmail.com>) id 1hSnbQ-00007e-W5
	for qemu-devel@nongnu.org; Mon, 20 May 2019 15:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clabbe.montjoie@gmail.com>) id 1hSnbP-00071b-C0
	for qemu-devel@nongnu.org; Mon, 20 May 2019 15:05:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <clabbe.montjoie@gmail.com>)
	id 1hSnbP-0006zB-4q
	for qemu-devel@nongnu.org; Mon, 20 May 2019 15:05:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id r4so15780309wro.10
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:subject:message-id:mime-version:content-disposition
	:user-agent; bh=/wBgxFqIYmxVjOICVhiMhej/rs9vVKrtLIN4IKZUwoU=;
	b=pz05wJ43cdxIiaMp7aFHfg2PYPtBTkbKpXwweXg1ABx/Cq2ffs3fkG9H667h3VFz6Y
	DLbEj86cMvNZJ2SXxMQ3atjvPzfyHlBDd2yQiEyAIM8+g3WwKw3q+YjxQ7pGIXmBAyVs
	yCvHHyZYz1K2712MinYlAMK4HtGLtAv/WmrNVffzc7dRafZbS8SHuntdU1zae3LjwvLd
	5K0OLwC/Ta0gntR8LUDWTgAupQb+XmAwpWSEk/d7TQldBE3p9tesGI/Cl9HiE/wURNZF
	bGYAp3juXwAjhZKwNclGLsjSA6BoFgBqE8YDwNeMh4HBGjUprX9LtD8gC4+LCnDihB8C
	Dvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:subject:message-id:mime-version
	:content-disposition:user-agent;
	bh=/wBgxFqIYmxVjOICVhiMhej/rs9vVKrtLIN4IKZUwoU=;
	b=qtVSi1ZHD6WV+arphagLSga5xmfUsFqdC872XM9NFa0F+1PArUtnROr4Q7PgQGRPS3
	DkPsQQLO34ypv4hGXFdydB53+5dUrR6uIgNTXJvVxTEPae9SPe15F75nQwplNSss3Fxk
	Q6Jw5xtNBL2o4KkohaOmAw1WG4Lspn7lQMQPeouVczvy70mJC5nt6sgv7U8DljVwLqv/
	Gsc3smx7GsgB+oElgPXQp7At8NTMzniodTNpFOWxcPrujydXNtj6oqLNWylNphaKmArq
	JLg8rETjbU3vLme+qN5mgt+tAOK+a/rkkiU2wGjK3dOTNgZUYX4Dc7S4eBJrASxwLhDX
	eQMw==
X-Gm-Message-State: APjAAAWORM5gnk/VNn495iyXBavPI74IrccyTsOJanlm7hXAaxg9H+tx
	teylz9mgHsZu/PyCNpAbiSc=
X-Google-Smtp-Source: APXvYqyY8p2WgIyMs5eCVadhRwAfNI1gozXpqIxOBLbOHWijWZcqmutPVykDNt/i49QK1QX+vg6MsQ==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr11891319wrs.280.1558379135879; 
	Mon, 20 May 2019 12:05:35 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
	by smtp.googlemail.com with ESMTPSA id
	j28sm29042150wrd.64.2019.05.20.12.05.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 12:05:35 -0700 (PDT)
Date: Mon, 20 May 2019 21:05:33 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: linux-omap@vger.kernel.org, qemu-devel@nongnu.org
Message-ID: <20190520190533.GA28160@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] Running linux on qemu omap
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

Hello

I am working on adding a maximum set of qemu machine on kernelCI.

For OMAP, five machine exists and I fail to boot any of them.
The maximum I can get with omap1_defconfig is
qemu-system-arm -kernel zImage -nographic -machine cheetah -append 'root=/dev/ram0 console=ttyO0'
Uncompressing Linux... done, booting the kernel.
then nothing more.

Does someone have a working config+version to share ?

Thanks
Regards

