Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C14C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841AB2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtnwpGHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841AB2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRlR-00047X-LL
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbRkQ-0002lz-9j
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:39:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39661
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbRkO-0003Cc-NS
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589992750;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1RXcT+m5fEQaQTWhBvQ/FuurJU8Ns0XgfOjyOfTUYT0=;
 b=ZtnwpGHppBs60mLA2jUYEiMe144uP+/rU9oS4nAYuR1JdGsgIVjGxpMcMxw1ArhnwMgoQd
 7lVwmE8aNRvPB7K4hdYh3Cjh0nGXOZysWVS8IRGuE5CWN37Vz60XrPBJArqWHbGmK/vTLe
 VrAvCSRJ4Gu3FBoayqG3AAKyoQxqisA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-QRsBqDPeNaacQDNFyeD8yA-1; Wed, 20 May 2020 12:38:59 -0400
X-MC-Unique: QRsBqDPeNaacQDNFyeD8yA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D2518010FC;
 Wed, 20 May 2020 16:38:58 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E0D55D9CA;
 Wed, 20 May 2020 16:38:53 +0000 (UTC)
Date: Wed, 20 May 2020 17:38:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] sd: disable sdhci-pci device by default
Message-ID: <20200520163850.GA2205278@redhat.com>
References: <20200520152450.200362-1-ppandit@redhat.com>
 <20200520152450.200362-3-ppandit@redhat.com>
 <CAFEAcA_WbJR9PWpw4f2jWecouSn7U0y9=0t4ek1rGwxtM6tXBQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WbJR9PWpw4f2jWecouSn7U0y9=0t4ek1rGwxtM6tXBQ@mail.gmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 04:39:45PM +0100, Peter Maydell wrote:
> On Wed, 20 May 2020 at 16:28, P J P <ppandit@redhat.com> wrote:
> >
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > Disable rarely used sdhci-pci device build by default.
> >
> > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> 
> Doesn't this break existing working command lines? The
> device exists, some people use it. We should treat it like
> other PCI devices -- if the guest arch/machine can handle
> PCI the device should be built.
> 
> There's obviously scope for being more general and allowing
> some kind of "only build the subset of devices we feel
> more confident abut the security of" setup (don't RH do
> something like this downstream?), but upstream we don't
> have a concept like that, we just build everything.

Yeah, disabling undesired devices is really a job for downstream and Red
Hat do indeed do this in RHEL builds of QEMU.

What's missing from an upstream side I think is largely a documentation
issue. ie a way to actually tell our users the good, bad & the ugly
for QEMU features, so they can make informed decision to disable stuff
if they wish.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


