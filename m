Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDEDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389BA20771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwusCeqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389BA20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJKO-0007CU-C0
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jmJJa-0006ku-0R
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:52:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jmJJY-0007ab-1p
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592581942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TwYCS38X66RlwOiNXHDbbvAR2QjAHypUAvfwoYIhq4U=;
 b=hwusCeqdliPVqqG9q7d8pnAXIEbj/YISs2J6HQqaiET6dQ1YqMdleOt2MBXqj+0XwB777j
 O+1Rs+BmjlGoR0MPCkJCm5Ygj5tfhmLOE7P+mRHL7ASxAMn5zIQseMknVqqBHv6Allqvp9
 O2OLSYV75Ma1QTNluW/BSDMmCanNpzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-_ar9jqGSNYS9pEvQBAkNng-1; Fri, 19 Jun 2020 11:52:04 -0400
X-MC-Unique: _ar9jqGSNYS9pEvQBAkNng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDD5D801503;
 Fri, 19 Jun 2020 15:52:02 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB4245BAD3;
 Fri, 19 Jun 2020 15:52:00 +0000 (UTC)
Date: Fri, 19 Jun 2020 16:51:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Deprecate TileGX port
Message-ID: <20200619155157.GX700896@redhat.com>
References: <20200619154831.26319-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200619154831.26319-1-peter.maydell@linaro.org>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Chen Gang <chengang@emindsoft.com.cn>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 04:48:31PM +0100, Peter Maydell wrote:
> Deprecate our TileGX target support:
>  * we have no active maintainer for it
>  * it has had essentially no contributions (other than tree-wide cleanups
>    and similar) since it was first added
>  * the Linux kernel dropped support in 2018, as has glibc
> 
> Note the deprecation in the manual, but don't try to print a warning
> when QEMU runs -- printing unsuppressable messages is more obtrusive
> for linux-user mode than it would be for system-emulation mode, and
> it doesn't seem worth trying to invent a new suppressible-error
> system for linux-user just for this.

Potentially we could turn it off by default in configure, so it
requires an explicit  --target-list to request it, but either way,
I don't mind.

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We discussed dropping this target last year:
>  https://patchew.org/QEMU/20191012071210.13632-1-philmd@redhat.com/
> and before that in 2018, when Chen told us he didn't have time
> to work on tilegx any more:
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03955.html
> Given that tilegx is no longer in upstream Linux I think it makes sense
> to finally deprecate-and-drop our linux-user support for it.
> 
>  docs/system/deprecated.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


