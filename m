Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5364C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A364D2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A364D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB2fD-00085N-Jy
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 16:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iB2ck-0005cB-3M
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iB2Xb-0007hS-Dv
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:56:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iB2Xb-0007gz-46
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:56:35 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EED04C002966
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 19:56:33 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k67so2127372wmf.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 12:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oKh+dd3twrBieLkpF1MRMcDhF+VT2bQOxBt6igrSwlI=;
 b=TsMRyCTsYtlhShvsg3CDHDR8Np5NDAKk+2WcPxqe0a1G9PerVbP1BwJwgsNniY1d3h
 wmHBAbgOtA8WVlOQYKN559tjVq2nk4A5Sud0o1Z6EEC7Cs9F3yyXSUSsrIse8+yDhHR0
 DUfKDRurezi24AvWyzgnATJMKiOC7XAfHNgHzDje+hDVlrGwb++A3mzp7NccJdAeWb6H
 aR2kW+nt/V5CwBfAJQhVXHxBga/bNtS0/WGb6v5wItR6yYRfzEVHgnNfaStry63EukZT
 D5nngjBvg9kkbFQApIFlGlxwLGL/PIfPKTvF3fTub7GKZsu2lLaYeoB17HqGB0hR2WpR
 55/A==
X-Gm-Message-State: APjAAAWBQWfTWHYjZoAs3GR3ggkEqR9ksCA8NC6nhQE38P+MYg2Vcb/O
 oTJGAy631w3Evp6/7GVXrGdfT4Jo9YvwaJy0QA9RkSnll+GUtEteZuJoivaHyTh4XOFf+W8/82m
 TYBxzhE/kwFrY5/g=
X-Received: by 2002:a1c:cb83:: with SMTP id b125mr4434963wmg.43.1568922992659; 
 Thu, 19 Sep 2019 12:56:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGNPEEsN6G2AG4lAeYrLT1xBO3IOA9yfP7Su+1RvmRnm5TcC9GCNmxtG4KyYI+CDnH4x/4tg==
X-Received: by 2002:a1c:cb83:: with SMTP id b125mr4434950wmg.43.1568922992451; 
 Thu, 19 Sep 2019 12:56:32 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c8sm9510911wrr.49.2019.09.19.12.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 12:56:31 -0700 (PDT)
Subject: Re: [PATCH] edk2 build scripts: work around TianoCore#1607 without
 forcing Python 2
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20190918171141.15957-1-lersek@redhat.com>
 <2d02cb02-27ce-081b-c9ec-4c4430503749@redhat.com>
 <6a5b3a61-0d52-6866-9fb9-4d71e5f01483@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f6266a5b-6f9b-fa2c-2e4f-9d12cdb8b375@redhat.com>
Date: Thu, 19 Sep 2019 21:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6a5b3a61-0d52-6866-9fb9-4d71e5f01483@redhat.com>
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 9:08 PM, Laszlo Ersek wrote:
> On 09/19/19 18:39, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 9/18/19 7:11 PM, Laszlo Ersek wrote:
>>> It turns out that forcing python2 for running the edk2 "build" utilit=
y is
>>> neither necessary nor sufficient.
>>>
>>> Forcing python2 is not sufficient for two reasons:
>>>
>>> - QEMU is moving away from python2, with python2 nearing EOL,
>>>
>>> - according to my most recent testing, the lacking dependency informa=
tion
>>>   in the makefiles that are generated by edk2's "build" utility can c=
ause
>>>   parallel build failures even when "build" is executed by python2.
>>>
>>> And forcing python2 is not necessary because we can still return to t=
he
>>> original idea of filtering out jobserver-related options from MAKEFLA=
GS.
>>> So do that.
>>
>> FYI I tried uninstalling python2 on Fedora 29,
>>
>> $ make -C roms efi -j8
>> make: Entering directory '/home/phil/source/qemu/roms'
>> make -C edk2/BaseTools \
>>         EXTRA_OPTFLAGS=3D'' \
>>         EXTRA_LDFLAGS=3D''

^ this is the 'edk2-basetools' target from roms/Makefile.

>> make[1]: Entering directory '/home/phil/source/qemu/roms/edk2/BaseTool=
s'
>> [...]
>> make -C Tests
>> make[2]: Entering directory
>> '/home/phil/source/qemu/roms/edk2/BaseTools/Tests'
>> /bin/sh: python: command not found
>> make[2]: *** [GNUmakefile:11: test] Error 127
>>
>> 'python' seems to be provided by python-unversioned-command which is
>> wired to Python2:
>>
>> $ dnf info python-unversioned-command
>> Last metadata expiration check: 0:03:08 ago on Thu 19 Sep 2019 04:21:2=
1
>> PM UTC.
>> Available Packages
>> Name         : python-unversioned-command
>> Version      : 2.7.16
>> Release      : 2.fc29
>> Arch         : noarch
>> Size         : 13 k
>> Source       : python2-2.7.16-2.fc29.src.rpm
>> Repo         : updates
>> Summary      : The "python" command that runs Python 2
>> URL          : https://www.python.org/
>> License      : Python
>> Description  : This package contains /usr/bin/python - the "python"
>> command that runs Python 2.
>>
>> I had to manually run update-alternatives to continue:
>>
>> $ sudo update-alternatives --install /usr/bin/python python
>> /usr/bin/python3 69
>>
>> Not sure this is the expected behavior, it is confusing.
>>
>=20
> The python detection is not fool-proof in edk2. A description is given =
at:
>=20
> https://github.com/tianocore/tianocore.github.io/wiki/BaseTools-Support=
-Python2-Python3
>=20
> To summarize that, it works like this, on Linux:
>=20
> - if you set PYTHON_COMMAND, then the binary pointed to by
> PYTHON_COMMAND will be used. The edk2 build infrastructure will
> determine whether the pointed-to binary is python 2 or python 3, and
> branch to the corresponding implementation of the build tools.
>=20
> - Otherwise, *minor* version auto-detection is attempted. With
> PYTHON3_ENABLE unset, or set to "TRUE", this minor version autodetectio=
n
> will aim at minor versions of python3.
>=20
> - Otherwise (=3D PYTHON3_ENABLE set to a string different from "TRUE"),
> the minor version auto-detection will focus on python2.

What you document regarding PYTHON3_ENABLE is valid once we sourced
edksetup.sh which is done in Makefile.edk2, one step after the previous
call:

efi: edk2-basetools               # call 1 (python failing)
	$(MAKE) -f Makefile.edk2  # call 2 sourcing edksetup.sh

> With this patch applied, the middle case is active. Apparently it fails=
,
> because the edk2 build tools developers could not foresee the situation=
s
> that you've exposed the auto-detection to, on Ubuntu and Fedora. Back
> when I tested the python3 enablement in edk2, I checked the patches in
> the following environments:
>=20
> - on RHEL-7 with the system python 2,
> - on RHEL-7 with python3.4 from EPEL-7,
> - on RHEL-8 with python3.6,
> - on RHEL-8 with platform-python.
>=20
> Everything worked fine for me. I have no clue what's going on in Ubuntu
> and in Fedora.
>=20
> Can we require all build host installations -- where we expect to run
> "make efi" -- to provide a Python 3 binary on $PATH that is plainly
> called "python3"?

Kevin recently suggested a similar patch (in another area):
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04377.html

> Then I think this patch should work. (If necessary, I could set
> "PYTHON_COMMAND=3Dpython3", too.)

Yes, I confirm forcing "PYTHON_COMMAND=3Dpython3 make -C roms efi" works.

Not sure what is the cleaner way to fix this although...

Regards,

Phil.

