Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AD7C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD5F20848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1QXgAGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD5F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACva-0000ge-LC
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jACuq-0008Uo-2k
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jACuo-0007pf-9e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:21:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jACuo-0007jf-3V
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583500881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OgvgzWrchsUQQohdXCIrnPlA3B1LxQKT0lORjwz/ak=;
 b=P1QXgAGtMuuijVCoh2+Wg4Vc2Tez/g9lMCGgKPwRUnEn7oe9YQ7Yu3G4Daw11bead1GDY0
 J6fiHGVmXPZBsjVNc7/jTcxiv0/Wq+v3vyn0ss50O39cjMyPONSGpzVx550Nbq4prPMryK
 sOSHrauJ3celL9ngVUpeU3CM9gLZfMQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-TkYbHMVoOIS8xMYga3u_hg-1; Fri, 06 Mar 2020 08:21:19 -0500
X-MC-Unique: TkYbHMVoOIS8xMYga3u_hg-1
Received: by mail-wr1-f72.google.com with SMTP id s10so975605wrr.21
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 05:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wqx8VhmgMaTld11hbRB+04/nIroHkjVq+sjyGLVv2k4=;
 b=dbIA/a6Z9AnjaWEq57i2DMjofoDNBtVcBZnAXYNOLPsDk/eqxt0WKigQhbQvfN7Crv
 OmI20sKtr4oZoHCbgyEMNqZxY7hQ5O/5rbYj2Y3//aaDYT5edVpaGbzrWJv/2X6TZopZ
 YfXMl0M0/PM88ojMd0ltu87mUG+9JlHirWOVmQewfftxupEUItaShni+jMAO0qr2soMI
 7qqjWbWN3Qs+2ktsaOrDMJ81o8v9oeJ5APYrMWR2aYmvfE6pGJdyXskjJzhg4rJ27rQ3
 Z3BTMmbuubSyw5RCSUONd/YkscnaepnTp0Z5euAUfpgWMJu2HnhW4iRpfjn2x2QUuQSJ
 1M3Q==
X-Gm-Message-State: ANhLgQ2Ihm1GmVcBz7dWfWDpS5SbaMvGtcQvVb9NaXOxqE0eeHGt3gsT
 mkiC3eaTLV2X2SsJyZVKJ0eanq//MOvupHBXHBi7NXgJwVbKKDk3p/1LeqCYCvTXA8N6t48dCfv
 Yr4z9+0YQ+ZlOHvE=
X-Received: by 2002:a1c:df07:: with SMTP id w7mr3907508wmg.7.1583500878150;
 Fri, 06 Mar 2020 05:21:18 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsRNQu3KkzQJPaNZCtT/P1LfIhoX2grgwS8OYzYJehMNz//elLFRiUISl2qRiRDYOswcU7JgA==
X-Received: by 2002:a1c:df07:: with SMTP id w7mr3907486wmg.7.1583500877957;
 Fri, 06 Mar 2020 05:21:17 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f207sm16147320wme.9.2020.03.06.05.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 05:21:16 -0800 (PST)
Subject: Re: [PATCH] 9p/proxy: Fix export_flags
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <158349633705.1237488.8895481990204796135.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5f2c984-8f2f-e547-364c-380d5baf1b95@redhat.com>
Date: Fri, 6 Mar 2020 14:21:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158349633705.1237488.8895481990204796135.stgit@bahia.lan>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/6/20 1:05 PM, Greg Kurz wrote:
> The common fsdev options are set by qemu_fsdev_add() before it calls
> the backend specific option parsing code. In the case of "proxy" this
> means "writeout" or "readonly" were simply ignored. This has been
> broken from the beginning.

oops...

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/9pfs/9p-proxy.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> index 8136e1342d78..6f598a0f111c 100644
> --- a/hw/9pfs/9p-proxy.c
> +++ b/hw/9pfs/9p-proxy.c
> @@ -1139,10 +1139,10 @@ static int proxy_parse_opts(QemuOpts *opts, FsDri=
verEntry *fs, Error **errp)
>       }
>       if (socket) {
>           fs->path =3D g_strdup(socket);
> -        fs->export_flags =3D V9FS_PROXY_SOCK_NAME;
> +        fs->export_flags |=3D V9FS_PROXY_SOCK_NAME;
>       } else {
>           fs->path =3D g_strdup(sock_fd);
> -        fs->export_flags =3D V9FS_PROXY_SOCK_FD;
> +        fs->export_flags |=3D V9FS_PROXY_SOCK_FD;
>       }
>       return 0;
>   }
>=20
>=20


