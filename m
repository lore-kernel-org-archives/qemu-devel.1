Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A3FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6BC2311C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFIWIB3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6BC2311C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmD7-0007PT-DC
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKmAE-00050j-UI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:33:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKmAC-0002ft-HH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600795989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNrxQDU1DwnuwDQj2UrUlDKvW68rAIu2T5xz9+uTFoE=;
 b=ZFIWIB3SOMnE9q7E1+iLsh3xDFM8eICv7rHIayS2Afo234XtAtBQOXl39J6dtj++z3hQA0
 CYQkr15cm4pcIBVPMQry3quYurggszW3+0zMu/RUMJ5Tm2ktXkw6RkCrHiacYSB0Bd/S/f
 1SyLaSy/penQomOVfpc0yhzuYNGLH3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-IjIBo8fCMTWiLvY-AyVcxQ-1; Tue, 22 Sep 2020 13:33:05 -0400
X-MC-Unique: IjIBo8fCMTWiLvY-AyVcxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20B7F10BBED2;
 Tue, 22 Sep 2020 17:33:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-122.ams2.redhat.com [10.36.113.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3DF81C41;
 Tue, 22 Sep 2020 17:32:58 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] block: deprecate the sheepdog block driver
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200922161611.2049616-1-berrange@redhat.com>
 <20200922161611.2049616-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cd9b52d4-cae7-a684-1305-b719d3575a71@redhat.com>
Date: Tue, 22 Sep 2020 19:32:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200922161611.2049616-3-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 13:33:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, sheepdog@lists.wpkg.org,
 qemu-block@nongnu.org, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/2020 18.16, Daniel P. Berrangé wrote:
> This thread from a little over a year ago:
> 
>   http://lists.wpkg.org/pipermail/sheepdog/2019-March/thread.html
> 
> states that sheepdog is no longer actively developed. The only mentioned
> users are some companies who are said to have it for legacy reasons with
> plans to replace it by Ceph. There is talk about cutting out existing
> features to turn it into a simple demo of how to write a distributed
> block service. There is no evidence of anyone working on that idea:
> 
>   https://github.com/sheepdog/sheepdog/commits/master
> 
> No real commits to git since Jan 2018, and before then just some minor
> technical debt cleanup..
> 
> There is essentially no activity on the mailing list aside from
> patches to QEMU that get CC'd due to our MAINTAINERS entry.
> 
> Fedora packages for sheepdog failed to build from upstream source
> because of the more strict linker that no longer merges duplicate
> global symbols. Fedora patches it to add the missing "extern"
> annotations and presumably other distros do to, but upstream source
> remains broken.
> 
> There is only basic compile testing, no functional testing of the
> driver.
> 
> Since there are no build pre-requisites the sheepdog driver is currently
> enabled unconditionally. This would result in configure issuing a
> deprecation warning by default for all users. Thus the configure default
> is changed to disable it, requiring users to pass --enable-sheepdog to
> build the driver.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  block/sheepdog.c           | 15 +++++++++++++++
>  configure                  |  5 +++--
>  docs/system/deprecated.rst |  9 +++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


