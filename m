Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEB4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2E12224E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFmxVkSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2E12224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaEr6-0007rg-Qa
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaEqP-0007Mf-AV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaEqM-0000Yp-MV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604481156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nrykHNFDOHbtB0XXMqU3MbrOn5E2Vi1MqzrUvX3ybYg=;
 b=eFmxVkSUUq4txNPIitCa7rKgkjvNpYJIcM0Sl/4I+r8cHOfqiVMKhWuZXafcMnpAH2GBbD
 +9DiZrFD2l3kREx5AEN/svtURnHicPIr4VXX1YhpVPBLmUKNA/BUeItc3tuADpaRozIjHE
 8qfz4tD3choa3oybme4HELVJrXg11rI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-fRlRT5ZKM5mwXzl9RxF8Lw-1; Wed, 04 Nov 2020 04:12:35 -0500
X-MC-Unique: fRlRT5ZKM5mwXzl9RxF8Lw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1253B106B268
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 09:12:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D82AE6EF5A;
 Wed,  4 Nov 2020 09:12:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E58B1132BD6; Wed,  4 Nov 2020 10:12:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-5.2 1/4] ivshmem-test: do not use short-form boolean
 option
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-2-pbonzini@redhat.com>
Date: Wed, 04 Nov 2020 10:12:32 +0100
In-Reply-To: <20201103151452.416784-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 3 Nov 2020 10:14:49 -0500")
Message-ID: <87wnz1zdrz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> This QemuOpts idiom will be deprecated, so get rid of it in the tests.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qtest/ivshmem-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/ivshmem-test.c b/tests/qtest/ivshmem-test.c
> index d5c8b9f128..dfa69424ed 100644
> --- a/tests/qtest/ivshmem-test.c
> +++ b/tests/qtest/ivshmem-test.c
> @@ -135,7 +135,7 @@ static void setup_vm_cmd(IVState *s, const char *cmd, bool msix)
>  static void setup_vm(IVState *s)
>  {
>      char *cmd = g_strdup_printf("-object memory-backend-file"
> -                                ",id=mb1,size=1M,share,mem-path=/dev/shm%s"
> +                                ",id=mb1,size=1M,share=on,mem-path=/dev/shm%s"
>                                  " -device ivshmem-plain,memdev=mb1", tmpshm);
>  
>      setup_vm_cmd(s, cmd, false);

Reviewed-by: Markus Armbruster <armbru@redhat.com>


