Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2968522B40
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1AZtlv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2968522B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tLP-0002VT-8g
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k2tKe-00023t-JP
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:34:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k2tKb-0001iG-WF
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596533640;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1u/jiTQpDamFXu57rybUwjHd22F8XG5Ygy0pNfb6GhI=;
 b=M1AZtlv+yEVs11cGj7Rd9EAO/HnDP5ZRvHFKoWbcR8TmKRQ8TAmj5NAqBEp0LzLojLKYVS
 nMghEl5yKB4l2JplkTJfpyRf3SS6sXYozT+Y9d6j8VELXLt6u+D7arcYvXvkTYLxSizrSw
 4Zbm9ckDcuxyde5V23mPzq9EvxZb74A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-1keIJpUjO26jWxtAyqpGcA-1; Tue, 04 Aug 2020 05:33:58 -0400
X-MC-Unique: 1keIJpUjO26jWxtAyqpGcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC67D100CCC9;
 Tue,  4 Aug 2020 09:33:57 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE65119C4F;
 Tue,  4 Aug 2020 09:33:52 +0000 (UTC)
Date: Tue, 4 Aug 2020 10:33:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1] .travis.yml: Deprecate it in favor of GitLab CI
Message-ID: <20200804093349.GE4020825@redhat.com>
References: <20200804083040.24659-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804083040.24659-1-philmd@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: libvir-list@redhat.com, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 10:30:40AM +0200, Philippe Mathieu-Daudé wrote:
> As of QEMU 5.2 we prefer to focus our CI development on GitLab.
> Mark Travis-CI as deprecated (adding a big warning).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  docs/system/deprecated.rst | 11 +++++++++++
>  .travis.yml                |  7 +++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 851dbdeb8a..c17a5b0896 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -17,6 +17,17 @@ they were first deprecated in the 2.10.0 release.
>  What follows is a list of all features currently marked as
>  deprecated.
>  
> +Build and test automation
> +-------------------------
> +
> +``Travis-CI`` (Since 5.2)
> +'''''''''''''''''''''''''
> +
> +``Travis-CI`` is deprecated in favor of GitLab-CI.
> +
> +The '.travis.yml' configuration should only be modified to remove jobs
> +when equivalent exist on GitLab-CI. Adding new jobs is not allowed.

I don't think this is really needed. CI is not an end user feature
that is covered by deprecation policy. We simply do whatever we want
with CI at any time that suits maintainers.

>  System emulator command line arguments
>  --------------------------------------
>  
> diff --git a/.travis.yml b/.travis.yml
> index 6695c0620f..4ad243f511 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,3 +1,10 @@
> +#  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
> +#
> +#  As of QEMU 5.2, this file is now deprecated in favor of GitLab CI.
> +#  Do not modify, except to remove jobs ported to GitLab CI.
> +#
> +#  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING

  NOTE: GitLab provides the primary CI platform, with Cirrus CI
        as the preferred secondary. No new jobs or functionality
	should be added to Travis. The intent is to eliminate
	Travis whereever possible.

More broadly we would benefit from having a ci.rst file somewhere
in docs/ to explain our setup and strategy

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


