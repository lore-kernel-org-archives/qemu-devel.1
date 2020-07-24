Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888EEC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FE02064B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gFb7gKNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FE02064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz03s-0002yQ-FN
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jz02Q-0001p0-QO; Fri, 24 Jul 2020 11:55:10 -0400
Received: from mail-eopbgr40139.outbound.protection.outlook.com
 ([40.107.4.139]:65178 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jz02P-0002Im-5Y; Fri, 24 Jul 2020 11:55:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2T6hKhbtkqQPSQT3I3wQekxqwGmLHeJqXMt4W8SWKo/YedG87Ln7n8NkvkiBNFjTxn5TXjdKx4SZ8R8Bn104VUhAUB87rIPgDYZSpEvTknkcKQYREjkyxHOFsjWpa1tQHj5VNGAAhPJZRaHIHauul/UmFs9DCJECOADIvfCNWslOLM4mQDI+v0susMAy7MJUQ6XhyMBpDBjLa3273p73lyBp0OHO4Nw+ztPrLC8o4++ErWeXiLpZ5vXEcY0qlS/fQGNlYaLYAI5vEzxZg9x1kJTMnu4FWq2VVk1WyqF5DEoBWq8uxm3dz5q372i3DYbFZNZLT++WzUiQKbFZoo9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srv4/PLf9bwoofbnslXbjWMbaVuL9Os+h4XJmVNf7DI=;
 b=iRxqsRvZFIkd15KThabDDRnEmNCj3uLmtvA1OjPi8pE1nKp9ofAHUJnqqz0qjh6jr6AJLBKbJDs06s9+9U2Iv11c8nlReqHbzVJdgO76niLWPFE9g8kJGTurKgICreOS+efWHNrIJtKrlwt9ThJ+Stz3uqEcS6bzuUEETTGM4902af5bYdXshi1dxiOXUhuWzn9vrv8S4MBd8pKSl1tlJH07AaEazc1+AbffAVSqfrXTh6X9pJSoRK3NSc8oAA1IjSPLrbZYRXt+Dx5jCYeAKkwqkX5WoEtrnbkZTQNRIdIo6JBveeLIvFFzHkNzT/CK9eoF5DhOAGmCLEl1hFdY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srv4/PLf9bwoofbnslXbjWMbaVuL9Os+h4XJmVNf7DI=;
 b=gFb7gKNjj01bmZD4mR8R/qRq2zu74rDYUHlSdyezwREvEHv7kpfpr24IINScOk2Lu4RAlRqctMkx6yoQCloSqmWhU7/gifE5SfxEqaAng7H9Asirxgt0oTYKD0h6gOsMYyyRhtDmnVuqEXASonXBTG97KlC8HOm4hrKv+NN5OGg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3765.eurprd08.prod.outlook.com (2603:10a6:20b:8f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 15:55:06 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 15:55:06 +0000
Subject: Re: [PATCH v7 38/47] block: Drop backing_bs()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-39-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <2abe7568-75ca-d09f-0241-17db11ccc5e4@virtuozzo.com>
Date: Fri, 24 Jul 2020 18:55:00 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-39-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR03CA0040.eurprd03.prod.outlook.com (2603:10a6:208::17)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR03CA0040.eurprd03.prod.outlook.com (2603:10a6:208::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 15:55:02 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32883f40-ed25-4e5d-3bd3-08d82fe9ef11
X-MS-TrafficTypeDiagnostic: AM6PR08MB3765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3765C3753CC7826E26DFEF9FF4770@AM6PR08MB3765.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPlTC4JxjdrneehW9biJpJqKGF+S96iQCZY7S6QCC5cKfEGimbDxZjd6CxPmUtQwfkI7vwwtqdmvn6SLbR7TbxRBd/7TTqvGwyRpf0I+UWGCw6/Ly/+6kdaFB4ZBGNK6oBxP2pkIrzP7DccHIVaomTl3i6jZLWs2VjQej+9M12+XRzG2RkWRiJIzpMX1opDAjHYcbx3jWqDTsTwTG8Zqr4uRlBOH1oGg5GE9N+YhkJQRt02TaDXScW98RyXITW83+RTQ7jxzBCI4th57rtYMaxHIcwkhWb+WS32F6CATk3dafK/OvNBpvVvkoQYBhNruLD+wSZYS/4n9IKU5GYxB73Mjs6tjPdGulcB7VKrzYxt1oLANUBmss+47BSJtawNi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39850400004)(316002)(54906003)(2906002)(31696002)(31686004)(8936002)(8676002)(5660300002)(478600001)(83380400001)(36756003)(4326008)(66946007)(66476007)(66556008)(52116002)(6506007)(53546011)(86362001)(6486002)(16526019)(186003)(26005)(6512007)(956004)(2616005)(44832011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9i0ampoAs7mck0DKyZ6L9+viNMX1j5twysgvlkTKWmYZHvV1A8GdJAxLDkxpScRxCJB8yVDtfOb+S+p/Cczdqk3eszxmOfKoIVGFaw4K0mmSW/lZsLAcWY+tX39VcrjtDuYjTdpYm45Yi+s9sGfT6Uf7gnTYpX6VlXEcL81+NBj3Na9wLkORahS/6Nbyy6KAjg92ZOlyuEsVIyKQy/RzBsxJ5LdAM1f8SATZXrbqjKEsPnPdaRY3xeUsUZ+5+a0+iMG0yYxkFjKjNAyU0ApskhRsMS6oIgPezNYTtE9KgeQQZodvPnllau9s4Kwfz2B06hM2G/dl2SCKcbon0hV9hKhCVqv383jd49l7rJXD86sS74wS9ZfmCZGdUsh5WJLHPQLfENbbWKlucEs4Pxf+zEGxQ4+wc+brQfw5BVrJib3z6cDmR9ZcegyvcEuZXG0oDsK3mtaw52+KMd6lFutI9NdPwlEWeEJ4azRYXOKKim8em4FN87u6MqotGU4KHObg
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32883f40-ed25-4e5d-3bd3-08d82fe9ef11
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 15:55:05.9823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3LwObsiJRzFXegyghTxp1Txb6lwEoAwW7XpmXmgQDOkBncCKkxW//ievbV+G5E7Cwvh4WzmHmy7u+QUSRO22H8IH3l5KKmLqSIFHhiJ03E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3765
Received-SPF: pass client-ip=40.107.4.139;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 11:55:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:22, Max Reitz wrote:
> We want to make it explicit where bs->backing is used, and we have done
> so.  The old role of backing_bs() is now effectively taken by
> bdrv_cow_bs().
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/block_int.h | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index c963ee9f28..6e09e15ed4 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -991,11 +991,6 @@ typedef enum BlockMirrorBackingMode {
>       MIRROR_LEAVE_BACKING_CHAIN,
>   } BlockMirrorBackingMode;
>   
> -static inline BlockDriverState *backing_bs(BlockDriverState *bs)
> -{
> -    return bs->backing ? bs->backing->bs : NULL;
> -}
> -
>   
>   /* Essential block drivers which must always be statically linked into qemu, and
>    * which therefore can be accessed without using bdrv_find_format() */


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



