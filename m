Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E681C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03849215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idEN6Cen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03849215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzsU-0006mB-03
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFzrp-0006Fu-2v
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFzrn-0002s9-3f
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599657026;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=f6lgh7doUbP9wqUymxNkeiG6zZ8d/q9QUIMzM40u6ZE=;
 b=idEN6CenljoQTaKQk03uFAbnawGPWWrPif5eiK9Mjh0edPBcSAxrHI4eV4+aWZdLq3kWvt
 9Z7f/r9jfNDSpApN3R9vOz1jvZSYKJTB+YslWRd1cIqx9ssoV+Yzi/VK0l8ZK3S8It3JVe
 uHN8lJgV2ZGYQ7QPIdLlX9L/h9/L/FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-QYxXSJSZOJiHdJt2bPHSVw-1; Wed, 09 Sep 2020 09:10:21 -0400
X-MC-Unique: QYxXSJSZOJiHdJt2bPHSVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63CC918BFEC8;
 Wed,  9 Sep 2020 13:10:19 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08B4D8093F;
 Wed,  9 Sep 2020 13:10:12 +0000 (UTC)
Date: Wed, 9 Sep 2020 14:10:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v2 19/21] tests: Fixes test-io-channel-file by mask only
 owner file state mask bits
Message-ID: <20200909131009.GI1011023@redhat.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-20-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200909094617.1582-20-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
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

On Wed, Sep 09, 2020 at 05:46:15PM +0800, Yonggang Luo wrote:
> This is the error on msys2/mingw
> Running test test-io-channel-file
> **
> ERROR:../tests/test-io-channel-file.c:59:test_io_channel_file_helper: assertion failed (TEST_MASK & ~mask == st.st_mode & 0777): (384 == 438)
> ERROR test-io-channel-file - Bail out! ERROR:../tests/test-io-channel-file.c:59:test_io_channel_file_helper: assertion failed (TEST_MASK & ~mask == st.st_mode & 0777): (384 == 438)
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-io-channel-file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
> index bac2b07562..75aea6450a 100644
> --- a/tests/test-io-channel-file.c
> +++ b/tests/test-io-channel-file.c
> @@ -56,7 +56,9 @@ static void test_io_channel_file_helper(int flags)
>      umask(mask);
>      ret = stat(TEST_FILE, &st);
>      g_assert_cmpint(ret, >, -1);
> -    g_assert_cmpuint(TEST_MASK & ~mask, ==, st.st_mode & 0777);
> +    /* On Windows the stat() function in the C library checks only
> +     the FAT-style READONLY attribute and does not look at the ACL at all. */
> +    g_assert_cmpuint(TEST_MASK & ~mask, ==, st.st_mode & 0700);

I think we will want the stronger check on non-Win32, so better to
ifdef this to use 0700 only on Win32.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


