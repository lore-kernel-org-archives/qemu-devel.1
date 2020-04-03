Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7F1C2D0E8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5692073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWkkk5u1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5692073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJS7-0005vy-4v
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKJQs-00041B-Sl
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKJQr-0002EH-KP
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:20:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44903
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKJQr-0002Du-H1
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585909213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1C/Oz5nFfDIWUwD12oZxAovwYDQ6/lqqhQBrwjZhTM=;
 b=SWkkk5u12NxQVU1MKVqAeNp6spxUwJSew4+zT8U8LSw38Kq1OPDUuERh6Cyo/TfUeJodYD
 XwqNJM4IDo4/ib+zxMPyfeDAoLiisHZMt6Py0+JWKEpyhcCjKtHgeHfMsuq4JUoENxK430
 knEc1hNW7RBvnJNl6JS2k+yvuHQTHG4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-HLgcMXazNEuT0CMltB9TFQ-1; Fri, 03 Apr 2020 06:20:11 -0400
X-MC-Unique: HLgcMXazNEuT0CMltB9TFQ-1
Received: by mail-ed1-f72.google.com with SMTP id h12so3699295edv.11
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 03:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gN15SiEGk8vOxam/s3H6x2+AdX1TQhcDdLC2kH6KgbE=;
 b=TfkaysJbyDaDGBJkpSLjsBYRGDf5SdhgiF1APqIiaNI60ctj12zfaLyhiUuoVi0uze
 X8zZ/sinkOY6QquVk2OXG9Wop8lV36jKp9ZvDDmgFC4k1m+E+3HIb6BMkyNqDDphygWT
 U5PjUn95IJdEuvZYEhy0ttbKU22RVdkXMXbhsEIVoUK8En2wVdDI5Vp5qv6M0S3L9foy
 rAJ1BZ5eypOTsbzZ62pkHS59WVhNoThTilItKdOfL7BhGm8QaC7VDh5GANch6cJOVVrv
 M4QsuMmBs+i2FPSyDWI+++1YJXwaQgeXnY4doUtyooS+qR+yIMVJ70HY5H+2LDTecK9T
 InLQ==
X-Gm-Message-State: AGi0PuZQl1SDBAGo/dEr7loScFl8PryBczAnpPSn0cJhd+FCQVMYDSs4
 WsZLYruhUP5oKy/Yw1KrMh9zLV9er1zCIFMtY4w7lc5EVyj0589lSXMghvKl+M73ZTGalPzw+ML
 KPW/t350U0VepYiI=
X-Received: by 2002:a50:ab1e:: with SMTP id s30mr7074291edc.336.1585909209949; 
 Fri, 03 Apr 2020 03:20:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypK+vgnXP926zsjWAY8V4KSfHEnA5BAbzLfgso45uw/r0+axtb3d9I8U+BTfzFs59+6eJwfY/A==
X-Received: by 2002:a50:ab1e:: with SMTP id s30mr7074280edc.336.1585909209731; 
 Fri, 03 Apr 2020 03:20:09 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id fx19sm1583486ejb.6.2020.04.03.03.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 03:20:09 -0700 (PDT)
Subject: Re: [PATCH] iotests/common.pattern: Quote echos
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200403101134.805871-1-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6be375b0-55af-a692-64c9-b7cb745992c2@redhat.com>
Date: Fri, 3 Apr 2020 12:20:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403101134.805871-1-mreitz@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 12:11 PM, Max Reitz wrote:
>  From time to time, my shell decides to repace the bracketed numbers here
> by the numbers inside (i.e., "=3D=3D=3D Clusters to be compressed [1]" is
> printed as "=3D=3D=3D Clusters to be compressed 1").  That makes tests th=
at
> use common.pattern fail.  Prevent that from happening by quoting the
> arguments to all echos in common.pattern.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   tests/qemu-iotests/common.pattern | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/commo=
n.pattern
> index 4f5e5bcea0..4caa5de187 100644
> --- a/tests/qemu-iotests/common.pattern
> +++ b/tests/qemu-iotests/common.pattern
> @@ -23,7 +23,7 @@ do_is_allocated() {
>       local count=3D$4
>  =20
>       for ((i=3D1;i<=3D$count;i++)); do
> -        echo alloc $(( start + (i - 1) * step )) $size
> +        echo "alloc $(( start + (i - 1) * step )) $size"
>       done
>   }
>  =20
> @@ -39,9 +39,9 @@ do_io() {
>       local count=3D$5
>       local pattern=3D$6
>  =20
> -    echo =3D=3D=3D IO: pattern $pattern >&2
> +    echo "=3D=3D=3D IO: pattern $pattern" >&2
>       for ((i=3D1;i<=3D$count;i++)); do
> -        echo $op -P $pattern $(( start + (i - 1) * step )) $size
> +        echo "$op -P $pattern $(( start + (i - 1) * step )) $size"
>       done
>   }
>  =20
> @@ -110,31 +110,31 @@ io_test2() {
>       #        free - free - compressed
>  =20
>       # Write the clusters to be compressed
> -    echo =3D=3D=3D Clusters to be compressed [1]
> +    echo '=3D=3D=3D Clusters to be compressed [1]'
>       io_pattern writev $((offset + 4 * $cluster_size)) $cluster_size $((=
9 * $cluster_size)) $num 165
> -    echo =3D=3D=3D Clusters to be compressed [2]
> +    echo '=3D=3D=3D Clusters to be compressed [2]'
>       io_pattern writev $((offset + 5 * $cluster_size)) $cluster_size $((=
9 * $cluster_size)) $num 165
> -    echo =3D=3D=3D Clusters to be compressed [3]
> +    echo '=3D=3D=3D Clusters to be compressed [3]'
>       io_pattern writev $((offset + 8 * $cluster_size)) $cluster_size $((=
9 * $cluster_size)) $num 165
>  =20
>       mv "$TEST_IMG" "$TEST_IMG.orig"
>       $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -c "$TEST_IMG.orig" "$TEST_=
IMG"
>  =20
>       # Write the used clusters
> -    echo =3D=3D=3D Used clusters [1]
> +    echo '=3D=3D=3D Used clusters [1]'
>       io_pattern writev $((offset + 0 * $cluster_size)) $cluster_size $((=
9 * $cluster_size)) $num 165
> -    echo =3D=3D=3D Used clusters [2]
> +    echo '=3D=3D=3D Used clusters [2]'
>       io_pattern writev $((offset + 1 * $cluster_size)) $cluster_size $((=
9 * $cluster_size)) $num 165
> -    echo =3D=3D=3D Used clusters [3]
> +    echo '=3D=3D=3D Used clusters [3]'
>       io_pattern writev $((offset + 3 * $cluster_size)) $cluster_size $((=
9 * $cluster_size)) $num 165
>  =20
>       # Read them
> -    echo =3D=3D=3D Read used/compressed clusters
> +    echo '=3D=3D=3D Read used/compressed clusters'
>       io_pattern readv $((offset + 0 * $cluster_size)) $((2 * $cluster_si=
ze)) $((9 * $cluster_size)) $num 165
>       io_pattern readv $((offset + 3 * $cluster_size)) $((3 * $cluster_si=
ze)) $((9 * $cluster_size)) $num 165
>       io_pattern readv $((offset + 8 * $cluster_size)) $((1 * $cluster_si=
ze)) $((9 * $cluster_size)) $num 165
>  =20
> -    echo =3D=3D=3D Read zeros
> +    echo '=3D=3D=3D Read zeros'
>       io_zero readv $((offset + 2 * $cluster_size)) $((1 * $cluster_size)=
) $((9 * $cluster_size)) $num
>       io_zero readv $((offset + 6 * $cluster_size)) $((2 * $cluster_size)=
) $((9 * $cluster_size)) $num
>   }
>=20


