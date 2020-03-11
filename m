Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA26DC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C0C20828
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID3LIYB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C0C20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBxhN-00019f-HX
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jBxgh-0000XO-TR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jBxgg-0000WQ-4Y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:30:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jBxgg-0000Sy-0N
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583918990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ix9LwiKc2VbnbLgLL58Tn9BHzYsE3/SmD8MGOyWV27c=;
 b=ID3LIYB1/By6Iv/cwPtVWV4wPQv5hIW3Ziy6Zul6WO74IdOIrQNvWqFwXm5g5xFkraWAk1
 3dBPmfXGKLJPAjukq0HUEQNR5/p3x/rIOrVTbEEzidZJmLBG3vb7aF+Q5qmPy38cfnOgU8
 TVGXNRYp9MXzg7jsjG8D3FWCYkrb0TI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-1aNQM2RzMpOmBJtH5jZ7oQ-1; Wed, 11 Mar 2020 05:29:46 -0400
X-MC-Unique: 1aNQM2RzMpOmBJtH5jZ7oQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5543A19057A2;
 Wed, 11 Mar 2020 09:29:44 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61EAD91844;
 Wed, 11 Mar 2020 09:29:38 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v5 06/13] arm/arm64: ITS: Introspection
 tests
To: Zenghui Yu <yuzenghui@huawei.com>, eric.auger.pro@gmail.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-7-eric.auger@redhat.com>
 <83ffda30-e0dc-7fbf-1775-bc45a308acb4@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7fc207fe-b761-6d24-0c14-896154023420@redhat.com>
Date: Wed, 11 Mar 2020 10:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <83ffda30-e0dc-7fbf-1775-bc45a308acb4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: andre.przywara@arm.com, drjones@redhat.com, alexandru.elisei@arm.com,
 thuth@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zenghui,

On 3/11/20 9:37 AM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2020/3/10 22:54, Eric Auger wrote:
>> +#define GITS_TYPER_PLPIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0)
>> +#define GITS_TYPER_VLPIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BI=
T(1)
>> +#define GITS_TYPER_ITT_ENTRY_SIZE=C2=A0=C2=A0=C2=A0 GENMASK_ULL(7, 4)
>> +#define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT=C2=A0=C2=A0=C2=A0 4
>> +#define GITS_TYPER_IDBITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 G=
ENMASK_ULL(8, 12)
>=20
> Note that this should be GENMASK_ULL(12, 8).
definitively

Eric
>=20
>> +#define GITS_TYPER_IDBITS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 8
>> +#define GITS_TYPER_DEVBITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
GENMASK_ULL(13, 17)
>=20
> (17, 13)
>=20
>> +#define GITS_TYPER_DEVBITS_SHIFT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 13
>> +#define GITS_TYPER_PTA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(19)
>> +#define GITS_TYPER_CIDBITS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
GENMASK_ULL(32, 35)
>=20
> (35, 32)
>=20
>> +#define GITS_TYPER_CIDBITS_SHIFT=C2=A0=C2=A0=C2=A0 32
>> +#define GITS_TYPER_CIL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BIT(36)
>=20
> And please use tab for all of them.
>=20
>=20
> Thanks,
> Zenghui
>=20


