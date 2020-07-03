Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C99C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811322063A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0Ibcv6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811322063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrItz-0004Qp-PY
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jrItE-0003mq-0S
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:25:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jrItC-0001hG-Az
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593771949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MLp5DtI5ymMYS0XLzItNhSVeWAW7ByTJ1HpvSySoFrU=;
 b=K0Ibcv6Zow5SChG2Pzt5QkQTgF8fjxjZuxtiRvLcVBPJ3QvGWAx+wIETpq85AwLfIMnRgP
 BxDD4t86LKK/CjUDZ0WJYNoiTzf9xQUFyYH/cQKXl88T92KZXbEo/BP7+QN4AjN7mtEKxR
 X0dbtgHSvpO+tJ4ubqPJ72p2eQlonwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-lNO_yIIdMEO9ObSiUsI9Yg-1; Fri, 03 Jul 2020 06:25:47 -0400
X-MC-Unique: lNO_yIIdMEO9ObSiUsI9Yg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EEC6800402;
 Fri,  3 Jul 2020 10:25:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A824A7AC72;
 Fri,  3 Jul 2020 10:25:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6687716E16; Fri,  3 Jul 2020 12:25:41 +0200 (CEST)
Date: Fri, 3 Jul 2020 12:25:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PULL 04/10] build: fix device module builds
Message-ID: <20200703102541.dz47mjnmustpuowl@sirius.home.kraxel.org>
References: <20200702122048.27798-1-kraxel@redhat.com>
 <20200702122048.27798-5-kraxel@redhat.com>
 <a7af3c56-98ab-16e2-afaf-383757b03720@suse.de>
MIME-Version: 1.0
In-Reply-To: <a7af3c56-98ab-16e2-afaf-383757b03720@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 11:01:43AM +0200, Claudio Fontana wrote:
> On 7/2/20 2:20 PM, Gerd Hoffmann wrote:
> > See comment.  Feels quite hackish.  Better ideas anyone?
> 
> A better idea could be to investigate what and why gets into the variable.

I see paths prefixed by "../", which seems to come from recursing into
target directories and not properly handling -m there.

I think this stop-gap will do the job fine as long as we don't have
target-specific modules.

With the pending switch to a meson-based build system which I hope
simplifies all this I didn't feel like investing too much effort into
finding the real root cause.  Debugging the Makefiles is a PITA ...

I'm open to any hints though.

take care,
  Gerd


