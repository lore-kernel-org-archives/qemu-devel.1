Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF9EC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD4B2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD4B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60333 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGI3J-0006mV-83
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 02:58:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGI2X-0006Tc-2V
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGI2U-0006GM-9a
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:57:56 -0400
Received: from [110.188.70.11] (port=25496 helo=spam2.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hGI2Q-00066z-GP
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:57:52 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
	by spam2.hygon.cn with ESMTP id x3G6v5vb051875;
	Tue, 16 Apr 2019 14:57:06 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
	by MK-FE.hygon.cn with ESMTP id x3G6uVNf013018;
	Tue, 16 Apr 2019 14:56:31 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from [172.20.20.110] (172.23.18.44) by cncheex02.Hygon.cn
	(172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3;
	Tue, 16 Apr 2019 14:57:03 +0800
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415092500.GD5718@redhat.com>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <aa92336f-681e-30d9-2670-7d0093d9912a@hygon.cn>
Date: Tue, 16 Apr 2019 14:56:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415092500.GD5718@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex02.Hygon.cn
	(172.23.18.12)
X-MAIL: spam2.hygon.cn x3G6v5vb051875
X-DNSRBL: 
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by spam2.hygon.cn id
	x3G6v5vb051875
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
Message-ID: <20190416065612.-MsppJvYz3H9tbOBfrv157iIlYt4L-hSinvQsy4pQx0@z>

On 2019/4/15 17:25, Daniel P. Berrang=C3=A9 wrote:
> On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
...
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f2c15bf..551bec9 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -128,6 +128,8 @@ GlobalProperty pc_compat_3_1[] =3D {
>>       { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
>>       { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
>>       { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
>> +    { "Dhyana" "-" TYPE_X86_CPU, "npt", "off" },
>> +    { "Dhyana" "-" TYPE_X86_CPU, "nrip-save", "off" },
>>       { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
>>       { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
>>       { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
>> @@ -152,6 +154,7 @@ GlobalProperty pc_compat_2_12[] =3D {
>>       { TYPE_X86_CPU, "topoext", "off" },
>>       { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>       { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>> +    { "Dhyana-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>   };
>>   const size_t pc_compat_2_12_len =3D G_N_ELEMENTS(pc_compat_2_12);
>=20
> You can drop the changes in this file. This CPU model didn't exist
> in any older QEMU releases, so there's no machine type backcompat
> required, at least from upstream QEMU POV.

Then how about running QEMU with the parameter like "-M pc-i440fx-2.12"?=20
Although the default machine is newer than that.

--=20
Regards,
Pu Wen

