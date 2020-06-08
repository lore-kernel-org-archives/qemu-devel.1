Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6DB2076C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaXh43bD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6DB2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIZY-0007R1-U1
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jiIYH-0006rX-De
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:15:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jiIYF-0003tV-Lz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 10:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591625697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OTSxJ+mBihR41WZGZUTdoxhaOdMGUvq7Z/DhdA5eud8=;
 b=YaXh43bDjIXQeMCwywAJWSBbDpoHCqpH9K9ZTN9bqM007Pj56XJDWjXbjxSK5XtdA7xbS/
 zd9y+DfSiEtfrzoTp5SxDDBwoDBmDroyDjkNKBOQgPIJVkTz9eja4xDk563Xfd2Kxspnrj
 pM+XuURFdCuycfdezaSmNa283aha5ME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-kPz7U-goNiCMTtwqQ0ILvQ-1; Mon, 08 Jun 2020 10:14:50 -0400
X-MC-Unique: kPz7U-goNiCMTtwqQ0ILvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24CC0107ACF2;
 Mon,  8 Jun 2020 14:14:49 +0000 (UTC)
Received: from [10.10.117.188] (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B21B61A8EA;
 Mon,  8 Jun 2020 14:14:44 +0000 (UTC)
Subject: Re: [PATCH 0/7] python: create installable package
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200603001523.18085-1-jsnow@redhat.com>
 <8f64d361-d167-f539-8c8e-b432b037be36@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <55ea34e7-c0b3-73ff-4e2d-7c127263af02@redhat.com>
Date: Mon, 8 Jun 2020 10:14:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8f64d361-d167-f539-8c8e-b432b037be36@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/6/20 1:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> For patches 05-07:
> 
> Reviewing such patch is a strange thing: Pipfile changes are obvious
> enough, just select some version (I can't be sure about correct version
> choice, just believe in your commit messages). But what for
> Pipfile.lock? I can state that it's about package set selecting,
> Pipfile.lock looks like what it should be, but I have idea about all
> these packages, their versions and hashes (and even, does it correspond
> really to Pipfile or not) :)
> 
> Ha, what I can check, is: does pipenv create almost same Pipfile.lock in
> my environment (with 3.7.5 python)
> OK, I've tried (pipenv lock --dev --python /usr/bin/python3), and yes,
> result is almost the same. For mypy and importlib-metadata packages I
> have newer version and different hashes (of course). Other packages are
> the same. Set of packages is the same.
> 
> Hmm, but in may generated Pipfile.lock there no "markers". They are
> about python version and looks like "markers": "python_version >=
> '3.5'".. Does pipenv follow them? Then why they are not generated for
> me, did you use some additional command/option to create them?
> Anyway, they don't look dangerous, so for last three patches:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 

Yes, from a blank repository you can do "pipenv install mypy>=0.730" --
it uses the same package specification syntax that pip uses.

(Or, you can edit the Pipfile manually, which is what I actually did.
The benefit of doing so is primarily about documenting our minimum
version requirements. I suppose in truth, those minimums should go into
setup.py too, actually.)

Thanks for taking a look!

--js

> 03.06.2020 03:15, John Snow wrote:
>> Based-on: 20200602214528.12107-1-jsnow@redhat.com
>>
>> This series factors the python/qemu directory as an installable
>> module. As a developer, you can install this to your virtual environment
>> and then always have access to the classes contained within without
>> needing to wrangle python import path problems.
>>
>> When developing, you could go to qemu/python/ and invoke `pipenv shell`
>> to activate a virtual environment within which you could type `pip
>> install -e .` to install a special development version of this package
>> to your virtual environment. This package will always reflect the most
>> recent version of the source files in the tree.
>>
>> When not developing, you could install a version of this package to your
>> environment outright to gain access to the QMP and QEMUMachine classes
>> for lightweight scripting and testing.
>>
>> This package is formatted in such a way that it COULD be uploaded to
>> https://pypi.org/project/qemu and installed independently of qemu.git
>> with `pip install qemu`, but of course that button remains unpushed.
>>
>> There are a few major questions to answer first:
>>
>> - What versioning scheme should we use? See patch 2.
>>
>> - Should we use a namespace package or not?
>>    - Namespaced: 'qemu.machine', 'qemu.monitor' etc may be separately
>>      versioned, packaged and distributed packages. Third party authors
>>      may register 'qemu.xxx' to create plugins within the namespace as
>>      they see fit.
>>
>>    - Non-namespaced: 'qemu' is one giant glob package, packaged and
>>      versioned in unison. We control this package exclusively.
>>
>> - How do we eliminate sys.path hacks from the rest of the QEMU tree?
>>    (Background: sys.path hacks generally impede the function of static
>>    code quality analysis tools like mypy and pylint.)
>>
>>    - Simplest: parent scripts (or developer) needs to set PYTHONPATH.
>>
>>    - Harder: Python scripts should all be written to assume package form,
>>      all tests and CI that use Python should execute within a VENV.
>>
>>    In either case, we lose the ability (for many scripts) to "just run" a
>>    script out of the source tree if it depends on other QEMU Python
>>    files. This is annoying, but as the complexity of the Python lib
>>    grows, it is unavoidable.
>>
>>    In the VENV case, we at least establish a simple paradigm: the scripts
>>    should work in their "installed" forms; and the rest of the build and
>>    test infrastructure should use this VENV to automatically handle
>>    dependencies and path requirements. This should allow us to move many
>>    of our existing python scripts with "hidden" dependencies into a
>>    proper python module hierarchy and test for regressions with mypy,
>>    flake8, pylint, etc.
>>
>>    (We could even establish e.g. Sphinx versions as a dependency for our
>>    build kit here and make sure it's installed to the VENV.)
>>
>>    Pros: Almost all scripts can be moved under python/qemu/* and checked
>>    with CQA tools. imports are written the same no matter where you are
>>    (Use the fully qualified names, e.g. qemu.core.qmp.QMPMessage).
>>    Regressions in scripts are caught *much* faster.
>>
>>    Downsides: Kind of annoying; most scripts now require you to install a
>>    devkit forwarder (pip3 install --user .) or be inside of an activated
>>    venv. Not too bad if you know python at all, but it's certainly less
>>    plug-n-play.
>>
>> - What's our backwards compatibility policy if we start shipping this?
>>
>>    Proposed: Attempt to maintain API compatibility (after stabilizing the
>>    library). Incompatible changes should probably cause a semver bump.
>>
>>    Each published release makes no attempt to support any version of QEMU
>>    other than the one it was released against. We publish this on the tin
>>    in big red letters.
>>
>> TESTING THIS PACKAGE OUT:
>>
>> 1. You can install to your local user's environment normally by
>> navigating to qemu/python/ and typing "pip3 install --user ."
>>
>> 2. If you are in a VENV, use "pip install ."
>>
>> 3. To install in development mode (Where the installed package always
>> reflects the most recent version of the files automatically), use "pip3
>> install -e ." or "pip install -e ." as appropriate (See above)
>>
>> John Snow (7):
>>    python/qemu: create qemu.lib module
>>    python/qemu: formalize as package
>>    python/qemu: add README.rst
>>    python/qemu: Add pipenv support
>>    python/qemu: add pylint to pipenv
>>    python/qemu: Add flake8 to pipenv
>>    python/qemu: add mypy to pipenv
>>
>>   python/README.rst                         |   6 +
>>   python/qemu/README.rst                    |   8 +
>>   python/Pipfile                            |  14 ++
>>   python/Pipfile.lock                       | 195 ++++++++++++++++++++++
>>   python/qemu/__init__.py                   |  11 --
>>   python/qemu/{ => core}/.flake8            |   0
>>   python/qemu/core/__init__.py              |  57 +++++++
>>   python/qemu/{ => core}/accel.py           |   0
>>   python/qemu/{ => core}/machine.py         |   0
>>   python/qemu/{ => core}/pylintrc           |   0
>>   python/qemu/{ => core}/qmp.py             |   0
>>   python/qemu/{ => core}/qtest.py           |   0
>>   python/setup.py                           |  50 ++++++
>>   scripts/device-crash-test                 |   2 +-
>>   scripts/qmp/qemu-ga-client                |   2 +-
>>   scripts/qmp/qmp                           |   2 +-
>>   scripts/qmp/qmp-shell                     |   2 +-
>>   scripts/qmp/qom-fuse                      |   2 +-
>>   scripts/qmp/qom-get                       |   2 +-
>>   scripts/qmp/qom-list                      |   2 +-
>>   scripts/qmp/qom-set                       |   2 +-
>>   scripts/qmp/qom-tree                      |   2 +-
>>   scripts/render_block_graph.py             |   6 +-
>>   scripts/simplebench/bench_block_job.py    |   4 +-
>>   tests/acceptance/avocado_qemu/__init__.py |   2 +-
>>   tests/acceptance/boot_linux.py            |   3 +-
>>   tests/acceptance/virtio_check_params.py   |   2 +-
>>   tests/acceptance/virtio_version.py        |   2 +-
>>   tests/migration/guestperf/engine.py       |   2 +-
>>   tests/qemu-iotests/235                    |   2 +-
>>   tests/qemu-iotests/297                    |   2 +-
>>   tests/qemu-iotests/iotests.py             |   4 +-
>>   tests/vm/basevm.py                        |   6 +-
>>   33 files changed, 355 insertions(+), 39 deletions(-)
>>   create mode 100644 python/README.rst
>>   create mode 100644 python/qemu/README.rst
>>   create mode 100644 python/Pipfile
>>   create mode 100644 python/Pipfile.lock
>>   delete mode 100644 python/qemu/__init__.py
>>   rename python/qemu/{ => core}/.flake8 (100%)
>>   create mode 100644 python/qemu/core/__init__.py
>>   rename python/qemu/{ => core}/accel.py (100%)
>>   rename python/qemu/{ => core}/machine.py (100%)
>>   rename python/qemu/{ => core}/pylintrc (100%)
>>   rename python/qemu/{ => core}/qmp.py (100%)
>>   rename python/qemu/{ => core}/qtest.py (100%)
>>   create mode 100755 python/setup.py
>>
> 
> 

-- 
—js


