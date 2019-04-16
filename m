Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BC9C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C832073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C832073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGK4A-0000rU-78
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 05:07:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGK2r-00008x-UH
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGK2q-00013w-0Y
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:06:25 -0400
Received: from [110.188.70.11] (port=31148 helo=spam1.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hGK2p-0000wS-9t
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:06:23 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
	by spam1.hygon.cn with ESMTP id x3G95Vl4001700;
	Tue, 16 Apr 2019 17:05:31 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
	by MK-FE.hygon.cn with ESMTP id x3G94sQ2023199;
	Tue, 16 Apr 2019 17:04:54 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from [172.20.20.110] (172.23.18.44) by cncheex02.Hygon.cn
	(172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3;
	Tue, 16 Apr 2019 17:05:26 +0800
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415092500.GD5718@redhat.com>
	<aa92336f-681e-30d9-2670-7d0093d9912a@hygon.cn>
	<20190416081804.GC31311@redhat.com>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <8622eb20-ed78-fcc8-4e24-f9b8333af381@hygon.cn>
Date: Tue, 16 Apr 2019 17:04:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416081804.GC31311@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex02.Hygon.cn
	(172.23.18.12)
X-MAIL: spam1.hygon.cn x3G95Vl4001700
X-DNSRBL: 
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by spam1.hygon.cn id
	x3G95Vl4001700
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 110.188.70.11
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416090436.0xs0vHRzIqYo1c4oOfFpChv6S-Bl0he1U-vesf2Calw@z>

On 2019/4/16 16:19, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 16, 2019 at 02:56:12PM +0800, Pu Wen wrote:
>> On 2019/4/15 17:25, Daniel P. Berrang=C3=A9 wrote:
>>> On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
>>>> @@ -152,6 +154,7 @@ GlobalProperty pc_compat_2_12[] =3D {
>>>>        { TYPE_X86_CPU, "topoext", "off" },
>>>>        { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>>>        { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>>> +    { "Dhyana-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>>>    };
>>>>    const size_t pc_compat_2_12_len =3D G_N_ELEMENTS(pc_compat_2_12);
>>>
>>> You can drop the changes in this file. This CPU model didn't exist
>>> in any older QEMU releases, so there's no machine type backcompat
>>> required, at least from upstream QEMU POV.
>>
>> Then how about running QEMU with the parameter like "-M pc-i440fx-2.12=
"?
>> Although the default machine is newer than that.
>=20
> That doesnt matter.  This back-compat property table is about ensuring
> that "-cpu Skylake-Client -M pc-i440fx-2.12" run on QEMU 4.0.0 release
> works the same way as when run on QEMU 2.12.0 release.
>=20
> Since there is no Dhyana CPU model in QEMU 2.12.0 release, there's no
> back compat issue to fix.

Thanks for the explanation. Will drop the changes in next version patch.

--=20
Regards,
Pu Wen

