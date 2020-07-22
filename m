Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE6BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD61207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHeljdF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD61207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyJLg-00039T-RY
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 14:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jyJL0-0002Ut-4t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:19:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55501
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jyJKv-00052w-KP
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595441964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=75x3G10LfbUWB912+9Ff+bDu9MKskr+M7l/KDukhdjo=;
 b=RHeljdF/uIuS83vat9hRHLafU89ShRgUAuB3UhgbUkNDgDO4Svut2HUn/ERnf9KGQTj/zh
 D4htyFHKe0VpVnZUT0jQ87fpM+sDIykJFNrGY8N+L3GhfZ2SOuG7Kq40toyn9GfeQLje+Y
 e1sZRhyOuO870OthlKkLuyAwbXKu2NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-5YigkKXzNKyMtkD8JhGV7Q-1; Wed, 22 Jul 2020 14:19:21 -0400
X-MC-Unique: 5YigkKXzNKyMtkD8JhGV7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D15AE8014D4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 18:19:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-98.rdu2.redhat.com [10.10.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAFBE88D41;
 Wed, 22 Jul 2020 18:19:14 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 6BD9E2202B4; Wed, 22 Jul 2020 14:19:14 -0400 (EDT)
Date: Wed, 22 Jul 2020 14:19:14 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH for-5.1 0/3] virtiofsd: allow virtiofsd to
 run in a container
Message-ID: <20200722181914.GB598987@redhat.com>
References: <20200722130206.224898-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722130206.224898-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-fs@redhat.com, vromanso@redhat.com, qemu-devel@nongnu.org,
 rmohr@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 02:02:03PM +0100, Stefan Hajnoczi wrote:
> Container runtimes handle namespace setup and remove privileges needed by
> virtiofsd to perform sandboxing. Luckily the container environment already
> provides most of the sandbox that virtiofsd needs for security.
> 
> Introduce a new "virtiofsd -o chroot" option that uses chroot(2) instead of
> namespaces. This option allows virtiofsd to work inside a container.
> 
> Please see the individual patches for details on the changes and security
> implications.
> 
> Given that people are starting to attempt running virtiofsd in containers I
> think this should go into QEMU 5.1.

Hi Stefan,

I have written a document to help with testing virtiofs with any changes.

https://github.com/rhvgoyal/misc/blob/master/virtiofs-tests/virtio-fs-testing-requirement.txt

Will be good to run some of these tests to make sure there are no
regressions due to these changes.

Thanks
Vivek

> 
> Stefan Hajnoczi (3):
>   virtiofsd: drop CAP_DAC_READ_SEARCH
>   virtiofsd: add container-friendly -o chroot sandboxing option
>   virtiofsd: probe unshare(CLONE_FS) and print an error
> 
>  tools/virtiofsd/fuse_virtio.c    | 13 +++++++++
>  tools/virtiofsd/helper.c         |  3 +++
>  tools/virtiofsd/passthrough_ll.c | 45 +++++++++++++++++++++++++++++---
>  3 files changed, 58 insertions(+), 3 deletions(-)
> 
> -- 
> 2.26.2
> 
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs


