Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152DAC282DD
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 02:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20A720869
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 02:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20A720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47729 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hI1vW-0001eu-QO
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 22:09:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hI1uW-00015q-Pu
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 22:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hI1uV-00078D-TF
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 22:08:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hI1uV-00076Z-Pg
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 22:08:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id v7so5442235qti.7
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 19:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition;
	bh=QKRi83dIUkSMEPKXrLXNF1z1GM5jOZq7T86fjdaAqgk=;
	b=UT+vPkY9bukLkW5fOkV5eoUffaX/GInVhJ9qDMN6nU19Cjv23AK5yrHYAG8VO9jBGb
	TSgemtIVTFXltGk6gs1gn6B1jqw6WZXsI1eU1FFA2tz90sLkI7ZbmC0kb9olcszPt8T4
	vn7andEXVxtHU8ZByAcn2p71Vgf/PLZaxHSCV5l6aWNx13SF7Juqq5yuXWrvUT6JoMxG
	0UKDUvA9sQSE72e8PkmmmO0GZabRoWm83+2AFJH91psmfA0Q2yuGzGTuMyvJ/T9fJ9rP
	31XJmi3XFMVXEmv3Z9X4oW19DxSCjdsC1HaR40kPWQaCB99FYeJG+z3YINJ+jBOOsr+r
	fLcg==
X-Gm-Message-State: APjAAAWrxRkdcKvj8Ic/9s0c9AkIT9vujakeOJftCNKxY+cGov0SupgW
	TC7EOdXMJ26AAN+gVCg/f6Pkgw==
X-Google-Smtp-Source: APXvYqy9+5is13MCbUGTr3h0Gnsv6PrtXKlYA07pcJBwFDpGVCysVUCJuRztuUBKWkmMiosZYVnaQA==
X-Received: by 2002:ad4:45ae:: with SMTP id y14mr917377qvu.129.1555812529854; 
	Sat, 20 Apr 2019 19:08:49 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	j93sm5468065qtd.82.2019.04.20.19.08.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 20 Apr 2019 19:08:48 -0700 (PDT)
Date: Sat, 20 Apr 2019 22:08:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <20190420220659-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: [Qemu-devel] some comments on virtio crypto device specification
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
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.vnet.ibm.com,
	Ola.Liljedahl@arm.com, brian.a.keating@intel.com,
	wangxinxin.wang@huawei.com, liang.j.ma@intel.com,
	jasowang@redhat.com, cohuck@redhat.com, xin.zeng@intel.com,
	qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de,
	arei.gonglei@huawei.com, stefanha@redhat.com,
	jianjay.zhou@huawei.com, Varun.Sethi@freescale.com,
	Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com,
	denglingli@chinamobile.com, weidong.huang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421020845.Q0dKcs2iMswcz19NdpqmsA9op9hHIXy62TqBYJ_bqTA@z>

Hi guys!
Some comments about things to improve in the virtio
crypto device part of the spec:
https://news.ycombinator.com/item?id=19698399#19706987

It would be great if someone translated this to
github issues and tried to improve the spec by
addressing them.

Thanks!

-- 
MST

