Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9B4C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0518321928
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0518321928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4gT-0003wv-St
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iB4Ap-0002L4-7i
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iB4Al-0006Yt-Kx
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:41:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iB4Al-0006Yf-CV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:41:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7149E10DCC8C
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 21:41:06 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-45.rdu2.redhat.com
 [10.10.121.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF7FD608A5;
 Thu, 19 Sep 2019 21:40:58 +0000 (UTC)
Subject: Re: [PATCH] edk2 build scripts: work around TianoCore#1607 without
 forcing Python 2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
References: <20190918171141.15957-1-lersek@redhat.com>
 <2d02cb02-27ce-081b-c9ec-4c4430503749@redhat.com>
 <6a5b3a61-0d52-6866-9fb9-4d71e5f01483@redhat.com>
 <f6266a5b-6f9b-fa2c-2e4f-9d12cdb8b375@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e23ac2ec-a15f-bb17-a82a-46730707d208@redhat.com>
Date: Thu, 19 Sep 2019 23:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f6266a5b-6f9b-fa2c-2e4f-9d12cdb8b375@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 19 Sep 2019 21:41:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/19/19 21:56, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/19/19 9:08 PM, Laszlo Ersek wrote:
>> On 09/19/19 18:39, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 9/18/19 7:11 PM, Laszlo Ersek wrote:
>>>> It turns out that forcing python2 for running the edk2 "build" utili=
ty is
>>>> neither necessary nor sufficient.
>>>>
>>>> Forcing python2 is not sufficient for two reasons:
>>>>
>>>> - QEMU is moving away from python2, with python2 nearing EOL,
>>>>
>>>> - according to my most recent testing, the lacking dependency inform=
ation
>>>>   in the makefiles that are generated by edk2's "build" utility can =
cause
>>>>   parallel build failures even when "build" is executed by python2.
>>>>
>>>> And forcing python2 is not necessary because we can still return to =
the
>>>> original idea of filtering out jobserver-related options from MAKEFL=
AGS.
>>>> So do that.
>>>
>>> FYI I tried uninstalling python2 on Fedora 29,
>>>
>>> $ make -C roms efi -j8
>>> make: Entering directory '/home/phil/source/qemu/roms'
>>> make -C edk2/BaseTools \
>>>         EXTRA_OPTFLAGS=3D'' \
>>>         EXTRA_LDFLAGS=3D''
>=20
> ^ this is the 'edk2-basetools' target from roms/Makefile.
>=20
>>> make[1]: Entering directory '/home/phil/source/qemu/roms/edk2/BaseToo=
ls'
>>> [...]
>>> make -C Tests
>>> make[2]: Entering directory
>>> '/home/phil/source/qemu/roms/edk2/BaseTools/Tests'
>>> /bin/sh: python: command not found
>>> make[2]: *** [GNUmakefile:11: test] Error 127
>>>
>>> 'python' seems to be provided by python-unversioned-command which is
>>> wired to Python2:
>>>
>>> $ dnf info python-unversioned-command
>>> Last metadata expiration check: 0:03:08 ago on Thu 19 Sep 2019 04:21:=
21
>>> PM UTC.
>>> Available Packages
>>> Name         : python-unversioned-command
>>> Version      : 2.7.16
>>> Release      : 2.fc29
>>> Arch         : noarch
>>> Size         : 13 k
>>> Source       : python2-2.7.16-2.fc29.src.rpm
>>> Repo         : updates
>>> Summary      : The "python" command that runs Python 2
>>> URL          : https://www.python.org/
>>> License      : Python
>>> Description  : This package contains /usr/bin/python - the "python"
>>> command that runs Python 2.
>>>
>>> I had to manually run update-alternatives to continue:
>>>
>>> $ sudo update-alternatives --install /usr/bin/python python
>>> /usr/bin/python3 69
>>>
>>> Not sure this is the expected behavior, it is confusing.
>>>
>>
>> The python detection is not fool-proof in edk2. A description is given=
 at:
>>
>> https://github.com/tianocore/tianocore.github.io/wiki/BaseTools-Suppor=
t-Python2-Python3
>>
>> To summarize that, it works like this, on Linux:
>>
>> - if you set PYTHON_COMMAND, then the binary pointed to by
>> PYTHON_COMMAND will be used. The edk2 build infrastructure will
>> determine whether the pointed-to binary is python 2 or python 3, and
>> branch to the corresponding implementation of the build tools.
>>
>> - Otherwise, *minor* version auto-detection is attempted. With
>> PYTHON3_ENABLE unset, or set to "TRUE", this minor version autodetecti=
on
>> will aim at minor versions of python3.
>>
>> - Otherwise (=3D PYTHON3_ENABLE set to a string different from "TRUE")=
,
>> the minor version auto-detection will focus on python2.
>=20
> What you document regarding PYTHON3_ENABLE is valid once we sourced
> edksetup.sh which is done in Makefile.edk2, one step after the previous
> call:
>=20
> efi: edk2-basetools               # call 1 (python failing)
> 	$(MAKE) -f Makefile.edk2  # call 2 sourcing edksetup.sh
>=20
>> With this patch applied, the middle case is active. Apparently it fail=
s,
>> because the edk2 build tools developers could not foresee the situatio=
ns
>> that you've exposed the auto-detection to, on Ubuntu and Fedora. Back
>> when I tested the python3 enablement in edk2, I checked the patches in
>> the following environments:
>>
>> - on RHEL-7 with the system python 2,
>> - on RHEL-7 with python3.4 from EPEL-7,
>> - on RHEL-8 with python3.6,
>> - on RHEL-8 with platform-python.
>>
>> Everything worked fine for me. I have no clue what's going on in Ubunt=
u
>> and in Fedora.
>>
>> Can we require all build host installations -- where we expect to run
>> "make efi" -- to provide a Python 3 binary on $PATH that is plainly
>> called "python3"?
>=20
> Kevin recently suggested a similar patch (in another area):
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04377.html
>=20
>> Then I think this patch should work. (If necessary, I could set
>> "PYTHON_COMMAND=3Dpython3", too.)
>=20
> Yes, I confirm forcing "PYTHON_COMMAND=3Dpython3 make -C roms efi" work=
s.
>=20
> Not sure what is the cleaner way to fix this although...

Thanks for the analysis!

I understand the issue now.

- "edk2/BaseTools/GNUmakefile" runs $(MAKE) in three subdirs:
  - Source/C,
  - Source/Python,
  - Tests (which depends on the former two)

- "edk2/BaseTools/Source/C/GNUmakefile" builds fine
- "edk2/BaseTools/Source/Python/GNUmakefile" does nothing
- "edk2/BaseTools/Tests/GNUmakefile" depends on PYTHON_COMMAND -- which
  should either come from the user, or from sourcing "edksetup.sh"

Therefore the issue is:

- the "edk2-basetools" target in "roms/Makefile" does not
  run (more precisely, does not "source") edksetup.sh

- the "build-edk2-tools" target in "tests/uefi-test-tools/Makefile"
  does not run (more precisely, does not "source") edksetup.sh

I don't think I will reorganize the dependencies in those makefiles. Nor
will I source edksetup.sh in the makefile recipes. Instead, I'll
directly set PYTHON_COMMAND=3Dpython3 in the "tools" recipes, and in the
build wrapper shell scripts.

I'll try to post v2 soon.

Thanks!
Laszlo

