Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAC9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7E8206C1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7E8206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaG2X-0001Pv-Lz
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFwP-0003TD-QT; Wed, 04 Nov 2020 05:22:57 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:53027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFwN-0002Gb-Ei; Wed, 04 Nov 2020 05:22:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 71B578B8;
 Wed,  4 Nov 2020 05:22:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 04 Nov 2020 05:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:content-type:mime-version
 :content-transfer-encoding; s=fm1; bh=srRT8XJhCUT9ojX3/6ge8wQnAa
 Zk2RyYfWdREYs3Wqk=; b=CDKtMK5A5xFTnT792W+aBBq7QZBVj1stk1wajxhbck
 YViMCcfmFQLzjnlKpke55h7o5KIQ/V+/qzbFLs+EK0RgrOPx1kP0Zuxwqoh9584v
 MxrR/QXJehsXxw1kDjx+M4AQrbhGuFrdx9wrpjChWvPuzCQqzttDihkt8009Ck6a
 +WetJQrbR15Ibz9neie3KxJ7K+7uKUFUCoTVq7C8G9diR6UY1+VrB49DGby4+29y
 rQ4fa3eI8X0lymY33YwEEg4rNqP0LdcyQSDZ/1Sv2iOuTMeUG9m4QEXa+jWoiL4O
 v8A98HkN0p6dAdEH7Gp3uXfxB4zWH2c4Z4QZtXy9H+/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=srRT8X
 JhCUT9ojX3/6ge8wQnAaZk2RyYfWdREYs3Wqk=; b=KX7wBvo24VMHGHD2ht0qaT
 Y0XFyGy5QO/ddlXPzJuVd/WePZeekKmyLZKrwtieVyuysp54kZUJKFygzDPb14bh
 iHvsXm5Tk3yqLpEGbw8qprBJPb6OAXm62XdmJ9eEoyoc6PTd+AwKhuLUI67QhBWI
 mchJFuS/tTW0MqAMO5/Py4w69FRbXKRK65asmqW9rq2mNR5mlJfBm8cU2tCayo4s
 1+YFL34w20MOtJNSQAJ9Rj9mhGFdpbNPrJCUtjTGPpQTTxD6nciuQvZWLRtFpGtf
 Etsap2jciiq4SybHCMZkCc2GwqwkCQMyw1xKLxmLZ3esU15DT9feFfjyc3ZtTBlw
 ==
X-ME-Sender: <xms:-oCiX-CkFqf5Orz5NYZRNSX9qpZtal5PaqczDofJYspCmx9BwxUBNw>
 <xme:-oCiX4iPOwOWuB-3JnpQZhGkU22NGfoKhBb-GGu9oJein0vdu8_r1R0DrUfFyLkML
 ljS6BblC7kKMan7NA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffotggggfesthhqredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhephfegveekiefgkeevvdetjeejkeekudfgvdehieejfffgkeffvdevlefftedvgefh
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:-4CiXxmlEBzH_vo6KpUCy7lm0nYkhCRGYowxttTwQrmf6Dw_Rib9yQ>
 <xmx:-4CiX8wtWg1bdxlPHYh9ArkQEsen0sJsF4k4zUFddyUgl22gAin4xw>
 <xmx:-4CiXzSM3hAZtvJYViXdQrsVxf7DPq0c31EokVj_ygeNar6uwceLZg>
 <xmx:_ICiX8QLSEVYFmUHv7ar05HJ742aea3CAbO5tGWTuAg1Y9Z4qUpi6Q>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8EB4E328037B;
 Wed,  4 Nov 2020 05:22:49 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 0/3] hw/block/nvme: coverity fixes
Date: Wed,  4 Nov 2020 11:22:45 +0100
Message-Id: <20201104102248.32168-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.21; envelope-from=its@irrelevant.dk;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 05:22:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

Fix three issues reported by coverity (CIDs 1436128, 1436129 and=0D
1436131).=0D
=0D
Klaus Jensen (3):=0D
  hw/block/nvme: fix null ns in register namespace=0D
  hw/block/nvme: fix uint16_t use of uint32_t sgls member=0D
  hw/block/nvme: fix free of array-typed value=0D
=0D
 hw/block/nvme.c | 6 ++----=0D
 1 file changed, 2 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.29.1=0D
=0D

