Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A5C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88331217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88331217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCJZ9-00032g-CI
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 03:47:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hCJYE-0002Ln-90
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hCJYD-0000FB-5g
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:46:14 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:45095
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hCJYC-00005B-RM
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:46:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 53B2B8139B;
	Fri,  5 Apr 2019 09:46:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2mlCEcAkf7wP; Fri,  5 Apr 2019 09:46:08 +0200 (CEST)
Received: from localhost.localdomain
	(lfbn-tou-1-152-179.w86-201.abo.wanadoo.fr [86.201.234.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id 3BC018139A;
	Fri,  5 Apr 2019 09:46:06 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-4-marcandre.lureau@redhat.com>
	<08893010-9018-65df-bbcc-56796bba5062@adacore.com>
	<CAMxuvazK7YcFm0fORScBfcv+=_kqbexvU5Dvwke8fb8uFkY-eg@mail.gmail.com>
	<c1d595db-dcc1-0742-0771-3ed6c6195932@adacore.com>
Message-ID: <bd3c7dd1-0f2f-150e-020a-647514867c2b@adacore.com>
Date: Fri, 5 Apr 2019 09:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c1d595db-dcc1-0742-0771-3ed6c6195932@adacore.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: Re: [Qemu-devel] [PATCH 3/9] chardev: use a child source for qio
 input source
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
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	"Armbruster, Markus" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405074604.beCQAb9ZANMabTIcs1MQOoZy81tBSr3SaTb3r6jzbdU@z>

Hi Marc,

I did more experiments.. It seems to be an issue in glib-2.44.1 which is =
quite
old. I updated and it seems I don't see the issue anymore.

Thanks for your input on this!

Cheers,
Fred

Le 4/4/19 =C3=A0 5:49 PM, KONRAD Frederic a =C3=A9crit=C2=A0:
>=20
>=20
> Le 4/4/19 =C3=A0 5:44 PM, Marc-Andr=C3=A9 Lureau a =C3=A9crit=C2=A0:
>> Hi
>>
>> On Thu, Apr 4, 2019 at 5:18 PM KONRAD Frederic
>> <frederic.konrad@adacore.com> wrote:
>>>
>>> Hi guys,
>>>
>>> We have some random delays with gdbstub since this commit under Windo=
ws.
>>> Basically while debugging the next command can sometimes take more th=
an 5
>>> seconds while it usually tooks 30ms before. It is not target dependen=
t I see
>>> that happening with sparc, ppc, riscv, etc.. but only on Windows host=
.
>>>
>>> Does that ring a bell?
>>
>> No, is this with a socket chardev or other kind?
>=20
> It's connecting through the TCP socket. '-s -S' option.
>=20
>>
>> Could you check the chardev behaviour with the HMP monitor for ex:
>> qemu -chardev socket,id=3Dfoo,server,host=3Dlocalhost,port=3D9999 -mon=
itor chardev:foo
>>
>> Is this also taking a few seconds to reply?
>>
>> Have you checked running tests/test-char on windows? Is this also
>> taking long (>2sec)?
>=20
> I'll try to test that.
>=20
> Thanks!
> Fred
>=20

