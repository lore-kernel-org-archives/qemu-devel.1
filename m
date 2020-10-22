Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF81C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D912225F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anseVYgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D912225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVTGZ-00063e-Re
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVTFa-0005O7-RK
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kVTFY-0003fR-UO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603344895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfE0EXfEx2dfnDFT6IimHa8AALlwRJeNFrt45D6d5D4=;
 b=anseVYgbszCeD9Gky14fdL+AkePJzZ5K55KDFsz+2mRfOM9uHXVdhE9ynDGIqzm3+KjvuZ
 e3vhcZ6LC7Xsfb4hIUbf830/0e4NQzMA8PD662Hbtu2Qe8Wg2E4OLYnOHBvftlo+Sn1FQ7
 kCreNbN5MFrSmpu30OXJ+BcefVDdJaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-TJlPbU4WO3-mdGblMa0C9A-1; Thu, 22 Oct 2020 01:34:51 -0400
X-MC-Unique: TJlPbU4WO3-mdGblMa0C9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE9651009E30;
 Thu, 22 Oct 2020 05:34:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 043C219C4F;
 Thu, 22 Oct 2020 05:34:45 +0000 (UTC)
Subject: Re: [PATCH v6 6/6] migration-test: Only hide error if !QTEST_LOG
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20201021212721.440373-1-peterx@redhat.com>
 <20201021212721.440373-7-peterx@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2735f709-29bf-ff6d-97ed-a17ed4675375@redhat.com>
Date: Thu, 22 Oct 2020 07:34:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201021212721.440373-7-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2020 23.27, Peter Xu wrote:
> The errors are very useful when debugging qtest failures, especially when
> QTEST_LOG=1 is set.  Let's allow override MigrateStart.hide_stderr when
> QTEST_LOG=1 is specified, because that means the user wants to be verbose.
> 
> Not very nice to introduce the first QTEST_LOG env access in migration-test.c,
> however it should be handy.  Without this patch, I was hacking error_report()
> when debugging such errors.  Let's make things easier.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration-test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index f410ec5996..f2142fbd3c 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -464,6 +464,10 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
>  }
>  
>  typedef struct {
> +    /*
> +     * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
> +     * unconditionally, because it means the user would like to be verbose.
> +     */
>      bool hide_stderr;
>      bool use_shmem;
>      /* only launch the target process */
> @@ -557,7 +561,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>  
>      g_free(bootpath);
>  
> -    if (args->hide_stderr) {
> +    if (!getenv("QTEST_LOG") && args->hide_stderr) {
>          ignore_stderr = "2>/dev/null";
>      } else {
>          ignore_stderr = "";

Reviewed-by: Thomas Huth <thuth@redhat.com>


