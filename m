Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D5C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8DE208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JV6IWhik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8DE208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4UuC-0003HH-HY
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 14:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j4UtY-0002rU-OH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j4UtX-0002eK-Cg
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:20:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j4UtW-0002df-L5
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582140026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03HFi2egQ0pHjLpU1GgjQSG6P/eisCpO25IAgvUlyNc=;
 b=JV6IWhik3cXeTL9evgzrQ7oA4neznj4b42rQSOHpTUSfTHA53Yuo+uVqqthzs4LD8XvmQC
 9C470Y96a9jDCXY+aNXtC+q/pZVdsrbKZpF4yvyQfKG9hnZUmrjSBjYUYubD1esO6IpE9e
 ADgXjz7xv4B+XboLLq/GdIGN7DhJNUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-LctP8eKxPYqIF7aUx9DSnA-1; Wed, 19 Feb 2020 14:20:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0E59800D4E;
 Wed, 19 Feb 2020 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-92.gru2.redhat.com
 [10.97.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4048E5C554;
 Wed, 19 Feb 2020 19:20:07 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] tests/boot_linux_console: add BIOS acceptance test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net, Cleber Rosa <crosa@redhat.com>
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-3-git-send-email-liam.merwick@oracle.com>
 <e7db8848-b8fb-94ff-a229-779b532c5e18@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <f610e44e-57d8-cfb2-efd1-f567136bf416@redhat.com>
Date: Wed, 19 Feb 2020 16:20:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e7db8848-b8fb-94ff-a229-779b532c5e18@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: LctP8eKxPYqIF7aUx9DSnA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/6/20 12:12 PM, Philippe Mathieu-Daud=E9 wrote:
> On 2/5/20 3:56 PM, Liam Merwick wrote:
>> Add a test to use qboot with the 'pc' machine class and SeaBIOS with
>> the 'microvm' machine class (since microvm uses qboot by default) by
>> adding the '-bios' option via self.vm.add_args() before
>> calling do_test_x86_64_machine().
>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> =A0 tests/acceptance/boot_linux_console.py | 17 ++++++++++++++++-
>> =A0 1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py=20
>> b/tests/acceptance/boot_linux_console.py
>> index 233601b429bd..e9375590bc1c 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -61,7 +61,6 @@ class BootLinuxConsole(Test):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '/=
vmlinuz')
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_hash =3D '23bebd2680757891cf7adedb033=
532163a792495'
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.fetch_asset(kernel_url,=
=20
>> asset_hash=3Dkernel_hash)
>> -
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.vm.set_console()
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_command_line =3D self.KERNEL_COMMON_C=
OMMAND_LINE +=20
>> 'console=3DttyS0'
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.vm.add_args('-kernel', kernel_path,
>> @@ -77,6 +76,14 @@ class BootLinuxConsole(Test):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>> =A0 +=A0=A0=A0 def test_x86_64_pc_qboot(self):
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 self.vm.add_args('-bios', 'pc-bios/bios-microvm.b=
in')

The test boots QEMU with bios file from $PWD/pc-bios/bios-microvm.bin.=20
If you want to get (optionally) the file from an installed QEMU you=20
could use Avocado test parameters [1]. Here goes an example:

self.vm.add_args('-bios', self.params.get('bios_microvm',=20
default=3D'pc-bios/bios-microvm.bin'))

Then you evoke avocado as:

$ avocado run -p bios_microvm=3D/usr/share/qemu/bios-microvm.bin (...)

[1]=20
https://avocado-framework.readthedocs.io/en/75.1/guides/writer/chapters/par=
ameters.html


>>
>
> This breaks running once QEMU is installed:
>
> =A0(2/4)=20
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc_qb=
oot:
> qemu: could not load PC BIOS 'pc-bios/bios-microvm.bin'
> ERROR: [Errno 104] Connection reset by peer (0.08 s)
>
> Cleber, Wainer, what path should we use?


Philippe, above answers your question?

Thanks,

- Wainer

>
>
>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>> +
>> =A0=A0=A0=A0=A0 def test_x86_64_microvm(self):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>> @@ -84,6 +91,14 @@ class BootLinuxConsole(Test):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>> =A0 +=A0=A0=A0 def test_x86_64_microvm_seabios(self):
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:microvm
>> +=A0=A0=A0=A0=A0=A0=A0 """
>> +=A0=A0=A0=A0=A0=A0=A0 self.vm.add_args('-bios', 'pc-bios/bios.bin')
>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>> +
>> =A0=A0=A0=A0=A0 def test_mips_malta(self):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:mips
>>
>


