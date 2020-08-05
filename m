Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3EFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F3223333
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="FLtQIh32";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiOPtBMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F3223333
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3L7T-0002wB-7T
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 11:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1k3L6P-0002Ta-NZ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 11:13:13 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1k3L6N-00083u-8j
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 11:13:13 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id AAC445C0099;
 Wed,  5 Aug 2020 11:13:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Wed, 05 Aug 2020 11:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
 from:to:subject:date:message-id:mime-version:content-type; s=
 fm3; bh=t/1haAjNM+f8995x/K7pnGuoXGWpgPXRwC7TQTue9gs=; b=FLtQIh32
 5z3frzMQ8IWsnEXIHlGgxIMYZs6BmxqpsWIBG1VbRTzQziU3gqnVntNXdw7bCbyE
 zoQOi+lvpSmEdW7SJOqTUsaXVzowJ1VCPV8vmBaJ96G6vRqG6UE5R05+QouLB2nn
 xghAEP+DS7VOGFs+kN22B9zk96ZM8HuRTKzj7x9lvIsqSPh/c7aJdStWUvzNEsTB
 H272uSwUtgiZU18C1TgGwuui3LdtvVpu5QKG9QlQtS6WKvdMU9KZQp/0Il8U36F2
 hWvZhzeQj4rL+UpqJvSzhHxDEPkDAY+GmlDzx/bmWPWAwJ07ESHbQPvSSSYKB9LI
 8Z4vQo3x9Mx/Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; bh=t/1haAjNM+f8995x/K7pnGuoXGWpg
 PXRwC7TQTue9gs=; b=XiOPtBMPxSTVBSX1+UMaHcQ3eFVu+p8hvLMKC36b6oDbr
 IQcOSV+MrsOdchjZ7e6uxaSxPotVwfQHpkoGxEd3ra03I+RWTCk252Ws0Vy7ztdg
 ZbNySs4JQwZjfRuyrsYudqlRJngv0fSwqPmv+VrklNSrXBF8ck3GnAWfAEDZroNu
 YO8wVZhASi+Hc0DYJIlMdixujCDXYcw54MB1v5IIHsOSwNu63TcZRNSUjgzGFXF7
 S3yS4u+Jjy/C6o8H0qX3/PLv008H/l33+80IDT9Ntul5KgRzzFxkeDbt3dxilmQJ
 vfTn9ksB5u+6b+gZwVJzN58aGwlL53RTRZFiDxAbg==
X-ME-Sender: <xms:hMwqX5oJmtsBB6kPg4mSwAjz3z-oWNF9aVqqs3ngrRVDegJvZQHqLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeekgdekkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkfggtgesthdtredttddttd
 enucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecu
 ggftrfgrthhtvghrnhepiefhheduffetjeelteevfeejleejiedvleejjefhueefffekud
 dvteejieefveeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkeegrddu
 keegrddvvdelrddvgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:hMwqX7qOJJM4K1PZm-FTcSQ3Rxb2fjLzKg6oBENaA67I07SIvAmuUA>
 <xmx:hMwqX2M5pFXnUoXN9HTkARujDs4AhbEIBsOQzVJs-dIuxEVFvCUYjg>
 <xmx:hMwqX07NogilmW4hM2Qad8La2or5qbx6vFaf4W3TqWRmYYH_lpDatw>
 <xmx:hMwqX6FNZJD7I3KHrhjFpOnlZDUgURIlDFSBopNc3iZLC8f6qKr1Dw>
Received: from x220.qyliss.net (p54b8e5f4.dip0.t-ipconnect.de [84.184.229.244])
 by mail.messagingengine.com (Postfix) with ESMTPA id 163A63060067;
 Wed,  5 Aug 2020 11:13:08 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 9D90687B; Wed,  5 Aug 2020 15:13:06 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: vhost-user protocol feature negotiation
Date: Wed, 05 Aug 2020 15:13:06 +0000
Message-ID: <87sgd1ktx9.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=66.111.4.28; envelope-from=hi@alyssa.is;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 11:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting from the definition of VHOST_USER_SET_PROTOCOL_FEATURES in
vhost-user.rst:

>   Only legal if feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` is present in
>   ``VHOST_USER_GET_FEATURES``.
> 
> .. Note::
>    Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
>    this message even before ``VHOST_USER_SET_FEATURES`` was called.

To me, this could mean either of two things:

(1) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
    VHOST_USER_SET_PROTOCOL_FEATURES, a backend should enable the
    protocol features immediately.

(2) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
    VHOST_USER_SET_PROTOCOL_FEATURES, a backend should store those
    feature bits, but not actually consider them to be enabled until
    after VHOST_USER_SET_FEATURES has been received (presumably
    containing VHOST_USER_F_PROTOCOL_FEATURES).

The reason I bring this up is that QEMU appears to interpret it as (1),
while the vhost-user-net backend in Intel's cloud-hypervisor[1]
interprets it as (2).  So I'm looking for a clarification.

[1]: https://github.com/cloud-hypervisor/cloud-hypervisor

Thanks in advance.

