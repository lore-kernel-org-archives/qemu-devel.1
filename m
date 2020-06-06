Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B36C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 05:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718E320723
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 05:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iEoNceLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718E320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhRRO-0002zr-OO
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 01:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhRQn-0002V9-Q0; Sat, 06 Jun 2020 01:31:45 -0400
Received: from mail-vi1eur05on2110.outbound.protection.outlook.com
 ([40.107.21.110]:14048 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhRQk-00018w-Hu; Sat, 06 Jun 2020 01:31:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moq9yCPgnSabh+6AdjbCbU1nL7etbCITo+lGEMWr/UyVfS+mcNTedfW22mKEArQJXnjy06M4w+7eVtlvtUc323MHBw6lWGy4/ClC3Pi7UQIm+g9aYvJK19BwI/VaAu/qCsS08LaDYOj2Vj0kjcrsD0BMMyD9ZqZJR1cOhcE/GEYqaqkl3SEHZ6+t19SM65LN/g6NyohnXPcGqE3mcJ1pQP21s9TQryS9mLFNINiA2ulzV4uLR+6opj0S0P3GMriyR20jeyQoN4NK0r1qLk4CC+/6h8/GmGkiFd88LhwDpvio2OVhyAXGPMr5KTE3FLU3XzBKxyqunB8JoGpKDM514g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThUknmnzv9xkQJFh3iiLnxm9GT2uCadultR/iP5RtBo=;
 b=g4wcUX1BO8TTBJu4CihAaRxQ3Yg7RNtGX8zV+bpjK861JPYhZoEvodPWRfNDNnQ6VSvOxVUrzR0PTrnnAA3pq0tE/Vf5L6LP2IVhu8kTpLK8ogN/SWGg+MGN6ymvpfuw/XY5KjjgI8Y/Enbt7UqRcxHnCNGjOl6Ws4T1mu9Kd5N7F6kqR2zu0bTydF7Qv7P0LAoow+aQNa+GxCUqr4y4FNAZ0RHBLwFgiugxm8iz/AX66PQ68ElF0DK2NOG6O/+rvQ4udrjLPv+MmncwLEPoJjZjBNjof/ylYYYgQbuK46CLFe2UuHVCA46oij69UvxI/XqbqEgbrElFr9i+wgdpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThUknmnzv9xkQJFh3iiLnxm9GT2uCadultR/iP5RtBo=;
 b=iEoNceLmm07ijMvJcQuIAAHmtBGypbBinvJ2iTPgwWkXXlrg2y9a+95QXnUKsJ+oRrvdwGxniry2nJGNx1Bh3pF/zvaHhbcb/y/gXXypSY2+L3lHD+nwPPHOa9R6SAXGelvHVUv/jgbCYDEOWrZ6z50VsDTnKOBbuMk1FIfg3DA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2784.eurprd08.prod.outlook.com (2603:10a6:802:25::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Sat, 6 Jun
 2020 05:31:37 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3066.022; Sat, 6 Jun 2020
 05:31:37 +0000
Subject: Re: [PATCH 4/7] python/qemu: Add pipenv support
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200603001523.18085-5-jsnow@redhat.com>
 <f351d9ee-6126-6efc-b074-ffaf0b664476@virtuozzo.com>
 <70809b85-cff5-65ab-78a6-4568e83fe5a4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ecd29356-e714-c5dc-c0e5-2ecc6f2dc580@virtuozzo.com>
Date: Sat, 6 Jun 2020 08:31:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <70809b85-cff5-65ab-78a6-4568e83fe5a4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0069.eurprd07.prod.outlook.com
 (2603:10a6:207:4::27) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.130) by
 AM3PR07CA0069.eurprd07.prod.outlook.com (2603:10a6:207:4::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.9 via Frontend Transport; Sat, 6 Jun 2020 05:31:36 +0000
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b27b786-22f8-4c3d-2017-08d809dae20f
X-MS-TrafficTypeDiagnostic: VI1PR08MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR08MB278418F3F86A1430CB92D725C1870@VI1PR08MB2784.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOkL+cG3WSQgc1Xjl7WKtb2dhmZ+Hql/essQuxBoHNoWvk7MViK+p3Z1mEa7vxmM1xHSebRPMNmo9qus3RExXsgEsfW9De7BtLQNcxogClT/V9zzy6mbFYty09ZG7FzTCbkfVuI2hcWA7ip0+2k16ADL5aJ7Q73u5KZToO4yeFgKGDMCAmrr5y4nGoS0o1uohzZIJVISidOOLNe5C/W0IULGDQuJ7W2oNLw2lee63pA6r3EuPwjalCz2ls+uDIjWaTcMHEBCxrQA2NzMkUzcP/fOB68sSU0BcYjLSJBL8iuXgOuYj8Lyaw1VAbHe2R392mshGpf6bz3N45c3fZNRkAGb8ZoLNuMdaFHDnmAGtN7REU8Q+nlSEBKys2yI8VRPzG7A9AvP5xUkBYOOCwM7acL7v0qEdcz00IyjbkOMOh5fswQZ/Fb9Vt3mRuvR5ymTjxkYtTfcG8563qP0GCNibA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(376002)(16576012)(66476007)(83380400001)(31686004)(66946007)(7416002)(5660300002)(86362001)(66556008)(2906002)(36756003)(956004)(8676002)(508600001)(52116002)(2616005)(26005)(8936002)(4326008)(16526019)(53546011)(31696002)(19627235002)(54906003)(186003)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MtZbdgWycUEZoal1TnPANZLL2YE+YPLSs3zpgCQ8/goCQw+WHrX4ufDhiDxFF8dCu2XlNqFUV4cEL5HdSjS6oCtEdf9YoF9nY7khqUaQ3H8DYhKrdA1yYO4gxw/XBdTXAAinMGSXc7lYGPaAiw8xVppIhJEKLqqh+IH7ClzzsW+XQGjR9N1HwbIPyhD5gU3jcCb6UicJfChxP55f2lprWKnjl5I5OAX3AxYgZnLbkAJQwrpvaQqHhrL+ceQalQCJaNRjgJfUxiRrzVLxaQIpBnmr1SQEJivG53UpyXbUx/FXeRjcqiv9JAZ+ogoY2XNvc/u6aBB6nupdOCuODROlj3wt+SU2cRF+cLbJ5lltfAWGy/9Zqd7cOSAtqX+uJ188VGcMumlAhaxoELbJ1MoKVj7m0SPIdmgdjadmoVR2He0CzptX4zOkwJpwnOz2FK6RkWWQxYDSgKetSuLgq8O2EfTL4peenW2FfSeIGZMJI5vmlFswTQblSTOHXCViIe8l
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b27b786-22f8-4c3d-2017-08d809dae20f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 05:31:37.5825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHt/+UYNlKwOhk/YsuRI/BNWdL5TsQCzlZcjFUk9pMMpLM1MarxjQ68nA6fZ+hD8P5hSgie9Xa79gcSiS/qgF4qakaQ1lCH7rQK27AdW1fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2784
Received-SPF: pass client-ip=40.107.21.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 01:31:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.06.2020 20:11, John Snow wrote:
> 
> 
> On 6/5/20 12:21 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 03.06.2020 03:15, John Snow wrote:
>>> pipenv is a tool used for managing virtual environments with precisely
>>> specified dependencies. It is separate from the dependencies listed in
>>> setup.py, which are (by 'best practices') not supposed to be pinned.
>>>
>>> Note that pipenv is not required to install or use this module; this is
>>> just a convenience for in-tree developing.
>>>
>>> Here, a "blank" pipfile is added with no dependencies, but specifies
>>> Python 3.6 for the virtual environment.
>>>
>>> Pipfile will specify our version minimums, while Pipfile.lock specifies
>>> an exact loudout of packages that were known to operate correctly. This
>>> latter file provides the real value for easy setup of container images
>>> and CI environments.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>    python/Pipfile | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>    create mode 100644 python/Pipfile
>>>
>>> diff --git a/python/Pipfile b/python/Pipfile
>>> new file mode 100644
>>> index 00000000000..9534830b5eb
>>> --- /dev/null
>>> +++ b/python/Pipfile
>>> @@ -0,0 +1,11 @@
>>> +[[source]]
>>> +name = "pypi"
>>> +url = "https://pypi.org/simple"
>>> +verify_ssl = true
>>> +
>>> +[dev-packages]
>>> +
>>> +[packages]
>>> +
>>> +[requires]
>>> +python_version = "3.6"
>>>
>>
>> Should it be >= or something like this?
>>
> 
> I think logistically that makes sense, but I'm not sure if the tool
> supports it.
> 
> I decided to target the oldest version of Python we support (for
> non-build infrastructure) to ensure a minimum viability.
> 
>> And, how should I use this all?
>>
>> My failed attempt:
>> [root@kvm python]# pipenv install --python /usr/bin/python3
>> Virtualenv already exists!
>> Removing existing virtualenv…
>> Creating a virtualenv for this project…
>> Pipfile: /work/src/qemu/john-python-installable/python/Pipfile
>> Using /usr/bin/python3 (3.7.5) to create virtualenv…
>> ⠹ Creating virtual environment...created virtual environment
>> CPython3.7.5.final.0-64 in 112ms
>>    creator
>> CPython3Posix(dest=/root/.local/share/virtualenvs/python-4FwBBPCc,
>> clear=False, global=False)
>>    seeder FromAppData(download=False, pip=latest, setuptools=latest,
>> wheel=latest, via=copy,
>> app_data_dir=/root/.local/share/virtualenv/seed-app-data/v1.0.1)
>>    activators
>> BashActivator,CShellActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator
>>
>>
>> ✔ Successfully created virtual environment!
>> Virtualenv location: /root/.local/share/virtualenvs/python-4FwBBPCc
>> Warning: Your Pipfile requires python_version 3.6, but you are using
>> 3.7.5 (/root/.local/share/v/p/bin/python).
>>    $ pipenv --rm and rebuilding the virtual environment may resolve the
>> issue.
>>    $ pipenv check will surely fail.
>> Installing dependencies from Pipfile.lock (44d7bd)…
>>    🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 0/0 — 00:00:00
>> To activate this project's virtualenv, run pipenv shell.
>> Alternatively, run a command inside the virtualenv with pipenv run.
>> [root@kvm python]# pipenv shell
>> Warning: Your Pipfile requires python_version 3.6, but you are using
>> 3.7.5 (/root/.local/share/v/p/bin/python).
>>    $ pipenv --rm and rebuilding the virtual environment may resolve the
>> issue.
>>    $ pipenv check will surely fail.
>> Launching subshell in virtual environment…
>>   . /root/.local/share/virtualenvs/python-4FwBBPCc/bin/activate
>> [root@kvm work]#  .
>> /root/.local/share/virtualenvs/python-4FwBBPCc/bin/activate
>> (python) [root@kvm work]# python
>> Python 3.7.5 (default, Oct 17 2019, 12:09:47)
>> [GCC 9.2.1 20190827 (Red Hat 9.2.1-1)] on linux
>> Type "help", "copyright", "credits" or "license" for more information.
>>>>> import pylint
>> Traceback (most recent call last):
>>    File "<stdin>", line 1, in <module>
>> ModuleNotFoundError: No module named 'pylint'
>>>>>
>>
>> and iotest 297 says: "pylint-3 not found"
>>
> 
> Ah! that's a bug in iotest 297. It's expecting the fedora package there.
> I'll have to fix that.
> 
>> (honestly, I'm new to using python virtual environment)
>>
> 
> Good questions. I'll document this in the README.rst for this folder,
> actually...
> 
> 
> 
> 1. Create a virtual environment
> 
>> pipenv sync --dev
> 
> jsnow@probe ~/s/q/python (python-package-refactor)> pipenv sync --dev
> Creating a virtualenv for this project…
> Pipfile: /home/jsnow/src/qemu/python/Pipfile
> Using /usr/bin/python3.6 (3.6.10) to create virtualenv…
> ⠏ Creating virtual environment...Using base prefix '/usr'
> New python executable in
> /home/jsnow/.local/share/virtualenvs/python-QepCANQl/bin/python3.6
> Also creating executable in
> /home/jsnow/.local/share/virtualenvs/python-QepCANQl/bin/python
> Installing setuptools, pip, wheel...done.
> Running virtualenv with interpreter /usr/bin/python3.6
> 
> ✔ Successfully created virtual environment!
> Virtualenv location: /home/jsnow/.local/share/virtualenvs/python-QepCANQl
> Installing dependencies from Pipfile.lock (44d7bd)…
>    🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 17/17 — 00:00:07
> To activate this project's virtualenv, run pipenv shell.
> Alternatively, run a command inside the virtualenv with pipenv run.
> All dependencies are now up-to-date!
> 
> 
> This command can both create and synchronize the venv's packages with
> those listed in Pipfile.lock.
> 
> It may be helpful to know that Pipfile describes which packages, with
> coarse version requirements. Pipfile.lock describes EXACTLY which
> package versions to install.
> 
> Pipenv, therefore, is a way to produce consistent execution environments
> in which we can run tests that are the same for everybody.
> 
> When we want to update our packages for this repeatable environment, we
> can use 'pipenv update' and commit the Pipfile.lock changes back to git.
> 
> (Note, using --dev here installs the development dependencies. If you
> omit it, you won't get any packages installed, because there are no
> runtime dependencies for this package!)

Seems, that was my mistake, now it works, thanks!

> 
> 
> 2. Where did it create the venv?
> 
> jsnow@probe ~/s/q/python (python-package-refactor)> pipenv --venv
> /home/jsnow/.local/share/virtualenvs/python-QepCANQl
> 
> 
> 3. Entering the venv
> 
> jsnow@probe ~/s/q/python (python-package-refactor)> pipenv shell
> Launching subshell in virtual environment…
> Welcome to fish, the friendly interactive shell
> jsnow@probe ~/s/q/python (python-package-refactor)>  source
> /home/jsnow/.local/share/virtualenvs/python-QepCANQl/bin/activate.fish
> 
> (python) jsnow@probe ~/s/q/python (python-package-refactor)>
> 
>   ^^^^^^ the virtual environment I am in
> 
>                       my git branch ^^^^^^^^^^^^^^^^^^^^^^^
> 
> 
> This just automates opening a sub-shell and then sourcing the activation
> file for you. You can do it manually if you'd like.
> 
> 
> 4. Installing the QEMU package in development mode to the venv
> 
> So far, pipenv only installed our development requirements. Install the
> package itself.
> 
>  From inside `pipenv shell`:
> 
>> pip install -e .
> Obtaining file:///home/jsnow/src/qemu/python
> Installing collected packages: qemu
>    Running setup.py develop for qemu
> Successfully installed qemu
> 
> Or, if you are outside the venv:
> 
>> pipenv run pip install -e .
> 
> 
> 5. Using the qemu package
> 
> (From inside the venv)
> 
> (python) jsnow@probe ~/s/q/python (python-package-refactor)> python3
> Python 3.6.10 (default, Dec 27 2019, 13:40:13)
> [GCC 9.2.1 20190827 (Red Hat 9.2.1-1)] on linux
> Type "help", "copyright", "credits" or "license" for more information.
>>>> import qemu.core
>>>> dir(qemu.core)
> ['QEMUMachine', 'QEMUMonitorProtocol', 'QEMUQtestMachine',
> 'QEMUQtestProtocol', '__all__', '__builtins__', '__cached__', '__doc__',
> '__file__', '__loader__', '__name__', '__package__', '__path__',
> '__spec__', 'accel', 'kvm_available', 'list_accel', 'machine', 'qmp',
> 'qtest', 'tcg_available']
>>>>
> 


-- 
Best regards,
Vladimir

