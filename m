Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED8BC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A42820A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx9kjY7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A42820A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSEv-0006Dk-PJ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60890 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSEM-0005gm-Jo
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:56:43 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSEA-0007ja-6f
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:56:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50625
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQSE9-0007j2-PL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587372989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ug0FCDj2BmXteBjRMScwNpB9iAXL6rH1Dgc7Q76ix5o=;
 b=Tx9kjY7N6+6eikS5C0F/18qRZdme0fNThRmamTSkQl8Nr1vjIxdexTSqVXo8E0GTCl+8yH
 ZE02v1SOhdZGukCEST3JzzeYIWonl8bhPdwTXrK74ObARgKxALqSstFjPc/0Qo0TErewAy
 2ElhPyY8kGuHbU1q35sn7S4JQXf49EY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-cq9a9VJcPHKP0d2rXctwAQ-1; Mon, 20 Apr 2020 04:56:25 -0400
X-MC-Unique: cq9a9VJcPHKP0d2rXctwAQ-1
Received: by mail-ej1-f70.google.com with SMTP id nn20so5979093ejb.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 01:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YI9jCELPX87Zw/2Zp1zQ8sWxou56U9PPlk79CnRfs+0=;
 b=MEUgI5pD3lX/aigrA3GLyUPtJyLBygglZmWcqmyLdiSOQKuw1MlcqltzZw5F8xU7bd
 SK0GWIIewaQGpYSDOzPW93aJKnQNWpCne9X8JEboO5OAUqfqALY7pyPCU5PWUOQUqZYo
 Q1ATLFhJtzLK/8ZYq3RjOs1qwJkpKFbnnqQzkLxQlTESR8gt3E3eWU2VffbRkw721nLB
 zt+F/6zDoTxWxQWHz0JY+28/h2uP0d+stRcy4Kt8zDiuniL5Z7e+CYHkMpPECg0LCG2X
 J6vT//qHu3e/RR6o/Nvu1tc/qOvNtsUzGVMZ7FagYlIWqcqPCMxlaC110nfRPTGxLokb
 geyA==
X-Gm-Message-State: AGi0PuaEJM+EODaMb2VF4tbLio2uS7FYqIsqlGwXAsOP+ApNnHdcgH5d
 IhV1aOyk0A2FaJFfwqZyAqC9EPEram59stAQwp+TMIVznHurAILdFFXDxzQFLn0Wmz7oBkXfgkr
 9r6VYSJ6wUj5ZeQY=
X-Received: by 2002:a17:906:6c93:: with SMTP id
 s19mr14666306ejr.135.1587372984472; 
 Mon, 20 Apr 2020 01:56:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ2D56ycx4joJt3FrsZ7gq6yPo9zorArt/d/bUGTkFEyHPnU7LIaWaWy2auA8EA0qlFWEoyHw==
X-Received: by 2002:a17:906:6c93:: with SMTP id
 s19mr14666293ejr.135.1587372984235; 
 Mon, 20 Apr 2020 01:56:24 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z16sm24394edq.23.2020.04.20.01.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 01:56:23 -0700 (PDT)
Subject: Re: [PATCH 11/11] migration/colo: Fix qmp_xen_colo_do_checkpoint()
 error handling
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200420083236.19309-1-armbru@redhat.com>
 <20200420083236.19309-12-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <909c738d-3ec0-ed29-9ccc-76a7bd599758@redhat.com>
Date: Mon, 20 Apr 2020 10:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420083236.19309-12-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 10:32 AM, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>=20
> qmp_xen_colo_do_checkpoint() passes @errp first to
> replication_do_checkpoint_all(), and then to
> colo_notify_filters_event().  If both fail, this will trip the
> assertion in error_setv().
>=20
> Similar code in secondary_vm_do_failover() calls
> colo_notify_filters_event() only after replication_do_checkpoint_all()
> succeeded.  Do the same here.
>=20
> Fixes: 0e8818f023616677416840d6ddc880db8de3c967
> Cc: Zhang Chen <chen.zhang@intel.com>
> Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   migration/colo.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index a54ac84f41..1b3493729b 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -263,7 +263,13 @@ ReplicationStatus *qmp_query_xen_replication_status(=
Error **errp)
>  =20
>   void qmp_xen_colo_do_checkpoint(Error **errp)
>   {
> -    replication_do_checkpoint_all(errp);
> +    Error *err =3D NULL;
> +
> +    replication_do_checkpoint_all(&err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>       /* Notify all filters of all NIC to do checkpoint */
>       colo_notify_filters_event(COLO_EVENT_CHECKPOINT, errp);
>   }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


