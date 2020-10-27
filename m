Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E6DC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F65218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qVwk0hUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F65218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPGr-0005q4-Nu
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXPF0-00045C-Vk; Tue, 27 Oct 2020 09:42:23 -0400
Received: from mail-eopbgr30098.outbound.protection.outlook.com
 ([40.107.3.98]:53251 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXPEx-0002EC-Jx; Tue, 27 Oct 2020 09:42:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0yEp5jrghcy5f3aSA+QJPYLLQywpegln0GQmTg4VdDy0xdIvXf2sSNOgrL1XwGGthXApMdZp29oNO2MMojHIm1TgzSSp3MREO7mGJ15P5UKPUQMb6iIm18Puo36aqBa5ts46klzCpxTcPN1A2wE0YHdAAyXMaOhS6wpUV4TpyRmbBAhWhJyEV2nKrGZcpznXsV6vkPQWTNBYFpT1il6l57plZ/ywEKxoqMq7BrdWyAWogP/HZmQ5U9ed3/pNGyL+V2c+LV7SSzv7senI5Gw8lsb2F7txLfbt02cQPUZjpZviCoU5TbeLdtP5hTgxo866FPg/KpEbj3Gd2irv8zo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCPFqlfT9Kwk8ANq/EHfpeX0xL2k5a/97uANnLnOBMo=;
 b=AjW+kb972DMfPxPKNoGx7HoGJE14qInOkzX0sYLa2R0rLKaJdnHY6gOILSVmJM/jabAxQk4w2XciBry2pW2g997mXd9Ouy1tDS31xSy4SEB3p++8UF2Rpa6NpeDBXRxkEZIuHZFtqC0C/4ELRTmAh97uQFmFxF/VloponQ2f39+hDKZImBe/n5SEUFJ5uy1n13ObWnm63KSoyiUIATdic3NN4T95BFL72j+AHbtDvY6FL7owaEdVA+PWCG9PdzH5ugMUxSr0d795qYn5Xw9zwmSMDWJrWXVHnEnEqHvcLyVrLUxf1hBbYdgJr27acJat6tov+SWyNTnQNMQ6teAKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCPFqlfT9Kwk8ANq/EHfpeX0xL2k5a/97uANnLnOBMo=;
 b=qVwk0hUUB43E6p7JLBk0yxkxFKKVzDjdcPjlwqNp+rsH7emmcQAHqU5jwI/tUO5SfBPrXW51ZC/abTX3NN2X2F6Tz0pUHavUhBeZagnXGFwQxRj2G4ZV+JMf2U/ZsoCUaGWt4tTMPr4pwv3tb9Ek7W40N1piP9O6scHUyCFQzSo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2928.eurprd08.prod.outlook.com (2603:10a6:802:1e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Tue, 27 Oct
 2020 13:42:11 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 13:42:11 +0000
Subject: Re: [PATCH v6 11/11] qapi: Use QAPI_LIST_ADD() where possible
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, armbru@redhat.com,
 rjones@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Richard Henderson
 <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Gibson <david@gibson.dropbear.id.au>, Halil Pasic
 <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "open list:GLUSTER" <integration@gluster.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 KVM CPUs" <qemu-s390x@nongnu.org>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-12-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dd84c46b-916d-66b0-4e3f-23e4fa9a3f4d@virtuozzo.com>
Date: Tue, 27 Oct 2020 16:42:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201027050556.269064-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM0PR01CA0136.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend
 Transport; Tue, 27 Oct 2020 13:42:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2054311-d03b-4fb7-94ef-08d87a7e1b0f
X-MS-TrafficTypeDiagnostic: VI1PR08MB2928:
X-Microsoft-Antispam-PRVS: <VI1PR08MB2928A20038C751A365CEB54EC1160@VI1PR08MB2928.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: synR/7A6pIfujENnbXD9RGAwI1GFoWRmbbYJ3AamtODze2NUHEh9SpIiM317CZRuM24Q8OIGrNDivwlE0sa8yIeJ3dLpCvGHjc2RI7VWnExyMkz1u2cVZZPWDd2bhg41dxUzhYEZmxRTG7PhIQgotUxAbbA/BjDw8qwk0vYlUFxQE5TfuFkiBGhjYPLSv9cj1hfL8VPZ+8jjNGCgrNYVd7giyHnHh62q0NnhnDoN3v+IxbCypDpPUW9rs6OShVb6STi/B2RQVm7SVLXrh2tThgu9sG2hL8zsIa+bkszUFkEG3EF3JqV5VOXUJR9Ycmzk4XvhGJos3yKFFpCE1p1LNJPwINmGwjCHwnhYwuSuleH+aLyidcF9+8kw2Bg0tQUC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(366004)(396003)(346002)(376002)(316002)(478600001)(54906003)(16576012)(8676002)(66476007)(66556008)(186003)(4326008)(16526019)(36756003)(26005)(2616005)(8936002)(66946007)(6486002)(86362001)(7406005)(83380400001)(2906002)(52116002)(7416002)(31686004)(5660300002)(31696002)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ra8o9iw3JpZqMtV6lJNJjah7YFipxpcfH1kXekin4V50qyOXnK/Ba5+YiJMGHJa5xQ5BcdbMc9uSiqQToL5+3+h2Et3dgzDbOPv6h1VutC5WY2D05jjzStxwTuDO0pUq13JFsJ0WStce8PAAcmgj/jxrAPMoBJ6BfJHQMZaF6ynxsR5Xf66VN7/ciKhotD0j2Fz4xPcqnEfWm3lDWKS/3rIrB2Sa4c5bBBSg2Umg1ATWOVNFRn4JdcgrU/MJ+tcBo/yRytS3xY3gUQqBX9VfeRSlQGZhQ7dRma4Jh9dZje9WHb3eWmc1RC1Cz/25CJyZ37i4SdlwWVOSkOsl/S1hhcHBM24ClPAmG72m/dlz1ODOTN5/a+CGbl4HAF0PYZb2X6LVBCj37R7RskbGFldsihyl0+h4EVawCadSRCwQfIO7ML0zIrCVttIPC7PiyZn8seqL4DjcgAY/MC9OCOg/a/+580lSeoSXKCmAKyIAYIAO1WIuqgv+2f2QKurTS/4+4xSO1UWXalqpH5rgn5z42d4hsiHUL1pv1nTgrk2xj0MRoGJp7FPralRuB1GjJZAa1Vy8vh1lGNnW1S7sd/mE1UNoiuc+OhN4aNbCLk8sLdX7YTue9TPode52kaYlj4FmhOvmwRQ9nSs2ESMO2bBVOw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2054311-d03b-4fb7-94ef-08d87a7e1b0f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 13:42:11.2753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNYcsgpr8CABDxYXeZsGv8qH08P5/FqsWeV2VwfBxW6aL7WDZH7HNl2N5a4r1P5xUtxeRI47y/dF0OTeqBinTl/yRs42e/jgxhAgD97aSyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2928
Received-SPF: pass client-ip=40.107.3.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 09:42:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.10.2020 08:05, Eric Blake wrote:
> Anywhere we create a list of just one item or by prepending items
> (typically because order doesn't matter), we can use the now-public
> macro.  But places where we must keep the list in order by appending
> remain open-coded.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

[..]

> 
> diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
> index 46a6c48683f5..3e11eeaa1893 100644
> --- a/docs/devel/writing-qmp-commands.txt
> +++ b/docs/devel/writing-qmp-commands.txt
> @@ -531,15 +531,10 @@ TimerAlarmMethodList *qmp_query_alarm_methods(Error **errp)
>       bool current = true;
> 
>       for (p = alarm_timers; p->name; p++) {
> -        TimerAlarmMethodList *info = g_malloc0(sizeof(*info));
> -        info->value = g_malloc0(sizeof(*info->value));
> -        info->value->method_name = g_strdup(p->name);
> -        info->value->current = current;
> -
> -        current = false;

You need to keep this line, otherwise logic is broken.

> -
> -        info->next = method_list;
> -        method_list = info;
> +	TimerAlarmMethod *value = g_new0(TimerAlarmMethod, 1);
> +        value->method_name = g_strdup(p->name);
> +        value->current = current;
> +        QAPI_LIST_ADD(method_list, value);
>       }
> 
>       return method_list;



-- 
Best regards,
Vladimir

