Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCD6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B578122CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjikCEnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B578122CB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGDB-0005sI-28
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBGCe-0005Sx-Vh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:36:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBGCd-0005OK-3Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598528182;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K7OZAZQTJ0z9o9qi95iFdineJGQ/t4TZQPD0OVO54Q8=;
 b=YjikCEnt7wtgiKyysTo1Eaf/0ugVJTytX08S1jti8/hEBoXkmFV/QDdHfUtu8Ul9Mc7JHB
 P5iVsifGK3qKxcDa9R+69yh0Y/N6Av4LwFaJ2Qov+m43vmj4lv3TPMBgLAiKQz5tiKph8z
 bpdqGasQQm1PKcXwolOwDTDaIWCl/Ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-RFqMWyvlNA2ygTS5IAwKSw-1; Thu, 27 Aug 2020 07:36:18 -0400
X-MC-Unique: RFqMWyvlNA2ygTS5IAwKSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E975185FD81;
 Thu, 27 Aug 2020 11:36:17 +0000 (UTC)
Received: from redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C435A10013D5;
 Thu, 27 Aug 2020 11:36:15 +0000 (UTC)
Date: Thu, 27 Aug 2020 12:36:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Deprecate lm32 port
Message-ID: <20200827113612.GQ192458@redhat.com>
References: <20200827113259.25064-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200827113259.25064-1-peter.maydell@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Walle <michael@walle.cc>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 12:32:59PM +0100, Peter Maydell wrote:
> Deprecate our lm32 target support. Michael Walle (former lm32 maintainer)
> suggested that we do this in 2019:
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg605024.html
> because the only public user of the architecture is the many-years-dead
> milkymist project. (The Linux port to lm32 was never merged upstream.)
> 
> In commit 4b4d96c776f552e (March 2020) we marked it as 'orphan' in
> the MAINTAINERS file, but didn't officially deprecate it. Mark it
> deprecated now, with the intention of removing it from QEMU in
> mid-2021 before the 6.1 release.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based-on: 20200825172719.19422-1-peter.maydell@linaro.org
> ("Deprecate Unicore32 port") to avoid the obvious textual-conflict.
> 
>  docs/system/deprecated.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


