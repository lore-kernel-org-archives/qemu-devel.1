Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC663C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7522166E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aljkcFuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7522166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzAP-0000nu-5G
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFz9e-0000GT-BD
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:24:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFz9c-0005VG-Co
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599654287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2IBmT9pdXN82dSskLwjyyG+0FOPIOZ0O3B17TTIJfXw=;
 b=aljkcFuG9c9x9yPbwg2gXiX54DMiGSEHoIas7kckkILCkX8YPjyHYMDRhs+uRO8NPFl3qQ
 l0tYLQxbHjo3u8RtwwXGLMHAJA9b6Rbvxd6MIuf5kQARmJfWiizQV9iORKEMt+DlXtTAa/
 VGr9jN8v+SdTfuRrF+8xb8RLkf7+3Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-FdyeyxYZMy60YWHH5oHC7w-1; Wed, 09 Sep 2020 08:24:43 -0400
X-MC-Unique: FdyeyxYZMy60YWHH5oHC7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9E7757050;
 Wed,  9 Sep 2020 12:24:41 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2A021002D67;
 Wed,  9 Sep 2020 12:24:27 +0000 (UTC)
Date: Wed, 9 Sep 2020 13:24:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v2 01/21] block: Fixes nfs compiling error on msys2/mingw
Message-ID: <20200909122424.GS1011023@redhat.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-2-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200909094617.1582-2-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 05:45:57PM +0800, Yonggang Luo wrote:
> These compiling errors are fixed:
> ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
>    27 | #include <poll.h>
>       |          ^~~~~~~~
> compilation terminated.
> 
> ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
>    63 |     blkcnt_t st_blocks;
>       |     ^~~~~~~~
> ../block/nfs.c: In function 'nfs_client_open':
> ../block/nfs.c:550:27: error: 'struct _stat64' has no member named 'st_blocks'
>   550 |     client->st_blocks = st.st_blocks;
>       |                           ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:751:41: error: 'struct _stat64' has no member named 'st_blocks'
>   751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>       |                                         ^
> ../block/nfs.c: In function 'nfs_reopen_prepare':
> ../block/nfs.c:805:31: error: 'struct _stat64' has no member named 'st_blocks'
>   805 |         client->st_blocks = st.st_blocks;
>       |                               ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:752:1: error: control reaches end of non-void function [-Werror=return-type]
>   752 | }
>       | ^
> 
> On msys2/mingw, there is no st_blocks in struct _stat64, so we use consistence st_size instead.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  block/nfs.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


