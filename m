Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C44CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A8B2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A8B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJQW-0007jl-HB
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNIxz-0004Fx-9c
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNIxy-0003tN-04
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNIxx-0003rt-Og
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:54:29 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC53281DE3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:54:27 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id i23so2596606wmb.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h3kc1jDmgz83K1w9nFAtUxB8op6ATJxy4mfmYwzUkM4=;
 b=JFK373MdIXHJqFKSXRaddVwQYytijvFW4l55CSH3DVJbtoknJ6FKDng9eFZL5655DC
 C74sn/cEB3A5e8vFu67d+R/UN1EniN3XJVWkZVAuL08uD+YwayJ9dJIFSm67zkiBhxFB
 43XkLM1GUVkU2SJydtZszmX4UI92kvNYHi8JA5RU6brAdymXJc9uNU2pb+8ThEFfv26Y
 WjN0Tg4tM+sfqm6onuFwued7V90RNhhIOt2kapqaKU7cjRlKfU8LsqAvIqc4bTdRndXZ
 mHob+VTM4zZLPx9hEQ0NTOzzlJpjiWq4MgkMX7QBkBcI4/OixKCVAqBMrN6t1scEBmUl
 Mi6g==
X-Gm-Message-State: APjAAAVfPhR0I8bB8TQbprkLdf9v9NhQg71LZkOsKTnbNw11qS3MaTM2
 NndteybZ9X4Rc00wLutilIK4MBz5GIkiDRTCiQzqIb8ndklVKYh0hZd2sTZetjGVXR/HfzGe5UQ
 MsdJdgpE5mFJ4ku0=
X-Received: by 2002:a5d:4803:: with SMTP id l3mr9213667wrq.381.1571846065601; 
 Wed, 23 Oct 2019 08:54:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxDw1037R9FQxx2zcLNa/bIkRuBCaMCtFuJeGbvC/TdLHnRefQJuFR21S0ObcM+1+inhs7oWA==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr9213624wrq.381.1571846065176; 
 Wed, 23 Oct 2019 08:54:25 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id i18sm20470155wrx.14.2019.10.23.08.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 08:54:24 -0700 (PDT)
Subject: Re: [PATCH v3 4/9] tests/acceptance: Refactor
 exec_command_and_wait_for_pattern()
To: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20191017165239.30159-1-f4bug@amsat.org>
 <20191017165239.30159-5-f4bug@amsat.org>
 <20191020101003.GM1960@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5075551-1fcc-ed38-ae96-a7782f7fa3fc@redhat.com>
Date: Wed, 23 Oct 2019 17:54:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020101003.GM1960@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 12:10 PM, David Gibson wrote:
> On Thu, Oct 17, 2019 at 06:52:34PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
>> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>>
>> The same utility method is already present in two different test
>> files,
>=20
> This patch only appears to remove it from one, though.
>=20
>> so let's consolidate it into a single utility function.

Indeed, I reordered while rebasing and didn't notice the change,
thanks.

>>
>> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> ---
>>   tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++++++++
>>   tests/acceptance/boot_linux_console.py    | 12 ++++--------
>>   2 files changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/accepta=
nce/avocado_qemu/__init__.py
>> index 39f72945cd..4d7d6b640a 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -80,6 +80,25 @@ def wait_for_console_pattern(test, success_message,
>>               test.fail(fail)
>>  =20
>>  =20
>> +def exec_command_and_wait_for_pattern(test, command,
>> +                                      success_message, failure_messag=
e):
>> +    """
>> +    Send a command to a console (appending CRLF characters), then wai=
t
>> +    for success_message to appear on the console, while logging the.
>> +    content. Mark the test as failed if failure_message is found inst=
ead.
>> +
>> +    :param test: an Avocado test containing a VM that will have its c=
onsole
>> +                 read and probed for a success or failure message
>> +    :type test: :class:`avocado_qemu.Test`
>> +    :param command: the command to send
>> +    :param success_message: if this message appears, test succeeds
>> +    :param failure_message: if this message appears, test fails
>> +    """
>> +    command +=3D '\r\n'
>> +    self.vm.console_socket.sendall(command.encode())
>> +    wait_for_console_pattern(self, success_message)
>> +
>> +
>>   class Test(avocado.Test):
>>       def setUp(self):
>>           self._vms =3D {}
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance=
/boot_linux_console.py
>> index bf9861296a..cc4d9be625 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -14,6 +14,7 @@ import gzip
>>   import shutil
>>  =20
>>   from avocado_qemu import Test
>> +from avocado_qemu import exec_command_and_wait_for_pattern
>>   from avocado_qemu import wait_for_console_pattern
>>   from avocado.utils import process
>>   from avocado.utils import archive
>> @@ -29,11 +30,6 @@ class BootLinuxConsole(Test):
>>  =20
>>       KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>>  =20
>> -    def exec_command_and_wait_for_pattern(self, command, success_mess=
age):
>> -        command +=3D '\r\n'
>> -        self.vm.console_socket.sendall(command.encode())
>> -        wait_for_console_pattern(self, success_message)
>> -
>>       def extract_from_deb(self, deb, path):
>>           """
>>           Extracts a file from a deb package into the test workdir
>> @@ -162,11 +158,11 @@ class BootLinuxConsole(Test):
>>           self.vm.launch()
>>           wait_for_console_pattern(self, 'Boot successful.')
>>  =20
>> -        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
>> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
>>                                                  'BogoMIPS')
>> -        self.exec_command_and_wait_for_pattern('uname -a',
>> +        exec_command_and_wait_for_pattern(self, 'uname -a',
>>                                                  'Debian')
>> -        self.exec_command_and_wait_for_pattern('reboot',
>> +        exec_command_and_wait_for_pattern(self, 'reboot',
>>                                                  'reboot: Restarting s=
ystem')
>>  =20
>>       def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_has=
h):
>=20

