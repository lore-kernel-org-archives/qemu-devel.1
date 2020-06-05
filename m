Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE03C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D119206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MtozUlih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D119206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDvf-00024c-I0
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhDmB-0004e1-MQ; Fri, 05 Jun 2020 10:56:55 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:27617 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhDm9-0007Xp-Li; Fri, 05 Jun 2020 10:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIqJgrSifJ2bjNxW1aSsFm+009uuI8FmqFa8gwtcLhZ6GSfbdpx8/yi2rCwnxvXKkxQcU1QS/P1hjJkC+edsmpsqsshd6qN4tr34xziX3jfQJAm6SHOpeC22lG903uiUVlmmAHIgzpzV3Sh6Dh3kjMU9GaLtLSfjRasAOQhyjLVG9Sh4u8YDtWTI9AdBwqjqvB8cuSXrc6lGpvJ2mCV7e9vX44QZxmhUQVS6vt/D3YR95r5XG3nSfvLuc/7tfHvkMb4w4clpxKuy5KVbhp7rx6u8sqQK2CAxo1J4iNNjhQpOVKeAuOzyCeoiILBl6R0PNInkVbtSJrXHgvPCxXS/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ7o/r8WAFclm1trOHivroBvgSXMbH2ymzVt4qGyXvo=;
 b=OAcZUAkgD9ydsg+1XSBmHi8ynCVLcj9OQz562Za1d0IhefRVRkVfQVE8LcJTu1D0q0+Y482BtXOu3d11WnFvIDO+3bezEqOP3UnTr5s465uxHL2ihbMdad3J/URtGyLMQ0XRNFOajEDCaqgtAEmRwbqfnbFhdOHw8qHQmKUZd6QTh5LR6QHL5PZ+gfYx2a0tzvG+prTQp5Zfff9BzEbGeFjjEcV7vAoOn3/MDbHS3+S5iURgYaVE07W7TRAGk5P+9FeRH3+WPBt0N5c9tnfnkoi6IsVbHH5FNKvfomSPaFm8ZYJaYP5Me5syimf4jAyFIb08uZfvtLvkwRYLXZT3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ7o/r8WAFclm1trOHivroBvgSXMbH2ymzVt4qGyXvo=;
 b=MtozUlihM983UDyafou7ctWQCO0tJkkHxjJhGbPRtmb19js/3DiRYsUirGT1RjzAYEYEmtHvaedBgb12qe9XN+7y3V/Z/LDp799y1y5O0rARBDquBnoaY+hHux6Xn+yWdcYS8ExaN1dMN9eQFKL3MXG4C1S5Ymu8fl8LGP0CT+g=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 14:56:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 14:56:50 +0000
Subject: Re: [PATCH 3/7] python/qemu: add README.rst
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200603001523.18085-4-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bc7d5925-2731-deea-c377-815e8c98abee@virtuozzo.com>
Date: Fri, 5 Jun 2020 17:56:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603001523.18085-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:205::37)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM4PR05CA0024.eurprd05.prod.outlook.com (2603:10a6:205::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 14:56:49 +0000
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4185dfa4-8e42-4fd2-9414-08d80960ad78
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54304E0FB765BFD5D1A70341C1860@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ijUkv0VZa369epe/GXfa+ERo4MAwfBO0ex360SlS6WhUvzkjzi7Iew/MmdKAhV9jt3a4qEzM17tO8JRctrIsXx+XsQaxGQjm4OpPesVut9I9SX6Q7rC/k7ZTCku4DY+0O+F8Mg9vMnxkVhkBxyTOUEtagLg8/y9w30aIUpcy2O1sV93gIjymqxda1CD0RDlf5/suPcJIpXiVN0xqlg30bQldijK55vFlPZJ9WZ8qdfW/eJvG4Pz/LH9U9YMxuZP+2LoCLGog5fmvCUauBuEFzDFqheWGqKi/lrQxb10ZStIPZQKKiGUiRNnjKQ3M4QUiDKWOskjQVj7CFcrS8k/RcJlijm5zNvlvcoTUlZe0nPgQyQUbhYKkxe5MZyVciNo+RrbxOViwwpCPtpvhc071o2FsgwrF3UU/nNq3GovH49N1pdqaMDuA4MAZn+vc2ukInDfbnhy6Xy39DubBZOvig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(186003)(4326008)(31696002)(316002)(66476007)(478600001)(16526019)(2616005)(8676002)(66556008)(8936002)(956004)(66946007)(16576012)(2906002)(31686004)(6486002)(7416002)(86362001)(36756003)(26005)(54906003)(5660300002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QB8XECDdLmEuejJuwkrtfm4jq3dsKcFDgwdrKlP4I4oOGWUXQgaaJRR7sh/Le/1ArT/k68a2XCcE7Eyd55Y74gH4XDYyRwcZaPoE0GZpqWiSKPk+AQbZKMMrLZWVGo1ZkKZUTi3VM+Wnwv/3TuBrVMZeAA98YnIZgBO+8DtBX0ie9Tq8b//R1YyUWDm4/ItFfqe7KdYdZ0sYwlpgLxHZRLV724qXICwc90VAYR5J1VOqM5qMd0Td8A+GII7hjwmDy6Iql2xt/MflngE1z27hEKlFKjU9YgQHqUlxLcu/FlWHf/Y9yPFz8AeKpokJjFkpO1lbIILVPhCPwOwY/TIFBFgAUibr3M1CJbXiRQ8ZHcC2Ojs/ngaV+TmePvk85K5aSmz91NTxnasnmGaD5W8/XzZMBkJYp4fcA8L2gUEbz2Al2z/RY5L4E7DByu58ZRwyOu1iQlFGJ25uVQa//TLdUmweTE7+2tZlbwfcp9c5q9oo5+x51kcixkA63M4rGVi2
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4185dfa4-8e42-4fd2-9414-08d80960ad78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 14:56:50.5493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJO87rQXN94ltqh4OFB9eU7aODTcwNqx14RemW7tbt3zTASiKL1HFkUppWmpsJOE3sK4yRHFMawlryqDudfNwnINY2CB3gsg91dZS9UjK0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.6.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 10:56:51
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
> Add a short readme that explains the package hierarchy, which will be
> visible while browsing the source on e.g. gitlab/github.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/README.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
>   create mode 100644 python/qemu/README.rst
> 
> diff --git a/python/qemu/README.rst b/python/qemu/README.rst
> new file mode 100644
> index 00000000000..96447b90616
> --- /dev/null
> +++ b/python/qemu/README.rst
> @@ -0,0 +1,8 @@
> +python/qemu/
> +------------
> +
> +This directory serves as the root of a `Python PEP 420 implicit
> +namespace package <<https://www.python.org/dev/peps/pep-0420/>`_.
> +
> +Each directory below is assumed to be an installable Python module that

As far as I understand terminology: s/module/package/

> +will be available under the ``qemu.<module>`` namespace.
> 

and here.

Possibly I'm wrong. anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

