Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319AAC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874C120878
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPVleQdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874C120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXXAn-0001w3-IL
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 18:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXX9T-0000Wk-4m
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXX9P-00022C-RK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603836545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=su/bN22lLpmzjCPGy7UhmjkkO3yJHQrgiJUX4Yy+h64=;
 b=QPVleQdhVe1P2ND2Ya4ecTiUzlYG7tO3fkw1iAqMeoiyvVcs9I8d8Sxz2nOOlBgDRODtR2
 acLPFeV7VpcwEYFsWMlZWDf07cQ88Bj51TUeH/w/N6zZXr4WTMPWEauayY74wMr3k0UXdp
 P+s3dDkWgB/vEWSaYR5CV5bu4HH/mb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-0eJTfaT0P8yhEpnShOz2cA-1; Tue, 27 Oct 2020 18:09:02 -0400
X-MC-Unique: 0eJTfaT0P8yhEpnShOz2cA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B4971074649;
 Tue, 27 Oct 2020 22:09:01 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4470855781;
 Tue, 27 Oct 2020 22:08:56 +0000 (UTC)
Subject: Re: [PATCH v3 00/15] python: create installable package
To: qemu-devel@nongnu.org
References: <20201020193555.1493936-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e1289328-d372-0eaa-7128-8cb4867ef4c0@redhat.com>
Date: Tue, 27 Oct 2020 18:08:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
 Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping O:-)

Looking for feedback from at least Cleber and Eduardo before I barge 
ahead and send a PR to include this on master. Additional packaging and 
versioning feedback from Dan would be nice.

(I know we have a very busy two weeks here; I will continue pinging, but 
I have every intention of merging this prior to 5.2.)

--js

On 10/20/20 3:35 PM, John Snow wrote:
> Based-on: https://gitlab.com/jsnow/qemu/-/tree/python
> 
> This series factors the python/qemu directory as an installable
> package. It does not yet actually change the mechanics of how any other
> python source in the tree actually consumes it (yet), beyond the import
> path.
>  > The point of this series is primarily to formalize our dependencies on
> mypy, flake8, isort, and pylint alongside versions that are known to
> work. It also adds explicitly pinned versions of these dependencies that
> should behave in a repeatable and known way for developers and CI
> environments both.
> 
> With the python tooling as a proper package, you can install this
> package in editable or production mode to a virtual environment, your
> local user environment, or your system packages. The primary benefit of
> this is to gain access to QMP tooling regardless of CWD, without needing
> to battle sys.path.
> 
> For example: when developing, you may go to qemu/python/ and invoke
> `pipenv shell` to activate a virtual environment that contains the qemu
> packages.  This package will always reflect the current version of the
> source files in the tree. When you are finished, you can simply exit the
> shell to remove these packages from your python environment.
> 
> When not developing, you could install a version of this package to your
> environment outright to gain access to the QMP and QEMUMachine classes
> for lightweight scripting and testing by using pip: "pip install [--user] ."
> 
> Finally, this package is formatted in such a way that it COULD be
> uploaded to https://pypi.org/project/qemu and installed independently of
> qemu.git with `pip install qemu`, but that button remains unpushed.
> 
> TESTING THIS SERIES:
> 
> CD to qemu/python first, and then:
> 
> 1. Try "pipenv shell" to get a venv with the package installed to it in
> editable mode. Ctrl+d exits this venv shell. While in this shell, any
> python script that uses "from qemu.[qmp|machine] import ..." should work
> correctly regardless of your CWD.
> 
> 2. Try "pipenv sync --dev" to create/update the venv with the
> development packages without actually entering the venv. This should
> install isort, mypy, flake8 and pylint to the venv.
> 
> 3. After the above sync, try "pipenv shell" again, and from the python
> project root, try any of the following:
> 
>    - pylint qemu
>    - flake8 qemu
>    - isort -c qemu
>    - mypy qemu
> 
> 4. Leave any venv you are in, and from the project root, try the
> following commands:
> 
>    - pipenv run pylint qemu
>    - pipenv run flake8 qemu
>    - pipenv run isort -c qemu
>    - pipenv run mypy qemu
> 
> V3:
>   - Changed "qemu.core" to "qemu.qmp" and "qemu.machine",
>     Partly to accommodate forthcoming work which would benefit from a separate
>     qemu.qmp namespace.
>   - Changed the initial version from 5.2.0a1 to 0.5.2.0a1, to allow for
>     more rapid development while we smooth out the initial kinks.
>   - 001: Renamed patch title; differences implement the new names.
>   - 002: Readme changes for above.
>   - 003: Version change.
>   - 004: New readme for the new qmp directory.
>   - 006: A few more import exceptions for pylint, hopefully temporary.
>   - 009: Updated flake8 config comment to match qapi's
>   - 012: Added namespace_package configuration value
> 
> 001/15:[down] 'python: create qemu packages'
> 002/15:[0009] [FC] 'python: add qemu package installer'
> 003/15:[0002] [FC] 'python: add VERSION file'
> 004/15:[0015] [FC] 'python: add directory structure README.rst files'
> 005/15:[----] [--] 'python: Add pipenv support'
> 006/15:[down] 'python: add pylint import exceptions'
> 007/15:[----] [--] 'python: move pylintrc into setup.cfg'
> 008/15:[----] [--] 'python: add pylint to pipenv'
> 009/15:[0002] [FC] 'python: move flake8 config to setup.cfg'
> 010/15:[----] [--] 'python: Add flake8 to pipenv'
> 011/15:[----] [-C] 'python: move mypy.ini into setup.cfg'
> 012/15:[0001] [FC] 'python: add mypy to pipenv'
> 013/15:[----] [--] 'python: move .isort.cfg into setup.cfg'
> 014/15:[----] [--] 'python/qemu: add isort to pipenv'
> 015/15:[----] [--] 'python/qemu: add qemu package itself to pipenv'
> 
> John Snow (15):
>    python: create qemu packages
>    python: add qemu package installer
>    python: add VERSION file
>    python: add directory structure README.rst files
>    python: Add pipenv support
>    python: add pylint import exceptions
>    python: move pylintrc into setup.cfg
>    python: add pylint to pipenv
>    python: move flake8 config to setup.cfg
>    python: Add flake8 to pipenv
>    python: move mypy.ini into setup.cfg
>    python: add mypy to pipenv
>    python: move .isort.cfg into setup.cfg
>    python/qemu: add isort to pipenv
>    python/qemu: add qemu package itself to pipenv
> 
>   python/PACKAGE.rst                          |  26 +++
>   python/README.rst                           |  27 +++
>   python/qemu/README.rst                      |   8 +
>   python/qemu/machine/README.rst              |   9 +
>   python/qemu/qmp/README.rst                  |   9 +
>   python/Pipfile                              |  16 ++
>   python/Pipfile.lock                         | 207 ++++++++++++++++++++
>   python/VERSION                              |   1 +
>   python/mypy.ini                             |   4 -
>   python/qemu/.flake8                         |   2 -
>   python/qemu/.isort.cfg                      |   7 -
>   python/qemu/__init__.py                     |  11 --
>   python/qemu/machine/__init__.py             |  44 +++++
>   python/qemu/{ => machine}/accel.py          |   0
>   python/qemu/{ => machine}/console_socket.py |   0
>   python/qemu/{ => machine}/machine.py        |  16 +-
>   python/qemu/{ => machine}/qtest.py          |   3 +-
>   python/qemu/{qmp.py => qmp/__init__.py}     |  12 +-
>   python/{qemu/pylintrc => setup.cfg}         |  67 ++++---
>   python/setup.py                             |  23 +++
>   tests/acceptance/boot_linux.py              |   3 +-
>   tests/qemu-iotests/297                      |   2 +-
>   tests/qemu-iotests/300                      |   4 +-
>   tests/qemu-iotests/iotests.py               |   2 +-
>   tests/vm/basevm.py                          |   3 +-
>   25 files changed, 437 insertions(+), 69 deletions(-)
>   create mode 100644 python/PACKAGE.rst
>   create mode 100644 python/README.rst
>   create mode 100644 python/qemu/README.rst
>   create mode 100644 python/qemu/machine/README.rst
>   create mode 100644 python/qemu/qmp/README.rst
>   create mode 100644 python/Pipfile
>   create mode 100644 python/Pipfile.lock
>   create mode 100644 python/VERSION
>   delete mode 100644 python/mypy.ini
>   delete mode 100644 python/qemu/.flake8
>   delete mode 100644 python/qemu/.isort.cfg
>   delete mode 100644 python/qemu/__init__.py
>   create mode 100644 python/qemu/machine/__init__.py
>   rename python/qemu/{ => machine}/accel.py (100%)
>   rename python/qemu/{ => machine}/console_socket.py (100%)
>   rename python/qemu/{ => machine}/machine.py (98%)
>   rename python/qemu/{ => machine}/qtest.py (98%)
>   rename python/qemu/{qmp.py => qmp/__init__.py} (96%)
>   rename python/{qemu/pylintrc => setup.cfg} (50%)
>   mode change 100644 => 100755
>   create mode 100755 python/setup.py
> 


