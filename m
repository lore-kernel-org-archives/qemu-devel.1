Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAF721D79
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dL81MMZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAF721D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFuIr-0001ZN-8A
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 03:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFuID-00015v-B1
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:13:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFuIB-0004IZ-4S
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599635597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XCX0wFJnvaFTZA4gm70zcE90W9Mkrw8eFIhGazyOGAQ=;
 b=dL81MMZjYbOxsQRgLVMHD7MSdk1VS1CxsjzHx/YrPFTgODBwtE5tqEglXZ+0U1FHD0+qLq
 RBtTAH4efrbU//BFTJyMCr+Y15MI/Tos0Mroz2yghUvBzP4lrPdGzGEqYg6qYc+l32jteq
 2o7zf2+Qxx3KsHyrq0Jr0A5ts2CxeJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-QjAXlcnuOVCWxwGtNtcwfg-1; Wed, 09 Sep 2020 03:13:13 -0400
X-MC-Unique: QjAXlcnuOVCWxwGtNtcwfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC83E801AEB;
 Wed,  9 Sep 2020 07:13:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADA837E8DA;
 Wed,  9 Sep 2020 07:13:01 +0000 (UTC)
Subject: Re: [PATCH 05/16] tests: disable /char/stdio/* tests in test-char.c
 on win32
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-6-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <31826ac4-9c97-8cfa-6a23-5db069ea77af@redhat.com>
Date: Wed, 9 Sep 2020 09:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200908194820.702-6-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/2020 21.48, Yonggang Luo wrote:
> These tests are blocking test-char to be finished.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-char.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/test-char.c b/tests/test-char.c
> index d35cc839bc..80e5bac61a 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -103,6 +103,7 @@ static void char_console_test(void)
>      g_test_trap_assert_stdout("CONSOLE");
>  }
>  #endif
> +#ifndef _WIN32
>  static void char_stdio_test_subprocess(void)
>  {
>      Chardev *chr;
> @@ -126,6 +127,7 @@ static void char_stdio_test(void)
>      g_test_trap_assert_passed();
>      g_test_trap_assert_stdout("buf");
>  }
> +#endif
>  
>  static void char_ringbuf_test(void)
>  {
> @@ -1471,8 +1473,10 @@ int main(int argc, char **argv)
>      g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
>      g_test_add_func("/char/console", char_console_test);
>  #endif
> +#ifndef _WIN32
>      g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess);
>      g_test_add_func("/char/stdio", char_stdio_test);
> +#endif
>  #ifndef _WIN32
>      g_test_add_func("/char/pipe", char_pipe_test);
>  #endif

I think you could rather simply replace the three #ifndef _WIN32
sections with only one?

 Thomas


