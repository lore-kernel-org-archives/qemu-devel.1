Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F215DC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3505C24808
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1Y/aKa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3505C24808
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqHm-000555-6W
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXqGS-0003wg-Tu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXqGP-0000wM-DZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603910015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nX5r7eLcHAN3NDKRqSULbN2vVjWfNdn5akVdS3bgzP0=;
 b=i1Y/aKa0TuSwgfYWa4Z4OLD/cgng5J0O29SlCv5aXlMj0Yil9TtR3GO1aDjN0ZRZiDjaku
 YW4qVLLWfv7E0GPagB2H5LNI+flacdaHVCC3I1Z2pPtUNDal6ZwA8kCUVIY9Ro5DP4iJta
 8iWuozafEqC++yhmnYEo3oyyvB1x/T4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-44yg39H5OB6EaKoasUa0QQ-1; Wed, 28 Oct 2020 14:33:33 -0400
X-MC-Unique: 44yg39H5OB6EaKoasUa0QQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 092741019625;
 Wed, 28 Oct 2020 18:33:32 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C96AE5C1D7;
 Wed, 28 Oct 2020 18:33:27 +0000 (UTC)
Subject: Re: [PATCH 4/5] python: add .gitignore
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201027223815.159802-1-jsnow@redhat.com>
 <20201027223815.159802-5-jsnow@redhat.com>
 <f9ea6ce1-f464-0376-29ac-6071f680e63b@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3c46ae21-c8fe-41ff-ac42-7e42524c857d@redhat.com>
Date: Wed, 28 Oct 2020 14:33:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f9ea6ce1-f464-0376-29ac-6071f680e63b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 4:13 AM, Thomas Huth wrote:
> On 27/10/2020 23.38, John Snow wrote:
>> Ignore build and package output (build, dist, qemu.egg-info);
>> effectively these are "in-tree" builds of a kind.
> 
> Since we recently moved away from in-tree builds, could these also be made
> out-of-tree only?
> 
>   Thomas
> 

# Summary

This wound up being controversial, so let's go over exactly what 
artifacts I have ignored here, and why I have done so. This email gets 
long, but please stick with me for at least this first Summary section.

One thing I would like to immediately clear up is that these artifacts 
are not related to a "QEMU build" in any way, shape or form; i.e., 
building QEMU does not cause these artifacts to exist.

For clarity: neither "make" nor "make check" from the root nor the build 
root will cause any changes to the ./python source tree. These artifacts 
come from explicit actions taken during manual testing/development in 
the ./python directory.

I use a Makefile in the ./python directory to canonize the expected 
invocations for a few common operations I anticipate developers wanting 
to take; these actions occur outside of "the QEMU build".


Those actions, and the expected artifacts they create, are:

- Running 'make check' inside ./python; AKA
   running 'pytest' (no arguments.)
   (.mypy_cache, .pytest_cache, __pycache__, possibly *.pyc)

- Running 'make venv' inside ./python; AKA
   running PIPENV_VENV_IN_PROJECT=1 pipenv sync --dev --keep-outdated
   (.venv, qemu.egg-info/, build/)

- Running 'make venv-check' inside ./python; AKA
   running 'make venv; pipenv run make check'
   (All of the above from both categories)

- Running various PyPI distribution commands; not in the Makefile
   (e.g. python3 setup.py sdist bdist_wheel)
   (build/, dist/)

- Using the Pycharm IDE to edit, run, or test python files:
   (.idea/)


While these do not happen during a (QEMU) make/make check, they DO 
happen as a result of my gitlab job, which simply does the dumbest 
possible thing and navigates to the source ./python directory and runs 
"make venv-check".

This was presumed "safe", because the gitlab output is not committed 
back into the container, does not affect the subsequent build, and has 
its output discarded after the job completes.

Read on below for more detailed information on what each file is, what 
creates it, what it's useful for, and why you might come to have these 
files in your source tree during development.



# make check

running "make check" here simply invokes "pytest". This causes 
.pytest_cache to exist where you ran it. The tests located in tests/ 
will run mypy (.mypy_cache), flake8, pylint and isort.

The act of running or importing files here may or may not cause 
__pycache__ and *.pyc files to exist based on the caller's environment.

All of the files created by running the linter are normal confetti you 
might expect to incur from running such programs; i.e. if you run mypy 
or pytest separately, of your own volition, you will encounter these 
files being made for you.

It is normal and expected for developers to want to run the linters 
during development to ensure adherence to the coding standards, so it is 
normal and expected to see these files being created in the source tree 
-- not during a build, but during development.

We ignore __pycache__ and *.pyc in the root tree too, this is just 
extending the concept to more python tooling that may litter the tree.


# make venv

This is an alias for "pipenv sync --dev", which uses the pipenv tool to 
actualize a very specific virtual environment based on the contents in 
Pipfile.lock.

It normally creates a virtual environment somewhere like:
  /home/jsnow/.local/share/virtualenvs/python-Z09Et8eW

but you can configure it to look in $CWD/.venv instead. There are no 
other options I am aware of! Your $CWD must include the Pipfile.lock file.

Let's assume that we will want to create a venv in two distinct contexts:

(1) For the purposes of iterative development; as an object we want to 
keep long-term (conjured explicitly by the developer), and

(2) For the purposes of a continuous integration check; a build check, 
or some other automatic invocation not explicitly conjured by the developer.

For the first, it's okay to store in ~/.local/share/ etc, and it's okay 
to store it in the source tree too -- in both cases, you'll have one 
venv per source tree. No problem. (And reminder, because this python 
virtual environment is tied to the python *source* and has no 
relationship whatsoever to a configuration of a QEMU build, a 1:1 
relationship from venv:source is OK. We do not need (or want) a 1:1 
relationship with configurations.)

For the second, it would be best if we didn't taint the user's 
environment. In this case, constraining it to where the the venv was 
requested is the best choice available. There are no hooks in this patch 
series that will invoke the creation of this venv in the source tree 
when a user types "make" or "make check" in their root or their build root.

So: ignoring .venv is for the sake of the python developer, but does not 
imply this file will exist for those not developing python.

Lastly, The qemu.egg-info file is an artifact of installing the source 
package itself into the virtual environment in "editable" mode. This is 
an expected artifact of development, but won't occur during a build.

A trick I explicitly support is `cd ~/src/qemu/python; pip install -e .` 
-- this installs a python package to your current environment (wherever 
it is; It can be one of your explicit creation) that simply installs 
symlinks to your git source tree -- this is a feature -- so that while 
updating the python source, your installed package always reflects the 
latest version without having to "re-install" the package to test it.

Therefore, it's reasonable and expected to have a 'qemu.egg-info/' 
folder in your source tree: it means you've installed this package 
somewhere. This doesn't happen by accident!


# make venv-check

This is a hook that runs both things: it creates a venv, then runs the 
tests inside that venv. It will create all of the confetti from both 
above processes.

If you made a build directory and configured QEMU, the configuration 
script will have copied the python directory into the build directory. 
You can run "make venv-check" from in there to avoid disturbing your 
source tree.

However, since running configure isn't necessary to check the python 
code, you can just run it straight from the source tree.


# .idea

This is the pycharm IDE folder for managing project settings. If you use 
pycharm to edit the Python code (and I encourage you to try if you wish 
to contribute Python code), you will see this directory created.


# build

This directory will be created as a result of engaging with pipenv.

It will show up under any of the following:

pipenv sync
pipenv lock
pipenv install

I believe this happens as a side-effect of installing the qemu package 
in editable mode, however:

`pip install -e .` does not create such a directory. I'm not sure which 
step is creating it and what it's used for, to be crassly honest. It 
appears safe to delete afterwards.

Actually, you can even create a read-only build directory owned by root, 
and pipenv will ... work the same, and never write into that directory. 
What's going on? Someone else's bug, I guess.

(It also shows up if you were to type "python3 setup.py bdist_wheel", 
which is a packaging step you would only type if you were preparing to 
build and package this code to upload it to PyPI.)


# dist

Only shows up if you type 'python3 setup.py sdist'. No reason to do this 
unless you're building a source distribution of the Python package alone 
to upload to somewhere else. Intentional developer action.


So ... long story short: I think these files are legitimate; I am sorry 
to have alarmed people by calling it an "in-tree build", they're not 
related to the QEMU build.

--js


