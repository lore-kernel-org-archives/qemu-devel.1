Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1118C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830D42084E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830D42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8wD-0005HO-O6
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:04:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1hP8u6-000416-8I
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1hP8u5-0004RJ-Ce
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:01:50 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>)
	id 1hP8u2-0004Pt-Tv; Fri, 10 May 2019 13:01:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 291393E4;
	Fri, 10 May 2019 13:01:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
	by compute4.internal (MEProxy); Fri, 10 May 2019 13:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=braap.org; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=mesmtp;
	bh=HAc61hZVPwMI44DNxHAee1xNkXKfQn9mb6hUsdxLP3k=; b=0tdz4EV4dk/P
	QwCMjB92FLTUHWyaFfcTMrpS5y2ywKgHLPSsYtA7vzNChnFVRFKB7uVw7u4DOo69
	ZP5rzDMdul0QnG53QfMf/q7QjdPD5kgIzafDDSU+T234VQvQHPmfc8efzRfRKpyU
	/IQKh4k+bKhMukurQqGZINP0svy86xs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; bh=HAc61hZVPwMI44DNxHAee1xNkXKfQn9mb6hUsdxLP
	3k=; b=fzFpRsSh6yf12POjeGdjnjKM+SVM0AXWcOaHu8Ixdu/D/RAMBjklPa5o/
	KV40Jk/PBB1VAJwrXTvEFZjGXWQAdY0q4VE7uts2gsZ+8+7lKWWcVaH/KC2tKEsz
	X1unvHtfhMCj+l1JxXh6/i6/+MxdGKsUU0PC+sWfAoAdLlJn5M3NQFRQsaeKn8ST
	x6UBVFca3TliSas6xgTUH36yeejW3ODz5ZMNiY0/UEjnlGgUi33oPdzl48msWqZ1
	tSLLYb+5NBEozxpZqf6bUKk4OK93u7ZqlmiS5wTs+BD2zCvB1vuT6PTHZk2r8VyG
	nIhdzrJzIWZQt/HeGYqF6W0Ka3OeA==
X-ME-Sender: <xms:d67VXMdoGG_zSUvNaITYdrbFjrA9EEXNfITv5HClU1QnIhMiiItBmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrkeekgdduuddtucetufdoteggodetrfdotf
	fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
	uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
	cujfgurhepfffhvffukfhfgggtugfgjggfsehtkeertddtredunecuhfhrohhmpedfgfhm
	ihhlihhoucfirdcuvehothgrfdcuoegtohhtrgessghrrggrphdrohhrgheqnecukfhppe
	duvdekrdehledrvddtrddvudeinecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohhtrges
	sghrrggrphdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:d67VXPEqDvQb0jaa39XVizmD-RpDlPHPyMSLvLMdfvVSC4O60xCyXg>
	<xmx:d67VXOj7hTWPS-F0h8ErW7wII31Kpw9JwpBzSoBnjtE1k4v0Ud_p9g>
	<xmx:d67VXD5FeGFDEF1ZAPmmzzgZBM7jJnj6yMrGYJAh_cRXi9VwMP_dgw>
	<xmx:d67VXCjRUzSEjJMpkXpXMSLCJpv7rWDe965D8A36pnz0ArgUiFsXcA>
Received: from localhost (flamenco.cs.columbia.edu [128.59.20.216])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1E1D38005A;
	Fri, 10 May 2019 13:01:43 -0400 (EDT)
Date: Fri, 10 May 2019 13:01:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190510170142.GA21309@flamenco>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<87muju4mvi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muju4mvi.fsf@zen.linaroharston>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 64.147.123.25
Subject: Re: [Qemu-devel] [PATCH v5 00/15] demacro softmmu (plus
 tests/coverage)
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
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 11:36:33 +0100, Alex Bennée wrote:
> Ping Emilio/Mark
> 
> Would you be able to re-run your tests to check there are no other
> regressions? I can then get the PR prepared for merging ;-)

I'll try to run some tests next week, but I am not sure I'll
have time to do so. If I were you I'd go ahead with the PR --
it's best to have these type of changes merged early in the
development cycle.

Thanks,

		Emilio

