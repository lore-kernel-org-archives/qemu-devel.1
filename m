Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AADAC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 06:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3112145D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 06:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKSg3Dkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3112145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFALu-0003HV-57
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 02:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFALE-0002lE-Be
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 02:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFALA-0001Lo-Tp
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 02:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599458958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFV+/MAzVMHJyY4leRsVlFW0ic947cBHONntQ5oK3Uk=;
 b=DKSg3DkfV/XRxnZ6mTr8iNtI4RSrYa75m3fmCHnrSg84WCa7iOZSzKVtnIUBVTkIKGKOep
 FwzmoHXWvAREnosXrZcmp+Go6zJtfU6Tn0suKf6LWRtM1JvW1Axew/Mj5HoHbqvjT4Rvx1
 v0S6cRnjeSLwxuDHa+1H9tZ+32ThFF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475--lwkOcggPi-dtxTJFHyF8Q-1; Mon, 07 Sep 2020 02:09:15 -0400
X-MC-Unique: -lwkOcggPi-dtxTJFHyF8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6E41802B5C;
 Mon,  7 Sep 2020 06:09:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B028110013C4;
 Mon,  7 Sep 2020 06:09:13 +0000 (UTC)
Subject: Re: [PATCH] meson: Fixes qapi tests.
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200905212603.761-1-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1d3a4666-e223-fb63-0f24-cf1ab14672e5@redhat.com>
Date: Mon, 7 Sep 2020 08:09:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200905212603.761-1-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/09/2020 23.26, Yonggang Luo wrote:
> Use -b to ignore-space-change
>
> The error are:
> +@end table
> +
> +@end deftypefn

I'd maybe just say "Use -b to ignore CR vs. CR-LF issues on Windows" and
omit the incomplete example (the diff in the test run that you linked in
an older mail showed that the diff was about the whole file due to the
different line endings).

> make: *** [Makefile.mtest:63: check-qapi-schema] Error 1
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/qapi-schema/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
> index c87d141417..f1449298b0 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -220,6 +220,6 @@ qapi_doc = custom_target('QAPI doc',
>  
>  # "full_path()" needed here to work around
>  # https://github.com/mesonbuild/meson/issues/7585
> -test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
> +test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
>       depends: qapi_doc,
>       suite: ['qapi-schema', 'qapi-doc'])
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


