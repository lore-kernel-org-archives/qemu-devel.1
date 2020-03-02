Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED26C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBB821775
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM2AOzFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBB821775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8occ-0002hn-1y
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j8obp-0001mF-Ck
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j8obo-0006Gz-GS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54767
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j8obo-0006FE-Bq
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583169119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUgcBfR2wFDbk2C9edO1lDykmzo6Uky/eoTcXsE/hmc=;
 b=VM2AOzFyrEAyqW/VgE5eByi1SnWVrSB9fnJLmPekGnKqK6E7TotLRnRj3t+iSRIoR6UaLS
 SQtY4OKJU/oBU1ISzfmT1/Ii683SUbI04QNN28jyzV8ahrx+244GpYXz7GvrN1eFxUDfIu
 ZvlgzKGR2tDx/ubT6khApTfo5L5tx/E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-hBlHm5VaPAu_NUO8aM-UkQ-1; Mon, 02 Mar 2020 12:11:58 -0500
X-MC-Unique: hBlHm5VaPAu_NUO8aM-UkQ-1
Received: by mail-wr1-f69.google.com with SMTP id z16so3768397wrm.15
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XD8/bLBqP5gHCb6eOsHOSe/KWwmQ1F7ykvu4UaUA8wk=;
 b=XR/4/eqGajliO0M9f8mQyqdrPBSLPAe7G0HPDxMaK82cLTfLX4Uum4nkl1TLOsFTMu
 5aQYUrAueGbV+V6ct8vEDuUrd0fTjzbZ+7qOIB4B8ubkOKMGUpYDW0N85YyI0L7RRr9D
 gzBs6gjGQD1vqpxJ9mEQaPbSTJt4jYjI1lWVkBO9/jqdLeJGbgRtQSS0FLUC4mAG6qIg
 /9zYvXcNBP7fmWdNqYGvW50uVRLdXhFwERh3xH2GciiXU1i7qJMpzDKJoX7JWDetfoiy
 E5UJrb0HaAln7eYwW4GLRpwSxY+NgzdWFBjK1dhxzxO9PJcO8nCxk+Pnhvw6HsxYfnhk
 n0Sw==
X-Gm-Message-State: ANhLgQ2zVLq7X8wWruK0VUgt7U6wLmXZ92Pw85seqeVtjFxzOgliUAdL
 UW3LkPEuN7lG6LhI170yHFd1v7YgX+EjtCO7sSlgoRXsobbDf1oHo7LhjeEA2FE/ej0Nh57iutY
 8WazpLoXmyIsEfBI=
X-Received: by 2002:adf:d843:: with SMTP id k3mr501118wrl.427.1583169116977;
 Mon, 02 Mar 2020 09:11:56 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvaAL4AFmq27/VH6AcajdSKg4nvaLeaygoZmJGxEKMU0tMbtGIYeJDztF8ns92m/SMZKJFJQA==
X-Received: by 2002:adf:d843:: with SMTP id k3mr501081wrl.427.1583169116458;
 Mon, 02 Mar 2020 09:11:56 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
 by smtp.gmail.com with ESMTPSA id t3sm29176449wrx.38.2020.03.02.09.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 09:11:55 -0800 (PST)
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Kamil Rytarowski <n54@gmx.com>, rth@twiddle.net, ehabkost@redhat.com,
 slp@redhat.com, peter.maydell@linaro.org, max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-3-n54@gmx.com>
 <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55d6ace5-3cf1-de24-53be-700982a9f834@redhat.com>
Date: Mon, 2 Mar 2020 18:11:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/20 12:41, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> Maybe you can add something like:
>=20
> if test "$targetos" =3D "NetBSD"; then
> =C2=A0=C2=A0=C2=A0 nvmm=3D"check"
> fi

You could do just nvmm=3D"" and, below,

if test "$nvmm" !=3D "no" && test "$targetos" =3D "NetBSD"

But maybe even testing NetBSD is not needed since nvmm.h will likely not
be there.

Paolo

> to build by default with NVMM if available.
>=20
>> +##########################################
>> +# NetBSD Virtual Machine Monitor (NVMM) accelerator check
>> +if test "$nvmm" !=3D "no" ; then
>> +=C2=A0=C2=A0=C2=A0 if check_include "nvmm.h" ; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvmm=3D"yes"
>> +=C2=A0=C2=A0=C2=A0 LIBS=3D"-lnvmm $LIBS"
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if test "$nvmm" =3D "yes"; t=
hen
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feat=
ure_not_found "NVMM" "NVMM is not available"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvmm=3D"no"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +fi=20


