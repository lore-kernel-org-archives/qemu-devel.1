Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6F7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A44206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Afsn1dB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A44206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTns-0002Iv-Eu
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtTnD-0001PP-GU
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:28:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtTnA-00087e-Hu
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594290513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/OWuRlIehsRHlWCuoueu7miuA0huSBRHYM7KDW2egQ=;
 b=Afsn1dB2INeOgPJTxcJK2w15em+0ptzMwO9R9qYtTNxaiCw8x8YTfHvRHB9BS4ebAaT8QB
 eWUInMJf7FWVvHpijzHnnUvLDcuT3y9aTTSY5XMFnshlPcf4vwEgNmJFrTG0cMw2Z2tRz1
 ztvi73L3UrzeA9YxE5RVRg43lXPJnzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-GsKK5r0yOYGkLugZ9B0kwA-1; Thu, 09 Jul 2020 06:28:31 -0400
X-MC-Unique: GsKK5r0yOYGkLugZ9B0kwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D98A180183C;
 Thu,  9 Jul 2020 10:28:30 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-122.ams2.redhat.com [10.36.114.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCC627F8B7;
 Thu,  9 Jul 2020 10:28:29 +0000 (UTC)
Date: Thu, 9 Jul 2020 12:28:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: Re: [PULL 00/12] Block layer patches
Message-ID: <20200709102828.GA4096@linux.fritz.box>
References: <20200707163504.194740-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200707163504.194740-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.07.2020 um 18:34 hat Kevin Wolf geschrieben:
> The following changes since commit 7623b5ba017f61de5d7c2bba12c6feb3d55091b1:
> 
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-07-06 11:40:10 +0100)
> 
> are available in the Git repository at:
> 
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 7bf114070834e1b0c947b7c2a1c96cb734eb6b86:
> 
>   qemu-img: Deprecate use of -b without -F (2020-07-07 18:18:06 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches:
> 
> - file-posix: Mitigate file fragmentation with extent size hints
> - Tighten qemu-img rules on missing backing format
> - qemu-img map: Don't limit block status request size

This has merge conflicts with Max's pull request that has been merged
since I sent this one, so I'll have to send a v2 once they are resolved
(unfortunately one of the conflicts is not completely trivial).

Kevin


