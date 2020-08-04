Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426DF2076C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViKN70xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426DF2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sTX-0003nT-Dy
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2sSc-0002cL-7S
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:38:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43672
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k2sSa-0002Di-HM
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596530289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=mj8Nx2QkFKKhnLdRk0a1cbxp2WcmoypSpHPyihRqr3M=;
 b=ViKN70xfFIATUUUgGf+wyyOU2FIC7bOSjDqPhY7faYSmj+w6mTyCfjoVJFMNKJc9L4yrqN
 MsooA7onT8+klINovfS3Pmg3vSyOkeQUVNvjnjvmrioBiRHtcgy2nsAbUPyhsD2QBle7uE
 kcflPUlS7bU6fxfH+ERWTPy/195muS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-DJTRikVAN8y20VmaS_jT6w-1; Tue, 04 Aug 2020 04:38:06 -0400
X-MC-Unique: DJTRikVAN8y20VmaS_jT6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A6301923766;
 Tue,  4 Aug 2020 08:38:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-162.ams2.redhat.com [10.36.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44E5D5D9F7;
 Tue,  4 Aug 2020 08:37:58 +0000 (UTC)
Subject: Re: [PATCH-for-5.1] .travis.yml: Deprecate it in favor of GitLab CI
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200804083040.24659-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <830481ff-d4c0-ff34-854a-c5d5f17bfdc9@redhat.com>
Date: Tue, 4 Aug 2020 10:37:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200804083040.24659-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: libvir-list@redhat.com, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/08/2020 10.30, Philippe Mathieu-Daudé wrote:
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

I don't think that we need to document this for the normal users.

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

Fine for me to add this warning here (but maybe without saying 16 x
WARNING) - but I guess we'd like to keep the non-x86 build jobs here for
people who do not have access to aarch64, ppc64le and s390x runners
otherwise?

 Thomas


