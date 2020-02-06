Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD6AC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30EB214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmlWijkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30EB214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlkA-0007KL-0I
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izljO-0006VX-Lf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izljM-0008Ng-Jq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:18:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48019
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izljM-00085M-Cc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581013101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djLhxZadw2RbaFF924unvfVyj7m+RdR/UMqJH+VPMDE=;
 b=ZmlWijkqHiTReLYr7TomsaTgovMDMEw12//f1w9ciXGQJVk5lTP/7THiGnNZzZ4cRoWt1C
 DgASqtfKqw/Kr0zu45Lmz94YgiTWB7xibai736yKsf7P2gCiXHRH0wK324dNfrLkvooG8a
 zmiipgd35ysDG0Vt3kzcfvQtQX+Wr5w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-KJfzTEbyN16ERmLlPsHmyw-1; Thu, 06 Feb 2020 13:18:19 -0500
Received: by mail-wr1-f71.google.com with SMTP id x15so3892851wrl.15
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 10:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bA55/hCXTgrpMCN2OUA8J8vblTWKHvoba7+0LQs+YTM=;
 b=ZBU6tl4ObZyDt8QEb1Koz9aU02wnw9sT9kCYmPFybFkw0+V5uV/a2q9bfhV7uJQ84p
 DkQ54/ZwJYh+4D/RiOKWIZ/XXxbYGEIvPuOT9SGcWyEii/d96PSfEKRgsX7kqOeKOu82
 E+C/tQCh99jNCcJkPJhPwbB5p2q4lGdCz4KrQkINah0SgAw4sAdTYn2ydxR2wfdLMLPu
 NxR4EFQCdrTdo7dxQedA4pbMK5yss0YSydxvod/WSNmfiLj6gWrdRP+CB+8H4jimzkrA
 QKxjfvbFt0faTfA6/iI10teJ3zChGZDpFmwB0zcTLKlfVA2ksZVIY8tvnRZHBFsXNNsb
 va+Q==
X-Gm-Message-State: APjAAAVRzYu9QTiAgSsvF3WEhH9LAaJvNlhRx38kUtXa6amRkW4FoeoJ
 ep5H8qGmDM59lkl5H8174MK0LDIjtu60bPZx1zZzu+gj/EBj88M6HpNZ0xQ0WSU2cS8AUV3mOyI
 IyafEC8yI9YR+h8U=
X-Received: by 2002:a1c:638a:: with SMTP id x132mr5777299wmb.43.1581013098115; 
 Thu, 06 Feb 2020 10:18:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXkBKz1jHKDTxrQL87ZX2P+PW/GMn/ESpu2WsMvhBbUt3AHlCueYztzzmE84hmvq9hv7r+ag==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr5777281wmb.43.1581013097890; 
 Thu, 06 Feb 2020 10:18:17 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v12sm115030wru.23.2020.02.06.10.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 10:18:17 -0800 (PST)
Subject: Re: [PATCH 1/2] tests/vhost-user-bridge: move to contrib/
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200206173631.752092-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7b4a568c-06fe-579a-8f44-649987af904c@redhat.com>
Date: Thu, 6 Feb 2020 19:18:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206173631.752092-1-lvivier@redhat.com>
Content-Language: en-US
X-MC-Unique: KJfzTEbyN16ERmLlPsHmyw-1
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 6:36 PM, Laurent Vivier wrote:
> vhost-user-bridge is not a test. Move it to contrib/ and
> add it to the tools list.
>=20
> It will be built only if tools (--enable-tools) and
> vhost-user (--enable-vhost-user) are enabled (both are set
> by default).
>=20
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   Makefile                                                      | 3 +++
>   Makefile.objs                                                 | 1 +
>   configure                                                     | 3 +++
>   contrib/vhost-user-bridge/Makefile.objs                       | 1 +
>   tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c | 0
>   tests/Makefile.include                                        | 1 -
>   6 files changed, 8 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/vhost-user-bridge/Makefile.objs
>   rename tests/vhost-user-bridge.c =3D> contrib/vhost-user-bridge/main.c =
(100%)

Please update the comment in docs/devel/migration.rst too:

   ... and the `vhost-user-bridge` (in `tests/`) and ...

by "(in `contrib/`)".

With docs/devel/migration.rst updated:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> diff --git a/Makefile b/Makefile
> index 461d40bea6c2..23342a433e11 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -442,6 +442,7 @@ dummy :=3D $(call unnest-vars,, \
>                   libvhost-user-obj-y \
>                   vhost-user-scsi-obj-y \
>                   vhost-user-blk-obj-y \
> +                vhost-user-bridge-obj-y \
>                   vhost-user-input-obj-y \
>                   vhost-user-gpu-obj-y \
>                   qga-vss-dll-obj-y \
> @@ -672,6 +673,8 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) li=
bvhost-user.a
>   =09$(call LINK, $^)
>   vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
>   =09$(call LINK, $^)
> +vhost-user-bridge$(EXESUF): $(vhost-user-bridge-obj-y) libvhost-user.a
> +=09$(call LINK, $^)
>  =20
>   rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
>   rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
> diff --git a/Makefile.objs b/Makefile.objs
> index 26b9cff95436..0240100b9a17 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -109,6 +109,7 @@ vhost-user-scsi.o-cflags :=3D $(LIBISCSI_CFLAGS)
>   vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS)
>   vhost-user-scsi-obj-y =3D contrib/vhost-user-scsi/
>   vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
> +vhost-user-bridge-obj-y =3D contrib/vhost-user-bridge/
>   rdmacm-mux-obj-y =3D contrib/rdmacm-mux/
>   vhost-user-input-obj-y =3D contrib/vhost-user-input/
>   vhost-user-gpu-obj-y =3D contrib/vhost-user-gpu/
> diff --git a/configure b/configure
> index 115dc38085f3..0415eb5c99d3 100755
> --- a/configure
> +++ b/configure
> @@ -6223,6 +6223,9 @@ if test "$want_tools" =3D "yes" ; then
>     if [ "$curl" =3D "yes" ]; then
>         tools=3D"elf2dmp\$(EXESUF) $tools"
>     fi
> +  if [ "$vhost_user" =3D "yes" ]; then
> +      tools=3D"vhost-user-bridge\$(EXESUF) $tools"
> +  fi
>   fi
>   if test "$softmmu" =3D yes ; then
>     if test "$linux" =3D yes; then
> diff --git a/contrib/vhost-user-bridge/Makefile.objs b/contrib/vhost-user=
-bridge/Makefile.objs
> new file mode 100644
> index 000000000000..36a8d9b49a05
> --- /dev/null
> +++ b/contrib/vhost-user-bridge/Makefile.objs
> @@ -0,0 +1 @@
> +vhost-user-bridge-obj-y =3D main.o
> diff --git a/tests/vhost-user-bridge.c b/contrib/vhost-user-bridge/main.c
> similarity index 100%
> rename from tests/vhost-user-bridge.c
> rename to contrib/vhost-user-bridge/main.c
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 2f1cafed720d..78cdbe91aed5 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -586,7 +586,6 @@ include $(SRC_PATH)/tests/qtest/Makefile.include
>  =20
>   tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
>   tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
> -tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-=
obj-y) libvhost-user.a
>  =20
>   SPEED =3D quick
>  =20
>=20


