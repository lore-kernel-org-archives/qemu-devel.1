Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF48C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3176C206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT7Jxph7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3176C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix513-0001E1-Ee
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 03:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ix50J-0000Yg-7V
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ix50I-00021L-1g
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:16:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ix50H-0001vF-U3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 03:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580372203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=55gRiVY249a8gB9tdbRJgB2G1/jbeYVGA9wu95vEH0Y=;
 b=gT7Jxph7jpMTlTxTDEqdkLRX1fLcV3u8TTdm+9wjzbcV/WlT0xEJ758+z94Xis0ecFTC1T
 yDlR84Jk6hkcdDeb1zwYLjKoVslBW5Q/RWpqzbnWjPytuhjnoWfEBaCji7AfgPg7OfUGOP
 19cydjSnI2sC2vAscZB+v0fAJxVBR48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-saG3oYp5N4uvT29pJ-ZbnA-1; Thu, 30 Jan 2020 03:16:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 939C2DBAE;
 Thu, 30 Jan 2020 08:16:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-117.ams2.redhat.com [10.36.117.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E31687B00;
 Thu, 30 Jan 2020 08:16:33 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200124170325.30072-1-thuth@redhat.com>
 <555bf60c-0d72-3ea3-f095-8c6c7a621deb@redhat.com>
 <300bbdee-004a-9d1a-3692-f32793d44523@redhat.com>
 <alpine.BSF.2.22.395.2001291841260.40686@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <133b09ed-78f7-e280-f603-18e616a00979@redhat.com>
Date: Thu, 30 Jan 2020 09:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2001291841260.40686@zero.eik.bme.hu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: saG3oYp5N4uvT29pJ-ZbnA-1
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
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/2020 18.48, BALATON Zoltan wrote:
> On Wed, 29 Jan 2020, Thomas Huth wrote:
>> On 27/01/2020 18.31, Wainer dos Santos Moschetta wrote:
>>> On 1/24/20 3:03 PM, Thomas Huth wrote:
>>>> The 2018 edition of the QEMU advent calendar 2018 featured Linux image=
s
>>>> for various non-x86 machines. We can use them for a boot tests in our
>>>> acceptance test suite.
>>>>
>>>> Let's also make sure that we build the corresponding machines in
>>>> Travis,
>>>> and while we're there, drop the superfluous --python parameter (python=
3
>>>> is now the only supported version anyway).
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>> [...]
>>>> +=C2=A0=C2=A0=C2=A0 def test_ppc_g3beige(self):
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:ppc
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:g=
3beige
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tar_hash =3D 'e0b872a5eb8f=
dc5bed19bd43ffe863900ebcedfc'
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-M', 'gr=
aphics=3Doff')
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.do_test_advcal_2018('=
15', tar_hash, 'invaders.elf')
>>>
>>> Hi Thomas, let me check one thing...
>>>
>>> The VM will be launched as:
>>>
>>> ----
>>>
>>> ppc-softmmu/qemu-system-ppc -display none -vga none -chardev
>>> socket,id=3Dmon,path=3D/tmp/tmpvdokyvs3/qemu-41146-monitor.sock -mon
>>> chardev=3Dmon,mode=3Dcontrol -machine g3beige -chardev
>>> socket,id=3Dconsole,path=3D/tmp/tmpvdokyvs3/qemu-41146-console.sock,ser=
ver,nowait
>>>
>>> -serial chardev:console -M graphics=3Doff -kernel
>>> /tmp/avocado_g3uccfo5/avocado_job_61gglyz3/02-tests_acceptance_boot_lin=
ux_console.py_BootLinuxConsole.test_ppc_g3beige/day15/invaders.elf
>>>
>>>
>>>
>>> ----
>>>
>>> Note that it passes '[..] -machine g3beige [...] -M graphics=3Doff [...=
]'.
>>> I suspect you wanted '-machine g3beige,graphics=3Doff'. am I right?
>>
>> No, the -M graphics=3Doff was intended.
>>
>>> or
>>> QEMU will interpret the -M option as a parameter of the already set
>>> machine type?
>>
>> That's exactly the case.
>>
>>> or the -M overwrites -machine, and because=C2=A0 g3beige is the
>>> default type it just works?
>>
>> No, the default machine of qemu-system-ppc is mac99.
>=20
> I think you're wrong about the default machine type:
>=20
> $ qemu-system-ppc -M help
> Supported machines are:
> 40p=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IBM RS/6000 7020 (40p)
> bamboo=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bamboo
> g3beige=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Heathrow based PowerMAC (default)
>=20
> g3beige is marked as default and seems to be created without any -M
> option

Oops, thanks, I stand corrected.

 Thomas


