Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEB3C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58532220D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUScX0P7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58532220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6gj-0007Fb-1S
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kL6dH-0001wu-Vo
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kL6dE-0005fD-VG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600874671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QalOxNYLBeiWlh/wkzhtACyyqBSI3QfS3e2W10Q+vRs=;
 b=NUScX0P7z0+x21hmO2LepzSG46O3kwc1JJ0fJAU07l7NaOOmbYe/bp+0O5Zl2BOwLDfpmW
 +ZEBG2FzqXPmucO8BLIWtSejU400/r8M0Jof/IAcKjoseY3oj0l26ruiCZwbS0irCHbLLG
 16yt4pbYUc6+CxkqjeWMvNrtDFBvtXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-jjVOBjCWP6mKcpev62q7tA-1; Wed, 23 Sep 2020 11:24:26 -0400
X-MC-Unique: jjVOBjCWP6mKcpev62q7tA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E52D110219E3;
 Wed, 23 Sep 2020 15:23:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-239.ams2.redhat.com [10.36.112.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C71F65C1C7;
 Wed, 23 Sep 2020 15:23:47 +0000 (UTC)
Date: Wed, 23 Sep 2020 17:23:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] tests/check-block: Do not run the iotests with old
 versions of bash
Message-ID: <20200923152346.GE6912@linux.fritz.box>
References: <20200918153514.330705-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918153514.330705-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.09.2020 um 17:35 hat Thomas Huth geschrieben:
> macOS is shipped with a very old version of the bash (3.2), which
> is currently not suitable for running the iotests anymore (e.g.
> it is missing support for "readarray" which is used in the file
> tests/qemu-iotests/common.filter). Add a check to skip the iotests
> in this case - if someone still wants to run the iotests on macOS,
> they can install a newer version from homebrew, for example.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to the block branch.

Kevin


