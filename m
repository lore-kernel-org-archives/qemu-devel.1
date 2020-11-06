Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372FEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F731205CA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6ufOMYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F731205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6EF-0008MR-0G
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kb6DZ-0007us-GS
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kb6DX-000362-4W
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604686324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=br2En5SgEYBPfiEmfeuWV+6096Upc+HED/wX69lPF/w=;
 b=R6ufOMYVE2lG76Gr1eHX12wGF0OWvRh8pwL0MKjOq6S+pt7xnz1m/m1TYyztDCOHa6dmWu
 IrB+uyW8KcIoVM0bfeFiWr0eo6P7VbMh/A3+JIVUoU8IuRHAtuFpzL22yL+qfssCpZ8Dqf
 +5t5XZC6ciOCu1jN85bUJojjVTv1EOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-0TIZMCoLO-uSahfMbq6T4A-1; Fri, 06 Nov 2020 13:12:03 -0500
X-MC-Unique: 0TIZMCoLO-uSahfMbq6T4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C6158030C8;
 Fri,  6 Nov 2020 18:12:02 +0000 (UTC)
Received: from work-vm (ovpn-114-220.ams2.redhat.com [10.36.114.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7377375121;
 Fri,  6 Nov 2020 18:11:58 +0000 (UTC)
Date: Fri, 6 Nov 2020 18:11:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Fotis Xenakis <foxen@windowslive.com>
Subject: Re: [Virtio-fs] [qemu-web PATCH v2] Add virtio-fs in OSv overview
 blog post
Message-ID: <20201106181155.GR3576@work-vm>
References: <AM0PR03MB629226965B72D3808EFB8795A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR03MB629226965B72D3808EFB8795A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
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
Cc: virtio-fs@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Fotis Xenakis (foxen@windowslive.com) wrote:
> This post briefly goes over the main points of virtio-fs and OSv, a
> unikernel running under QEMU/KVM and taking advantage of its virtio-fs
> implementation.
> 
> Changes since v1:
> - Fixed wording and links, as suggested by Thomas Huth.
> - Added a short example of virtio-fs usage in OSv.
> 
> Signed-off-by: Fotis Xenakis <foxen@windowslive.com>

> +One central point is OSv's support for booting from virtio-fs: this enables
> +deploying a modified version or a whole new application **without rebuilding**
> +the image, just by adjusting its root file system contents on the host. Last,
> +owing to the DAX window practically providing low-overhead access to the host's
> +page cache, scalability is also expected to excel, with it being a common
> +concern due to the potentially high density of unikernels per host.

Hi Fotis,
  Since I'm not used to unikernels, I'm a little confused by this; I'd
appreciate some explanation.

  In your unikernel, does the root filesystem just contain data?  I mean
being a 'unikernel' aren't all the binaries and support all linked into
the kernel itself?

Dave
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


