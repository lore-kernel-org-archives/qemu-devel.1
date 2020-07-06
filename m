Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89525C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5070120675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PLhjXekK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5070120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUAg-0000m3-G6
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsU9c-0007j5-MR; Mon, 06 Jul 2020 12:39:40 -0400
Received: from mail-db8eur05on2119.outbound.protection.outlook.com
 ([40.107.20.119]:1760 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsU9a-0002SM-5Y; Mon, 06 Jul 2020 12:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPo5vaxUdXlxjhFet1z59crY8bV6/ao9LFdsyfTh9qrmJLsXvLYSXysaqn203+TuwiHWpAENVmtRbwZ5HaDfTYRMO4yNdo7Yl/rYhWRsxM3ncRyTNN6o/1nQMs8FSdEk4iSvQk6rY3L/IQYtlFCfBnUQL4X3SUofEWK74fFsknXqjWrp3CluXnPVzyvggiL5Kfkh1dPwiyUNYqvzekpqfMcSGEbMdNzc+/kEODKGT7BIQZpu8sbwNx5c4gL9NSi7l6OHU+AMXPDziPrwRDizu3sB6MEsRBpGvZVzgVlj+mN9bq4m5TROIfvlREUqPEJowKvMxdg3N4WS/P+yYBh0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwL/nTizRe7Txe8uTaBLpZPrJubcOCcLBKQkAK9U44E=;
 b=SShgRlu0o11GrkF3t6XEmemjSR0/FPJWy4DMEE1yQPW8ZuKPLp8Jw2IWWr9qLQHUe6rg7dN6eqLKEohWN4+YF9R7bI65W1EwR1cIVYdhsTx6/3GbCjAyAr62UQCxESnOWUtWN0JympcofkT5AwavivxmV6tJegbg59PfkOuq+iP7O5bAlWPimPpGSYJ9gUMcFpXy3joSA3p6Ge2FZWY9rFlTMMSQUUl4u499TEfgPqd5QMXhxAsrv5H01l9sfJbEn5qqfgw7pNVIPYojwpJ9dAXhnVZXjlit4Sd2r8cVArJ/1p9u3r6LvLjd+tJ6UcaeClkvEzIBfwO6zCOOMlTFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwL/nTizRe7Txe8uTaBLpZPrJubcOCcLBKQkAK9U44E=;
 b=PLhjXekKQFfXG4acrw+y/Txqkz3WK+CcvlKGnaJKnU07jeeiJMnpx7EyedwhfvBL5YAO669TjXphdUbeqtMhJJ4s52VxiTV1K+BbvVx3nE22aTxg9ReVs3qg+5rbaXouUJefmsDEE4USAYUZZotLT9UXOB+gD4uZTK0sApSxTzY=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4788.eurprd08.prod.outlook.com (2603:10a6:20b:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 16:39:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:39:35 +0000
Subject: Re: [PATCH v3 28/44] qom: Use returned bool to check for failure,
 manual part
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-29-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <98f00963-0b32-ea46-fa92-72c7354b5a8b@virtuozzo.com>
Date: Mon, 6 Jul 2020 19:39:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200706080950.403087-29-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:207:8::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.12] (185.215.60.58) by
 AM3PR07CA0131.eurprd07.prod.outlook.com (2603:10a6:207:8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 16:39:34 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbbfa86a-9af6-44a4-9007-08d821cb2a89
X-MS-TrafficTypeDiagnostic: AM6PR08MB4788:
X-Microsoft-Antispam-PRVS: <AM6PR08MB478810777AAF183F4C075EF4C1690@AM6PR08MB4788.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN2gc0RGfKkFx7+KfV3/PXmCnIGh7/i85jhAbzD6Es5sX22Q2+rFCallKvK58QYpx5fDvZ7dCDSw69wz5GOpU7DOcoNtBwP3bcP1P84xGHkoxFh/7WDeEWCWqFDirUnUbb/wEkrRGWhvkNSSbwht/506/UyHE9a5zcQcUpFRahm/vEvmDxM8U2qMjPRLRs2ma5+L2wBlA2JFRgVBktFWPDKYx6wwQ8gWnrp1m2lNEGhbEM1TZozBLlUFD5uIqJByPqg0NRDNBv75cA7oK+JohD7ZtDzD+f94uEzseomLEYaGS8EK2L3WyqeQR8JF6wi9xRmgg2X3QMApTiC5VkdUu+9aOvC/+n4AZkvcbr6XhNXD84gdYwjQvEcHxTIH1rSR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39840400004)(478600001)(4744005)(66556008)(66946007)(66476007)(8676002)(5660300002)(956004)(36756003)(2906002)(2616005)(52116002)(31686004)(53546011)(31696002)(16576012)(86362001)(186003)(4326008)(16526019)(316002)(8936002)(26005)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lcw5Uv/zHL+jTVfRmnWBh9mrjiwBQ9fJcq86lcNKV2dr7ge7eLcYWc4HveUSdeMSfpjgLyqgQZ1vGBaMl1EAVq28stKDLf+6EAayte5krfnB6da+AGE76JO8L7W3te0M6quNjkkWmxVlQkBo43ZcjFsaqPGOea6yfBFYrj9LmlNJ9uVP6nImKJMgsesm/2gZmAWoFcUOTpEuiwmuAySw99VXv1bmeUJiMIgoYdDiSSoRyrYsPwp2Fg25q90Fao+ACO7SLydNiWZqi9V+FrbRAnTkZXp3Tr1ykVaRE6ShjbsKzxVoHHexnC2iC/1YSD5CQicCSpUJN7Sd8fbl+mo4/DQoTCVn0VPdzul2alx8dyXuO90FSnNl1Q2cqXuql4bogdZzx2CniN80YcH5Jvv3aWJ5H6sOrUuvb7oNpzepdHGvFOKhEQqdGZy88oRlXBD+AA+n5/EcAhcXmqa8uTvqEt+PDDA+fYmPwetSb1hutYs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbfa86a-9af6-44a4-9007-08d821cb2a89
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 16:39:35.0523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nefK55u+c11KTiSoYsofK5iUUBpUUMEkk+YaqI/PUeP8A7CrDhiTXDIfDz91AP4w4VK8IJMUDV9Z+9SO7atuTcPx5o98cmP3AzG6nGTdB24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4788
Received-SPF: pass client-ip=40.107.20.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:39:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, groug@kaod.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.07.2020 11:09, Markus Armbruster wrote:
> The previous commit used Coccinelle to convert from checking the Error
> object to checking the return value.  Convert a few more manually.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> Reviewed-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

