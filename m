Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338E5C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EAD02080D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsHluX2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAD02080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSch-0005xf-D0
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUSbS-0005Bv-67
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUSbP-0000an-R5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603104076;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0QDB9ZJyK9QJxbI0CFYEfZxcqDjZwlmTQJyXeW3OLRI=;
 b=XsHluX2/YaqDzArF0aUqve0NpvyzIdFJb9IefDa0N2LsIdofM2ojHfbAOFg7iYng+abcZs
 2V96pjLeFJGI/aNpSIoq4FX6iMm9wwjiNP7azFiZXn7c7Vw72v94y7RHqGlRnOfjWGJN5N
 Ehso4JiHLDb+CUIZYNeJB8rhZDAH5Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-deBlwoSBNOi2iVxzBECFUQ-1; Mon, 19 Oct 2020 06:41:12 -0400
X-MC-Unique: deBlwoSBNOi2iVxzBECFUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEBE2803F44;
 Mon, 19 Oct 2020 10:41:10 +0000 (UTC)
Received: from redhat.com (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2BD310013C4;
 Mon, 19 Oct 2020 10:41:09 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:41:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chetan Pant <chetan4windows@gmail.com>
Subject: Re: [PATCH 2/30] io: Fix Lesser GPL version number
Message-ID: <20201019104107.GF236912@redhat.com>
References: <20201014134033.14095-1-chetan4windows@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201014134033.14095-1-chetan4windows@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 01:40:33PM +0000, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License.
> It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> This patch replaces all occurrences of "Lesser GPL version 2" with
> "Lesser GPL version 2.1" in comment section.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>  include/io/channel-buffer.h     | 2 +-
>  include/io/channel-command.h    | 2 +-
>  include/io/channel-file.h       | 2 +-
>  include/io/channel-socket.h     | 2 +-
>  include/io/channel-tls.h        | 2 +-
>  include/io/channel-util.h       | 2 +-
>  include/io/channel-watch.h      | 2 +-
>  include/io/channel-websock.h    | 2 +-
>  include/io/channel.h            | 2 +-
>  include/io/dns-resolver.h       | 2 +-
>  include/io/task.h               | 2 +-
>  io/channel-buffer.c             | 2 +-
>  io/channel-command.c            | 2 +-
>  io/channel-file.c               | 2 +-
>  io/channel-socket.c             | 2 +-
>  io/channel-tls.c                | 2 +-
>  io/channel-util.c               | 2 +-
>  io/channel-watch.c              | 2 +-
>  io/channel-websock.c            | 2 +-
>  io/channel.c                    | 2 +-
>  io/dns-resolver.c               | 2 +-
>  io/task.c                       | 2 +-
>  tests/test-io-channel-buffer.c  | 2 +-
>  tests/test-io-channel-command.c | 2 +-
>  tests/test-io-channel-file.c    | 2 +-
>  tests/test-io-channel-socket.c  | 2 +-
>  tests/test-io-task.c            | 2 +-
>  27 files changed, 27 insertions(+), 27 deletions(-)

Acked-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


