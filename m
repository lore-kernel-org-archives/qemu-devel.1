Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2458F2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4OXjhfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2458F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8oj3-0005kC-CU
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j8ocM-0002Yh-5i
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j8ocL-0006jG-54
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33934
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j8ocL-0006j5-1i
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583169152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXgGVeNZ4gnHNkth6XiEECTKsZq5BL9p6HrQEve8tPI=;
 b=D4OXjhflbrkLpDv7ApV/zi/OLM0eQ0CgkEmev06Mh+PFTGqlZJsi4ytRT4fSpmvbp6eYdr
 jQ7KRJUUtPoi+Z17HNZ0XL6O+R527Hn5kQ6burKeztKl1BsTmZ5S2Z6x4SrL5rdwBEYx1f
 5oon5gTgVMHf8bioSo00RfPKg+09UsU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-nqYT_0sdODGR8dD052qVPA-1; Mon, 02 Mar 2020 12:12:30 -0500
X-MC-Unique: nqYT_0sdODGR8dD052qVPA-1
Received: by mail-wm1-f69.google.com with SMTP id w12so7508wmc.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TA4MEChkH8Uyp0cQUQXJr88UAUNELptycG1jlWYJSZA=;
 b=fDz8Jn50mAwoodDHQ5B39lh+Q+Qs6YSwmC7VwSkaz+sqR4Y8wUAxoG+c8XMLUcre5T
 4dz7rnnf7BvAMs0LQ7oNMZjjApc3bfTa3coH1aEPicubMA4JTWEXO0FnDQI+WOyzn0Yr
 21xB2E5Yfzw/MSTkfZwPZVnYpE1LOV5GwDUzuj53W/r7+4xGN7FAHCOp+6+e0PVTO/27
 WBDT+dFVSH4QU4Bi2QeMDhBqxdVfbq10ajdtTp7YIFJotgwtCuELeNQuGQTSSToKZGh1
 RQ2SBMFbX1jszbCWAkJaSBl40rbMX7RHHt6psKl+fdY5MxGiT2TkbWAFA6ijd7DjZMGo
 BUeg==
X-Gm-Message-State: ANhLgQ0U+qKHvefyWbeLxSJZW8c2/+dvmC+/5KgHKvXpK9XvbBEZ377g
 ptEFXEdw7z6HY203dc2j6P+uQROQvjBkyjydjZvHMNRCHd3qR/3pyN2Bf8ilmmq3Vnd04H0EWSc
 2BUXN/XTQj7/5LmM=
X-Received: by 2002:adf:de83:: with SMTP id w3mr554901wrl.275.1583169149139;
 Mon, 02 Mar 2020 09:12:29 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt4N6L2MF5CbRanW9nI84tBE/7IIEcQO/SJIR2v3+BFUvxbIT3sWODdTH/1fBvsw1Ci2ilRRQ==
X-Received: by 2002:adf:de83:: with SMTP id w3mr554879wrl.275.1583169148939;
 Mon, 02 Mar 2020 09:12:28 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
 by smtp.gmail.com with ESMTPSA id b7sm28412520wrs.97.2020.03.02.09.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 09:12:28 -0800 (PST)
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
To: Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com,
 peter.maydell@linaro.org, max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-3-n54@gmx.com>
 <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
 <4e29b732-ce95-02f1-ec9c-31f1ce33cda0@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ece50db-33c7-4630-6b0f-52197b2ae845@redhat.com>
Date: Mon, 2 Mar 2020 18:12:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4e29b732-ce95-02f1-ec9c-31f1ce33cda0@gmx.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/20 12:56, Kamil Rytarowski wrote:
> On 03.02.2020 12:41, Philippe Mathieu-Daud=C3=A9 wrote:
>>> @@ -1768,6 +1785,7 @@ disabled with --disable-FEATURE, default is
>>> enabled if available:
>>> =C2=A0=C2=A0=C2=A0 hax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 HAX acceleration support
>>> =C2=A0=C2=A0=C2=A0 hvf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Hypervisor.framework acceleration support
>>> =C2=A0=C2=A0=C2=A0 whpx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Windows Hypervisor Platform acceleration support
>>> +=C2=A0 nvmm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 NetBSD Virtual Machine Monitor acceleration support
>>> =C2=A0=C2=A0=C2=A0 rdma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Enable RDMA-based migration
>>> =C2=A0=C2=A0=C2=A0 pvrdma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Enable PVRDMA support
>>> =C2=A0=C2=A0=C2=A0 vde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 support for vde network
>>> @@ -2757,6 +2775,20 @@ if test "$whpx" !=3D "no" ; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 fi
>>>
>>
>> Maybe you can add something like:
>>
>> if test "$targetos" =3D "NetBSD"; then
>> =C2=A0=C2=A0=C2=A0 nvmm=3D"check"
>> fi
>>
>> to build by default with NVMM if available.
>=20
> I will add nvmm=3Dyes to the NetBSD) targetos check section.

No, nvmm=3Dyes instead should fail the build if nvmm.h is not available.
That is not a good default.

Paolo


