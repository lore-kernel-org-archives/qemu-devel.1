Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E9C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 20:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502EF206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 20:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SESZG6xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502EF206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44127 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIftv-0006SW-L9
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 16:50:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amitkumarrathore07@gmail.com>) id 1hIfpO-0003EF-M8
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 16:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amitkumarrathore07@gmail.com>) id 1hIfga-00066D-NS
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 16:37:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:41108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <amitkumarrathore07@gmail.com>)
	id 1hIfga-000656-HG
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 16:37:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id d9so404795pls.8
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:mime-version:to:from:subject:date:importance;
	bh=tpXMig1LX0Un8qPtGVtaL5uFOQXqxVOXr784jTvlx50=;
	b=SESZG6xhXZfeBIyoM1UfFid3PBhTDflyqNkO4eo42M7pGN963S040awmdM6/G77Is4
	ezyEV21ME0pDvXeqAEw6FezurxBWUg/L6gd0a+q2Cf1ErC8iAfvjfmFavEN8dK0vRpyH
	h4s/7lGYoA1dKTDpEx+A5mEhGMbPeFPpDv3yvgIJTJM7CTMj3vAp0CdMeNR4l30VzLR5
	odV8CzZSbCxwk7iJ9TLdrVnwYtkdRjVTagMwLdClhwqTSEDo4tTK5hwIY1sznCsdQfBo
	hCgyySPy4FnfGgd3NGgM13yOLfbwRa12Ymkzx9JSWFbwun9qolSECSW96e/rRLze5HHy
	lb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version:to:from:subject:date
	:importance;
	bh=tpXMig1LX0Un8qPtGVtaL5uFOQXqxVOXr784jTvlx50=;
	b=rak1xfkpLj17LPAsNuPYcHKXqEYeWAGvicf7cihQuXEyIkymmUdRQ7mXLXFbgKRxyi
	V8uviSqs37ToS23yI41mu/jvRJjwyyK8Db7kC8OVS7VceNqdQK3A7ptSAOFFjoRDyT9L
	yqLfJNLZXIozpRVRb2v6TN3B28iyTwSP95iUdqApyNHgrOkH71w4Agvx+ZUP151loySF
	M6cWMcVth052h2ZuJCeDVFK2/8daJoHMDZ5bMky3Ic0c0DiR8M6MrkjACWp9nm2zjWdF
	yv6ZbtdfM6U3PO3AH49ayScBe5EAngM+PPZVlUWa5z7vughXWHXW22HGfoeypnP6JxUj
	WLTw==
X-Gm-Message-State: APjAAAUMTe7QVEgWtDrL/kjJdy+UV0Dr03aAPcKRzrH1qUaMpys3x+NK
	qrSRKNLhbGYXpyat0tAsCUpFJbZpTV0=
X-Google-Smtp-Source: APXvYqxs2zSqnp8QwbD/MPf5az2hlc93H5+G2xf1NzTzUmSGS5IRnjYQipdbpzN9F/cZcGx9XVs20g==
X-Received: by 2002:a17:902:2ec5:: with SMTP id
	r63mr22368183plb.139.1555965425653; 
	Mon, 22 Apr 2019 13:37:05 -0700 (PDT)
Received: from ?IPv6:::ffff:192.168.43.173? ([27.97.105.34])
	by smtp.gmail.com with ESMTPSA id
	75sm21615207pfr.55.2019.04.22.13.37.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 Apr 2019 13:37:04 -0700 (PDT)
Message-ID: <5cbe25f0.1c69fb81.e0425.9c3b@mx.google.com>
MIME-Version: 1.0
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: amit kumar rathore <amitkumarrathore07@gmail.com>
Date: Tue, 23 Apr 2019 02:07:03 +0530
Importance: normal
X-Priority: 3
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Review my proposal
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
Message-ID: <20190422203703.GWFG1eczdR69uVfwYPpOLLVc5qI-6OA7DF2lQ7BhX_0@z>

Sir,
My proposal is still not review by my mentor. My mentor is JAN KISZKA .I al=
ready mail him but he not responding me. What I do now? How can I know my p=
roposal is view or not.

Sent from Mail for Windows 10

