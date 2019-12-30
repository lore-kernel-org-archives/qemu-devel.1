Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA1CC2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D8920748
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsJwfc9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D8920748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilqWs-00080j-NE
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 03:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilqWF-0007Uf-4W
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilqWE-0003JE-1O
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:35:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30686
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilqWD-0003Iu-UG
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577694917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vcCNAwMmPzy8leHRw3gK//nqTtyUbMX9n/yDkVL3Y4=;
 b=AsJwfc9vpJRM6yyFMczR+QTrUrBjFcxdfXX/Xl2jx6Gi6GfcITX8EIK+ZBieEfUGObwn8X
 e9EZSDE1fYgudtGbcFQPcpOXEaKU4GVv+PnU55T3UsYti3zglvoABkEb9h0jHUwQUAXBOW
 qnPNt3CCoPSTf9ghDn+QnWg/8i6EzC0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-Vs_LLP1sO52y2oNTblpckA-1; Mon, 30 Dec 2019 03:35:15 -0500
Received: by mail-wr1-f69.google.com with SMTP id k18so16338392wrw.9
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 00:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JT2gjGI/XGDyoglaldxrVLQVpEqpnEJfVuZI4A1e3eI=;
 b=e2CHzs8E2sf6B7sy3hJ/5zjllUiWf5Uw5dvOLtDdsFROcKAWWvRz+xp8pfByiM6iIi
 OEx16CAN2sjjVHcQ4DuLF62Lhtq90Db/d4Z8SKtuFxjm5rUN2TpaG5mHYw0FPyVer8dk
 HDp3k4rswQEMuaOkp+0xtfL5Pzmw345XX3o6xWAL6AnREL/Q+38SqeZUmxO7RWPDeI3Y
 zS1+xiZC4ivAlXBNH4rs+Ul2M0IBgweXbZCZ4mCNT77EJOHO833EHl/ylCpFUdJkJFGD
 ReDaQp4NmHsD6CCvRpN30xAxWMWI3juIsII9/6hKm3ng8SRNG1SpFtz0uR0uAxvAF+0q
 SrOg==
X-Gm-Message-State: APjAAAXEQ5dJPqQdLJevaSDpFIzg1jSqNalrPL1lXl/pcPbYlUSvqZAR
 N7TgIuA5z5TAl0kCePAM+DhmkFynhzwqpd8kpU0CgLRjOhZvH2OqL3kRbILCODqNHkeLHhOp1a+
 1NmH8FKrnXHCR8nI=
X-Received: by 2002:a05:600c:145:: with SMTP id
 w5mr35478947wmm.157.1577694913391; 
 Mon, 30 Dec 2019 00:35:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqw91vT8R+h9yQrnpEPKrWkFERrtcPF8go3aKBujjKtpMRJVAQ5L5OQT0DXlQofOKwBVwd9ccw==
X-Received: by 2002:a05:600c:145:: with SMTP id
 w5mr35478922wmm.157.1577694913204; 
 Mon, 30 Dec 2019 00:35:13 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id p26sm19702810wmc.24.2019.12.30.00.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2019 00:35:12 -0800 (PST)
Subject: Re: [PATCH] 9p: local: fix memory leak
To: Yan Wang <wangyan122@huawei.com>, groug@kaod.org
References: <20191230022347.36932-1-wangyan122@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c387271b-ff01-edc9-e3d8-82989cc12cb6@redhat.com>
Date: Mon, 30 Dec 2019 09:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230022347.36932-1-wangyan122@huawei.com>
Content-Language: en-US
X-MC-Unique: Vs_LLP1sO52y2oNTblpckA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Please describe the memory leak, and if possible how you noticed it.

Indeed the previous 2 calls to g_path_get_dirname() aren't free'd.

On 12/30/19 3:23 AM, Yan Wang wrote:
> Signed-off-by: Yan Wang <wangyan122@huawei.com>
> ---
>   hw/9pfs/9p-local.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index ca641390fb..d0592c3b45 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -947,7 +947,7 @@ static int local_link(FsContext *ctx, V9fsPath *oldpa=
th,
>       if (ctx->export_flags & V9FS_SM_MAPPED_FILE &&
>           local_is_mapped_file_metadata(ctx, name)) {
>           errno =3D EINVAL;
> -        return -1;
> +        goto out;

As the rest of this function... OK.
With some love this function could get clever by only allocating=20
variables it will use.

With better commit description:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>       }
>  =20
>       odirfd =3D local_opendir_nofollow(ctx, odirpath);
>=20


