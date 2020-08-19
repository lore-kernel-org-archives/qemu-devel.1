Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A50C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF63620639
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezEzei1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF63620639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8KCx-0006SF-6d
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 05:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k8KBK-0004cX-1f
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:14:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35771
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1k8KBH-00082D-TG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597828490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FW0Kmmzj3GPCWRdcmClJIlXUslLpnOeq09PbBsXBwdc=;
 b=ezEzei1mwGK49EhVeO66uh+gfyvKRPpd01ylAvY9RdoSMqg3pRlFllXLhdPr3AaAYl3jpf
 IEBTkQWlnfBVfyDsAYumI3gd51Jr7iCpNu4MS6U28G3yM37srn6jsMPWJpTS7qjtk66s2m
 EQT0poWymtrCNRvP91jiC1/4FlbGWd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-fblcvZv2M0yhWdNGDR6aCw-1; Wed, 19 Aug 2020 05:14:49 -0400
X-MC-Unique: fblcvZv2M0yhWdNGDR6aCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7A6D186A563;
 Wed, 19 Aug 2020 09:14:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-57.ams2.redhat.com
 [10.36.114.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31A0F6F120;
 Wed, 19 Aug 2020 09:14:46 +0000 (UTC)
Subject: Re: [PATCH v2 1/7] x86: lpc9: let firmware negotiate 'CPU hotplug
 with SMI' features
To: Cornelia Huck <cohuck@redhat.com>
References: <20200818122208.1243901-1-imammedo@redhat.com>
 <20200818122208.1243901-2-imammedo@redhat.com>
 <f5a7a4a6-f80e-9836-1524-d4ffe896be92@redhat.com>
 <20200819105811.4e649725.cohuck@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5d53a2d1-d664-07ea-20f7-ca04aec76016@redhat.com>
Date: Wed, 19 Aug 2020 11:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200819105811.4e649725.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 aaron.young@oracle.com, David Gibson <dgibson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, boris.ostrovsky@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/19/20 10:58, Cornelia Huck wrote:

> I consider any patch that adds compat options without adding all compat
> machines first to be buggy. We had that in the past, and it had been
> painful to sort it out again later. That's why I usually post a compat
> machines patch during hardfreeze, to be picked up by anyone who needs
> it.
> 
> (See
> https://lore.kernel.org/qemu-devel/20200728094645.272149-1-cohuck@redhat.com/
> -- this is the patch that Daniel re-posted.)

Indeed, thank you -- in the end, I did notice that Daniel's patch
started with "From: Cornelia" :) and then I checked my qemu-devel
folders for more emails with the same subject.

> Just pick my original patch, it has a bunch of acks already.

True, but Igor's series wouldn't apply without manual conflict
resolution, and I can't do that if I want to respond with a Tested-by.

(Of course, picking up your patch and including it in v3 is feasible for
Igor.)

Thanks!
Laszlo


