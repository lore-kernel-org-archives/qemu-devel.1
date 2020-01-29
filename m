Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8671C35240
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C1020720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 17:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C1020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwrSt-0002Qv-RH
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 12:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iwrSJ-0001pZ-8R
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iwrSI-00049c-7o
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 12:48:47 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:14814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1iwrSE-0003vn-Rr; Wed, 29 Jan 2020 12:48:43 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E86E6747D5D;
 Wed, 29 Jan 2020 18:48:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 697A1747871; Wed, 29 Jan 2020 18:48:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 677437476D5;
 Wed, 29 Jan 2020 18:48:32 +0100 (CET)
Date: Wed, 29 Jan 2020 18:48:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
In-Reply-To: <300bbdee-004a-9d1a-3692-f32793d44523@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2001291841260.40686@zero.eik.bme.hu>
References: <20200124170325.30072-1-thuth@redhat.com>
 <555bf60c-0d72-3ea3-f095-8c6c7a621deb@redhat.com>
 <300bbdee-004a-9d1a-3692-f32793d44523@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1156086865-1580320112=:40686"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1156086865-1580320112=:40686
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jan 2020, Thomas Huth wrote:
> On 27/01/2020 18.31, Wainer dos Santos Moschetta wrote:
>> On 1/24/20 3:03 PM, Thomas Huth wrote:
>>> The 2018 edition of the QEMU advent calendar 2018 featured Linux imag=
es
>>> for various non-x86 machines. We can use them for a boot tests in our
>>> acceptance test suite.
>>>
>>> Let's also make sure that we build the corresponding machines in Trav=
is,
>>> and while we're there, drop the superfluous --python parameter (pytho=
n3
>>> is now the only supported version anyway).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
> [...]
>>> +=C2=A0=C2=A0=C2=A0 def test_ppc_g3beige(self):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:ppc
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:=
g3beige
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tar_hash =3D 'e0b872a5eb8=
fdc5bed19bd43ffe863900ebcedfc'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-M', 'g=
raphics=3Doff')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.do_test_advcal_2018(=
'15', tar_hash, 'invaders.elf')
>>
>> Hi Thomas, let me check one thing...
>>
>> The VM will be launched as:
>>
>> ----
>>
>> ppc-softmmu/qemu-system-ppc -display none -vga none -chardev
>> socket,id=3Dmon,path=3D/tmp/tmpvdokyvs3/qemu-41146-monitor.sock -mon
>> chardev=3Dmon,mode=3Dcontrol -machine g3beige -chardev
>> socket,id=3Dconsole,path=3D/tmp/tmpvdokyvs3/qemu-41146-console.sock,se=
rver,nowait
>> -serial chardev:console -M graphics=3Doff -kernel
>> /tmp/avocado_g3uccfo5/avocado_job_61gglyz3/02-tests_acceptance_boot_li=
nux_console.py_BootLinuxConsole.test_ppc_g3beige/day15/invaders.elf
>>
>>
>> ----
>>
>> Note that it passes '[..] -machine g3beige [...] -M graphics=3Doff [..=
.]'.
>> I suspect you wanted '-machine g3beige,graphics=3Doff'. am I right?
>
> No, the -M graphics=3Doff was intended.
>
>> or
>> QEMU will interpret the -M option as a parameter of the already set
>> machine type?
>
> That's exactly the case.
>
>> or the -M overwrites -machine, and because=C2=A0 g3beige is the
>> default type it just works?
>
> No, the default machine of qemu-system-ppc is mac99.

I think you're wrong about the default machine type:

$ qemu-system-ppc -M help
Supported machines are:
40p                  IBM RS/6000 7020 (40p)
bamboo               bamboo
g3beige              Heathrow based PowerMAC (default)

g3beige is marked as default and seems to be created without any -M optio=
n=20
but having two -M options e.g. -M mac99 -M graphics=3Doff creates mac99=20
machine so multiple options seem to work as you described.

Regards,
BALATON Zoltan
--3866299591-1156086865-1580320112=:40686--

