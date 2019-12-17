Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1AEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 11:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE18F207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 11:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn3EKbzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE18F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihBVE-00019A-1Z
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 06:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ihBUb-0000i3-5r
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 06:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ihBUZ-00007A-2T
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 06:58:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ihBUY-0008TQ-QZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 06:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576583897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7gRXh5dn38UHamU5mA/LadIM5P95eTj0S8O1nnVnTE=;
 b=cn3EKbzkmwiWEmOUHYOf3QMjnCOZzdlcbMpP2X+PwhFwherV1a3GNQ/WjG1MlZ4NGRvQQU
 O6cgDNNJ7AEjwFznyZCRfVDSLgKiSW3G6c4+z5N3DvEW5uC1c7J+m83L/PtFSRDBAVbZ6/
 DzWJjOixK8pSYnLGXDdPRwa7rlKlduM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-pakaXeAwMsCgCHv3xfXi0w-1; Tue, 17 Dec 2019 06:58:14 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so4597310wrq.12
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 03:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=xrXP+8vsjjqtAgpZXoAzY5Ei+hVt9KEj4FbqxCQB3kY=;
 b=N3p1L8z2sCpYaS297FT8DftVO14A2fz2qsjri3SKyq4qUp2Ntmuse7DWpauuzo44HM
 s/NrNOu62DdxbLS22AF3+q/RdmGRbbfPLkhLN4mUVGCd7CSpfn65qrMT5+O2GRbH6wID
 7alfLmUS9Jhzyd15Imsuw5ZBgsmbxdXpCwGp74PveVwaCcX13KHUEEz+JJ7mogGHBtI/
 AbCuzsKE9GsmnuY59UjfKD01K4/OOSkGa5NAXGniv7DFMVTbhp/SctzWSsAgvMWnLy/4
 wyzsLpkv1LB+NGN4qJgGF2IIouQXMcF4ctS0jEyX58374B+7UnrAokSwdEevoL4yB34o
 QO1g==
X-Gm-Message-State: APjAAAUsSZOH2k3myjXFbdzc8P50dRJPbRAuXmE+1PyNAKGxiTe9IMX5
 c5A4yTIEi6V9yTCykAFvj4GyGRFahzCgxPvRVTCj4L5C1RhkG+clHtQMEdCD1tsXhSTlKpF+Pyb
 ZNjHxNbo19ZC2pzs=
X-Received: by 2002:a5d:690e:: with SMTP id t14mr36043384wru.65.1576583893073; 
 Tue, 17 Dec 2019 03:58:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzT6qjkim6HB1Mt2HQJa48HwVI0wsbN9dC3HsAS9/DnAFSsM1dMRvXnQ/PS81y0RcFfZHHrBw==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr36043354wru.65.1576583892779; 
 Tue, 17 Dec 2019 03:58:12 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:1c42:ed63:2256:4add?
 ([2a01:e0a:466:71c0:1c42:ed63:2256:4add])
 by smtp.gmail.com with ESMTPSA id q15sm25194281wrr.11.2019.12.17.03.58.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Dec 2019 03:58:12 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] memory: Do not allow subregion out of the parent region
 range
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <4a07cc6f-8762-145e-2b54-c61b0e287f19@redhat.com>
Date: Tue, 17 Dec 2019 12:58:11 +0100
Message-Id: <127AF076-D309-4952-B572-52587A93F46A@redhat.com>
References: <20191214160223.20012-1-philmd@redhat.com>
 <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
 <92bb8e12-3ece-9811-438b-8fa64d2bde66@redhat.com>
 <4a07cc6f-8762-145e-2b54-c61b0e287f19@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: pakaXeAwMsCgCHv3xfXi0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 17 Dec 2019, at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 16/12/19 18:46, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>=20
>>>=20
>>> I think in some cases this could be intentional, for example if you hav=
e
>>> different models with different BAR sizes and you organize this with th=
e
>>> same tree of MemoryRegion and different sizes for the parent.
>>=20
>> But if a child is outside of the parent range, it can't be reached,
>> right? I'm confused, maybe AddressSpace can do that, but MemoryRegion
>> shouldn't?
>=20
> Yes, the idea is that you could have for one version of the device
>=20
>   parent 0x000-0x7ff
>     stuff 0x000-0x3ff
>     morestuff 0x400-0x7ff
>=20
> and for another
>=20
>   parent 0x000-0x3ff
>     stuff 0x000-0x3ff
>     morestuff 0x400-0x7ff
>=20
> where parent is the BAR, and you can share the code to generate the tree
> underneath parent.

I can see why you would have code reuse reasons to do that,
but frankly it looks buggy and confusing. In the rare cases
where this is indented, maybe add a flag making it explicit?

>=20
>> In the PCI case, you will simply alias a subregion with
>> memory_region_init_alias(..., size), and size has to be <=3D parent size=
.
>> But you won't add the PCI region, you'll add the alias, so the assert
>> won't fire.
>=20
> Yes, this is a workaround though.  You shouldn't need the alias.
>=20
> I can see a case for your patch but I can also see one for the current
> behavior...
>=20
> Paolo
>=20
>=20


