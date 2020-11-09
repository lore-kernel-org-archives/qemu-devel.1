Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F233CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5BB2067D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDENdiug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5BB2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBL3-0005Sk-0O
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcBIn-0003hN-JF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:50:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcBIl-00041E-RL
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604944197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQR9wPyXLDo9I6/AppnyK2WPP3SO43lz/RS7/KoKTlY=;
 b=KDENdiugyaBq3tnlqgluY3GkcS0dUNCnhG6aFh2syhLYUrak0na1zFpph9xOycx6ciKEni
 /6fDO31rYlOXzGI2aB4e6/spTTz5amlh7FO31dqtWWzn8TJyoCCiKn2tN+jAG2lJN+ec9U
 p4LBDLNcSCzFS7wxPELhlQbMcjM2vjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-d5j0XgPnOlGD3iXt8hyAcA-1; Mon, 09 Nov 2020 12:49:54 -0500
X-MC-Unique: d5j0XgPnOlGD3iXt8hyAcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA0179CC05;
 Mon,  9 Nov 2020 17:49:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-179.ams2.redhat.com
 [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02C3B60C84;
 Mon,  9 Nov 2020 17:49:51 +0000 (UTC)
Subject: Re: [PULL 00/15] Block patches for 5.2.0-rc1
To: qemu-block@nongnu.org
References: <20201109173839.2135984-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1703f9e1-bcd2-91ce-62f7-01cf06d2f0ad@redhat.com>
Date: Mon, 9 Nov 2020 18:49:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109173839.2135984-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.11.20 18:38, Max Reitz wrote:
> The following changes since commit 2a190a7256a3e0563b29ffd67e0164097b4a6dac:
> 
>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/renesas-fixes-20201109' into staging (2020-11-09 11:20:25 +0000)
> 
> are available in the Git repository at:
> 
>    https://github.com/XanClic/qemu.git tags/pull-block-2020-11-09
> 
> for you to fetch changes up to 8f88cb77b06be0c2e45ed31c9fd6817d2ce3836a:
> 
>    block: make bdrv_drop_intermediate() less wrong (2020-11-09 15:44:21 +0100)
> 
> ----------------------------------------------------------------
> Block patches for 5.2.0-rc1:
> - Some nvme fixes (addressing problems spotted by Coverity)
> - Fix nfs compiling on mingw (and enable it in Cirrus)
> - Fix an error path in bdrv_co_invalidate_cache() (permission update
>    was initiated, but not aborted)
> - Fix (on-error) roll back in bdrv_drop_intermediate(): Instead of
>    inlining bdrv_replace_node() (wrongly), call that function
> - Fix for iotest 240
> - Fix error handling in bdrv_getlength()
> - Be more explicit about how QCowL2Meta objects are handled
> - Cleanups

Sorry, NAK.  I applied patch 12 the wrong way (namely, just using 
git-am) and so it’s missing the Message-Id and my Signed-off-by.

v2 is on the way.

Max


