Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD24C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31FF208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWlXR1cC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31FF208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKkkF-0001Cs-OB
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKkha-0007rQ-6C
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKkhS-0004DU-Te
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600790365;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxgc5vFfcN+1jT9L65R0oIK9e7XGY+hftVbyCnu8oaM=;
 b=BWlXR1cCzQBkJj/83H3nPvykiG7PvTyNjURJ6r79N2xiv8FocWU7NKNbMSWPM9hURfITmz
 088/I3DaDw+8Vl1Lt5CZARuZgDjH1Qjzr2/APPIOQEt/HT6tUYNCkEQ1vHdyElR7qx1F/T
 4AfIBY6PdetZbhOzU684kqoHITp8ELM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-781XJXzLNMyGMOAXSAaqIg-1; Tue, 22 Sep 2020 11:58:58 -0400
X-MC-Unique: 781XJXzLNMyGMOAXSAaqIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDCCC1018758;
 Tue, 22 Sep 2020 15:58:43 +0000 (UTC)
Received: from redhat.com (ovpn-114-64.ams2.redhat.com [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C0737CD44;
 Tue, 22 Sep 2020 15:58:40 +0000 (UTC)
Date: Tue, 22 Sep 2020 16:58:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 00/20] block/export: Allow exporting BDSs via FUSE
Message-ID: <20200922155838.GR1989025@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922104932.46384-1-mreitz@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 12:49:12PM +0200, Max Reitz wrote:
> Based-on: <20200907182011.521007-1-kwolf@redhat.com>
>           (“block/export: Add infrastructure and QAPI for block exports”)
> 
> (Though its patch 16 needs a s/= \&blk_exp_nbd/= drv/ on top.)
> 
> v1: https://lists.nongnu.org/archive/html/qemu-block/2019-12/msg00451.html
> 
> Branch: https://github.com/XanClic/qemu.git fuse-exports-v2
> Branch: https://git.xanclic.moe/XanClic/qemu.git fuse-exports-v2
> 
> 
> Hi,
> 
> Ever since I found out that you can mount FUSE filesystems on regular
> files (not just directories), I had the idea of adding FUSE block
> exports to qemu where you can export block nodes as raw images.  The
> best thing is that you’d be able to mount an image on itself, so
> whatever format it may be in, qemu lets it appear as a raw image (and
> you can then use regular tools like dd on it).
> 
> The performance is quite bad so far, but we can always try to improve it
> if the need arises.  For now I consider it mostly a cute feature to get
> easy access to the raw contents of image files in any format (without
> requiring root rights).

Aside from the iotests, so you forsee any particular use cases
where this feature is desirable / important ?

Looking at it from a security POV, I'm not thrilled about the
idea of granting QEMU permission to use the mount syscall for
seccomp or SELinux. IOW, I expect this feature won't be something
we want to expose in QEMU guests managed by libvirt, which would
limit how widely it can be used.

QEMU can export NBD. Would it make sense to do this as an NBD
client ? There's already https://libguestfs.org/nbdfuse.1.html
but IIUC that exposes it as a file within a dir. Presumably
it is not too hard to make it support exposing it directly as
a file too.

I wonder how performance compares between your native FUSE
impl in QEMU vs NBD FUSE ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


