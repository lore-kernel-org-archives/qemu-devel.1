Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DAEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4C52074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yjqt7pKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4C52074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEQA-0004Dy-Nb
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhEPQ-0003fv-Ko; Fri, 05 Jun 2020 11:37:28 -0400
Received: from mail-eopbgr50135.outbound.protection.outlook.com
 ([40.107.5.135]:32416 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhEPO-0001w3-EP; Fri, 05 Jun 2020 11:37:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRcdl3b+Z9ueL0tkwRagIl3ohsi9QKTrxy21jKRyL5ooBe2483WdHzt6E3yRA+NI1uqOYj3iv/+okU9baYFSnR4h39tKRPeoeWepxTgMXyJaJpfmx76rW367SFhClVnrO+36ResdCVxKv7AbwvYhaNa8WibZBDIR0ERCnMwWqzraE/+c1qqN5cZD87YbZAg1phuLtdduiAbaIZVSkDqkcXAaTvrufQeUnR2cOvOlx5bbmqsG53JBpTS+lNIC75wSb0RBPYwXcYKEu7iLc8FliXMiIsTTgCA+BA7bP1zlIO+PPgRkU+pHIETj8dcKYXR1EGPcCbtIUcEgsDlFLP/BVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1FAeKv3nmIKeAA5DqQnt7ss5g4IZk7WSBCLBMgDlhI=;
 b=VLHHsvaxXGerbzPTWNajU+TsCg05U/TlJoFL7CW4o384cbQtxOM0EUsn7DiCkos3SWS/rPAb7nobiy23owc0AC0vRsNJxVs6DtIiOhF9sgC5UrbcNXTYibkgw5PGPNRGQVBA7iqXcSOmG4PjAhnM+48HU98JKl4MP21Ad5+aO5/fBFRnGVrR45d1XRhoCmBLpSe/OwhXsL1VTAIINBzFIrhqHYsbcn8cy3rsQwtPx9HAVN09x+FB7vVnnSbCArka9q2bb/eI2KUfN/c7s6oz6T12Lk6NMUO1qyJ6mHu0yF8NBnweHgYXx+MNgER0caQiP7DOsMNP+31oVj7FKrQbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1FAeKv3nmIKeAA5DqQnt7ss5g4IZk7WSBCLBMgDlhI=;
 b=Yjqt7pKfNMf88JO9F+lqXPTl6J6dkKoCCdHL377q07ix9A1iUg9XCgAhyBb3+qBOGBl1ukY5wl4AJjibLilf/revaoUdjOaHQY8OXn67Xl7FQVM+X28LtBuNPasDkuOHaHZi+d5MAaAvNbWxRoObZZBlCRvtgL0S3CFcHH0rbF8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5528.eurprd08.prod.outlook.com (2603:10a6:20b:dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 15:37:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 15:37:23 +0000
Subject: Re: [PATCH 4/7] python/qemu: Add pipenv support
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200603001523.18085-5-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b7fb25b4-2aa7-94b3-7d2c-5c33bdc09c5c@virtuozzo.com>
Date: Fri, 5 Jun 2020 18:37:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603001523.18085-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0083.eurprd05.prod.outlook.com
 (2603:10a6:208:136::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM0PR05CA0083.eurprd05.prod.outlook.com (2603:10a6:208:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Fri, 5 Jun 2020 15:37:22 +0000
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4a86f06-2f62-4db4-dd89-08d80966578c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5528:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5528BB7FC9E3B58EA3761D57C1860@AM7PR08MB5528.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlH8IKZw61JYNz4DKCGg3XKrU+HIVZMxZcaWMdxJwSP7U/IQv6XzZhGL1L3S6zX+PRw/pS9nHDKUY/JcTI/mqphH10C0RsIOJLwwcgfrxMj7xRdJQBZELYptA2M/S2Y/Qj97VjhyaGrcpI4n8Uzm4MVFMkDZeOM7FwbkMig/pD8ME/cL4q6MB39iWPpCTERTL+nI7ayLAXYUzrIv01alL34gLiDs6ugeSAX46kXxlu8Lfe9YmN9PNxR+iDzY+niQzt/pxUDvukGaSiRm52ejE2HTuut/WmqE45in3L+RL7sLWkgDbEwNuWqtJPufqCXFCfvb8LJUVhrKvY/mJRhGLUrCvLpurYfXrNZlftq0uAjRwml/l9kM5feFNi4BgWJqGo9I1awLgFKYnP4TIKE5IZXm7DRCPic8L8NWILzPG5fbLI8mzLIAdtZsEuCPLFBJUScOt812KWtniWTuNbFyHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(346002)(376002)(396003)(366004)(136003)(16526019)(86362001)(54906003)(83380400001)(956004)(7416002)(478600001)(2616005)(186003)(16576012)(5660300002)(26005)(52116002)(36756003)(66946007)(6486002)(8936002)(8676002)(316002)(4326008)(2906002)(31686004)(66556008)(66476007)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NXO5/DdSDDJCvstkLJG8GRiR0CFIuMfafm9T5LU/cponXS2vTQobla2Rdm7DArc7AKtrIZhml5T/ZVWTn/lxIGSoqmfQOnClAH8nZ+bTZTM0jpQ/zR8N7CvDEt5ne/sRwNuiNpyNeTCQ9hDOxuCahM0ZdVZseJeDXlK8CpgLZe7ccWoaIELIUebTOXKSm3ZGja7UkzNGyS6KMde71g+Q/f1hRYq9kL2JVjxdwXrz72zBY8Ax0js5b/y+sj8jwK9BfmSqmDtRXUMW+xqmR0GqGjPJRnjSYtZBVCH4gQ9kORwZxVPi12aEZug+yYmbfiXG1kSoWk1prFUArWT6HUtLK//uC6PDWp16RocYL2+t3f27q/PQTqaCbkZTYh1808dWIzgIQD3XUZzgt7vvH6zl6fJ+cTUhLWpOJzgjdWxKki2nZtaeH17hnr0+cOdGZBT6JvchWe9qqKtZsKozM9/HVDKSEXoqBzSBWCM32V2dc5UUfqjuIdq4Pf+m7gincS0y
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a86f06-2f62-4db4-dd89-08d80966578c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 15:37:23.4054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ML5P+h4ngXMLhemQP4K+CXXvlTE+AP/rQs4jVJHv79XvSu1213ue/T6mCmlSNpz+ISsdIXNGpDvP8nGIY3c1ZwhRbMq5pTxcCiGaPvjB2SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5528
Received-SPF: pass client-ip=40.107.5.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 11:37:24
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

I didn't find what does [[source]] mean, but seems it a standard header of Pipfile.

Not sure, how much sense in it, but:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +
> +[dev-packages]
> +
> +[packages]
> +
> +[requires]
> +python_version = "3.6"
> 


-- 
Best regards,
Vladimir

