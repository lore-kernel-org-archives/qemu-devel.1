Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3147C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF3D2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gyulM+VT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF3D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhF6j-0006Zs-2p
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhF5l-0005ig-GD; Fri, 05 Jun 2020 12:21:13 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:24342 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhF5h-00036b-Bt; Fri, 05 Jun 2020 12:21:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExuWm2SkVIVvWP6ADtt1f4MrZeeNp0U2x0YJ1VzviKakF6ghhlSAGpobpgy3U1aqr/oRT1K6k7UNRc+lLawIDSIvY55eDUDzJ9UPaFgNHT+f0a0DahF/wmJAa5GIUEMwhS+I037sbKcgl/WmWx9pAl2D0h4HmzIqSs3ZChzRvOVv08AwnYs4T4KLP7iN00VmsLEgmPF/KMBBGTLUz7uAZKWBt3MAKKLslEvZ7wHUWb1lCmpoPMIpgcjqk2UnqvPrNkUTGSx34rjORRbbS+WW5DUTi2Z5bLVyLllvvIRzPt6QQQrO7XfSYo4QQLKM00AkR7KM9d74GPjd8y+13JA23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCM8aF/86CiP4AJXABOLk93fTeTunC62ovkCJ91DPL8=;
 b=dhmPWmyJA6CVOOWUog+1Prn5E+Yxsxg4y7kWsj8RJnbgjbpKeW2Q6tS95KgN0fbEYPnrb3uZ6ZZ/8jmTaarb7FPTA5dT9DjX7pw5GtMpOgmniYnNG7kLPyfQk56YfiSjWez+BTL/dOue5naCPrpucXdn7A/GyvKBGR+jB/aTWr4vwFFylmN5zEL6Q1+RNKIyvg/Le/nYefj55J1exkKrJ1m8Bu+rPf/HmpeONJiCJTdmtpLFYqtLZoRPwj+7yCk958NMv6sKmNyNBV3R5nDMgPOpBT2dcKzm2hDUxACEdBawssm29wsQhP16GYQvCNGmAJspFZaDho7M6cxveR5Gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCM8aF/86CiP4AJXABOLk93fTeTunC62ovkCJ91DPL8=;
 b=gyulM+VTpK03LuLhgpDpcfWjCBkOCsgq2xO3n6mg9UwXscxKjf+C1gkmxcD4Ik63CVTCSNCCPzxrC68xVD6I3TejJlFP736CjB1NWOwhXJObeiOigupmKZ1cQZRMTEwVG0zw3LTGgbWl0e0d39hvGOOdFNYlic0aQFP7h5pkwA4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5479.eurprd08.prod.outlook.com (2603:10a6:20b:104::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 16:21:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 16:21:05 +0000
Subject: Re: [PATCH 4/7] python/qemu: Add pipenv support
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200603001523.18085-5-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f351d9ee-6126-6efc-b074-ffaf0b664476@virtuozzo.com>
Date: Fri, 5 Jun 2020 19:21:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603001523.18085-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM4P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 16:21:04 +0000
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0ffa075-6d3a-47e1-6351-08d8096c7234
X-MS-TrafficTypeDiagnostic: AM7PR08MB5479:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5479C67F38561B05A3FC94C0C1860@AM7PR08MB5479.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsKYtUmfLE9X/cC2TuAsomXWsnY0ULPXul20H9YaCS7ZUJcFSTk3823M7zGFij6KP2g18WJde5W5a4jNkNBEL7kqQYbNyDLUJ9+GlIdI/jFUsZd2DDWjuZwTDknB53JNS49yaXjfQl+Wyn3BunxP9jaDWzQX2lyhz41reYq9HjqT5Hh3+kf8hVX2Ol/189fTtDOPhXZHJdgJWsk4tQWU7IG31sq/dH6c3LX8ubu/fZ7h7vR9r/SgJyEHAO3dsGu6x8hQs+ZGvXlo9enTwnzBNv0a0LUHztywmtyqKpIsW4tDVhpcdmyfXvKHXauZosau7p6Giq0fh3G1ezlYKLE2DDNZcbOfoBNNBG0sGOb3/Wb893hIYl19QwtX+wQstyOxOA0hPjy818AgM8tqpu1anW+obuH/1ynwcJbQZxByvfnewol33tKBf5eIJs+qeOW/im/PAs5erVj0cuCZkpxbVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39850400004)(346002)(396003)(136003)(26005)(16526019)(36756003)(2616005)(7416002)(52116002)(956004)(5660300002)(4326008)(186003)(6486002)(478600001)(86362001)(66946007)(83380400001)(2906002)(66556008)(54906003)(19627235002)(16576012)(8676002)(31696002)(31686004)(66476007)(316002)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2B9NBExGw82xNCzlHyO99ccl90m8BhCBUm1YXsSJC0lq6GLecaEbZbmvYQTwNFLEZSgSZ1CXYSLSKG5eA2McC9ozr8wzuDYHc8WNUdGCWdWoeumUXgXVFZzYQitIf4qoVKbEN5elga+9y5jp1FAjJ3lFKoGu6XsVYwthAF09ziFPLLCJFr7q6FJRbUyCZF/5eof9byNRpEnC/bIdpwb2zHeCwJgFOeiY3JU71bFcoIeYXgitrLoNjL7dSXgkkvq321WCi5Mmab5VcggFHWFM4C0IHZiTIH+V9j0G4p94VgXQktuxylmRfxsid4Pxot52XeIaetxpGH0Az1+Z7fbrxEWBfutU90EdmA1eNITiatF6xIOxpk+Er14JN57xVi0WprefM5k1NnRXkc38UR3KSMyH8BWozoUqLKkNqfjv32LQsrUEt6ZzwyIslId0R9fethnERlWegrme9qsjLTLDS7YrmZl0Y9Ypf+xqOxbwAIOLeid76Eu6UD1n9dO6qXYo
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ffa075-6d3a-47e1-6351-08d8096c7234
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 16:21:05.1104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNb5WDwrC+uQpKFD8TaOHGJrPe2O1GDRsxBQej/stkb90tBAAZ3qznYunZHeQRm3zO/9c0aEVv2h+pEFiOTg8DCKhNxIp9E2/p1iZEa5ekY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
Received-SPF: pass client-ip=40.107.8.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 12:21:06
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
> pipenv is a tool used for managing virtual environments with precisely
> specified dependencies. It is separate from the dependencies listed in
> setup.py, which are (by 'best practices') not supposed to be pinned.
> 
> Note that pipenv is not required to install or use this module; this is
> just a convenience for in-tree developing.
> 
> Here, a "blank" pipfile is added with no dependencies, but specifies
> Python 3.6 for the virtual environment.
> 
> Pipfile will specify our version minimums, while Pipfile.lock specifies
> an exact loudout of packages that were known to operate correctly. This
> latter file provides the real value for easy setup of container images
> and CI environments.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/Pipfile | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>   create mode 100644 python/Pipfile
> 
> diff --git a/python/Pipfile b/python/Pipfile
> new file mode 100644
> index 00000000000..9534830b5eb
> --- /dev/null
> +++ b/python/Pipfile
> @@ -0,0 +1,11 @@
> +[[source]]
> +name = "pypi"
> +url = "https://pypi.org/simple"
> +verify_ssl = true
> +
> +[dev-packages]
> +
> +[packages]
> +
> +[requires]
> +python_version = "3.6"
> 

Should it be >= or something like this?

And, how should I use this all?

My failed attempt:
[root@kvm python]# pipenv install --python /usr/bin/python3
Virtualenv already exists!
Removing existing virtualenv…
Creating a virtualenv for this project…
Pipfile: /work/src/qemu/john-python-installable/python/Pipfile
Using /usr/bin/python3 (3.7.5) to create virtualenv…
⠹ Creating virtual environment...created virtual environment CPython3.7.5.final.0-64 in 112ms
   creator CPython3Posix(dest=/root/.local/share/virtualenvs/python-4FwBBPCc, clear=False, global=False)
   seeder FromAppData(download=False, pip=latest, setuptools=latest, wheel=latest, via=copy, app_data_dir=/root/.local/share/virtualenv/seed-app-data/v1.0.1)
   activators BashActivator,CShellActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator

✔ Successfully created virtual environment!
Virtualenv location: /root/.local/share/virtualenvs/python-4FwBBPCc
Warning: Your Pipfile requires python_version 3.6, but you are using 3.7.5 (/root/.local/share/v/p/bin/python).
   $ pipenv --rm and rebuilding the virtual environment may resolve the issue.
   $ pipenv check will surely fail.
Installing dependencies from Pipfile.lock (44d7bd)…
   🐍   ▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉ 0/0 — 00:00:00
To activate this project's virtualenv, run pipenv shell.
Alternatively, run a command inside the virtualenv with pipenv run.
[root@kvm python]# pipenv shell
Warning: Your Pipfile requires python_version 3.6, but you are using 3.7.5 (/root/.local/share/v/p/bin/python).
   $ pipenv --rm and rebuilding the virtual environment may resolve the issue.
   $ pipenv check will surely fail.
Launching subshell in virtual environment…
  . /root/.local/share/virtualenvs/python-4FwBBPCc/bin/activate
[root@kvm work]#  . /root/.local/share/virtualenvs/python-4FwBBPCc/bin/activate
(python) [root@kvm work]# python
Python 3.7.5 (default, Oct 17 2019, 12:09:47)
[GCC 9.2.1 20190827 (Red Hat 9.2.1-1)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import pylint
Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
ModuleNotFoundError: No module named 'pylint'
>>> 

and iotest 297 says: "pylint-3 not found"

(honestly, I'm new to using python virtual environment)

-- 
Best regards,
Vladimir

