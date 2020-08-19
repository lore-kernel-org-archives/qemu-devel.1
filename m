Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF39C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF9C20639
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="eg96V0rN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF9C20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Ov2-0005HF-10
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8OuG-0004QA-Cs
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:17:36 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:49421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k8OuE-0007M3-Iz
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=/pqxlgbJiOoFey+/cR0F1JNDYpIW3EumvG38kmPg88Q=; b=eg96V0rNaakoO+qJc0iACQNOqJ
 00jh3ITqnK2frkdF4kXJOmTjNWr5YBYcikIGy6oYCtRB/QMqSq74De1gHy9icOnuzROTLCsFfv0oM
 h+YtvQsZ0OIFnKGE0+2sP29hiQZtKq86/Bg3IFM8yFGK5CUGconqPBEFML+RRsY5o4vFhi2tUWAY6
 aAyTOXh2e77eR1OTQGWh44sioupDi64VbVJJgP/iFK5osfkZMNCA9V0ylAk6b23pavXCDvRpvdp3x
 qa6ILcKqLAfQAgDqeKS+CW+pyPFeNMw34K3zhqv+tK/82IjXKzkCT1/rwtZfm97OChJQehZohSEYg
 ZG4JEdlw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: David Vossel <dvossel@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>,
 Fabian Deutsch <fdeutsch@redhat.com>
Subject: Re: guest agent public ssh key add/remove support?
Date: Wed, 19 Aug 2020 16:17:30 +0200
Message-ID: <63919092.VjiBKyA9Op@silver>
In-Reply-To: <CAPjOJFsr2_0Kdp03jbSUZ2vpde41uHrS6ki_Wax4pZ-d8RTDvQ@mail.gmail.com>
References: <CAPjOJFsjqFg6jO==Y5ExhL2+mZXA0Z1vce2pmUCODLtyS6Z7Yw@mail.gmail.com>
 <2310267.m5nKHIMqSz@silver>
 <CAPjOJFsr2_0Kdp03jbSUZ2vpde41uHrS6ki_Wax4pZ-d8RTDvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 07:30:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Mittwoch, 19. August 2020 15:49:50 CEST David Vossel wrote:
> > There are two pass-through file systems in QEMU: 9pfs and virtiofs. Don't
> > you
> > think they would be sufficient for the use case?
> 
> probably not entirely.
> 
> Understand this isn't an either/or scenario. Our api has been designed to
> support multiple "propagation" methods for the ssh keys. We've converged on
> the qemu guest agent for some other features and the agent appears to have
> the potential to provide us the greatest flexibility when it comes to how
> we want this pub ssh key use case to work.  This isn't to say something
> like virtiofs won't make sense either in certain scenarios, but for the
> purposes of this discussion we're hoping to explore how the qemu guest
> agent could be used.
> 
> I don't want to go too deep into the shared filesystem approach. I'll
> provide some context on the challenges there though.

Expected response, but I could not resist. ;-)

> - virtiofs requires guest kernel >= 5.4. We aren't considering 9p due to
> security/performance concerns.

Hey, there had been no security issue for quite a while with 9pfs. :)
And I am working on the performance issues actually.

Best regards,
Christian Schoenebeck



