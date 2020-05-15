Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080BB205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnnwY5t+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080BB205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWJl-0001Hb-5l
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZWIw-0008Qx-Jc
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:06:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28811
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZWIu-0002OR-Oo
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589533611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sowM/9j+kZRiSKGXQzqV+PxmhTxns9/+DtpFll6HMhk=;
 b=SnnwY5t+LkMBusDRlvSKW3FxUncdspVFplsmLcQ4ReN/4FjlpjCrDsDMm1xkUTDBx4U4KA
 ko+BBKsr1Lnbo9HaVvjqArSaDlk/tjPSgTZaNj3eg68w8I6bPlAEYtOwdjGhjYiEf56mVP
 3p9JJP7VSibsF5ChhY5mto8MMyISL7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-4mrLz4OTOSuJS-3PO_cNxA-1; Fri, 15 May 2020 05:06:50 -0400
X-MC-Unique: 4mrLz4OTOSuJS-3PO_cNxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3440C80183C;
 Fri, 15 May 2020 09:06:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5C951001B2C;
 Fri, 15 May 2020 09:06:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E692116E16; Fri, 15 May 2020 11:06:47 +0200 (CEST)
Date: Fri, 15 May 2020 11:06:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: proposal: deprecate -readconfig/-writeconfig
Message-ID: <20200515090647.hpeok5f57cf2oos5@sirius.home.kraxel.org>
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
 <20200514085622.GB1280939@redhat.com>
 <56379563-c1f3-3270-f9ac-5bdd49b324aa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <56379563-c1f3-3270-f9ac-5bdd49b324aa@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Sometimes I feel like a broken and impartial solution is really worse
> than having none. If we don't truly support the read/write config
> options, we shouldn't pretend that we do.
> 
> Funneling users back to using the CLI is likely the better thing, even
> with no replacement.
> 
> I realize this is a pretty hostile thing to do in general, though, but
> it might truly be the kinder option to start simplifying and unifying
> configuration, documentation, and support efforts.
> 
> We don't have to actually remove it right away, either.

Removing doesn't buy us much as long as both cli and -readconfig are
using QemuOpts as backend.  -readconfig itself isn't that much code
after all, it is just an alternative way to feed QemuOpts.

I see -readconfig getting into the way when moving from QemuOpts to
something else (with proper tree support) though.

> We can just start sounding the alarms that we're preparing to remove
> it, and falling back to using the CLI would be a safe thing to do for
> now.

Yes, we should start sounding the alarms (aka deprecate it).  Not sure
"fallback to cli" is a good recommendation though, I suspect that might
not stay compatible either.

take care,
  Gerd


