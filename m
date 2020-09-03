Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A49C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4A620897
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLwR4cj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4A620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkZm-0000J3-EH
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDkXq-0004gG-DG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:24:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43950
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDkXo-00007P-Hz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599121471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWUVD1AMxwYlhHgLy9NbxCNpT1a2+skmCBvE/G/yI9A=;
 b=eLwR4cj2XIZCNlzmAHD/cmmv+hp2ua24XKYMo+AKh6rgGz29IGJ0ZeMRVTJ8rpqUu+H1K8
 v7yShuYhaL0g5fF5kOEX5wPRrFOScGBk+eRO7zUUrjoJ+uqmzPy0okVmsF2aKN0/y4H2fm
 R5SXPtPeOT+K15cpS3c6Lm3JkdMJ6tE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-LnrqHawSMRSqycILt91ReA-1; Thu, 03 Sep 2020 04:24:30 -0400
X-MC-Unique: LnrqHawSMRSqycILt91ReA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DAA2801AE0
 for <qemu-devel@nongnu.org>; Thu,  3 Sep 2020 08:24:29 +0000 (UTC)
Received: from redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 341B078B38;
 Thu,  3 Sep 2020 08:24:28 +0000 (UTC)
Date: Thu, 3 Sep 2020 09:24:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] stubs: Move qemu_fd_register stub to util/main-loop.c
Message-ID: <20200903082425.GC441291@redhat.com>
References: <20200903054503.425435-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200903054503.425435-1-thuth@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 07:45:03AM +0200, Thomas Huth wrote:
> The linker of MinGW sometimes runs into the following problem:
> 
> libqemuutil.a(util_main-loop.c.obj): In function `qemu_fd_register':
> /builds/huth/qemu/build/../util/main-loop.c:331: multiple definition of
>  `qemu_fd_register'
> libqemuutil.a(stubs_fd-register.c.obj):/builds/huth/qemu/stubs/fd-register.c:5:
>  first defined here
> collect2: error: ld returned 1 exit status
> /builds/huth/qemu/rules.mak:88: recipe for target 'tests/test-timed-average.exe'
>  failed
> 
> qemu_fd_register() is defined in util/main-loop.c for WIN32, so let's simply
> move the stub also there in the #else part of the corresponding #ifndef
> to fix this problem.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  stubs/fd-register.c | 6 ------
>  stubs/meson.build   | 1 -
>  util/main-loop.c    | 4 ++++

>  3 files changed, 4 insertions(+), 7 deletions(-)
>  delete mode 100644 stubs/fd-register.c

The util/meson.build only adds main-loop.c under 'if have_block'.

Since you didn't remove that conditional, I assume that nothing
built in a "if not have_block" scenario was relying on the existing
stub ?

Assuming the answer is yes and/or CI passes 

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


