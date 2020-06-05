Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17725C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA59206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LlxwE4ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA59206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDXd-0002wO-6N
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhDWb-0001Pu-FB; Fri, 05 Jun 2020 10:40:49 -0400
Received: from mail-eopbgr20097.outbound.protection.outlook.com
 ([40.107.2.97]:16053 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhDWY-0003k7-Jg; Fri, 05 Jun 2020 10:40:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFSlHbNV0C8XRmeMNPWFc+4LajzVBTPVl/1dZk3kg0ps2IFIjrf1LzZtitBf2OIs9AANP8yLVRd1AwiUaPQg4tuE2j9XzHLMkZVDrBQje2KyFkpbB5hw/95iQflbF7d3YFvfXfYTkGdFmbrbKBWXxAWmYer5JfeqVswbVyyvJAUjf4lv6O+TIDlYV+7oqlRqkNhfZ0pW1Q3kKU933UYUM3XkNKJombNAeExzTUGPUmXofJBo9w/sZQn0N8pffzw0ai6Yo3eShQ9Pc4lA40O2ODc1zB0ryW8COW96Ewl2Et4bXB7Sla9gTtDpN9JHn6AsKMd7FRJ4Vzy0GiX+BqaFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEuFaPpZdWVbKpFhdFCfeDiabEfcQGgu2LuWl4Wm7fw=;
 b=e2kfn8GPMztfLhWIlMuOE5fgzGEkiQiQNrDnUldiX3na8xQWlCjKmggYc2EBLtXd3eamFqOqnq9Wh3wxkruq43BogEZ8qiDzCgb6VCPU3K0ZMh419fuiTUemwsF/cAw5R7EL1kn1F90NGWyRGDB+imRjrT1wvC1JTTS2qQNC8Y8JcJK/v9kW88acK7A0MpWBYpcm5ulXs49PYzQnbDxyakRaUyA3sFQNsBzxsIIpqiuXbwFy9+5Z0uwCKlyGxlTcYM/lT8qSwQ/TrDSMo6V9ewfl/DRwvwNLPZluH5d2KRpr/HF1b1rjaaNx9wXuMo6O3hojVYPjaJzrX9xv3CPzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEuFaPpZdWVbKpFhdFCfeDiabEfcQGgu2LuWl4Wm7fw=;
 b=LlxwE4nsNvW+lIyzr8aLdJ8L71EaR9WJBlkEb8N8ztrOhVLo7AV5aO0bSweNv7DhcwHObDnWwv2OOowowwCLcU4T4ZjpkSNtyj+a3rRw6ezDbQvBTMf4hWK/TcE5xB0Bh9LEGvW/oFtSYeJDFmYkoQ71+2yV9AmerXBctBZAtCE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 14:40:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 14:40:43 +0000
Subject: Re: [PATCH 2/7] python/qemu: formalize as package
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200603001523.18085-3-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <543575b7-44be-37e6-a82b-9299b637ef78@virtuozzo.com>
Date: Fri, 5 Jun 2020 17:40:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603001523.18085-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0146.eurprd04.prod.outlook.com (2603:10a6:207::30)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM3PR04CA0146.eurprd04.prod.outlook.com (2603:10a6:207::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20 via Frontend Transport; Fri, 5 Jun 2020 14:40:42 +0000
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75abf588-0a81-49af-ced0-08d8095e6ca9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53992313B295A195E6540D23C1860@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y18Qx8d9Q7MurEVfclSsXDuyq3oQC3U94BDJ3UpLQ3jGk2i7EesoFYCgrSnghrfPFola0uoefcB5cDb2gRVwWegrx6wIt6tnMMA5HM+Yg3LvFj0TRrX1ZulGqnJW+fTYX8RbFCbtS43yVg+xS1AiXzQzXmXpOocKXOmWwNBEZvmxoRe7fzY3eEZo1eP7EUjaGUpS6IN9IaHaDJaPX8IytD9GUpH118Ib9CDew+exwAf2vW9sGvIf//0Vx5tTVKzkg30FF+IkSSzYC1w8xQmzkFQKctYr3GGR7akdpW/8xT2YjTneWIQ7CbkNc9oUWtFwoBxy/lIXn9Tr+z4Ujq+VT8RToHSuJtEtcBTBoNTfRBdAMUa5M8+AyIMelK6pxj2Lxv1EWz2+8gs8Kz63g/P2K8FkRMaOy3aDMBZgSCKI80Vu5qegVd3ogI0/s4ogxsro4iO/ypUEiGtKcyD3iLYbGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(396003)(346002)(376002)(186003)(36756003)(16526019)(26005)(31696002)(86362001)(66476007)(66556008)(478600001)(5660300002)(16576012)(54906003)(66946007)(316002)(52116002)(2906002)(8936002)(31686004)(8676002)(6486002)(4326008)(956004)(83380400001)(7416002)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: d66uw31JhaTTeIuwXRveyDP2yjuKDmV08fekVv3yG6hXFtv3Z2uhDV2UG007K4I2EiZ/3/4QJ3/BvoRgW5Aa6sdvgvadtPl6oqNmeEUz30mSOyyZh87DLf+3+ZVm6aGlHAqpd1nz7Ao5y86sJcRV2dlI3MYog1lowLzpjDO4UDM2tU/EFIFd7DCwaRf8m6Vsy2iO/uxhiy4GqTPc9WEp009cBTr9iXupt7xKrELtpjj5JB2Mk5FMr/dUs7d+qZR2+OHiG6c+H2pGnKeffiwZeyiwe26Y3ba3K5eJW9d9fuQqf8Fj4OFuPjt/KoQ6CMzlTv+iQTdGmcNHrarhfj/F36zqZhU2qldCH5ZxmO1B9gGmG9E7KSxAnslrbJ9zuZSFpQlAR9aFh95loRTM3bST757cgVMWyXbGSqgcXbfGYlZFCwUS7Ph5zjwDotSyf7k7IKstigAvZGLz3SaJYiieu8WyfRtKilBl9lUDGlGdg+oY/w8YznG4zdbNlUUTiav7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75abf588-0a81-49af-ced0-08d8095e6ca9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 14:40:43.0824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr2Stgu9scKcgnIDcuXhpUnLhvzwXDNEyF2If7mjgIn1rB9Jmjp3y70gGVHx1dfugLT+aLU7dLlR+BJQpO5+LtX8Hc0WBtIOTN23L1OhnnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.2.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 10:40:44
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

03.06.2020 03:15, John Snow wrote:
> NB: I am choosing Python 3.6 here. Although our minimum requirement is
> 3.5, this code is used only by iotests (so far) under which we have been
> using a minimum version of 3.6.
> 
> 3.6 is being preferred here for variable type hint capability, which
> enables us to use mypy for this package.
> 
> RFC: This uses the version tags of the parent tree here, so packages
> will be installed as e.g. 5.0.0, 5.1.0-rc0, etc.
> 
> Pros:
>   - Easy to tell which versions of QEMU it supports
>   - Simple
> 
> Cons:
>   - Implies semver, which we do NOT follow for QEMU releases
>   - Implies the package is in a stable state

Necessarily? Couldn't we state Development Status: Alpha, even with version 5.1.0 ?

> 
> 
> We could also start a separate versioning for just the Python SDK at
> e.g. 0.1;
> 
> Pros:
>   - We can use semver, which is expected of Python packaging
>   - Allows us to break compatibility for 0.x releases
> 
> Cons:
>   - More complex, the mapping from SDK version to QEMU version
>     is less obvious
>   - Requires someone to manage a secondary version commit for
>     the Python SDK.
> 
> Or, perhaps, we could start versioning with 0.5.0.0, 0.5.1.0, etc to
> combine a bit of both flavors; bumping the major version number only
> when incompatible changes to the Python interface itself are made,
> treating the major version number more like an epoch.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/README.rst |  6 ++++++
>   python/setup.py   | 50 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+)
>   create mode 100644 python/README.rst
>   create mode 100755 python/setup.py
> 
> diff --git a/python/README.rst b/python/README.rst
> new file mode 100644
> index 00000000000..25f6d93fd5f
> --- /dev/null
> +++ b/python/README.rst
> @@ -0,0 +1,6 @@
> +QEMU Python Tooling
> +-------------------
> +
> +This package provides QEMU tooling used by the QEMU project to build,
> +configure, and test QEMU. It is not a fully-fledged SDK and it is subject
> +to change at any time.
> diff --git a/python/setup.py b/python/setup.py
> new file mode 100755
> index 00000000000..f897ceac970
> --- /dev/null
> +++ b/python/setup.py
> @@ -0,0 +1,50 @@
> +#!/usr/bin/env3 python

env python3 you mean

with it fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +"""
> +QEMU tooling installer script
> +Copyright (c) 2020 John Snow for Red Hat, Inc.
> +"""
> +
> +import setuptools
> +
> +def main():
> +    """
> +    QEMU tooling installer
> +    """
> +
> +    kwargs = {
> +        'name': 'qemu',
> +        'use_scm_version': {
> +            'root': '..',
> +            'relative_to': __file__,
> +        },
> +        'maintainer': 'QEMU Developer Team',
> +        'maintainer_email': 'qemu-devel@nongnu.org',
> +        'url': 'https://www.qemu.org/',
> +        'download_url': 'https://www.qemu.org/download/',
> +        'packages': setuptools.find_namespace_packages(),
> +        'description': 'QEMU Python Build, Debug and SDK tooling.',
> +        'classifiers': [
> +            'Development Status :: 5 - Production/Stable',

Could we use "3 - Alpha" ?

> +            'License :: OSI Approved :: GNU General Public License v2 (GPLv2)',
> +            'Natural Language :: English',
> +            'Operating System :: OS Independent',
> +        ],
> +        'platforms': [],
> +        'keywords': [],
> +        'setup_requires': [
> +            'setuptools',
> +            'setuptools_scm',
> +        ],

Hmm, documentation says:

    Warning Using setup_requires is discouraged in favor of PEP-518

did you consider this thing?

> +        'install_requires': [
> +        ],
> +        'python_requires': '>=3.6',
> +        'long_description_content_type': 'text/x-rst',
> +    }
> +
> +    with open("README.rst", "r") as fh:

You use '' for all other strings (except for doc-strings) in this file. Maybe use '' here too?

> +        kwargs['long_description'] = fh.read()
> +
> +    setuptools.setup(**kwargs)
> +
> +if __name__ == '__main__':
> +    main()
> 

Hmm in examples in documentations I always see something like this:

> from setuptools import setup, find_namespace_packages
> 
> setup(
>     name='mynamespace-subpackage-a',
>     ...
>     packages=find_namespace_packages(include=['mynamespace.*'])
> )

How much is it better (or popular) to use __name__ == __main__ style for setup.py?
We are not going to use it as module to import main somewhere...

-- 
Best regards,
Vladimir

