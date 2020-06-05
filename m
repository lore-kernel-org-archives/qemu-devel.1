Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8CCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A162077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwQfxV8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A162077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFtY-00019e-6M
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jhFsu-0000Yo-1e
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:12:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40069
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jhFss-0006HB-56
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591377117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LNiu70eIliUr4gT/NyVjv1MDrWz8klna/NhSbKfNFB0=;
 b=BwQfxV8kCt/+bGm3on8nqtXih/KHVzEL5pM077tGfGygvXtd0znFSSffoaGHOEi862KGcp
 htXzIou8clxKCfAKtXeHBWJeeaSEaKmUkxwSbCAv2vAko84znFgJ2CBipFFqL6VJJJNnNY
 2ZOK70k16WcW5DCVj6N9Aco6gdP6CAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-4ms3JJiAM_ykO8YsQrfD8A-1; Fri, 05 Jun 2020 13:11:50 -0400
X-MC-Unique: 4ms3JJiAM_ykO8YsQrfD8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 230FA107ACCA;
 Fri,  5 Jun 2020 17:11:49 +0000 (UTC)
Received: from [10.10.117.188] (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 812C8108BA;
 Fri,  5 Jun 2020 17:11:44 +0000 (UTC)
Subject: Re: [PATCH 4/7] python/qemu: Add pipenv support
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200603001523.18085-5-jsnow@redhat.com>
 <f351d9ee-6126-6efc-b074-ffaf0b664476@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <70809b85-cff5-65ab-78a6-4568e83fe5a4@redhat.com>
Date: Fri, 5 Jun 2020 13:11:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f351d9ee-6126-6efc-b074-ffaf0b664476@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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



On 6/5/20 12:21 PM, Vladimir Sementsov-Ogievskiy wrote:
> 03.06.2020 03:15, John Snow wrote:
>> pipenv is a tool used for managing virtual environments with precisely
>> specified dependencies. It is separate from the dependencies listed in
>> setup.py, which are (by 'best practices') not supposed to be pinned.
>>
>> Note that pipenv is not required to install or use this module; this is
>> just a convenience for in-tree developing.
>>
>> Here, a "blank" pipfile is added with no dependencies, but specifies
>> Python 3.6 for the virtual environment.
>>
>> Pipfile will specify our version minimums, while Pipfile.lock specifies
>> an exact loudout of packages that were known to operate correctly. This
>> latter file provides the real value for easy setup of container images
>> and CI environments.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/Pipfile | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>   create mode 100644 python/Pipfile
>>
>> diff --git a/python/Pipfile b/python/Pipfile
>> new file mode 100644
>> index 00000000000..9534830b5eb
>> --- /dev/null
>> +++ b/python/Pipfile
>> @@ -0,0 +1,11 @@
>> +[[source]]
>> +name = "pypi"
>> +url = "https://pypi.org/simple"
>> +verify_ssl = true
>> +
>> +[dev-packages]
>> +
>> +[packages]
>> +
>> +[requires]
>> +python_version = "3.6"
>>
> 
> Should it be >= or something like this?
> 

I think logistically that makes sense, but I'm not sure if the tool
supports it.

I decided to target the oldest version of Python we support (for
non-build infrastructure) to ensure a minimum viability.

> And, how should I use this all?
> 
> My failed attempt:
> [root@kvm python]# pipenv install --python /usr/bin/python3
> Virtualenv already exists!
> Removing existing virtualenv…
> Creating a virtualenv for this project…
> Pipfile: /work/src/qemu/john-python-installable/python/Pipfile
> Using /usr/bin/python3 (3.7.5) to create virtualenv…
> ⠹ Creating virtual environment...created virtual environment
> CPython3.7.5.final.0-64 in 112ms
>   creator
> CPython3Posix(dest=/root/.local/share/virtualenvs/python-4FwBBPCc,
> clear=False, global=False)
>   seeder FromAppData(download=False, pip=latest, setuptools=latest,
> wheel=latest, via=copy,
> app_data_dir=/root/.local/share/virtualenv/seed-app-data/v1.0.1)
>   activators
> BashActivator,CShellActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator
> 
> 
> ✔ Successfully created virtual environment!
> Virtualenv location: /root/.local/share/virtualenvs/python-4FwBBPCc
> Warning: Your Pipfile requires python_version 3.6, but you are using
> 3.7.5 (/root/.local/share/v/p/bin/python).
>   $ pipenv --rm and rebuilding the virtual environment may resolve the
> issue.
>   $ pipenv check will surely fail.
> Installing dependencies from Pipfile.lock (44d7bd)…
>   🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 0/0 — 00:00:00
> To activate this project's virtualenv, run pipenv shell.
> Alternatively, run a command inside the virtualenv with pipenv run.
> [root@kvm python]# pipenv shell
> Warning: Your Pipfile requires python_version 3.6, but you are using
> 3.7.5 (/root/.local/share/v/p/bin/python).
>   $ pipenv --rm and rebuilding the virtual environment may resolve the
> issue.
>   $ pipenv check will surely fail.
> Launching subshell in virtual environment…
>  . /root/.local/share/virtualenvs/python-4FwBBPCc/bin/activate
> [root@kvm work]#  .
> /root/.local/share/virtualenvs/python-4FwBBPCc/bin/activate
> (python) [root@kvm work]# python
> Python 3.7.5 (default, Oct 17 2019, 12:09:47)
> [GCC 9.2.1 20190827 (Red Hat 9.2.1-1)] on linux
> Type "help", "copyright", "credits" or "license" for more information.
>>>> import pylint
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ModuleNotFoundError: No module named 'pylint'
>>>>
> 
> and iotest 297 says: "pylint-3 not found"
> 

Ah! that's a bug in iotest 297. It's expecting the fedora package there.
I'll have to fix that.

> (honestly, I'm new to using python virtual environment)
> 

Good questions. I'll document this in the README.rst for this folder,
actually...



1. Create a virtual environment

> pipenv sync --dev

jsnow@probe ~/s/q/python (python-package-refactor)> pipenv sync --dev
Creating a virtualenv for this project…
Pipfile: /home/jsnow/src/qemu/python/Pipfile
Using /usr/bin/python3.6 (3.6.10) to create virtualenv…
⠏ Creating virtual environment...Using base prefix '/usr'
New python executable in
/home/jsnow/.local/share/virtualenvs/python-QepCANQl/bin/python3.6
Also creating executable in
/home/jsnow/.local/share/virtualenvs/python-QepCANQl/bin/python
Installing setuptools, pip, wheel...done.
Running virtualenv with interpreter /usr/bin/python3.6

✔ Successfully created virtual environment!
Virtualenv location: /home/jsnow/.local/share/virtualenvs/python-QepCANQl
Installing dependencies from Pipfile.lock (44d7bd)…
  🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 17/17 — 00:00:07
To activate this project's virtualenv, run pipenv shell.
Alternatively, run a command inside the virtualenv with pipenv run.
All dependencies are now up-to-date!


This command can both create and synchronize the venv's packages with
those listed in Pipfile.lock.

It may be helpful to know that Pipfile describes which packages, with
coarse version requirements. Pipfile.lock describes EXACTLY which
package versions to install.

Pipenv, therefore, is a way to produce consistent execution environments
in which we can run tests that are the same for everybody.

When we want to update our packages for this repeatable environment, we
can use 'pipenv update' and commit the Pipfile.lock changes back to git.

(Note, using --dev here installs the development dependencies. If you
omit it, you won't get any packages installed, because there are no
runtime dependencies for this package!)


2. Where did it create the venv?

jsnow@probe ~/s/q/python (python-package-refactor)> pipenv --venv
/home/jsnow/.local/share/virtualenvs/python-QepCANQl


3. Entering the venv

jsnow@probe ~/s/q/python (python-package-refactor)> pipenv shell
Launching subshell in virtual environment…
Welcome to fish, the friendly interactive shell
jsnow@probe ~/s/q/python (python-package-refactor)>  source
/home/jsnow/.local/share/virtualenvs/python-QepCANQl/bin/activate.fish

(python) jsnow@probe ~/s/q/python (python-package-refactor)>

 ^^^^^^ the virtual environment I am in

                     my git branch ^^^^^^^^^^^^^^^^^^^^^^^


This just automates opening a sub-shell and then sourcing the activation
file for you. You can do it manually if you'd like.


4. Installing the QEMU package in development mode to the venv

So far, pipenv only installed our development requirements. Install the
package itself.

From inside `pipenv shell`:

> pip install -e .
Obtaining file:///home/jsnow/src/qemu/python
Installing collected packages: qemu
  Running setup.py develop for qemu
Successfully installed qemu

Or, if you are outside the venv:

> pipenv run pip install -e .


5. Using the qemu package

(From inside the venv)

(python) jsnow@probe ~/s/q/python (python-package-refactor)> python3
Python 3.6.10 (default, Dec 27 2019, 13:40:13)
[GCC 9.2.1 20190827 (Red Hat 9.2.1-1)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import qemu.core
>>> dir(qemu.core)
['QEMUMachine', 'QEMUMonitorProtocol', 'QEMUQtestMachine',
'QEMUQtestProtocol', '__all__', '__builtins__', '__cached__', '__doc__',
'__file__', '__loader__', '__name__', '__package__', '__path__',
'__spec__', 'accel', 'kvm_available', 'list_accel', 'machine', 'qmp',
'qtest', 'tcg_available']
>>>


