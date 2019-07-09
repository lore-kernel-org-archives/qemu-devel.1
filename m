Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43ACC004EF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D49E20844
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D49E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkoIl-00028O-V8
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkoHz-0001Wp-EB
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkoHy-0001eq-94
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:28:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hkoHv-0001bi-J7; Tue, 09 Jul 2019 07:27:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BEB2081F25;
 Tue,  9 Jul 2019 11:27:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6389D196EE;
 Tue,  9 Jul 2019 11:27:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01BA61138648; Tue,  9 Jul 2019 13:27:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20190703110044.25610-1-dplotnikov@virtuozzo.com>
 <20190703110044.25610-2-dplotnikov@virtuozzo.com>
Date: Tue, 09 Jul 2019 13:27:55 +0200
In-Reply-To: <20190703110044.25610-2-dplotnikov@virtuozzo.com> (Denis
 Plotnikov's message of "Wed, 3 Jul 2019 14:00:42 +0300")
Message-ID: <878st78n2c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 09 Jul 2019 11:27:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 1/3] qcow2: introduce compression type
 feature
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'd like to recommend a few commas.

Denis Plotnikov <dplotnikov@virtuozzo.com> writes:

> The patch adds some preparation parts for incompatible compression type
> feature to QCOW2 header that indicates that *all* compressed clusters
> must be (de)compressed using a certain compression type.
>
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image.
>
> The goal of the feature is to add support of other compression algorithms
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> It works roughly x2 faster than ZLIB providing a comparable compression ratio
> and therefore provide a performance advantage in backup scenarios.
>
> The default compression is ZLIB. Images created with ZLIB compression type
> is backward compatible with older qemu versions.
>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
[...]
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..5b8a8d15fe 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -109,7 +109,12 @@ in the description of a field.
>                                  An External Data File Name header extension may
>                                  be present if this bit is set.
>  
> -                    Bits 3-63:  Reserved (set to 0)
> +                    Bit 3:      Compression type bit. The bit must be set if
> +                                the compression type differs from default: zlib.
> +                                If the compression type is default the bit must
> +                                be unset.
> +
> +                    Bits 4-63:  Reserved (set to 0)
>  
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation can
> @@ -165,6 +170,21 @@ in the description of a field.
>                      Length of the header structure in bytes. For version 2
>                      images, the length is always assumed to be 72 bytes.
>  
> +        104 - 107:  compression_type
> +                    Defines the compression method used for compressed clusters.
> +                    A single compression type is applied to all compressed image
> +                    clusters.
> +                    The compression type is set on image creation only.
> +                    The default compression type is zlib.
> +                    When the deafult compression type is used the compression

Comma after used, please.

> +                    type bit (incompatible feature bit 3) must be unset.
> +                    When any other compression type is used the compression

Likewise.

> +                    type bit must be set.
> +                    Qemu versions older than 4.1 can use images created with
> +                    the default compression type without any additional
> +                    preparations and cannot use images created with any other

Comma after preparations, please.

> +                    compression type.
> +
>  Directly after the image header, optional sections called header extensions can
>  be stored. Each extension has a structure like the following:
>  
[...]

