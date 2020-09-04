Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052DFC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2EF206C9
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL2W3dGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2EF206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE72y-0003GH-UH
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 04:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kE72D-0002KX-54
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kE72A-00041d-QK
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599207920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywa21owwmaWlLxKWHnJJeh2l491iysQJ3u2fT/E0nBw=;
 b=iL2W3dGd3B9zW1iapYkeJ/vL6/VSNsR0S9Tn25X0CAfvHHkDOzpkl+44G1fKZps1FmCpAY
 tAscwpfmmtu0y4O6kI3q91xmv6xFaOACoIdCCl15HxPvF8WwEhn71jASI4qIXHAs6O+gKQ
 KShleLSdgzBe/0X4IL9bNVVCj9aXTqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-rwxEEwKHPUeXqwsoMUCnNQ-1; Fri, 04 Sep 2020 04:25:17 -0400
X-MC-Unique: rwxEEwKHPUeXqwsoMUCnNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69622100856A;
 Fri,  4 Sep 2020 08:25:16 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-114.ams2.redhat.com [10.36.112.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50AD55C1D0;
 Fri,  4 Sep 2020 08:25:15 +0000 (UTC)
Date: Fri, 4 Sep 2020 10:25:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] iotests: Remove 030 from the auto group
Message-ID: <20200904082513.GA6237@linux.fritz.box>
References: <20200904055701.462482-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904055701.462482-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 04:25:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.09.2020 um 07:57 hat Thomas Huth geschrieben:
> Test 030 is still occasionally failing in the CI ... so for the
> time being, let's disable it in the "auto" group. We can add it
> back once it got more stable.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

I would rather just disable this one test function as 030 is a pretty
important one that tends to catch bugs.

>  I just saw the problem here:
>   https://cirrus-ci.com/task/5449330930745344?command=main#L6482
>  and Peter hit it a couple of weeks ago:
>   https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00136.html

I wonder how this can still happen. The test should have more than
enough time to complete now. Except if the throttling doesn't work as
expected.

I can't seem to reproduce this even if I add rather long delays. After
40 seconds, all jobs have moved either by 512k (which is STREAM_CHUNK)
or not at all.

What is interesting is that in both cases it's stream-node8, which is
the job streaming from node6 to node8, and node8 is the top-level node.
It's also the last job to be changed to full speed, so all others did
succeed before.

Kevin


