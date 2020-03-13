Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C2C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D280206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfZTOoCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D280206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqJY-0006J3-RX
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 15:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCqIq-0005Mt-ME
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCqIp-0007c9-KJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:49:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28488
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCqIp-0007ag-HH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584128943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXtoWihVkHDbEvXnNxm3QwCR8MfyO0vwKI1H+t1s5KE=;
 b=EfZTOoChz69UH+OH61EYnADZ+5BK3ZuIMcEkJ6kiFHhIPumQfV0RXg35XdG3O1tU63Ql2w
 03ptAAISxPWPgN8MPCx2LwT4WZ3L4t8i1dGwE00Wn4hMme1o69bM0nxoQsz2F5wLRa+eWS
 Exr0M4a1eymrTx/vuYw2Oo2+x/SOGwQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-d261ZbqGMCe9uLSqIr6o2Q-1; Fri, 13 Mar 2020 15:49:01 -0400
X-MC-Unique: d261ZbqGMCe9uLSqIr6o2Q-1
Received: by mail-wm1-f71.google.com with SMTP id z26so3708338wmk.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BoR+8Wo9+RqRhSASXisiDugM7jUh+0I8YmOyLRR0IEY=;
 b=U7iLVvCY3ZgF2YlzTxKBrYb6pKWp+iYrFdKIE78q5hX/ESWt8yqSFy04J5R4Y2pW8J
 NgN9pHWNj1g+hv7lUQJgkPwsqwa9d0+nBdAJAjinhEFJUHuRq5LZZeCn4RgvNvXsZNxi
 TbEHoZAwRVk+4J5pd9v+xoa7XaLEo+ouLYNyXTpwHshqmRj/pOMtbqXwjMEWp3clt+kZ
 msAA7Ae+9+kdZ+APy6fFgFRL1jW1glzL8TBy6XoHT2lCbzfm8uEIGpoumaHEJSKX63GE
 OMco3OBmBiJBphxgH7+5NYeITH/Su5G1LGJnchJ8WtHrKZHfUC+vMCwkegGCDVcekX2x
 RdWw==
X-Gm-Message-State: ANhLgQ18aeeJIsm/NZQjBu74ELPz3z7zCV/B/MU92u6CYcNCaPjxFDOs
 FKUkfe04qbw/N0lDwkIB2paBPZc6ybWWZCU5j5ZFpSEZ6/1B3wDVV3XtwY7z7Awnp/rECTiQctQ
 E2F4odxnZk8i5DEA=
X-Received: by 2002:adf:fe41:: with SMTP id m1mr19059473wrs.355.1584128939598; 
 Fri, 13 Mar 2020 12:48:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuGqq8dD9cnoOE62Iuoc2yRXJ+Q6ZLxbI7MXi7/qeqTnQDE7tNGvcFHVEeKBE0g5s4K70HovQ==
X-Received: by 2002:adf:fe41:: with SMTP id m1mr19059446wrs.355.1584128939225; 
 Fri, 13 Mar 2020 12:48:59 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id b5sm9998476wrw.86.2020.03.13.12.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 12:48:58 -0700 (PDT)
Subject: Re: [PATCH 3/3] xen-block: Use one Error * variable instead of two
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <25a312fd-20ce-3baf-c839-1284dcc53097@redhat.com>
Date: Fri, 13 Mar 2020 20:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313170517.22480-4-armbru@redhat.com>
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
Cc: alxndr@bu.edu, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 ashijeetacharya@gmail.com, paul.durrant@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 6:05 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/block/xen-block.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 3885464513..7b3b6dee97 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -998,14 +998,13 @@ static void xen_block_device_destroy(XenBackendInst=
ance *backend,
>       XenBlockVdev *vdev =3D &blockdev->props.vdev;
>       XenBlockDrive *drive =3D blockdev->drive;
>       XenBlockIOThread *iothread =3D blockdev->iothread;
> +    Error *local_err =3D NULL;
>  =20
>       trace_xen_block_device_destroy(vdev->number);
>  =20
>       object_unparent(OBJECT(xendev));
>  =20
>       if (iothread) {
> -        Error *local_err =3D NULL;
> -
>           xen_block_iothread_destroy(iothread, &local_err);
>           if (local_err) {
>               error_propagate_prepend(errp, local_err,
> @@ -1015,8 +1014,6 @@ static void xen_block_device_destroy(XenBackendInst=
ance *backend,
>       }
>  =20
>       if (drive) {
> -        Error *local_err =3D NULL;
> -
>           xen_block_drive_destroy(drive, &local_err);
>           if (local_err) {
>               error_propagate_prepend(errp, local_err,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


