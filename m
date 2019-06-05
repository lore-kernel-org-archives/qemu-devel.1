Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D45C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53F820684
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDYeR61P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53F820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYW9g-0004tp-0w
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 09:40:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW8b-0004OH-OM
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW8Z-0002Ny-O2
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:39:33 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hYW8V-00025g-Si
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:39:29 -0400
Received: by mail-ed1-x543.google.com with SMTP id m10so5849680edv.6
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=vIcNOxYsz30b7dNDw+ATeMzsMsRXXFsn4VgaluwXq6A=;
	b=cDYeR61PTE1/mRKB6n5KsJOM4gUy3FFeP/xJkPMS99lOXG7T+j6x884KTkYrCtjDRt
	9bwQYXB/XkXoEsCqZDHeTxIb76jEFlcKYJvebsIQ5/qPDaql8YrVfJNuJxtvuUu03iL2
	ynrUAg4EvCLeAE1T73BArx8cyx3q1dNyzpimvAf9tHwT2AJ/4ngdvU3+NcP5QmRr9Gxk
	Vm4f/NNmTUHvFkq11BIWNzcdWnvBXxwG9P9RHc/9bgsYdEzXYsRz66bOgQTEgk4awlHq
	WAEcJjxjmivsyOCOhKxwwYvrtDWTWLMEg3LF3ogE/1wVny76ph603TT5UD4cyMGAMWbi
	k+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=vIcNOxYsz30b7dNDw+ATeMzsMsRXXFsn4VgaluwXq6A=;
	b=Ly/Y98CaXfDq+1qJd4J5K3Kpjtru0tOqdaZArCqeA2e1V2wOH7XknDcihv83vFF7DO
	WI6eU9q0neE4xZz0HNmlXc2pIdQlpEPqhH/vgzPqu3IbURBb9CjwdhWcKHraPaE+Gsy+
	jQ9mHGlSGLGjV5NY//1shhOQsNivhOb/YePvRUt0g7bW7lqsWGX6s9StH3HKQEqCQZaC
	htYyWC3crb5FyS/gGSPSIOfccC0a8gC1GOEDVu9biVuhGp4oYSsl4tPif6IDVdlZ9fCP
	gb2oT0QSD5qO42FN7prkxtt8Vxa7zZtmjhdSqiGsD4foDHjYnFyV0WogBCdirtMpttZW
	Z5rw==
X-Gm-Message-State: APjAAAUeIdQVvihSq0S1SllDGO0Vbe/3Mbwr32onu89lPAh0ZrAYga6h
	Pqv80KTHKOSea2k3m9Tu6D4=
X-Google-Smtp-Source: APXvYqzoNpVY4BJLdxRSiw8ecgsZxRrJfaNktkq7a4OTlSchwVIDzCo46ik1gMcv5I9a/TnXvhncNA==
X-Received: by 2002:a50:ac12:: with SMTP id v18mr18132149edc.232.1559741961717;
	Wed, 05 Jun 2019 06:39:21 -0700 (PDT)
Received: from localhost ([185.92.221.13]) by smtp.gmail.com with ESMTPSA id
	x30sm5579384edc.53.2019.06.05.06.39.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 05 Jun 2019 06:39:20 -0700 (PDT)
Date: Wed, 5 Jun 2019 13:39:19 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Philippe Mathieu-Daud?? <philmd@redhat.com>
Message-ID: <20190605133919.2yslqh6seu7ij5mr@master>
References: <20190605010828.6969-1-richardw.yang@linux.intel.com>
	<c3b37e07-6d13-1ed9-bb75-0a94c31c8399@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b37e07-6d13-1ed9-bb75-0a94c31c8399@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH] migratioin/ram.c: reset complete_round
 when we gets a queued page
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 02:27:11PM +0200, Philippe Mathieu-Daud?? wrote:
>migratioin -> migration

Ah... I should take an English lesson...

Thanks

-- 
Wei Yang
Help you, Help me

