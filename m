Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA8C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C05D20818
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C05D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVlQ-0001G9-Gq
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:38:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQVb4-0002SQ-Ee
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hQVb3-0006XK-3e
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:27:50 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:50973)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hQVb2-0006VZ-TT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:27:49 -0400
Received: from player779.ha.ovh.net (unknown [10.108.57.43])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 0BEDFFA29D
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:27:45 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
	(Authenticated sender: clg@kaod.org)
	by player779.ha.ovh.net (Postfix) with ESMTPSA id F175A5A0F6B1;
	Tue, 14 May 2019 11:27:37 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190514064627.3838-1-clg@kaod.org>
	<CAFEAcA__w9ZXzvAVemstba1=tU6rpKn73m8E5+vJQaArkZzzVw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2245e3b0-7573-60f5-7a22-9140b909f74f@kaod.org>
Date: Tue, 14 May 2019 13:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__w9ZXzvAVemstba1=tU6rpKn73m8E5+vJQaArkZzzVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11975352887614409685
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleeigdegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.51.249
Subject: Re: [Qemu-devel] [PATCH] docs: provide documentation on the POWER9
 XIVE interrupt controller
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 11:17 AM, Peter Maydell wrote:
> On Tue, 14 May 2019 at 07:46, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> This documents the overall XIVE architecture and gives an overview of
>> the QEMU models. It also provides documentation on the 'info pic'
>> command.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  docs/index.rst     |   1 +
>>  docs/ppc/index.rst |  13 ++
>>  docs/ppc/xive.rst  | 344 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  MAINTAINERS        |   1 +
>>  4 files changed, 359 insertions(+)
>>  create mode 100644 docs/ppc/index.rst
>>  create mode 100644 docs/ppc/xive.rst
>=20
> Hi -- it's great to see this documentation. Unfortunately,
> where you've put it doesn't match our intended layout for docs.

OK. I guess I need to split the file in multiple parts.
=20
> Each subdirectory of docs/ becomes its own manual, and
> the intention is to eventually have five manuals
> (as sketched out in https://wiki.qemu.org/Features/Documentation):
>  * QEMU user mode emulation -- docs/user
>  * QEMU full-system emulation user's guide -- docs/system

Should we put the documentation of machine options under this directory ?=
=20

>  * QEMU full-system emulation management and interoperability guide --
> docs/interop

There, I could put the 'info pic' documentation.

>  * QEMU full-system emulation guest hardware specifications  -- docs/sp=
ecs

and there, the low level information on the XIVE controller.

>  * QEMU developer's guide -- docs/devel

and finally, there, some of the documentation on QEMU modeling. =20

> We don't want to have a separate PPC-specific manual.

OK.

> Currently we only have interop and devel. I have on
> my todo list to try to sort out the others, including
> figuring out how to transition from our current set
> of texinfo-based manuals to this layout.
>=20
> I'm not sure exactly where this document should live.
> From a quick scan it appears to be mixing together
> information aimed at several different audiences --
> the "Overview of the QEMU models for XIVE" part looks
> like information about QEMU internals which belongs
> in docs/devel, but some other parts seem to be user
> facing information which should go in one of the
> other manuals.

What is nice about the single file model is that you find all=20
the information related to one topic in one place.=20

Can manuals reference each another ?=20

Thanks,

C.=20

