Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD2AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 07:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350DD22B48
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 07:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNI5qHzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350DD22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifIiA-0004dE-WB
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 02:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ifIge-0003uq-Na
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 02:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ifIgd-0004pX-IW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 02:15:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ifIgd-0004oc-D0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 02:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576134898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=HrOr8ThciaL1w99d1O++m/DVMpp8xswZ6Fzo9yj+2XQ=;
 b=XNI5qHzVI464OdUw66S2BbuAKY0QbAB5m4UUTil561f6eAAkzNx1Mqrm3zDVSMCOK8SKlv
 6fpveU3a2CAbbnR1KeeSvVZ9XqngSTodw8MFzSPX4RQxztSnXiS4GQMInUewUrS1mMaeQY
 4zx99NwL1fLKbuB8TdxOfHhP+0x8t8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-T5y-wLeCOLyd53Txhd5VTA-1; Thu, 12 Dec 2019 02:14:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4D78107ACC9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 07:14:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63A1C5D6C8;
 Thu, 12 Dec 2019 07:14:56 +0000 (UTC)
Subject: Re: [PATCH v2] tests: use g_test_rand_int
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576113478-42926-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <984565ca-2188-5b44-b43b-3691deb65a6b@redhat.com>
Date: Thu, 12 Dec 2019 08:14:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576113478-42926-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: T5y-wLeCOLyd53Txhd5VTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/2019 02.17, Paolo Bonzini wrote:
> g_test_rand_int provides a reproducible random integer number, using a
> different number seed every time but allowing reproduction using the
> --seed command line option.  It is thus better suited to tests than
> g_random_int or random.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/ivshmem-test.c | 2 +-
>  tests/test-bitmap.c  | 8 ++++----
>  tests/test-qga.c     | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
> index be9aa92..ecda256 100644
> --- a/tests/ivshmem-test.c
> +++ b/tests/ivshmem-test.c
> @@ -443,7 +443,7 @@ static gchar *mktempshm(int size, int *fd)
>      while (true) {
>          gchar *name;
>  
> -        name = g_strdup_printf("/qtest-%u-%u", getpid(), g_random_int());
> +        name = g_strdup_printf("/qtest-%u-%u", getpid(), g_test_rand_int());
>          *fd = shm_open(name, O_CREAT|O_RDWR|O_EXCL,
>                         S_IRWXU|S_IRWXG|S_IRWXO);
>          if (*fd > 0) {
> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> index 087e02a..2f5b714 100644
> --- a/tests/test-bitmap.c
> +++ b/tests/test-bitmap.c
> @@ -22,10 +22,10 @@ static void check_bitmap_copy_with_offset(void)
>      bmap2 = bitmap_new(BMAP_SIZE);
>      bmap3 = bitmap_new(BMAP_SIZE);
>  
> -    bmap1[0] = random();
> -    bmap1[1] = random();
> -    bmap1[2] = random();
> -    bmap1[3] = random();
> +    bmap1[0] = g_test_rand_int();
> +    bmap1[1] = g_test_rand_int();
> +    bmap1[2] = g_test_rand_int();
> +    bmap1[3] = g_test_rand_int();
>      total = BITS_PER_LONG * 4;
>  
>      /* Shift 115 bits into bmap2 */
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index 1ca49bb..d2b2435 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -143,7 +143,7 @@ static void qmp_assertion_message_error(const char     *domain,
>  static void test_qga_sync_delimited(gconstpointer fix)
>  {
>      const TestFixture *fixture = fix;
> -    guint32 v, r = g_random_int();
> +    guint32 v, r = g_test_rand_int();
>      unsigned char c;
>      QDict *ret;
>  
> @@ -186,7 +186,7 @@ static void test_qga_sync_delimited(gconstpointer fix)
>  static void test_qga_sync(gconstpointer fix)
>  {
>      const TestFixture *fixture = fix;
> -    guint32 v, r = g_random_int();
> +    guint32 v, r = g_test_rand_int();
>      QDict *ret;
>  
>      /*
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


