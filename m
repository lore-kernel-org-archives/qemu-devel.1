Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96853C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 05:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A32D207D5
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 05:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JqwiEvvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A32D207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhRms-00065U-Fv
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 01:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhRmA-0005aa-JS; Sat, 06 Jun 2020 01:53:50 -0400
Received: from mail-am6eur05on2116.outbound.protection.outlook.com
 ([40.107.22.116]:54298 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhRm7-0004Gj-86; Sat, 06 Jun 2020 01:53:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmKSV2APbBoCkFr/AnPGnysafmcwsz5jqRMdyMUM2/FtDensgjm5f1qUBdoe9NoTNirpD7FKO6Wu1QNWiSdF/20m9tuBeuBTb0e5nFxwq7seLfX+es4+0yFWiJ7CI6IgAxElTirTAHOGc5oYp7ARVbRU4dsFZrU1I4MARa1I90+P2nvur6hzg2tm7n5bk9QKv0uKeZbyNyJg78gmZQe+GkA8Pf0g3JHZByxhDbRtqsN3liGUIPtPotS+nMnmVAAWAHs0WfeSOIldkzDUJktywe7dzgKbPAaiQGGrMAQ1sDiHsPzBtPiYIpAYBG/4snDTYAxDHzW41w1ixSXv6xJqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WKf3plYDOWDt1MMbIoFMDW5ucJ8oeKHsKuG9fGhoDs=;
 b=lZPUYy1TyilDq8VUy1aVvHN0nhc0WjaezmINMg6OY1rIUS0u7aYV599YJ5hnddffSUGF86IgHsKREumivjSoM6rKng7941af4i3OftliuB+dCsi21hugSvW7n8RPH3ehfhVllVmuAr34/jyCt7W65tT7nhkpN6FH4d2Kb0Mzmjq+RnpRgCprsykdrSEtk0ntLCrdolHCHNZvmN7ml2G2SIlsTEOPXL4pTyDJx7jGutlzKDYXsc4TQFcWXuVDGLABZmmXMTzS4qWNwLpJeNxHxwq0FDesdvXT+T+2TQ4Z9NPrPvMWK5X/qi7kpfgzugGGW1/qVhrtPR4zEdSCe3Zo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WKf3plYDOWDt1MMbIoFMDW5ucJ8oeKHsKuG9fGhoDs=;
 b=JqwiEvvP0j1i4Iqs+bDTOJtvaDP4QPYBvWC1KZ+E+dqyK8DTWOFGRsh1wLqAHyT16VWi4mzUAKc5sXlbYMRGB3Ui9i0GQ8Q063r83+vs8ov5BGU+yZZPgjOc20Eg4v+bVx7tH3kuv5h3Uy0EuHUBMBpuIIXJqs9fuoL5mOhMfqM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB3006.eurprd08.prod.outlook.com (2603:10a6:803:40::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sat, 6 Jun
 2020 05:53:43 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3066.022; Sat, 6 Jun 2020
 05:53:42 +0000
Subject: Re: [PATCH 0/7] python: create installable package
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200603001523.18085-1-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8f64d361-d167-f539-8c8e-b432b037be36@virtuozzo.com>
Date: Sat, 6 Jun 2020 08:53:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603001523.18085-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0010.eurprd03.prod.outlook.com
 (2603:10a6:205:2::23) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.130) by
 AM4PR0302CA0010.eurprd03.prod.outlook.com (2603:10a6:205:2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Sat, 6 Jun 2020 05:53:41 +0000
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a427f8e-179b-4838-c16b-08d809ddf7dc
X-MS-TrafficTypeDiagnostic: VI1PR08MB3006:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3006C8D7AB6C9FB8AFAEA8D4C1870@VI1PR08MB3006.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jiks43J3JWkma9im8jTSPzAL+mbbM5kVe0qXJxf5YUndcfUL2+2Z+XEDdkYAblR7DjJWVidY6DzkjgCArULwutPkcZH/txbHm7L7em6mg/X0R9MdU3MV5o3qSxw1sv4xCCyPzfX/iW3UWv8Wq+uWq3Jm4W1KxUVLIMd6wb44fNsd/ddbqJSNy6b7I2GGbiCrwp+CW774EtvdmhCXscCB+kjJSA9KkD5kMN138GEwqvTp+L6Ejqzn/gYICxC7PsWF8TGnOQOQ4jA3SyXAOTU4QOqMhW5Dczh2FbNViNibAHj37X0Z4zCEDG/QcyimfRYNk/UOPmrA8gfUv7CedV+VYTSp7RGM9QJZeFFYG2J7MKVXfUrsZNMYEV3kwvgH38boCWPj+f+y4tTDKOqTeK74vVNKHK8rXyzVEhjcFa6JW7H7fGY7su9u7aaGViRXDj3CQa/JVzyKOdEBrV1TuH+IwWsFunK3ReN1th5XYGWTTYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39850400004)(8936002)(16526019)(316002)(54906003)(4326008)(7416002)(52116002)(2906002)(8676002)(36756003)(26005)(83380400001)(478600001)(6486002)(966005)(5660300002)(31686004)(66476007)(66946007)(956004)(186003)(16576012)(2616005)(86362001)(31696002)(66556008)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ebqbNNac5TL3YJe6FesM9UbX/sirCP2oAOMJgYjiDDdGbyg2wUhQp0ZLsaDRKhUMxO9QKrsoHGB0WzRJRWdmRKVPdU6pbpseoXbnWFp6nJbB7KpnxSR1mW2xkYwAUt3EvDHsun0lCghkH/6AKDXDbekIzSd3tCkmncLm2lj6AQh2eFXI/7gsGNr9E/7nniEKaxWh+LlVDvUm7nOA2xsNLdlqCupdo9xYRVyZcukQhjJpbSJMxfpfwUY/j30dTLSmdu2dJIjfCHMI1ANBTmJsb2D5Ud4ujddMr8/Dh/JWVUC6QFkMnnRXmUtDA1PsiLQEXS6wRwwJ6qqX19tVpiZmMB19+2GcFCecuk3TrhkYLFmuRhmfIO7ytxW3FwyHyBtXI6WQ+JPiZUnPTmGFl6qPGIduUioAS8jUhtQEBOjNh/z1VFIvsBtZymsm9LHRe1+NZ183+ZL7ZfC9rDnBYt4QV4/hpS/rTOvQVwyPMxLFixYsqE3G142+xVFDQlV1FAAU
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a427f8e-179b-4838-c16b-08d809ddf7dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 05:53:42.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4KsmYci1FRCe/VAPm5F9pqVZOH4vDoq7wNy0m3kIOGCcDozc5kNfuwmU9gXpqrLg145wVPTA+8dHlLaqdvUSU3vSHaptNx3T2rBcc2L1Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3006
Received-SPF: pass client-ip=40.107.22.116;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 01:53:44
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

For patches 05-07:

Reviewing such patch is a strange thing: Pipfile changes are obvious enough, just select some version (I can't be sure about correct version choice, just believe in your commit messages). But what for Pipfile.lock? I can state that it's about package set selecting, Pipfile.lock looks like what it should be, but I have idea about all these packages, their versions and hashes (and even, does it correspond really to Pipfile or not) :)

Ha, what I can check, is: does pipenv create almost same Pipfile.lock in my environment (with 3.7.5 python)
OK, I've tried (pipenv lock --dev --python /usr/bin/python3), and yes, result is almost the same. For mypy and importlib-metadata packages I have newer version and different hashes (of course). Other packages are the same. Set of packages is the same.

Hmm, but in may generated Pipfile.lock there no "markers". They are about python version and looks like "markers": "python_version >= '3.5'".. Does pipenv follow them? Then why they are not generated for me, did you use some additional command/option to create them?
Anyway, they don't look dangerous, so for last three patches:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

03.06.2020 03:15, John Snow wrote:
> Based-on: 20200602214528.12107-1-jsnow@redhat.com
> 
> This series factors the python/qemu directory as an installable
> module. As a developer, you can install this to your virtual environment
> and then always have access to the classes contained within without
> needing to wrangle python import path problems.
> 
> When developing, you could go to qemu/python/ and invoke `pipenv shell`
> to activate a virtual environment within which you could type `pip
> install -e .` to install a special development version of this package
> to your virtual environment. This package will always reflect the most
> recent version of the source files in the tree.
> 
> When not developing, you could install a version of this package to your
> environment outright to gain access to the QMP and QEMUMachine classes
> for lightweight scripting and testing.
> 
> This package is formatted in such a way that it COULD be uploaded to
> https://pypi.org/project/qemu and installed independently of qemu.git
> with `pip install qemu`, but of course that button remains unpushed.
> 
> There are a few major questions to answer first:
> 
> - What versioning scheme should we use? See patch 2.
> 
> - Should we use a namespace package or not?
>    - Namespaced: 'qemu.machine', 'qemu.monitor' etc may be separately
>      versioned, packaged and distributed packages. Third party authors
>      may register 'qemu.xxx' to create plugins within the namespace as
>      they see fit.
> 
>    - Non-namespaced: 'qemu' is one giant glob package, packaged and
>      versioned in unison. We control this package exclusively.
> 
> - How do we eliminate sys.path hacks from the rest of the QEMU tree?
>    (Background: sys.path hacks generally impede the function of static
>    code quality analysis tools like mypy and pylint.)
> 
>    - Simplest: parent scripts (or developer) needs to set PYTHONPATH.
> 
>    - Harder: Python scripts should all be written to assume package form,
>      all tests and CI that use Python should execute within a VENV.
> 
>    In either case, we lose the ability (for many scripts) to "just run" a
>    script out of the source tree if it depends on other QEMU Python
>    files. This is annoying, but as the complexity of the Python lib
>    grows, it is unavoidable.
> 
>    In the VENV case, we at least establish a simple paradigm: the scripts
>    should work in their "installed" forms; and the rest of the build and
>    test infrastructure should use this VENV to automatically handle
>    dependencies and path requirements. This should allow us to move many
>    of our existing python scripts with "hidden" dependencies into a
>    proper python module hierarchy and test for regressions with mypy,
>    flake8, pylint, etc.
> 
>    (We could even establish e.g. Sphinx versions as a dependency for our
>    build kit here and make sure it's installed to the VENV.)
> 
>    Pros: Almost all scripts can be moved under python/qemu/* and checked
>    with CQA tools. imports are written the same no matter where you are
>    (Use the fully qualified names, e.g. qemu.core.qmp.QMPMessage).
>    Regressions in scripts are caught *much* faster.
> 
>    Downsides: Kind of annoying; most scripts now require you to install a
>    devkit forwarder (pip3 install --user .) or be inside of an activated
>    venv. Not too bad if you know python at all, but it's certainly less
>    plug-n-play.
> 
> - What's our backwards compatibility policy if we start shipping this?
> 
>    Proposed: Attempt to maintain API compatibility (after stabilizing the
>    library). Incompatible changes should probably cause a semver bump.
> 
>    Each published release makes no attempt to support any version of QEMU
>    other than the one it was released against. We publish this on the tin
>    in big red letters.
> 
> TESTING THIS PACKAGE OUT:
> 
> 1. You can install to your local user's environment normally by
> navigating to qemu/python/ and typing "pip3 install --user ."
> 
> 2. If you are in a VENV, use "pip install ."
> 
> 3. To install in development mode (Where the installed package always
> reflects the most recent version of the files automatically), use "pip3
> install -e ." or "pip install -e ." as appropriate (See above)
> 
> John Snow (7):
>    python/qemu: create qemu.lib module
>    python/qemu: formalize as package
>    python/qemu: add README.rst
>    python/qemu: Add pipenv support
>    python/qemu: add pylint to pipenv
>    python/qemu: Add flake8 to pipenv
>    python/qemu: add mypy to pipenv
> 
>   python/README.rst                         |   6 +
>   python/qemu/README.rst                    |   8 +
>   python/Pipfile                            |  14 ++
>   python/Pipfile.lock                       | 195 ++++++++++++++++++++++
>   python/qemu/__init__.py                   |  11 --
>   python/qemu/{ => core}/.flake8            |   0
>   python/qemu/core/__init__.py              |  57 +++++++
>   python/qemu/{ => core}/accel.py           |   0
>   python/qemu/{ => core}/machine.py         |   0
>   python/qemu/{ => core}/pylintrc           |   0
>   python/qemu/{ => core}/qmp.py             |   0
>   python/qemu/{ => core}/qtest.py           |   0
>   python/setup.py                           |  50 ++++++
>   scripts/device-crash-test                 |   2 +-
>   scripts/qmp/qemu-ga-client                |   2 +-
>   scripts/qmp/qmp                           |   2 +-
>   scripts/qmp/qmp-shell                     |   2 +-
>   scripts/qmp/qom-fuse                      |   2 +-
>   scripts/qmp/qom-get                       |   2 +-
>   scripts/qmp/qom-list                      |   2 +-
>   scripts/qmp/qom-set                       |   2 +-
>   scripts/qmp/qom-tree                      |   2 +-
>   scripts/render_block_graph.py             |   6 +-
>   scripts/simplebench/bench_block_job.py    |   4 +-
>   tests/acceptance/avocado_qemu/__init__.py |   2 +-
>   tests/acceptance/boot_linux.py            |   3 +-
>   tests/acceptance/virtio_check_params.py   |   2 +-
>   tests/acceptance/virtio_version.py        |   2 +-
>   tests/migration/guestperf/engine.py       |   2 +-
>   tests/qemu-iotests/235                    |   2 +-
>   tests/qemu-iotests/297                    |   2 +-
>   tests/qemu-iotests/iotests.py             |   4 +-
>   tests/vm/basevm.py                        |   6 +-
>   33 files changed, 355 insertions(+), 39 deletions(-)
>   create mode 100644 python/README.rst
>   create mode 100644 python/qemu/README.rst
>   create mode 100644 python/Pipfile
>   create mode 100644 python/Pipfile.lock
>   delete mode 100644 python/qemu/__init__.py
>   rename python/qemu/{ => core}/.flake8 (100%)
>   create mode 100644 python/qemu/core/__init__.py
>   rename python/qemu/{ => core}/accel.py (100%)
>   rename python/qemu/{ => core}/machine.py (100%)
>   rename python/qemu/{ => core}/pylintrc (100%)
>   rename python/qemu/{ => core}/qmp.py (100%)
>   rename python/qemu/{ => core}/qtest.py (100%)
>   create mode 100755 python/setup.py
> 


-- 
Best regards,
Vladimir

