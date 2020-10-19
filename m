Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB4BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A252225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0dhlUrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A252225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXpq-0005UY-Tf
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUXnE-0003VH-Oz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUXnB-0002sb-2j
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603124028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLkNubfYPfvXxw0XnPwQ0A6ogkIuys7UN91UJw51oco=;
 b=U0dhlUrp4CbnToTy8y3RBc++N7B1PWvF48DgYmLop7IwHoYyVItMTh/+JZP6FgCLQ7AREL
 TbI/L0/+AY8TM4kVEmGF+NgT00WHs9oasr/DVO+FnnCfju7ueRoZnfA5wPB/ANcNql2PA0
 AU0eSc31ik+1vkZdT9ZXprZE8mngZKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-7LUbepVoMUaKTBneZz-9Tw-1; Mon, 19 Oct 2020 12:13:44 -0400
X-MC-Unique: 7LUbepVoMUaKTBneZz-9Tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FCB81009636;
 Mon, 19 Oct 2020 16:13:42 +0000 (UTC)
Received: from [10.10.114.194] (ovpn-114-194.rdu2.redhat.com [10.10.114.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D584C10023A5;
 Mon, 19 Oct 2020 16:13:34 +0000 (UTC)
Subject: Re: [PATCH v2 03/15] python: add VERSION file
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
References: <20201014142957.763624-1-jsnow@redhat.com>
 <20201014142957.763624-4-jsnow@redhat.com>
 <5d5148df6e51a70b8980945b5259c248c2994969.camel@redhat.com>
 <20201019100207.GD236912@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <355ca901-2586-b0d0-5973-ad4c8aa2e696@redhat.com>
Date: Mon, 19 Oct 2020 12:13:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201019100207.GD236912@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 6:02 AM, Daniel P. Berrangé wrote:
> On Mon, Oct 19, 2020 at 11:45:09AM +0200, Andrea Bolognani wrote:
>> On Wed, 2020-10-14 at 10:29 -0400, John Snow wrote:
>>> Python infrastructure as it exists today is not capable reliably of
>>> single-sourcing a package version from a parent directory. The authors
>>> of pip are working to correct this, but as of today this is not possible
>>> to my knowledge.
>>>
>>> The problem is that when using pip to build and install a python
>>> package, it copies files over to a temporary directory and performs its
>>> build there. This loses access to any information in the parent
>>> directory, including git itself.
>>>
>>> Further, Python versions have a standard (PEP 440) that may or may not
>>> follow QEMU's versioning. In general, it does; but naturally QEMU does
>>> not follow PEP 440. To avoid any automatically-generated conflict, a
>>> manual version file is preferred.
>>>
>>>
>>> I am proposing:
>>>
>>> - Python core tooling synchronizes with the QEMU version directly
>>>    (5.2.0, 5.1.1, 5.3.0, etc.)
>>>
>>> - In the event that a Python package needs to be updated independently
>>>    of the QEMU version, a pre-release alpha version should be preferred,
>>>    but *only* after inclusion to the qemu development or stable branches.
>>>
>>>    e.g. 5.2.0a1, 5.2.0a2, and so on should be preferred prior to 5.2.0's
>>>    release.
>>>
>>> - The Python core tooling makes absolutely no version compatibility
>>>    checks or constraints. It *may* work with releases of QEMU from the
>>>    past or future, but it is not required to.
>>>
>>>    i.e., "qemu.core" will always remain in lock-step with QEMU.
>>>
>>> - We reserve the right to split out e.g. qemu.core.qmp to qemu.qmp
>>>    and begin indepedently versioning such a package separately from the
>>>    QEMU version it accompanies.
>>
>> I think this need to be considered very carefully.
>>
>> I'm not overly familiar with the Python ecosystem but it would appear
>> that, despite PEP 440 not mandating this, many (most?) of the
>> packages uploaded to PyPi are using semantic versioning.
> 
>    https://packaging.python.org/guides/distributing-packages-using-setuptools/#choosing-a-versioning-scheme
> 
> Semver is the recommended approach, but they explicitly list date
> based versioning as a valid alternative
> 
>    "Semantic versioning is not a suitable choice for all projects,
>     such as those with a regular time based release cadence and a
>     deprecation process that provides warnings for a number of
>     releases prior to removal of a feature."
> 
> That paragraph describes QEMU's scenario.
> 
> NB, historically we've made arbitrary changes to the python code
> since it was not considered public API. If we make it official
> public API, then we would actually need to start following our
> deprecation process for the python code too.
> 

I think our deprecation process is not tightly compatible with how 
Python programmers at-large expect packages to work. Semver is more or 
less the norm, despite the fact that it isn't explicitly required.

setting requirements in requirements.txt, setup.[cfg|py], Pipfile, etc 
often hinge on a major version, e.g.

qemu >= 5.0
qemu >= 3.0, < 6.0

would both be common forms of describing a requirement.

Pinning specific versions is considered bad form, but in the context of 
releasing a package, I often see maintainers hedging their bets and 
preventing upgrades across a major version line.

For that reason I am a little weary of adopting the deprecation policy 
as it exists in QEMU directly, and would propose a modification for my 
purposes here:

- Features must be marked as deprecated
- They must remain in a deprecated state for [at least] 2 releases
- Deprecated features may not be removed until a major version change.

In practice, this modification is a change from "2 releases" to "at 
least 2".

However, I didn't intend to pay any mind to the deprecation policy 
"yet", as I have the package metadata listing the package status as 
"Alpha", see below:

>> With that in mind, I think it would be unwise for qemu.* not to do
>> the same; in particular, using a version number that's not <1.0.0 for
>> a package that is very much in flux will almost certainly break
>> people's expectations, and is also not something that you can easily
>> take back at a later time.
> 
> I don't think it is that big a deal, and there is clear benefit to
> having the python code version match the QEMU version that it is
> the companioon to.
> 

Do you think it's fine if I start versioning at, say, "0.5.2", I could 
ignore a deprecation policy for now? I have a lot of changes I want to 
make and expect a lot of breaking changes very quickly.

I just wanted to try -- somehow -- to conjure up a relationship to the 
QEMU package it's designed to work with.

> Ultimately the versioning scheme just impacts on the version string
> conditionals people list for their dependancies. Apps consuming QEMU
> can handle any of the version schemes without much difference.
> 
> Regards,
> Daniel
> 

Thanks for your input. This is the trickiest part of the process for me.

I believe there is value in distributing these tools for other 
developers to help them prototype and experiment with new features, but 
realize it's a tightrope walk because we're flying dangerously close to 
providing a management utility that needs to care about cross-version 
compatibility and so on.

I have no interest in providing stringent cross-version compatibility, 
but at the same time, libraries like QMP are not really at risk of 
changing all that much, actually. It will *probably* work for most QEMU 
versions.

I have some further patches where I clean up the scripts in 
./scripts/qmp and move them to ./python/qemu/qmp -- and that work is 
making me consider a rework to this series. I think that rework matches 
the spirit of an earlier suggestion of yours:

- move ./python/qemu/core/qmp.py to ./python/qemu/qmp/qmp.py
- (in a follow-up series) move ./scripts/qmp/* to ./python/qemu/qmp/*
- rename ./python/qemu/core/ to ./python/qemu/machine
     (move accel.py, machine.py and qtest.py to a 'machine' pkg.)


In effect, we'd then have:

qemu.machine -- primarily a test interface for QEMU instances
qemu.qmp -- fairly ageless QMP tools/lib for talking to QEMU

and the different levels of support and "use at your own risk" become 
slightly more clear between the two packages.

--js


