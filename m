Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE6C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AE4206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7Ncjs66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AE4206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVc4J-00021W-RR
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walters@verbum.org>)
 id 1jVbxx-00015U-GH
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:21:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walters@verbum.org>)
 id 1jVbxu-0002k2-SI
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:21:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 394AD5C00D1
 for <qemu-devel@nongnu.org>; Mon,  4 May 2020 10:21:00 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Mon, 04 May 2020 10:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=lw3Ql38m0Jwl/TF00t7JYTP77xvzbsuVGUsilmK4D
 kY=; b=l7Ncjs66JjeiVymLKVIDx/KEU4pDYugZNu7ES/3FtOksKRzLDKQ01R0MU
 U9LzTkFDj3frZL2AKhQGA72iUxEBu00x8mj4s7KikvWSNn9RAG1ALUuyluzsnYsZ
 9uHUNLznFanLou0KmvP6IdgW2+OtXJ6EKFrTz0GchjM8jsc7WwW00BqoNM8wNDFg
 WUe22NGYjN/0jxN6VqqGlvOO7ouAPF4uRK1t9suAUBR125XgvDUXfkem+9FdurrX
 Uj2sut6o6GiAHa07qrxptDyjKJDzvdXRfHWieT2f9NbEiAY0wEntDSa4ROHVZHDv
 kuYnY+Cx1YCJS0PeDDpuEDnefgmkg==
X-ME-Sender: <xms:yySwXinf1fUWHGbDwXvC8MVck8isgUuvHrkmapBJukrARe1yxF8azA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeggdeijecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgfgsehtqh
 ertderreejnecuhfhrohhmpedfveholhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghr
 shesvhgvrhgsuhhmrdhorhhgqeenucggtffrrghtthgvrhhnpeekjeeggeeivdekhfehve
 eutdejudehffetgfejieetjeevleegvddtiedvleekkeenucffohhmrghinhepghhithhh
 uhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:yySwXnroevN01FRTJDWW--0z2jXc8vKI_ecYNZxKj3ilztfest6qbw>
 <xmx:yySwXrHN6-GGOzlpexmGNL5D2j40LtVriHK6UhZlcxGdkqkVZoTqig>
 <xmx:yySwXjzo9XdWjxi9jovo-U7VV7YQbRx5j2LUIIhC0EadOcy1hKqSNQ>
 <xmx:zCSwXtiRFH1CbVGLZuu15C_e7VGghmwl_3tiwc6Xn4wmk9Qngt9_AA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id ADDE0660089; Mon,  4 May 2020 10:20:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-351-g9981f4f-fmstable-20200421v1
Mime-Version: 1.0
Message-Id: <47c7707a-b5c5-4d25-8d86-ced4741f6a27@www.fastmail.com>
In-Reply-To: <CAJ+F1CJsBRp+9yf=kGZt18APXskO8NWyQ1YEqauLYhiNmcW39Q@mail.gmail.com>
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
 <CAJ+F1CJsBRp+9yf=kGZt18APXskO8NWyQ1YEqauLYhiNmcW39Q@mail.gmail.com>
Date: Mon, 04 May 2020 10:20:39 -0400
From: "Colin Walters" <walters@verbum.org>
To: qemu-devel@nongnu.org
Subject: =?UTF-8?Q?Re:_[PATCH]_virtiofsd:_Use_clone()_and_not_unshare(),
 _support_?= =?UTF-8?Q?non-root?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=66.111.4.25; envelope-from=walters@verbum.org;
 helo=out1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 09:50:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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



On Mon, May 4, 2020, at 10:07 AM, Marc-Andr=C3=A9 Lureau wrote:

> Now that systemd-nspawn works without privileges, isn't that also a
> solution? One that would fit both system and session level
> permissions, and integration with other services?

This is a complex topic and one I should probably write up in the bubble=
wrap README.md.  Today for example for CoreOS, our build and CI processe=
s run inside OpenShift (Kubernetes) - we aren't running systemd inside o=
ur containers.

bubblewrap is a small self-contained C wrapper around the container syst=
em calls basically.  In contrast, AFAICS right now, nspawn requires syst=
emd - which won't work for our use case.

Really the contention point here is systemd's dependency on cgroups for =
process tracking; in a "nested containerization" scenario you often just=
 want the cgroups from the "outer" container to apply.  But having neste=
d mounts/pid namespaces are still very useful.  (That said, cgroups v2 a=
llows sane nesting, but we aren't there yet)

Also related is https://github.com/kubernetes/enhancements/issues/127 - =
without that one requires privileged containers to do nesting.

Now honestly, probably an even easier fix is `virtiofsd --disable-sandbo=
xing` because we fully trust the code running in these VMs.

Or to directly respond again to your proposal: systemd-nspawn as an opti=
on may work for some cases but won't for mine (I don't want virtiofsd/qe=
mu instances to "escape" the build container or run separately).


