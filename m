Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B73BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA2921941
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4ca31Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA2921941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzhc-000142-AI
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFzgU-0007tz-S4
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:58:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFzgS-0001M5-QR
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599656324;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UrOCaicHssnVgHJqwEsr5duMXzpe2/GGdpsIeMTjPI=;
 b=e4ca31LcxtJUtNaR0kleiPZJ7Hz9JKEp2wTNus5T0abRrt2pl936zsuuNA3IMJbaYlG38G
 UlU5GMRgI9n9fxWsGVN+IH6GZSfix1i0ofzVHKBcGZFBEFlzVAURwuUB/NdY9RldHWyJb2
 fl8SaRIBAF7S3+52BclP0yH2ylz6apM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-lqtAZJ3-MbWqejr78cMrFQ-1; Wed, 09 Sep 2020 08:58:38 -0400
X-MC-Unique: lqtAZJ3-MbWqejr78cMrFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7B938D2ECE;
 Wed,  9 Sep 2020 12:58:36 +0000 (UTC)
Received: from redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2523219C78;
 Wed,  9 Sep 2020 12:58:29 +0000 (UTC)
Date: Wed, 9 Sep 2020 13:58:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v2 08/21] tests: test-replication disable
 /replication/secondary/* on msys2/mingw.
Message-ID: <20200909125827.GZ1011023@redhat.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-9-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200909094617.1582-9-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Wed, Sep 09, 2020 at 05:46:04PM +0800, Yonggang Luo wrote:
> They cause failure on msys2/mingw, that's because file-win32.c not implement
> .bdrv_reopen_prepare/commit/abort yet.
> 
> > $ ./tests/test-replication.exe
> > # random seed: R02S3f4d1c01af2b0a046990e0235c481faf
> > 1..13
> > # Start of replication tests
> > # Start of primary tests
> > ok 1 /replication/primary/read
> > ok 2 /replication/primary/write
> > ok 3 /replication/primary/start
> > ok 4 /replication/primary/stop
> > ok 5 /replication/primary/do_checkpoint
> > ok 6 /replication/primary/get_error_all
> > # End of primary tests
> > # Start of secondary tests
> > ok 7 /replication/secondary/read
> > ok 8 /replication/secondary/write
> > Unexpected error in bdrv_reopen_prepare() at ../block.c:4191:
> > Block format 'file' used by node '#block4287' does not support reopening
> > files
> 
> Can you try to find out what reopen this is?
> 
> I assume it's for switching between read-write and read-only. In this
> case an implementation of .bdrv_reopen_prepare/commit/abort that can do
> this switch is required.
> 
> This is more serious development work, so I can't propose a quick fix.
> 
> Alternatively, we could just declare replication unsupported on Windows
> and let configure make sure that CONFIG_REPLICATION is never set for it.
> 
> <stefanha> luoyonggang: That might be missing functionality in block/file-win32.c.
> * davidgiluk yawns and looks up
> <stefanha> luoyonggang: The block/file-posix.c block driver supports .bdrv_reopen_*()
> while block/file-win32.c does not. It's probably because no one has tried to implement it.
> <luoyonggang> OK, I got the direction,
> <luoyonggang> Just need implement .bdrv_reopen_*() functions in file-win32.c


We don't need to add IRC transscripts into the commit message. It
is sufficient to note that .bdrv_reopen* are not implemented on
in block/file-win32.c, which you already did at the start.

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-replication.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/test-replication.c b/tests/test-replication.c
> index e7cbd6b144..b067240add 100644
> --- a/tests/test-replication.c
> +++ b/tests/test-replication.c
> @@ -392,6 +392,7 @@ static void test_secondary_write(void)
>      teardown_secondary();
>  }
>  
> +#ifndef _WIN32
>  static void test_secondary_start(void)
>  {
>      BlockBackend *top_blk, *local_blk;
> @@ -546,6 +547,7 @@ static void test_secondary_get_error_all(void)
>  
>      teardown_secondary();
>  }
> +#endif
>  
>  static void sigabrt_handler(int signo)
>  {
> @@ -597,6 +599,7 @@ int main(int argc, char **argv)
>      /* Secondary */
>      g_test_add_func("/replication/secondary/read",  test_secondary_read);
>      g_test_add_func("/replication/secondary/write", test_secondary_write);
> +#ifndef _WIN32
>      g_test_add_func("/replication/secondary/start", test_secondary_start);
>      g_test_add_func("/replication/secondary/stop",  test_secondary_stop);
>      g_test_add_func("/replication/secondary/continuous_replication",
> @@ -605,6 +608,7 @@ int main(int argc, char **argv)
>                      test_secondary_do_checkpoint);
>      g_test_add_func("/replication/secondary/get_error_all",
>                      test_secondary_get_error_all);
> +#endif
>  
>      ret = g_test_run();

With the commit msg trimmed

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


