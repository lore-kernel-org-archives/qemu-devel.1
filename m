Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D42CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5765F206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCjfW8aT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5765F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwogR-0006um-GA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 09:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwofQ-0006B0-UE
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwofL-0001B6-2o
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:50:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwofK-00018S-OI
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580309402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1QRuEfeMGsBpUXzLPpobVgCXhvt97OcpaxvHkpqgh7Y=;
 b=HCjfW8aT6QTM2Vk++w6w5FT7AgIDyaj3ey8OV3Fowg39zlAj8DvOLtIHqaLkF19PrWjEAl
 r/cxCT1WcZDLlWcQdGULjVmDaH82Q1WSLwf9Hqz0P5YmaVxS2OFN3t/2M+o1KC4j5ezllp
 8IpSN4Cz8hCeNxgxpuiO119PJATIBnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-qWug86llO52lUpmqqBkjjw-1; Wed, 29 Jan 2020 09:49:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 307638A2437;
 Wed, 29 Jan 2020 14:49:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 398B019756;
 Wed, 29 Jan 2020 14:49:54 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200124170325.30072-1-thuth@redhat.com>
 <555bf60c-0d72-3ea3-f095-8c6c7a621deb@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <300bbdee-004a-9d1a-3692-f32793d44523@redhat.com>
Date: Wed, 29 Jan 2020 15:49:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <555bf60c-0d72-3ea3-f095-8c6c7a621deb@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qWug86llO52lUpmqqBkjjw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/01/2020 18.31, Wainer dos Santos Moschetta wrote:
>=20
> On 1/24/20 3:03 PM, Thomas Huth wrote:
>> The 2018 edition of the QEMU advent calendar 2018 featured Linux images
>> for various non-x86 machines. We can use them for a boot tests in our
>> acceptance test suite.
>>
>> Let's also make sure that we build the corresponding machines in Travis,
>> and while we're there, drop the superfluous --python parameter (python3
>> is now the only supported version anyway).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
[...]
>> +=C2=A0=C2=A0=C2=A0 def test_ppc_g3beige(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:ppc
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:g3b=
eige
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tar_hash =3D 'e0b872a5eb8fdc=
5bed19bd43ffe863900ebcedfc'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-M', 'grap=
hics=3Doff')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.do_test_advcal_2018('15=
', tar_hash, 'invaders.elf')
>=20
> Hi Thomas, let me check one thing...
>=20
> The VM will be launched as:
>=20
> ----
>=20
> ppc-softmmu/qemu-system-ppc -display none -vga none -chardev
> socket,id=3Dmon,path=3D/tmp/tmpvdokyvs3/qemu-41146-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -machine g3beige -chardev
> socket,id=3Dconsole,path=3D/tmp/tmpvdokyvs3/qemu-41146-console.sock,serve=
r,nowait
> -serial chardev:console -M graphics=3Doff -kernel
> /tmp/avocado_g3uccfo5/avocado_job_61gglyz3/02-tests_acceptance_boot_linux=
_console.py_BootLinuxConsole.test_ppc_g3beige/day15/invaders.elf
>=20
>=20
> ----
>=20
> Note that it passes '[..] -machine g3beige [...] -M graphics=3Doff [...]'=
.
> I suspect you wanted '-machine g3beige,graphics=3Doff'. am I right?

No, the -M graphics=3Doff was intended.

> or
> QEMU will interpret the -M option as a parameter of the already set
> machine type?

That's exactly the case.

> or the -M overwrites -machine, and because=C2=A0 g3beige is the
> default type it just works?

No, the default machine of qemu-system-ppc is mac99.

And just to make sure that the g3beige test is really running with a G3
and not a G4 (i.e. mac99):

$ avocado --show=3Dconsole run
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_ppc_g3beige
| grep motherboard
console: PowerMac motherboard: PowerMac G3 (Silk)

 Thomas


