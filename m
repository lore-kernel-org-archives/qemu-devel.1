Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2EBC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977BC20B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="UNYZEwbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977BC20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnt8-00054E-MH
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:36:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hTnkw-0006Hq-Hy
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hTnkv-000874-I0
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:27:38 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:41570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hTnkr-00081s-Kx
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:27:35 -0400
Received: from [172.18.11.102] (antfield.tima.u-ga.fr [147.171.129.253])
	by beetle.greensocs.com (Postfix) with ESMTPSA id E54B296F50;
	Thu, 23 May 2019 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1558618049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=wFG2hCvjSJgBnBlD54sWIUgjXteX0lpW0FTYPIy0VTw=;
	b=UNYZEwbUiVSSXN3hSZuNzhNQhhOQbd9Av7laZbBq7gzXeASHzpmbouR8plF2gxWMr3RJJm
	5owYWbWK/42QK5AL3oxqUZX3PjKkOB7VNQhmNCGefvyBgZWupLRPwuVnaZwglN/aZ/MVS0
	gS+amThAKmSYos2ZXeq/yimYAC/lk2o=
To: Peter Maydell <peter.maydell@linaro.org>,
	Markus Armbruster <armbru@redhat.com>
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
	<CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
	<f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com>
	<87imu3swp2.fsf@dusky.pond.sub.org>
	<CAFEAcA_LFdwYX0Lp8Z=ecgJKC18F7i51nUjOT7YY+CQBaH_tTg@mail.gmail.com>
	<87ef4pisja.fsf@dusky.pond.sub.org>
	<CAFEAcA-8CZT2-sNBDEJdKv7PB-b1usNgbqo0O9QofYApvR-=pQ@mail.gmail.com>
	<874l5lnzjd.fsf@dusky.pond.sub.org>
	<CAFEAcA98zZ60fAWgu4s9aCdKjafNtZsCt8ieEfTWYdZx5D2aGw@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <26f742b1-a26b-6af6-41dc-384c8313572b@greensocs.com>
Date: Thu, 23 May 2019 15:27:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98zZ60fAWgu4s9aCdKjafNtZsCt8ieEfTWYdZx5D2aGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1558618049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=wFG2hCvjSJgBnBlD54sWIUgjXteX0lpW0FTYPIy0VTw=;
	b=w6Q6FkvPAvOi1Rneb927BOd3u6jZ3fIfZ85M06EPWaAoEuehqK28yzUrGu+WYXup3hDuhS
	aLc29yvE9JICfWVB1EO2COBdWC9BfqrIOWQlZQ16yyGeG2w6WHt0Nd4t26HmGXQ9tHe17B
	UFnNJrMMMhRCqEfdWl+MU5MXxcmfeKM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1558618049; a=rsa-sha256; cv=none;
	b=1BqOZp7j4Y+0uHRt7y4BxPYE2P7ZBXYb8jQw7N0ZG5xT2dGYau5JZu3SBiyCq7zHreIMH5
	WOEF9PeAxNkyFd9Sw07LcWnudGtrTj7lKsKdoZqaunJFjyw/xcPm4wTidjJJ0AVF4kwESD
	zVzufU2cAOYUm4fCW3dSKTmgwkmrUhg=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [RFC] hw/core/bus.c: Only the main system bus can
 have no parent
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 5/23/19 2:12 PM, Peter Maydell wrote:
> ...so after this long thread, are we at a conclusion?
> I think my view is that the patch-as-sent needs to be
> revised to also fix bus_unparent() but is otherwise OK.
> 

I think so too.

Damien

