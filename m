Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB3C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839CB206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sy4VKKQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839CB206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4UdF-0005wH-N7
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 14:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j4Ucf-0005UW-26
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j4Ucd-0002Q3-3A
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:03:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38387
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j4Ucc-0002LR-VJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582138976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdmQjLbKDyN51HsAypWrE6gYsAgPcLfGv6dYmRuKHWw=;
 b=Sy4VKKQyD1H+TTT7n4M3rr+DSorrLdJteSWDe40iiDKwd5SPW6bSGhG2M2Hsy0Q91wmMks
 Vf2mCSLUL2rJ94nh8dmliMCK0qOGYOF3AElRZkwPKHVkYAMC2q1rmiiZUjeg5ZtY7OoLNK
 /ZnhWEGDszQAGn7ahgnQPvdbyEVe+Vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Hq-hicQ5OcqNT5jYlqRZmQ-1; Wed, 19 Feb 2020 14:02:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D30A801E53;
 Wed, 19 Feb 2020 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-92.gru2.redhat.com
 [10.97.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 157D910001AE;
 Wed, 19 Feb 2020 19:02:39 +0000 (UTC)
Subject: Re: [PATCH v2 1/6] tests/boot_linux_console: add microvm acceptance
 test
To: Liam Merwick <liam.merwick@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 alex.bennee@linaro.org, fam@euphon.net
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-2-git-send-email-liam.merwick@oracle.com>
 <6ceb7e42-125a-ac91-fad6-e67c332c48b4@redhat.com>
 <03a996af-49eb-8c91-eabd-4b9a29270f63@redhat.com>
 <09b5f7df-fe96-27c5-8559-1c760522f526@oracle.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <5bd82176-242c-bf22-8656-04b1d1013d9a@redhat.com>
Date: Wed, 19 Feb 2020 16:02:38 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <09b5f7df-fe96-27c5-8559-1c760522f526@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Hq-hicQ5OcqNT5jYlqRZmQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Liam,

Sorry for the long time to reply it... comments below.

On 2/6/20 1:05 PM, Liam Merwick wrote:
> On 06/02/2020 14:09, Philippe Mathieu-Daud=E9 wrote:
>> Hi Liam,
>>
>> On 2/6/20 2:57 PM, Philippe Mathieu-Daud=E9 wrote:
>>> On 2/5/20 3:56 PM, Liam Merwick wrote:
>>>> Refactor test_x86_64_pc() to test_x86_64_machine() so that separate
>>>> functions which specify the Avocado tag of ':avocado: tags=3Dmachine:'
>>>> as being either 'pc' or 'microvm' can be used to test booting a
>>>> compressed kernel using either machine class.
>>>>
>>>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> ---
>>>> =A0 tests/acceptance/boot_linux_console.py | 20 +++++++++++++++++---
>>>> =A0 1 file changed, 17 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>>> b/tests/acceptance/boot_linux_console.py
>>>> index e40b84651b0b..233601b429bd 100644
>>>> --- a/tests/acceptance/boot_linux_console.py
>>>> +++ b/tests/acceptance/boot_linux_console.py
>>>> @@ -51,10 +51,10 @@ class BootLinuxConsole(Test):
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 os.chdir(cwd)
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return self.workdir + path
>>>> -=A0=A0=A0 def test_x86_64_pc(self):
>>>> +=A0=A0=A0 def do_test_x86_64_machine(self):
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>>> -=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>>> -=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>>>> +=A0=A0=A0=A0=A0=A0=A0 Common routine to boot an x86_64 guest.
>>>> +=A0=A0=A0=A0=A0=A0=A0 Caller must specify tags=3Darch and tags=3Dmach=
ine
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
>>>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>>>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>>>> @@ -70,6 +70,20 @@ class BootLinuxConsole(Test):
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 console_pattern =3D 'Kernel command line: =
%s' %=20
>>>> kernel_command_line
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.wait_for_console_pattern(console_patt=
ern)
>>>> +=A0=A0=A0 def test_x86_64_pc(self):
>>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>>> +
>>>> +=A0=A0=A0 def test_x86_64_microvm(self):
>>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:microvm
>>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>>> +
>>>> =A0=A0=A0=A0=A0 def test_mips_malta(self):
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:mips
>>>>
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>>> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>>
>> Actually this breaks testing the distrib QEMU:
>
>
> I happen to have a QEMU RPM installed - how do I override 'make=20
> check-acceptance' to pick up /usr/bin/qemu-system-x86_64 (and=20
> /usr/share/qemu/bios-microvm.bin - not sure that is a universal=20
> location for distros)?=A0=A0 Overriding QTEST_QEMU_BINARY didn't seem to=
=20
> work for me - doesn't appear to apply to the check-acceptance rule.

So far as I know you cannot override the QEMU path with `make=20
check-acceptance`. If you still need to override then you need to evoke=20
avocado manually. Suppose it is in the build directory, do:

$ make check-venv

$ ./tests/venv/bin/avocado run -p qemu_bin=3D/usr/bin/qemu-system-x86_64=20
-t arch:x86_64 tests/acceptance/boot_linux_console.py

The -p option on the command above is used to pass a test parameter. The=20
underlying avocado_qemu framework used on the acceptance tests=20
recognizes the 'qemu_bin' parameter, which in case of its absence the=20
test setup searches for a suitable QEMU built on the current directory.=20
The avocado_qemu doesn't=A0 have a parameter to indicate the path to the=20
bios file, so there is no way to override it (well, not entirely true=20
and I explain it on the patch 02 of this series).

Thanks!

- Wainer

>
>
>>
>> =A0=A0(1/2)=20
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:=
=20
>> PASS (2.58 s)
>> =A0=A0(2/2)=20
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_micr=
ovm:=20
>>
>> Output: 'qemu-system-x86_64: -machine microvm: unsupported machine=20
>> type\nUse -machine help to list supported machines\n'
>> ERROR: timed out (15.10 s)
>>
>> Do you mind testing the series testing a machine is available?
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675086.html
>
>
> Sure. I'll test/review those.
>
> Regards,
> Liam
>
>


