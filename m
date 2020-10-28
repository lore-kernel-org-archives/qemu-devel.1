Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A9C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92909247FE
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3chWz0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92909247FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXs1V-0006Yw-FP
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXs0V-0005ft-AV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXs0T-0008UR-6J
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603916716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1PJGssT3BtW8pfkPAK9iaW+UhLa0v0RjPK8xCXI8dw=;
 b=V3chWz0Fy67rcb2gRY54D0JCQ4DTGzFC5gyrSl9nOdDNzfXX1ATDQJQC/h5gVw+TkZ47hn
 XxnVdfKqA/zLOEau0x2U0pKiDmKhsmQmX/Kkjgqyg9zxKOjEdkOi78hoiwsGNdmbjcZyRO
 G1ivbwslzen5wv0XCFCr6UD430I8Ulw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-Xm_0Vt1WM8OCCfAlcasxwg-1; Wed, 28 Oct 2020 16:25:10 -0400
X-MC-Unique: Xm_0Vt1WM8OCCfAlcasxwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CA67805EFF;
 Wed, 28 Oct 2020 20:25:08 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7142E5D9EF;
 Wed, 28 Oct 2020 20:25:03 +0000 (UTC)
Subject: Re: [PATCH v3 02/15] python: add qemu package installer
To: Cleber Rosa <crosa@redhat.com>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-3-jsnow@redhat.com>
 <20201028151049.GC2201333@localhost.localdomain>
 <6498254a-46e0-a780-e7db-34275af734ae@redhat.com>
 <20201028194632.GE2201333@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <6864b888-f7db-c9fd-d9f3-c76e2e8c5026@redhat.com>
Date: Wed, 28 Oct 2020 16:25:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028194632.GE2201333@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 3:46 PM, Cleber Rosa wrote:
> On Wed, Oct 28, 2020 at 01:02:52PM -0400, John Snow wrote:
>> On 10/28/20 11:10 AM, Cleber Rosa wrote:
>>>> +mirror <https://gitlab.com/jsnow/qemu/-/tree/python>`_, but
>>>> +contributions must be sent to the list for inclusion.
>>>
>>> IMO it's not clear if this branch/mirror is your development work, a
>>> staging area, etc.
>>>
>>
>> Fair enough. jsnow/qemu/python is intended as a staging area for patches
>> that have been vetted on-list.
>>
>> jsnow/qemu/master is a lazily-updated mirror. (I tend to update it every day
>> as part of my development process, but there are days I don't write code.)
>>
>> jsnow/qemu/python-* is development work; review branches, etc.
>>
>> I'll try to rephrase this a bit. What I want to communicate:
>>
>> - This package exists as a subfolder of a larger project
>> - I am responsible for maintaining this package, but not for the larger
>> project
>> - Please contact *me* for problems with this package
>> - Contributions should go through qemu-devel (I will gently redirect
>> contributors who may send pull requests to the qemu devel list.)
>>
> 
> OK, sounds good.  I'll look at the exact rewording on v+1.
> 
>>>> diff --git a/python/setup.cfg b/python/setup.cfg
>>>> new file mode 100755
>>>> index 0000000000..12b99a796e
>>>> --- /dev/null
>>>> +++ b/python/setup.cfg
>>>> @@ -0,0 +1,18 @@
>>>> +[metadata]
>>>> +name = qemu
>>>> +maintainer = QEMU Developer Team
>>>> +maintainer_email = qemu-devel@nongnu.org
>>>> +url = https://www.qemu.org/
>>>> +download_url = https://www.qemu.org/download/
>>>> +description = QEMU Python Build, Debug and SDK tooling.
>>>> +long_description = file:PACKAGE.rst
>>>> +long_description_content_type = text/x-rst
>>>> +classifiers =
>>>> +    Development Status :: 3 - Alpha
>>>> +    License :: OSI Approved :: GNU General Public License v2 (GPLv2)
>>>> +    Natural Language :: English
>>>> +    Operating System :: OS Independent
>>>> +
>>>
>>
>> Also ... licensing question, do we need *L*GPLv2, or does Python not have a
>> "linking exception" problem?
>>
>> I guess we can't really re-license these files anyway, so nevermind.
>>
>> (I immediately regret asking this.)
>>
> 
> I'll just pretend you never did.
> 
>>> I know the sky is the limit, but I miss the Python version classifier,
>>> at least:
>>>
>>>     Programming Language :: Python :: 3 :: Only
>>>
>>
>> Sure.
>>
>> Wait, why can you specify Python as a language? Is it possible to have
>> non-Python packages on PyPI?
>>
>> *CONCERNED*
>>
> 
> I guess it has to do with packages that can interact or serve other
> languages.  Or, that are (partially) written in another language?
> 
>>> And optionally those:
>>>
>>>     Programming Language :: Python :: 3.6
>>>     Programming Language :: Python :: 3.7
>>>     Programming Language :: Python :: 3.8
>>>     Programming Language :: Python :: 3.9
>>>
>>> Although it may be a good idea to add them along test jobs on those
>>> specific Python versions.
>>>
>>
>> Are these worth adding? I've got python_requires >= 3.6 down below. From my
>> test of a blank package upload to PyPI, it seems to display prominently:
>>
>> https://pypi.org/project/qemu/
>>
>> Is there a tangible benefit that you are aware of?
>>
> 
> AFAICT, the classifiers are about letting people search for packages
> that match a given criteria.  It's all metadata, so the benefits are
> not super tangible.  I've used those to keep track / document the
> Python versions that I know the project has been actively tested on,
> and that's the reason of my comment about (CI) test jobs.
> 

OK, let's add them alongside a tox/pytest configuration or something in 
the future when we add those versions as being supported.

I guess I can add the 3.6 version for starters, since it's explicitly 
supported?

>>>> +[options]
>>>> +python_requires = >= 3.6
>>>> +packages = find_namespace:
>>>> diff --git a/python/setup.py b/python/setup.py
>>>> new file mode 100755
>>>> index 0000000000..e93d0075d1
>>>> --- /dev/null
>>>> +++ b/python/setup.py
>>>> @@ -0,0 +1,23 @@
>>>> +#!/usr/bin/env python3
>>>> +"""
>>>> +QEMU tooling installer script
>>>> +Copyright (c) 2020 John Snow for Red Hat, Inc.
>>>> +"""
>>>> +
>>>> +import setuptools
>>>> +import pkg_resources
>>>> +
>>>> +
>>>> +def main():
>>>> +    """
>>>> +    QEMU tooling installer
>>>> +    """
>>>> +
>>>> +    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-metadata-1babbe54c108
>>>> +    pkg_resources.require('setuptools>=39.2')
>>>
>>> Getting back to the "test jobs on those specific Python versions" I
>>> was really anxious that environments with Python 3.6 will fail to
>>> have such a "recent" setuptools version.
>>>
>>
>> Reasonable doubt. However, this isn't *required* to use the library (the
>> QEMU code can continue to just set PYTHONPATH or sys.path as necessary) and
>> bypasses the installer entirely.
>>
> 
> Right, but I had the impression that activating it in develop mode (at
> least) was the intention down the line.
> 

For builds at all?

I guess we could, yeah, if we wanted to start making a "build venv" and 
install it there. I think there's a lot of questions to work out there 
first, though. I am not really there yet, myself.

Right now, *right now*, all of this code is used only for testing and 
CI, so we've skirted around build requirements.

I did want to start picking up some other packages though, like 'qapi', 
for the purposes of applying the linter paradigm though ... and I 
figured I'd cross that bridge when I got there.

Right now, having a forwarder script with a sys.path hack works.

(Probably by the time we figure that out, setuptools 39 will be standard 
on all of our supported build platforms...)

>> That gives us some leeway apart from the usual version constraints; in order
>> to independently use this library outside of the QEMU tree we may impose
>> more modern setups -- as long as the minimum requirements for QEMU itself
>> don't break.
>>
> 
> OK.
> 
>> Having a modern setuptools in order to install seems like less of a problem
>> barrier; and it seemed like a good idea to make it explicitly fail instead
>> of silently doing something weird if it didn't see/understand setup.cfg.
>>
> 
> Agreed.
> 
>> (And it seems like good practice to update pip in your venv, so I think
>> we'll be OK except for the stodgiest of users, but sometimes you can't have
>> new things on old systems without learning some new tricks!)
>>
>>> CentOS 8 has that specific version, while Ubuntu 18.04 has version
>>> 39.0.  Ubuntu 20.04 has a recent enough version though.  Given that
>>> all GitLab CI moved to 20.04, this should be safe.
>>>
>>> - Cleber.
>>>
>>
>> FWIW, for the purposes of running the linters, I am using Fedora32 and the
>> python36 package.
>>
> 
> This is a minor suggestion: use CentOS 8 stock Python 3.6 packages,
> and then Fedora 33 with also stock Python 3.9.  Even though all
> tools are pinned, it's still a good idea to test at least min/max
> (if not all) Python versions.
> 

I can use CentOS, sure. I don't think it matters tremendously whose 
Python 3.6 we use. I opted for Fedora because we package old python 
interpreters on purpose, which makes it easy to say "I want Python3.6 
and not a drop older or newer."

I assume the same is true on CentOS. We can talk about this on the CI 
series; though I will likely merge these two series into one for future 
revisions.

I don't have a framework in mind for doing python version matrix testing 
yet. I guess tox is the canonical tool for that. We can cross that 
bridge when we get there, I guess. (We currently have: 0 tests for the 
qemu python library. oops!)

For the meantime, though, I think it's OK to only run the linter on 
Python 3.6: it's not a test of the package itself, it's just a specific 
environment that we use to enforce code quality. It so happens to be a 
Python 3.6 environment. Pinning it to a specific version of python there 
is useful because the linters *do* sometimes have different behavior 
depending on version; due largely in part to changes in the stdlib 
typing library.

> - Cleber.
> 
>>>> +
>>>> +    setuptools.setup()
>>>> +
>>>> +
>>>> +if __name__ == '__main__':
>>>> +    main()
>>>> -- 
>>>> 2.26.2
>>>>
>>


