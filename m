Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B20C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4213A2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbxYgJMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4213A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j16IH-0002tL-F4
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 05:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1j16Hf-0002Cd-UT
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1j16Hd-0000Pl-SW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:27:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20504
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1j16Hd-0000Oz-Ks
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581330436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3I1JFY4Uk5ZJJe8bsZVXIweUHXgN2+/GrubmWyn6ecU=;
 b=hbxYgJMBripsLTe8ywiodB+5j4TDjK3xIGP0vN/u8p6LKWzF/2vuPI5AMB/6VUrOFDrNqx
 ty37jYEo6Pfob7lG/CuzhkE+KfytNiaQ8eE96y7H3LtvCMu8PAlGUHDY+qhZwg/UB8kq6m
 TUqOY2khOiF5aloXIDEgB1Zr1w3gBLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-gvisQ3hQOLWKGW1cKue-RQ-1; Mon, 10 Feb 2020 05:27:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC56213EA;
 Mon, 10 Feb 2020 10:27:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-219.ams2.redhat.com [10.36.116.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B4828ED0B;
 Mon, 10 Feb 2020 10:26:54 +0000 (UTC)
Subject: Re: Tricore default machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200207161948.15972-1-philmd@redhat.com>
 <20200207161948.15972-2-philmd@redhat.com>
 <9590e020-226d-bc85-e496-95b4f0116f69@redhat.com>
 <e4157357-7697-a2d5-8662-f5bd12d74619@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f7b72c47-4202-d220-7b29-bd5ad6283700@redhat.com>
Date: Mon, 10 Feb 2020 11:26:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e4157357-7697-a2d5-8662-f5bd12d74619@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: gvisQ3hQOLWKGW1cKue-RQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/02/2020 11.08, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/10/20 10:35 AM, Thomas Huth wrote:
>> On 07/02/2020 17.19, Philippe Mathieu-Daud=C3=A9 wrote:
>>> The MachineClass is already zeroed on creation.
>>>
>>> Note: The code setting is_default=3D0 in hw/i386/pc_piix.c is
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 different (related to compat optio=
ns). When adding a
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new versioned machine, we want it =
to be the new default,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 so we have to mark the previous on=
e as not default.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> v3: new patch
>>> ---
>>> =C2=A0 hw/lm32/lm32_boards.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>> =C2=A0 hw/lm32/milkymist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>> =C2=A0 hw/m68k/q800.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1 -
>>> =C2=A0 hw/microblaze/petalogix_ml605_mmu.c | 1 -
>>> =C2=A0 hw/tricore/tricore_testboard.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
 -
>>> =C2=A0 5 files changed, 5 deletions(-)
>> [...]
>>> diff --git a/hw/tricore/tricore_testboard.c
>>> b/hw/tricore/tricore_testboard.c
>>> index 20c9ccb3ce..8ec2b5bddd 100644
>>> --- a/hw/tricore/tricore_testboard.c
>>> +++ b/hw/tricore/tricore_testboard.c
>>> @@ -105,7 +105,6 @@ static void ttb_machine_init(MachineClass *mc)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->desc =3D "a minimal TriCore board";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->init =3D tricoreboard_init;
>>> -=C2=A0=C2=A0=C2=A0 mc->is_default =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->default_cpu_type =3D TRICORE_CPU_TYP=
E_NAME("tc1796");
>>> =C2=A0 }
>>
>> I wonder whether we should simply make that machine the default for
>> qemu-system-tricore? There is only one machine here, and not having a
>> default machine always causes some headaches in the tests...
>> (see e.g. tests/qemu-iotests/check for example)
>=20
> Or make it generic? If a architecture has a single machine, use it by
> default?

Sounds like a good idea, too ... we've got a couple of targets that have
only one machine.

 Thomas


