Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3401C20825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX/bB4ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3401C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVKY-0006bm-4f
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 21:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1kaVK1-0006CH-7X; Wed, 04 Nov 2020 21:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1kaVJz-00020B-DX; Wed, 04 Nov 2020 21:48:20 -0500
Received: from sstabellini-ThinkPad-T480s (c-24-130-65-46.hsd1.ca.comcast.net
 [24.130.65.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 245DF207BB;
 Thu,  5 Nov 2020 02:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604544496;
 bh=ZRX03WWp+HodhW70KtyU3AosnroCscAI79TzzbsHGMo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=tX/bB4ieWI//QTQJIe7Jp/rxTkdd79TjF1ezfVgEucOxk+jnx/1r2TP3B0IVG0RSU
 vgsI8Upx66YuO5sZAqFhAA66ilyYACmbv5aCJpzXkLqmmZz+RmEhQHHJh0Uptxw/Pa
 /EYtXuZou0pV3xIkPO6c9mBLKIFzqwWVm/u/KIgw=
Date: Wed, 4 Nov 2020 18:48:14 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
In-Reply-To: <CABgObfaAH1fty0y0Z10GALnhy4kL_FqSxPZc2-=PwJgtSrOX0g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2011041742580.3264@sstabellini-ThinkPad-T480s>
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
 <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
 <21e90ddb-fe8a-c780-2741-9b7a2f7f1c9a@redhat.com>
 <alpine.DEB.2.21.2011031722100.3264@sstabellini-ThinkPad-T480s>
 <CABgObfaAH1fty0y0Z10GALnhy4kL_FqSxPZc2-=PwJgtSrOX0g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1067490152-1604540899=:3264"
Content-ID: <alpine.DEB.2.21.2011041755170.3264@sstabellini-ThinkPad-T480s>
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:48:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1067490152-1604540899=:3264
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.2011041755171.3264@sstabellini-ThinkPad-T480s>

On Wed, 4 Nov 2020, Paolo Bonzini wrote:
> Il mer 4 nov 2020, 03:27 Stefano Stabellini <sstabellini@kernel.org> ha scritto:
>       FYI I tried to build the latest QEMU on Alpine Linux 3.12 ARM64 and I
>       get:
> 
>         ninja: unknown tool 'query'
> 
>       Even after rebuilding ninja master by hand. Any ideas? I don't know much
>       about ninja.
> 
> 
> Are you sure you have ninja installed and not its clone samurai (yes, I am serious)? I have contributed query support to samurai but it
> hasn't made it to a release yet.
> 
> What is the output of "ninja -t list"?

I repeated all the steps to make sure. The first time I was using
Samurai because Alpine Linux comes with it and not Ninja. Then, I
removed Samurai and built and installed Ninja by hand from
https://github.com/ninja-build/ninja and that actually works. Yesterday
it was late and I was distracted by global events -- I must have failed
to update Ninja appropriately. Sorry for the confusion.
--8323329-1067490152-1604540899=:3264--

