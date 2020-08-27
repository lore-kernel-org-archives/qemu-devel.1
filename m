Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95857C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE3F20738
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8k7MbIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE3F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEI4-0005DN-Id
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBEDQ-0006l6-Id
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:29:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBEDO-00043z-Cs
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598520540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VSqzT/3cT9tuKSuiCbBKvwVmtBzWA6xWGuBGhdzDymA=;
 b=A8k7MbImE7c2fsJuz4ABK0/aqEJx5wjSyH50ENd+gxddQ1V1BDErKDu69pS1AWIZBmd8y2
 kT+c72WMoE5ux28EBQJZfPOsOeQwR8a6OTdaYplyiJlmbzRPduefH1T8beHKpJ3vqo2aTi
 OzO/BtFtyb++ThobTgqMmvfphw4x9Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-B0nSCDuVN1Cj3fUh9X81cQ-1; Thu, 27 Aug 2020 05:28:58 -0400
X-MC-Unique: B0nSCDuVN1Cj3fUh9X81cQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86B51640D2;
 Thu, 27 Aug 2020 09:28:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BBB65C1DA;
 Thu, 27 Aug 2020 09:28:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A37A8991; Thu, 27 Aug 2020 11:28:53 +0200 (CEST)
Date: Thu, 27 Aug 2020 11:28:53 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 0/3] Fixes 20200825 patches
Message-ID: <20200827092853.eu3uvddhcyljqqbe@sirius.home.kraxel.org>
References: <20200825062008.6502-1-kraxel@redhat.com>
 <128e42b3-3b0f-744b-91be-f4c52837c3a2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <128e42b3-3b0f-744b-91be-f4c52837c3a2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 laurent@vivier.eu, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> if I've got that right, something in this pull request broke the gitlab
> CI, see:
> 
>  https://gitlab.com/qemu-project/qemu/-/jobs/702680909
> 
> 216 (33/45)
> tests/acceptance/vnc.py:Vnc.test_change_password_requires_a_password:
> ERROR: Unexpected empty reply from server (0.08 s)
> 217 (34/45) tests/acceptance/vnc.py:Vnc.test_change_password:  ERROR:
> Unexpected empty reply from server (0.06 s)

Yep, qemu is upset b/c the en-us keymap isn't there.

Seems we handle the 'no qemu-keymap present + start from build
directory' case not correctly.  I guess with the symlink being
gone now we should just copy the files from the source tree.

https://gitlab.com/kraxel/qemu/-/commit/1e29c4518e7b69d09bb22e071376ddeb151d0970
https://gitlab.com/kraxel/qemu/-/pipelines/182575761

lets see how it is going ...

take care,
  Gerd


