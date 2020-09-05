Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7975DC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 08:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25062074D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 08:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0tqeNVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25062074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kETtF-0004Yp-4Z
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 04:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kETsV-0003PG-OX
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 04:48:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kETsS-0001aN-FY
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 04:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599295731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aib86e8UyJL+uw2dKy1yyP4FfcfFN7gu49Scwc3x0ww=;
 b=R0tqeNVlh8JjeZLTjqZ6CWtYjiIyXuoLqyQE/pBGsyyiU1GLG739BiwYMjI1KfWjpdVTV9
 emLXu8MM0M6+j9IxzleQXVj0qjZDu/hC4FUlBR1TPdeW0ZyVsqinqULc1nDLwfQSowfMOB
 SGfY0ivaIatAE4fNMJuo4XIokTaftNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-BsAVsE8QNYGk1J5moWf5OA-1; Sat, 05 Sep 2020 04:48:49 -0400
X-MC-Unique: BsAVsE8QNYGk1J5moWf5OA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CDB618B9ECA;
 Sat,  5 Sep 2020 08:48:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-27.ams2.redhat.com [10.36.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 685837DA2A;
 Sat,  5 Sep 2020 08:48:46 +0000 (UTC)
Subject: Re: [PATCH] tests: fixes test-vmstate.c compile error on msys2
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200905063813.1875-1-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aed3143c-5bf5-3b40-2c7c-1db2ac43f4c9@redhat.com>
Date: Sat, 5 Sep 2020 10:48:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200905063813.1875-1-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 04:11:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/09/2020 08.38, Yonggang Luo wrote:
> ../tests/test-vmstate.c: In function 'int_cmp':
> ../tests/test-vmstate.c:884:5: error: unknown type name 'uint'; did you mean 'uInt'?
>   884 |     uint ua = GPOINTER_TO_UINT(a);
>       |     ^~~~
>       |     uInt
> ../tests/test-vmstate.c:885:5: error: unknown type name 'uint'; did you mean 'uInt'?
>   885 |     uint ub = GPOINTER_TO_UINT(b);
>       |     ^~~~
>       |     uInt
> make: *** [Makefile.ninja:5461：tests/test-vmstate.exe.p/test-vmstate.c.obj] 错误 1
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-vmstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index f7b3868881..f8de709a0b 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -881,8 +881,8 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>  /* ID comparison function */
>  static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>  {
> -    uint ua = GPOINTER_TO_UINT(a);
> -    uint ub = GPOINTER_TO_UINT(b);
> +    guint ua = GPOINTER_TO_UINT(a);
> +    guint ub = GPOINTER_TO_UINT(b);
>      return (ua > ub) - (ua < ub);
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>


