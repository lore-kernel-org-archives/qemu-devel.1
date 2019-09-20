Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C8DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25D321A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25D321A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBDr4-0003c9-U8
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBDoH-0001Mj-Vt
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBDoF-00035P-Cp
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBDoF-00035A-6M
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:58:31 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2FB8F81F07
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:58:30 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id n3so837859wmf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 00:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KGn5/4uqP4WoBV74qQ5FgM9uECyyUIlv8ObsZhJdKFo=;
 b=A6FTx9h3k8P5FccopAALTXFFBDJUrDVH9rqMTVdd0Ms68g1AaRt9W6cDweWvPzoiWB
 a+MIEgBOMu0rdnMWhfnzj7jECP4dhZ+WYkDYK283PRStfRqL52hzoNTsip8C5wf+bgdw
 Abm1jK5MFabKooj6+Gy47TirhXB9h6xIDXN4ZSPJB44NY+3frztOzYs3I3b2vIV/zezg
 QBVDUfsFBDHCrCzs3vDUGwDtbX91rbAxO/cfObZzKgzA5iae/RzK4VTckMyuFAF2z3TM
 VItDuDtN9oA3+F1WGnEJ0WoTa5284jxlIDxIVSewZXNGyqH5u6w61Iw30Vhhss9edbw0
 SgiA==
X-Gm-Message-State: APjAAAVBjxET0+ibXKC+Ui2SZqD3FGRzexbJcKPbko8CWZ0S/X0Bm/WD
 AqaJMXIFy4IAJGuE6tCKLHYKGupbgo8tY/KKsOQpqnENZpLyjQeLEdNQEgLaWgWmLZ+GRpGEjMQ
 O6OMIfsJyWOtZvio=
X-Received: by 2002:a5d:5381:: with SMTP id d1mr45198wrv.315.1568966308841;
 Fri, 20 Sep 2019 00:58:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxAG49GqeWGx7wKx0jwxOjLXDdvI3Cmgu++pgiNpg0FqLsnzm0L6cDL0mdF8q3M3YVl5uFf3g==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr45182wrv.315.1568966308553;
 Fri, 20 Sep 2019 00:58:28 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id t1sm1156637wrn.57.2019.09.20.00.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 00:58:27 -0700 (PDT)
Subject: Re: [PATCH] edk2 build scripts: work around TianoCore#1607 without
 forcing Python 2
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list
 <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
References: <20190918171141.15957-1-lersek@redhat.com>
 <2d02cb02-27ce-081b-c9ec-4c4430503749@redhat.com>
 <6a5b3a61-0d52-6866-9fb9-4d71e5f01483@redhat.com>
 <f6266a5b-6f9b-fa2c-2e4f-9d12cdb8b375@redhat.com>
 <e23ac2ec-a15f-bb17-a82a-46730707d208@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <60e1c8b1-1694-7c5e-47b3-07570898a167@redhat.com>
Date: Fri, 20 Sep 2019 09:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e23ac2ec-a15f-bb17-a82a-46730707d208@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 11:40 PM, Laszlo Ersek wrote:
> On 09/19/19 21:56, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 9/19/19 9:08 PM, Laszlo Ersek wrote:
>>> On 09/19/19 18:39, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 9/18/19 7:11 PM, Laszlo Ersek wrote:
>>>>> It turns out that forcing python2 for running the edk2 "build" util=
ity is
>>>>> neither necessary nor sufficient.
>>>>>
>>>>> Forcing python2 is not sufficient for two reasons:
>>>>>
>>>>> - QEMU is moving away from python2, with python2 nearing EOL,
>>>>>
>>>>> - according to my most recent testing, the lacking dependency infor=
mation
>>>>>   in the makefiles that are generated by edk2's "build" utility can=
 cause
>>>>>   parallel build failures even when "build" is executed by python2.
>>>>>
>>>>> And forcing python2 is not necessary because we can still return to=
 the
>>>>> original idea of filtering out jobserver-related options from MAKEF=
LAGS.
>>>>> So do that.
>>>>
>>>> FYI I tried uninstalling python2 on Fedora 29,
>>>>
>>>> $ make -C roms efi -j8
>>>> make: Entering directory '/home/phil/source/qemu/roms'
>>>> make -C edk2/BaseTools \
>>>>         EXTRA_OPTFLAGS=3D'' \
>>>>         EXTRA_LDFLAGS=3D''
>>
>> ^ this is the 'edk2-basetools' target from roms/Makefile.
>>
>>>> make[1]: Entering directory '/home/phil/source/qemu/roms/edk2/BaseTo=
ols'
>>>> [...]
>>>> make -C Tests
>>>> make[2]: Entering directory
>>>> '/home/phil/source/qemu/roms/edk2/BaseTools/Tests'
>>>> /bin/sh: python: command not found
>>>> make[2]: *** [GNUmakefile:11: test] Error 127
>>>>
>>>> 'python' seems to be provided by python-unversioned-command which is
>>>> wired to Python2:
>>>>
>>>> $ dnf info python-unversioned-command
>>>> Last metadata expiration check: 0:03:08 ago on Thu 19 Sep 2019 04:21=
:21
>>>> PM UTC.
>>>> Available Packages
>>>> Name         : python-unversioned-command
>>>> Version      : 2.7.16
>>>> Release      : 2.fc29
>>>> Arch         : noarch
>>>> Size         : 13 k
>>>> Source       : python2-2.7.16-2.fc29.src.rpm
>>>> Repo         : updates
>>>> Summary      : The "python" command that runs Python 2
>>>> URL          : https://www.python.org/
>>>> License      : Python
>>>> Description  : This package contains /usr/bin/python - the "python"
>>>> command that runs Python 2.
>>>>
>>>> I had to manually run update-alternatives to continue:
>>>>
>>>> $ sudo update-alternatives --install /usr/bin/python python
>>>> /usr/bin/python3 69
>>>>
>>>> Not sure this is the expected behavior, it is confusing.
>>>>
>>>
>>> The python detection is not fool-proof in edk2. A description is give=
n at:
>>>
>>> https://github.com/tianocore/tianocore.github.io/wiki/BaseTools-Suppo=
rt-Python2-Python3
>>>
>>> To summarize that, it works like this, on Linux:
>>>
>>> - if you set PYTHON_COMMAND, then the binary pointed to by
>>> PYTHON_COMMAND will be used. The edk2 build infrastructure will
>>> determine whether the pointed-to binary is python 2 or python 3, and
>>> branch to the corresponding implementation of the build tools.
>>>
>>> - Otherwise, *minor* version auto-detection is attempted. With
>>> PYTHON3_ENABLE unset, or set to "TRUE", this minor version autodetect=
ion
>>> will aim at minor versions of python3.
>>>
>>> - Otherwise (=3D PYTHON3_ENABLE set to a string different from "TRUE"=
),
>>> the minor version auto-detection will focus on python2.
>>
>> What you document regarding PYTHON3_ENABLE is valid once we sourced
>> edksetup.sh which is done in Makefile.edk2, one step after the previou=
s
>> call:
>>
>> efi: edk2-basetools               # call 1 (python failing)
>> 	$(MAKE) -f Makefile.edk2  # call 2 sourcing edksetup.sh
>>
>>> With this patch applied, the middle case is active. Apparently it fai=
ls,
>>> because the edk2 build tools developers could not foresee the situati=
ons
>>> that you've exposed the auto-detection to, on Ubuntu and Fedora. Back
>>> when I tested the python3 enablement in edk2, I checked the patches i=
n
>>> the following environments:
>>>
>>> - on RHEL-7 with the system python 2,
>>> - on RHEL-7 with python3.4 from EPEL-7,
>>> - on RHEL-8 with python3.6,
>>> - on RHEL-8 with platform-python.
>>>
>>> Everything worked fine for me. I have no clue what's going on in Ubun=
tu
>>> and in Fedora.
>>>
>>> Can we require all build host installations -- where we expect to run
>>> "make efi" -- to provide a Python 3 binary on $PATH that is plainly
>>> called "python3"?
>>
>> Kevin recently suggested a similar patch (in another area):
>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04377.html
>>
>>> Then I think this patch should work. (If necessary, I could set
>>> "PYTHON_COMMAND=3Dpython3", too.)
>>
>> Yes, I confirm forcing "PYTHON_COMMAND=3Dpython3 make -C roms efi" wor=
ks.
>>
>> Not sure what is the cleaner way to fix this although...
>=20
> Thanks for the analysis!
>=20
> I understand the issue now.
>=20
> - "edk2/BaseTools/GNUmakefile" runs $(MAKE) in three subdirs:
>   - Source/C,
>   - Source/Python,
>   - Tests (which depends on the former two)
>=20
> - "edk2/BaseTools/Source/C/GNUmakefile" builds fine
> - "edk2/BaseTools/Source/Python/GNUmakefile" does nothing
> - "edk2/BaseTools/Tests/GNUmakefile" depends on PYTHON_COMMAND -- which
>   should either come from the user, or from sourcing "edksetup.sh"
>=20
> Therefore the issue is:
>=20
> - the "edk2-basetools" target in "roms/Makefile" does not
>   run (more precisely, does not "source") edksetup.sh
>=20
> - the "build-edk2-tools" target in "tests/uefi-test-tools/Makefile"
>   does not run (more precisely, does not "source") edksetup.sh
>=20
> I don't think I will reorganize the dependencies in those makefiles. No=
r

Exactly, nor do I.

> will I source edksetup.sh in the makefile recipes. Instead, I'll
> directly set PYTHON_COMMAND=3Dpython3 in the "tools" recipes, and in th=
e
> build wrapper shell scripts.

I notice this:

 $ git grep -i python configure
 ...
 configure:1832:python=3D"$python -B"
 ...
 configure:7287:echo "PYTHON=3D$python" >> $config_host_mak
 ...
 configure:7863:echo "export PYTHON=3D'$python'" >> "$iotests_common_env"

While config-host.mak is too QEMU specific, the iotest common.env is
very simple:

 $ cat tests/qemu-iotests/common.env
 # Automatically generated by configure - do not modify
 export PYTHON=3D'python3 -B'

I'm not sure we need to run ./configure to run any make target in the
roms/ directory (since we use 'make -C roms ...'), this script doesn't
even clone the required submodules, we need to call 'make
git-submodule-update' first.

Note that when there is no 'python3' in $PATH, the ./configure script
checks for python2, but does not use generic 'python':

configure:901:for binary in "${PYTHON-python3}" python python2
configure:905:        python=3D"$binary"

> I'll try to post v2 soon.

While forcing PYTHON_COMMAND in roms/Makefile would help, I think part
of the proper way to fix this is generic to QEMU.

Not sure what is the cleaner way yet :/

Regards,

Phil.

