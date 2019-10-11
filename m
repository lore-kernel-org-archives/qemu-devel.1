Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A73ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793242196E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793242196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIs1R-0002t1-Jk
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 06:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIs0O-0001ic-PJ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIs0M-0006Qj-HN
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:18:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIs0K-0006Ps-Fz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:18:36 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 755DA87630
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 10:18:35 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n18so4132873wro.11
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 03:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AblDhCRuDTOu649sGBChawoqlUQYL72V+wnIfus3mDY=;
 b=Y01sBuxMWOCgVV1cECsxyZkhF8Rj3OO+mTGT0a3N5/+N8ba5b2N56dJkFmiiVHjUfK
 k6naPycBSCW0/6+ORuCwsdKBNliCWyHtL+vWtbiu1imxrBRrJYwT5Qb3koSKLMh57ag6
 Vt+YVlHV9OLV8LaMZHYyJEjbkMSFUjxBEFDpmJq3D58KmdvuYu/9vhKkAgq5ec3rKVpy
 WcsfXDDmfwyzk4BZbQEhV4YqVYIj2Md0uw7AskZu2rxOY2RU7Drmysz3bMb6rG48n8y5
 np+4sLJHK8kwgZkfoKv54YMNUt6RBC6zw/zbiTD/wOUoXeDhob6StKYZVkFqRuA9fZod
 7K5g==
X-Gm-Message-State: APjAAAXbc/cY3sI58EJXDEcW0eGWWNuA90CTIS4W+VpN0akTL6LxSUWq
 1QFhDO9+cJxbd+ZeV9xYLpusqlnSQSEvd/oY49uNe1CxFtmgaAJkXLIZbBpkfFyfmopX6hbso0d
 Suv6JVTroJ64HWbM=
X-Received: by 2002:adf:9102:: with SMTP id j2mr11663164wrj.136.1570789113970; 
 Fri, 11 Oct 2019 03:18:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzsg4qFbf3jGhLUi2PIcw0/c6HuGZvib7m4sAbjeQnjJiWlVpw32p2Wf52eLtd+U+iWso3C+Q==
X-Received: by 2002:adf:9102:: with SMTP id j2mr11663150wrj.136.1570789113767; 
 Fri, 11 Oct 2019 03:18:33 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id z189sm13657822wmc.25.2019.10.11.03.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 03:18:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] qcow2: Limit total allocation range to INT_MAX
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191010100858.1261-1-mreitz@redhat.com>
 <20191010100858.1261-2-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a3842fe-0a99-a8d2-9b24-c22493a80e45@redhat.com>
Date: Fri, 11 Oct 2019 12:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010100858.1261-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 12:08 PM, Max Reitz wrote:
> When the COW areas are included, the size of an allocation can exceed
> INT_MAX.  This is kind of limited by handle_alloc() in that it already
> caps avail_bytes at INT_MAX, but the number of clusters still reflects
> the original length.
>=20
> This can have all sorts of effects, ranging from the storage layer writ=
e
> call failing to image corruption.  (If there were no image corruption,
> then I suppose there would be data loss because the .cow_end area is
> forced to be empty, even though there might be something we need to
> COW.)
>=20
> Fix all of it by limiting nb_clusters so the equivalent number of bytes
> will not exceed INT_MAX.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   block/qcow2-cluster.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 8d5fa1539c..8982b7b762 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1330,6 +1330,9 @@ static int handle_alloc(BlockDriverState *bs, uin=
t64_t guest_offset,
>       nb_clusters =3D MIN(nb_clusters, s->l2_slice_size - l2_index);
>       assert(nb_clusters <=3D INT_MAX);
>  =20
> +    /* Limit total allocation byte count to INT_MAX */
> +    nb_clusters =3D MIN(nb_clusters, INT_MAX >> s->cluster_bits);
> +
>       /* Find L2 entry for the first involved cluster */
>       ret =3D get_cluster_table(bs, guest_offset, &l2_slice, &l2_index)=
;
>       if (ret < 0) {
> @@ -1412,7 +1415,7 @@ static int handle_alloc(BlockDriverState *bs, uin=
t64_t guest_offset,
>        * request actually writes to (excluding COW at the end)
>        */
>       uint64_t requested_bytes =3D *bytes + offset_into_cluster(s, gues=
t_offset);
> -    int avail_bytes =3D MIN(INT_MAX, nb_clusters << s->cluster_bits);
> +    int avail_bytes =3D nb_clusters << s->cluster_bits;
>       int nb_bytes =3D MIN(requested_bytes, avail_bytes);
>       QCowL2Meta *old_m =3D *m;
>  =20
>=20

