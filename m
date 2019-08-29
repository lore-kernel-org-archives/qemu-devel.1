Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F14EC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E85208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E85208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3GgD-0004Gw-Da
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 05:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3GfV-0003jF-Nb
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3GfU-0004DP-0f
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:24:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3GfT-0004Ch-Od
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:24:35 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B60BA7FDF5
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:24:33 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id h3so1799609wrw.7
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 02:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=moYRizQq6rTFZ0+Q5zZ+yqZXsSIvMt8A5SMBGswzVhI=;
 b=J7p/DX3aI+93/ntKFLNsd5E1wdvbyJr6oys7Ao2R+FlHUScUrvZ8uNP277X4sksqE7
 xKpxaR1U7UyIajwt+xGzdQo+LqTc70Iu/Ty5BfZEc/FV99ySMbl34WPRKCLya9hNbPBJ
 jdWh1vtlSz6kckoL7mody4K97ciOy0nu0HDaQSrTww20sIeezcEpztgpMikd0USD0O6f
 cgIc8JIE2+lgpnxRjZe6k0q2na4DN4MLJYPhsF+XaANBiQqIoqUWP0kQaRnstMn+b0hJ
 5miaSPWTRxioGDX0vfdP0Z1O+qbgF/QOapi0pj4/OC2At9L9ZkNoK7osuezaif6uDcCW
 CcVQ==
X-Gm-Message-State: APjAAAW7oz1o0swRna3kNzQtz07XiNTe3okLR1SOk4JeOSfRo07Cb2Xs
 +Hp8qFHpH864vEka6Yii7375PEeMxbZRc3rt8SGO2QdTgwqVfZpAyz8nOdwypWfSfq1C9Fhoi3d
 0iPQDw1ktFFwt4io=
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr9914842wmj.118.1567070672063; 
 Thu, 29 Aug 2019 02:24:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFLHZGT0kUr8+aJYzb4UyjU8nEQkeQnOTv8sSaVJcKLB+QafNnyjG7Vs2dsnH4E9YV7vHBxA==
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr9914804wmj.118.1567070671684; 
 Thu, 29 Aug 2019 02:24:31 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id 20sm1573042wmk.34.2019.08.29.02.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 02:24:31 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
 <20190829032746.GA488@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
Date: Thu, 29 Aug 2019 11:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190829032746.GA488@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 5:27 AM, Cleber Rosa wrote:
> On Thu, Aug 29, 2019 at 11:51:17AM +1000, David Gibson wrote:
>> On Thu, Aug 29, 2019 at 11:31:25AM +1000, David Gibson wrote:
>>> If I attempt to run "make check-acceptance" on my POWER9, RHEL8.1
>>> machine when the openssl-devel package isn't installed, I get the
>>> following very cryptic error:
>>>
>>>   VENV    /home/dwg/qemu/build/rhel8/tests/venv
>>>   PIP     /home/dwg/qemu/tests/requirements.txt
>>> Command "/home/dwg/qemu/build/rhel8/tests/venv/bin/python -u -c "import setuptools, tokenize;__file__='/tmp/pip-build-la4el5r5/cryptography/setup.py';f=getattr(tokenize, 'open', open)(__file__);code=f.read().replace('\r\n', '\n');f.close();exec(compile(code, __file__, 'exec'))" install --record /tmp/pip-1efs22iz-record/install-record.txt --single-version-externally-managed --compile --install-headers /home/dwg/qemu/build/rhel8/tests/venv/include/site/python3.6/cryptography" failed with error code 1 in /tmp/pip-build-la4el5r5/cryptography/
>>>
>>> Using V=1 doesn't give any more useful information, and it's not
>>> (easily) possible to manually re-run the given command since it relies
>>> on things in /tmp that are removed once the attempt finishes.
>>>
>>> I only figured out it was openssl-devel being missing that was the
>>> problem by (mostly) guesswork.  It would be really great if we could
>>> generate a more helpful error here.
>>>
>>> In addition, if I rerun "make check-acceptance" it no longer even
>>> attempts the PIP install, since tests/venv already exists in my build
>>> environment.  It then sort of works, but I think it might be hitting
>>> other errors because of the missing python packages.  Sorry that's a
>>> bit vague - I also seem to be getting unrelated errors that I'm still
>>> trying to figure out.
>>
>> Fwiw, I also get an equally cryptic error that I haven't figured out
>> the cause for on my 32-bit Fedora container environment:
>>
>>   VENV    /home/dwg/src/qemu/build/i386/tests/venv
>>   PIP     /home/dwg/src/qemu/tests/requirements.txt
>>   Failed building wheel for bcrypt
>> Could not build wheels for bcrypt which use PEP 517 and cannot be installed directly
>> You are using pip version 19.0.3, however version 19.2.3 is available.
>> You should consider upgrading via the 'pip install --upgrade pip' command.
>>
> 
> This is certainly caused by pip not being able to install paramiko on
> those systems.  I have dealt with paramiko (and its many dependencies)
> before on the avocado remote runner plugin (which is not being used
> here) and it was not fun.
> 
> My personal goal was to rely on the ssh binary as an ssh client, which
> should be more ubiquitous, and with that I added a simple wrapper to
> Avocado:
> 
>   https://avocado-framework.readthedocs.io/en/71.0/api/utils/avocado.utils.html#module-avocado.utils.ssh

I did not know this module.

> I guess we should consider changing the (few) tests that require
> paramiko to use that module instead.

Clean way to resolve this issue.

>> In this case the check definitely doesn't work - it doesn't appear to
>> have installed avocado in the venv.
>>
>>   AVOCADO tests/acceptance
>> /home/dwg/src/qemu/build/i386/tests/venv/bin/python: No module named avocado
>>
> 
> My hope is that with pure Python modules in requirements.txt, failures
> will be much harder to come by.  Either way, it'd be nice to improve

Is there a way to check for this before submitting/merging patches?

Some checkpatch.py lines that report:

  The 'paramiko' module is not pure Python and can
  not be added in requirements.txt.

> the venv creation, at the very least add a cleanup if it fails to
> complete successfully.
> 
> As a workaround I'd suggest two things:
> 
>  1) remove paramiko from requirements.txt
>  2) set the env var CONTINUOUS_INTEGRATION=1 before running `make
>     check-acceptace` (the tests in linux_ssh_mips_malta.py check for
>     that and don't run if it's set).
> 
> But, we'll need to address those failures definitely ASAP.  Anyway,
> thanks for reporting it.
> 
> - Cleber.
> 
>> -- 
>> David Gibson			| I'll have my music baroque, and my code
>> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
>> 				| _way_ _around_!
>> http://www.ozlabs.org/~dgibson
> 
> 
> 

