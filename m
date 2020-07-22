Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD68C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2284020714
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyPIJKoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2284020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBPu-0007do-3W
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jyBAv-0002Bk-SQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:36:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jyBAt-0008P5-0Z
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595410589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CicbFjaTnNeoEJVDzGjcmtVdGZ96GzEdCKJgCbauGNQ=;
 b=SyPIJKoWobPgGT+YSifW9D9vRuFr1JrSRNdqbvLPyrOgCJszbvCQyoePORUteelrhlXSq5
 KcV2FbIESi/yjzcpkOIeTN+bYTGs7gLeX4841qeEdDMEAIQEotkuJzsubQDrsJE705vbSX
 oT1R465h41ixBj1uTgTemfbiaulCgW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-GTmu4WnDN9Kze3W3aJ877Q-1; Wed, 22 Jul 2020 05:36:27 -0400
X-MC-Unique: GTmu4WnDN9Kze3W3aJ877Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 945E9100CCC3;
 Wed, 22 Jul 2020 09:36:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-50.ams2.redhat.com [10.36.114.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A583B74F58;
 Wed, 22 Jul 2020 09:36:22 +0000 (UTC)
Date: Wed, 22 Jul 2020 11:36:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: please try to avoid sending pullreqs late on release-candidate day
Message-ID: <20200722093621.GA4838@linux.fritz.box>
References: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.07.2020 um 17:56 hat Peter Maydell geschrieben:
> It is not helpful if everybody sends their pullrequests late
> on the Tuesday afternoon, as there just isn't enough time in the
> day to merge test and apply them all before I have to cut the tag.
> Please, if you can, try to send pullrequests earlier, eg Monday.

I sent the majority of my fixes for -rc1 on Friday, not the least to
give us some time in case we get a testing failure. However, the earlier
you send the pull request, the greater the chance that you get some new
patches after the pull request. In this case, the patches were only
ready Tuesday afternoon, so even sending on Monday instead of Friday
wouldn't have helped.

The alternative would have been letting them wait for -rc2. I suppose
you can always says "too late" and make that decision for me, but I
wouldn't want to unnecessarily move things to a later RC. Do you think
we shouldn't send a pull request in case of doubt?

So given that we _will_ have some late patches, what can we do to
improve the situation?

Maybe I could send the pull request before testing it to save some time.
Your tests will take a while anyway, so if my own testing fails (e.g.
for the parts of iotests that you don't test), I would still have time
to NACK my own pull request. This wouldn't buy us more than an hour at
most and could lead to wasted testing effort on your side (which is
exactly the resource we want to save).

Can you test multiple pull requests at once? The Tuesday ones tend to be
small (between 1 and 3 patches was what I saw yesterday), so they should
be much less likely to fail than large pull requests. If you test two
pull requests together and it fails so you have to retest one of them in
isolation, you still haven't really lost time compared to testing both
individually. And if it succeeds, you cut the testing time in half.

Kevin


