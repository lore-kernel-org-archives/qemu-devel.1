Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073C7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24D02070B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="omKNKvkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24D02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBY9-0001CN-2c
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhBXJ-0008Oq-7C; Fri, 05 Jun 2020 08:33:25 -0400
Received: from mail-vi1eur05on2096.outbound.protection.outlook.com
 ([40.107.21.96]:11866 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhBXF-00017f-PU; Fri, 05 Jun 2020 08:33:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9jOsBEHz35iLB4jmOZAKX84CudpIvvKTi+PHJY4tUp6DC0f55PQD3S88eUXfbN9aaSYJvYOwk6u3K42aub7XSme7Rc68cXIdI4p+trBxmrt30hE3QGkyR+qW0wp4/LcvRQBWYFMC610ENSXkJEIkksM0QDcleEWI0i+TKEWRaKZgDSpV5oJZ365xcb5jDxH3e3mBS3R+4fQs1FVIYFU3e7OvkQQMqErjvT3geoA9ZxdqygUJ4tj5qpIR4BZ6HYpJO5jlYF5kIY8lsRLPk71WKAi5Vyq8Li2eSChjigXJ4SMuNZPkJ6R/JKOFHesTCXybhvlQz2abbBKJxMhIi3AOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuzSsM082G82yfiNv1jFXb6Cj2tK/zea88nrixyMVrk=;
 b=Tnq/Og7o2HuvbwC1tiaerRmmyyliFx/u+fN33cDXttUR/3ykjM336vCGtFLid8kDgMb9Ukhy4VtVFflkZLOpRB/kcVDcIiIVCafueicdGIlK0sGjyvUlhaRo69O3ck+lgxjK3xvvXx9cOgMpfL6Ekq2bCPK0Voy5V4vHX6waMBo3Y+xihYWgV6Ps5I2qtCEwEAqEjy1Rmx2LtbyI26lRMlSFGl+8xk0RlhzeCbNATGeWV/S3LyKriPwktKKlCN+6Jw2865haljcDZX8lxEIDJJbPY7O6zNzIKK0so266nqUfWrfFmelnqnXkK3seoiOk74t6/Us3QU9kRPkTfo4skA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuzSsM082G82yfiNv1jFXb6Cj2tK/zea88nrixyMVrk=;
 b=omKNKvkn/2TCQ+l35ZKFnS0HHay0Mnk8BtUB/JTv58qfJyrCnqsCX9zoPz4CifOAAwKVW1miqdwchQ08uO7KSaS9/GtmJjeqn82CagectbZc+yywy6TocIXQe8yenSJcMrMbfOyovPqovOix0coUZxA0NlSJuXJP41ML2aphtHk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5398.eurprd08.prod.outlook.com (2603:10a6:20b:103::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 12:33:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 12:33:19 +0000
Subject: Re: [PATCH 1/7] python/qemu: create qemu.lib module
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200603001523.18085-2-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0584ec1c-f867-8f97-c521-75ade4e3010a@virtuozzo.com>
Date: Fri, 5 Jun 2020 15:33:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603001523.18085-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0065.eurprd03.prod.outlook.com (2603:10a6:208::42)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM0PR03CA0065.eurprd03.prod.outlook.com (2603:10a6:208::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Fri, 5 Jun 2020 12:33:18 +0000
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cba7f2c-55aa-49bd-9b48-08d8094ca0b5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5398:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53989FBA6F9951324115CE9DC1860@AM7PR08MB5398.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xB8+vkQDqxj0GBg44i3L2emmzbqT/7qCRoNV4sHLehOGmAtsU4bMwEGljnDB01agizOLm34Vi6cmw48o8kEmNFfxEdX+DANYTUgZxkhyk7+w+HxYW/N2nJ9t/03NH7lf+VJPYYrknVA5c4IBgXXiNHOzu1x8zFSSuFPAK3yPLQtws2Ep/CXg7HptW9ux2B6umqIDEcdfFNAQmeaTG7Qk5T9Nqg0jO6VohBhR83gf7Dsw1HPARD9dPm75Az13ac3Ohfd+lpkJHNwxFJQR4dL8CtPnR3h6GZcX9IHnqaPtVb5pmzDYKVnCntgn4iiR30nXtb9tw8BpLi1Icixlu21FS3asP3oLnBzG0X3mF1MOKvYAWU8kaltKKOAMCEMUzK6u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39840400004)(346002)(376002)(66556008)(66946007)(86362001)(66476007)(6486002)(186003)(16526019)(83380400001)(31696002)(36756003)(5660300002)(8936002)(8676002)(7416002)(31686004)(16576012)(478600001)(52116002)(956004)(4326008)(2906002)(2616005)(316002)(54906003)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nHvcFI+3EbEPN0ecgyJbZ1Ej05uyVYN7A4BZ8GvFxS53NmwsLvQGYB+rUrSDKwgUFAQPh43SgNpc6gb8U4a0tqPWuBY8SPNIxJgDQSlmb/SWl7rCDdho3/XdDCNvTZV2b9wDQjVSPgOMPwho0AouYCi1yFWj2kSr+hGhFyO0UUjq9cxglRXSkYdes5VBfOEJGZ/6qk8Z+E3rbbQb2KIpfSn1eUrfWJBCpYsCjykjKXrnd9ctfTA02Ia+i3qAnjUjj1wqI+yVb5YWU2cqPqZRtIQNdJs59mVJnTB0xOyLVhPdRpoq4iYssy4nKFYjYYu7VPoVboWmWurKFF4tmIUCFcZEbBSjvCRGRpBJEQzCvoPDotyAyKeXr8BKMHmdiMudcRh2aKP6EkJxIMMoi/eU+gqcuTi3dCqIPEWyoSvFNjm7PvUvjBWLRtxWalXWPtkMhsJP1iFLLr/n6K/pUYz6ol1URQvmpQW/I5ZjObPrObAtXrITfq/605m42rOYSgdy
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cba7f2c-55aa-49bd-9b48-08d8094ca0b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 12:33:19.2341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13KELWEMaXSaCzyc6M/s5DGS0NuChwtjV13n47H8tZmtCorgmgJCZUeZzfnYLhIOKLGjpmqm+JkYhTxk/yFhJIqWeBFYFCYYKqFIQJMABAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5398
Received-SPF: pass client-ip=40.107.21.96;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 08:33:20
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
> move python/qemu/*.py to python/qemu/core/*.py.
> 
> To create a namespace package, the 'qemu' directory itself shouldn't
> have module files in it. Thus, these files will go under a 'lib' package
> directory instead.
> 
> Bolster the core/__init__.py file a little bit, Make the top-level
> classes and functions available directly inside the `qemu.core`
> namespace, to facilitate a convenient shorthand:
> 
>> from qemu.core import QEMUQtestMachine, QEMUMonitorProtocol
> 
> Lastly, update all of the existing import directives.
> 
> (Note: these scripts were not necessarily tested to see if they still
> work. Some of these scripts are in obvious states of disrepair and it is
> beyond the scope of this patch to attempt to fix them.)
> 
> 
> RFC: For now, I have used the 'qemu.core' namespace to provide a group
> of related tools. I liked Daniel's suggestion of using qemu.machine (and
> possible qemu.monitor), but that requires me to rewrite the import
> statements and understand a bit more about how to configure
> pylint/mypy/flake8 and it's not right to focus on that right now. In the
> interest of expedience, I've chosen to keep everything in one package to
> be able to send another RFC patchset.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

[..]

> --- a/scripts/render_block_graph.py
> +++ b/scripts/render_block_graph.py
> @@ -25,10 +25,8 @@
>   from graphviz import Digraph
>   
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
> -from qemu.qmp import (
> -    QEMUMonitorProtocol,
> -    QMPResponseError,
> -)
> +from qemu.core import QEMUMonitorProtocol
> +from qemu.core.machine import MonitorResponseError

it should be
+from qemu.core.qmp import QMPResponseError

with that fixed:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir

