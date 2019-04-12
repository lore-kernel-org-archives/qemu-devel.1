Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DFAC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E6E2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E6E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyO8-0000Wf-HL
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 11:46:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hEyMZ-0007T2-EG
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hEyMY-0005N5-GE
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:45:11 -0400
Received: from [110.188.70.11] (port=9251 helo=spam2.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hEyMX-0005HU-1X
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:45:10 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
	by spam2.hygon.cn with ESMTP id x3CFinSr024045;
	Fri, 12 Apr 2019 23:44:49 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from cncheex02.Hygon.cn ([172.23.18.12])
	by MK-FE.hygon.cn with ESMTP id x3CFiJXm095632;
	Fri, 12 Apr 2019 23:44:19 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
Received: from [192.168.1.193] (172.23.18.44) by cncheex02.Hygon.cn
	(172.23.18.12) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3;
	Fri, 12 Apr 2019 23:44:46 +0800
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1555072669-20441-1-git-send-email-puwen@hygon.cn>
	<20190412132420.GM25308@redhat.com>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <084d8178-4fb2-6cda-aac9-90ab2ed9ce69@hygon.cn>
Date: Fri, 12 Apr 2019 23:44:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412132420.GM25308@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex02.Hygon.cn
	(172.23.18.12)
X-MAIL: spam2.hygon.cn x3CFinSr024045
X-DNSRBL: 
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by spam2.hygon.cn id
	x3CFinSr024045
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 110.188.70.11
Subject: Re: [Qemu-devel] [PATCH RFC] i386: Add new Hygon 'Dhyana' and
 'Dhyana-IBPB' CPU models
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"rth@twiddle.net" <rth@twiddle.net>, "mst@redhat.com" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412154445.szHEdJIUPrIRk6_qPxs25XoWAr14-OfR9hrHdNFok7Y@z>

On 2019/4/12 21:25, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Apr 12, 2019 at 08:37:49PM +0800, Pu Wen wrote:
>> Add two new base CPU models called 'Dhyana' and 'Dhyana-IBPB' to model
>> processors from Hygon Dhyana (family 18h), which derived from AMD EPYC
>> (family 17h). 'Dhyana-IBPB' is a copy of the 'Dhyana' CPU model with
>> just CPUID_8000_0008_EBX_IBPB added.
...
> The Google results I see suggest that Dhyana CPUs started to become
> available in July 2018, so surely they would come with microcode
> that has the IBPB right from day 1 ?

Yes, you are right. Dhyana CPUs already have the IBPB feature.

> Am I missing anything that means there will be a compelling need
> to support Dhyana /without/ IBPB ?
>=20
> If not, then we only need 1 CPU model and that would include IBPB.

Okay, will only keep one CPU model which include IBPB by using the name=20
'Dhyana'.

Thx.

--=20
Regards,
Pu Wen

