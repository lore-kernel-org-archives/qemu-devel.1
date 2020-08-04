Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC6AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1252073E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzDX9TED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1252073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2q49-00070g-OH
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 02:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k2q2m-0006C9-5L
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:03:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k2q2k-0008MJ-LA
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596521001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4kl/vb8/jM3WSIDSk0Tyw/QUz8u4LKbkOIzE+cPsR0=;
 b=YzDX9TEDeQuxc4VrZHJBSMoyh4HG7b1c8CyfaMWfapftHXLaidkYc/Unf2WosTE3d6gpcg
 XwhSiiIsfX90qBYgYzmzqmKw4a6k8hm15YG768JlHmYWIZ6apCRzkHIhYgdOuewUgUnqOO
 J3ACsj903NNpIpfBTopsvPc4RKEHqpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-wc9lrJmGOYizjk_yubfQuw-1; Tue, 04 Aug 2020 02:03:17 -0400
X-MC-Unique: wc9lrJmGOYizjk_yubfQuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0EFD100CD00;
 Tue,  4 Aug 2020 06:03:16 +0000 (UTC)
Received: from [10.72.13.197] (ovpn-13-197.pek2.redhat.com [10.72.13.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EEA560BF3;
 Tue,  4 Aug 2020 06:03:14 +0000 (UTC)
Subject: Re: [PATCH] colo-compare: Remove superfluous NULL-pointer checks for
 s->iothread
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <20200731070604.0c981f41@luklap>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <962438f9-4c18-34bc-d235-a9f3933dafee@redhat.com>
Date: Tue, 4 Aug 2020 14:03:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731070604.0c981f41@luklap>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Chen <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/31 下午1:06, Lukas Straub wrote:
> s->iothread is checked for NULL on object creation in colo_compare_complete,
> so it's guaranteed not to be NULL.
> This resolves a false alert from Coverity (CID 1429969).
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>   net/colo-compare.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index cc15f23dea..2c20de1537 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -1442,9 +1442,7 @@ static void colo_compare_finalize(Object *obj)
>           qemu_chr_fe_deinit(&s->chr_notify_dev, false);
>       }
>   
> -    if (s->iothread) {
> -        colo_compare_timer_del(s);
> -    }
> +    colo_compare_timer_del(s);
>   
>       qemu_bh_delete(s->event_bh);
>   
> @@ -1470,9 +1468,7 @@ static void colo_compare_finalize(Object *obj)
>           g_hash_table_destroy(s->connection_track_table);
>       }
>   
> -    if (s->iothread) {
> -        object_unref(OBJECT(s->iothread));
> -    }
> +    object_unref(OBJECT(s->iothread));
>   
>       g_free(s->pri_indev);
>       g_free(s->sec_indev);


Applied.

Thanks


