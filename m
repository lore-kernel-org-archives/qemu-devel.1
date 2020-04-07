Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED819C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DCE4206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7rA4kDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCE4206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLm2f-0003cw-Nw
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLm1T-00029e-UF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLm1R-0001wm-F6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:04:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26336
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLm1R-0001wc-8A
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586257440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qH4vYyzUzyXgBG+RVHwqKwIDCWDhU/st53N1eVgzgwI=;
 b=U7rA4kDo+74tY3ReQDCJ0641jeWJoqsD2akJbYw3QBVj5SyajoaAaTlUANxyILf2DZ9fOp
 Y3k2J0s7dMZG8I3JqspjTgKtsfp7xrSiOLW8gqKKD4fwUsz+p9Bwr86X113UDFAig5B90H
 UTh5kcbdMm1RXs2CYN6yRf75g+ssLWo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-z4qYMuOFNeOk_cHLagwQoQ-1; Tue, 07 Apr 2020 07:03:56 -0400
X-MC-Unique: z4qYMuOFNeOk_cHLagwQoQ-1
Received: by mail-ed1-f71.google.com with SMTP id h12so2731827edv.11
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 04:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A9LL6Ut6al9YGzBIFblWxd6Wqj2HvddqjZHfnhuHJbY=;
 b=SQnM1cp94yxHE1uP86ptXXZixkOEZDhOomGLhB1OejMxA7/cmWml4t50QkJs22iYlk
 E5cFGrtQdmxxcORJYBkfZK9dYozEPb3DMFagCLNdIGDGF6e/uEu8sVoMX4/G7zvXFMFM
 Usjyku4Cf8stXkw3vgD77n8Y03hqM+rGEJfEGlAaAtYhws5y/WVF7myeLMO5sCeq0A9Z
 v1uOTE4Vt8GS1GsKhCpEJ6B45cmYBd866TrErdPAxyjQEb3Ns/7Wqbcq/8bsSXSJuVLo
 7/Y1uTmDjThJ46Miwip9SwNteQBL+x9/hpMHq898drammIf7aZly2+W0YNUCSMerC0cH
 myzA==
X-Gm-Message-State: AGi0PuZfutrpCMdQI4OEWHnfindQUopQ0XDcc3zYU3uXxtE8fid73r4C
 P4aBlKJZky96j9dXkyQ6z4KSVsppWQiUfcTS+Vy6Ml7mg1ihhQ/I6Er4N/4LAZzUIttO9VFuCmJ
 ixk6OXX3cr+Iq1sc=
X-Received: by 2002:a17:906:52c2:: with SMTP id
 w2mr1439020ejn.117.1586257435310; 
 Tue, 07 Apr 2020 04:03:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypJFJRnrVD/2aeBwqkQ3cpArrCanRWhUSyokzJQ0inUEyvLfyZFLUjawjGcPqjA67OfFbOG+lA==
X-Received: by 2002:a17:906:52c2:: with SMTP id
 w2mr1438990ejn.117.1586257435011; 
 Tue, 07 Apr 2020 04:03:55 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h11sm2644476edk.10.2020.04.07.04.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 04:03:54 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 48/54] scripts/coccinelle: Use &error_abort in
 TypeInfo::instance_init()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-49-f4bug@amsat.org>
 <04663728-06f3-85bf-74b7-45184f90aa0a@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ac7213fd-3ea2-e80c-7308-5f2de02c341c@redhat.com>
Date: Tue, 7 Apr 2020 13:03:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <04663728-06f3-85bf-74b7-45184f90aa0a@virtuozzo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 9:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 06.04.2020 20:47, Philippe Mathieu-Daud=C3=A9 wrote:
>> The instance_init() calls are not suppose to fail. Add a
>> Coccinelle script to use &error_abort instead of ignoring
>> errors by using a NULL Error*.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> =C2=A0 .../use-error_abort-in-instance_init.cocci=C2=A0=C2=A0=C2=A0 | 52=
 +++++++++++++++++++
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
>> =C2=A0 2 files changed, 53 insertions(+)
>> =C2=A0 create mode 100644=20
>> scripts/coccinelle/use-error_abort-in-instance_init.cocci
>>
>> diff --git a/scripts/coccinelle/use-error_abort-in-instance_init.cocci=
=20
>> b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
>> new file mode 100644
>> index 0000000000..8302d74a0c
>> --- /dev/null
>> +++ b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
>> @@ -0,0 +1,52 @@
>> +// Use &error_abort in TypeInfo::instance_init()
>> +//
>> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
>> +// This work is licensed under the terms of the GNU GPLv2 or later.
>> +//
>> +// spatch \
>> +//=C2=A0 --macro-file scripts/cocci-macro-file.h --include-headers \
>> +//=C2=A0 --sp-file=20
>> scripts/coccinelle/use-error_abort-in-instance_init.cocci \
>> +//=C2=A0 --keep-comments --in-place
>> +//
>> +// Inspired by=20
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg692500.html
>> +// and https://www.mail-archive.com/qemu-devel@nongnu.org/msg693637.htm=
l
>> +
>> +
>> +@ has_qapi_error @
>> +@@
>> +=C2=A0=C2=A0=C2=A0 #include "qapi/error.h"
>> +
>> +
>> +@ match_instance_init @
>> +TypeInfo info;
>> +identifier instance_initfn;
>> +@@
>> +=C2=A0=C2=A0=C2=A0 info.instance_init =3D instance_initfn;
>> +
>> +
>> +@ use_error_abort @
>> +identifier match_instance_init.instance_initfn;
>> +identifier func_with_error;
>> +expression parentobj, propname, childobj, size, type, errp;
>> +position pos;
>> +@@
>> +void instance_initfn(...)
>> +{
>> +=C2=A0=C2=A0 <+...
>> +(
>> +=C2=A0=C2=A0 object_initialize_child(parentobj, propname,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 childobj, size, type,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 errp, NULL);
>> +|
>> +=C2=A0=C2=A0 func_with_error@pos(...,
>> +-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 NULL);
>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &error_abort);
>> +)
>=20
>=20
> Hmm. I don't follow, what are you trying to achieve by this ( | )=20
> construction? The second pattern (func_with_error...) will be matched=20
> anyway, with or without first pattern (object_initialize_child...)=20
> matched. And first pattern does nothing.

Expected behavior :)

If object_initialize_child() matched:
   do nothing.
Else:
   transform.

>=20
>=20
>> +=C2=A0=C2=A0 ...+>
>> +}
>> +
>> +
>> +@script:python depends on use_error_abort && !has_qapi_error@
>> +p << use_error_abort.pos;
>> +@@
>> +print('[[manual edit required, %s misses #include "qapi/error.h"]]' %=
=20
>> p[0].file)
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 14de2a31dc..ae71a0a4b0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2059,6 +2059,7 @@ F: scripts/coccinelle/error-use-after-free.cocci
>> =C2=A0 F: scripts/coccinelle/error_propagate_null.cocci
>> =C2=A0 F: scripts/coccinelle/remove_local_err.cocci
>> =C2=A0 F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>> +F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
>> =C2=A0 F: scripts/coccinelle/use-error_fatal.cocci
>> =C2=A0 F: scripts/coccinelle/use-error_propagate-in-realize.cocci
>>
>=20
>=20


