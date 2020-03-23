Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7862C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 06:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22F120736
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 06:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rwF4CyXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22F120736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGGwb-00048H-Pz
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 02:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGGve-0003EM-AM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 02:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGGvd-0002Fa-Bo
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 02:51:18 -0400
Received: from mail-am6eur05on2109.outbound.protection.outlook.com
 ([40.107.22.109]:37057 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGGvZ-0002Di-VR; Mon, 23 Mar 2020 02:51:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwHe2/tao+3e5QsC1FBM/FtJfBoiikyeonjp7S6IoFH23omxJEP8VW7sA/XXGrdNzb8iRxRI2Tp+JQCfnB+3EPobPKk44Cbsi7gB6WmUcr7nmB7OKJLP0F430+8i/50X7BRHK0WuLZXdA98IBZY3CEvMdkkEUgqy3ljhawHEBAe2mMuPW8wf+t1325JGKpgWG55VJx1xNu79jiMBeA6nQmhHdz4r9BwAspl5SJmC8wY6Rk1a7zAujh769mKd5q2M4I0dTeDEz5QNDGK00MnbSbv6qfzNh7X7SlPVkPWioU6U2grg9FO2K6T5miNYU9KLdtp547Z90tYAGDPdYxgxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK691dGL3ZU9u1d3WNexJsWqlP3V2fO6Lxf7ihNu85Y=;
 b=P0hg3+4a9XAIRRyPsNAnLEq2I6zwVAzf6eO5Sy/2zmRnvuOItS2JTprE2RAFZofXPNKTWEhRFuGjbrVilNOwpb1Srfr7ePYr3PaMseF7PUICVVHC2T7i47wgS9jKuHVR5yzsQH9M/ue3E3p0v9XSp1lrBNtZ/SWTM3jRvI/Q5S7k+Rgf+dR5MwRzLk8ZUOX9Kjkw+5wcAXggR6unE9+acAl/OpTufqbh0PsgSOHbkflbKbHzJLK+TljpphoeU1O89UxWldiFTbW2kgSQjZSuIjfvABBrsjxqO6/wgM7juvrg6ApG4gxtajQExWO4adHjsc2sfJ1dgkBiwf6z1x7tyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK691dGL3ZU9u1d3WNexJsWqlP3V2fO6Lxf7ihNu85Y=;
 b=rwF4CyXM3j0fVCqdcRcZRUlRC8mSExbNk8TDVe/3wKIc7p+GWw1xd2n3a2q+bpFVYrM+guLmvnO/XZZcU/PHX19kwQIpcGRQJwVm5gh3j7nxOIz1ixvIrZM0L2+l/0NSK37F5X5P2HaArpE1yGwzef3Ad5BHBvmaqKEwS/jfESY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5463.eurprd08.prod.outlook.com (10.141.172.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Mon, 23 Mar 2020 06:51:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 06:51:10 +0000
Subject: Re: [PATCH] block: Avoid memleak on qcow2 image info failure
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200320183620.1112123-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200323095108086
Message-ID: <7420ada8-8892-c075-25fb-9ad8d28cd97a@virtuozzo.com>
Date: Mon, 23 Mar 2020 09:51:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200320183620.1112123-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0111.eurprd07.prod.outlook.com
 (2603:10a6:207:7::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.41) by
 AM3PR07CA0111.eurprd07.prod.outlook.com (2603:10a6:207:7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.9 via Frontend Transport; Mon, 23 Mar 2020 06:51:09 +0000
X-Tagtoolbar-Keys: D20200323095108086
X-Originating-IP: [185.215.60.41]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b5f372f-99c4-42cf-990d-08d7cef691bc
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463093984012BC7DB74D737C1F00@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(396003)(366004)(39840400004)(376002)(136003)(199004)(54906003)(26005)(31686004)(36756003)(8676002)(81166006)(81156014)(478600001)(52116002)(6486002)(66946007)(66476007)(5660300002)(66556008)(2616005)(4744005)(16576012)(8936002)(86362001)(2906002)(107886003)(4326008)(186003)(956004)(31696002)(16526019)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5463;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+P17qfcvMo9favedMpTsx9vU8WhxpVBD2jAN9QXe96IfyLxOnHx6w49PvifoJUoZYUmryFvsOk5KRN0LhGDAzqyV3gL1h2WDZQpDLAsRMs1YEsaSdrWc2sWJ0CrwUwkPP60qAWz60Yx2qESPasDKsq7Le5ZAhjmQKeYtC7jYq5Cckzbod73EK/KibT4FDKPENpGQTC/g2/nwJ0oVMiBKPU/57cui9yU1SQCCAEsMogvlQ7RCTsQff2SZdRBSZtGNSZaU30A13LPTE6uuELteuAT4KPrPku7CMVHCdNqIAJPSQRh0JZVpXUn2vWHQ7Kq3zck84jqEy5ioOBmAkCF5/1W3gaLR+j0fz9FoVQ9L//saeSoX6/+xTMtSjO9d/w1q67Yy7HO1l3suYD0OQBfrMn1y07W8WV6juXrR7I5zWsn3srDUo9W0eSK/xPdmIV8
X-MS-Exchange-AntiSpam-MessageData: hG1+aRV4VOi0Ce7VPsJqtUqZnm8cIY7nQQcxIeUW142QZNUUajpemQAvctFWGWJk5ijfuI0pkyaoArXFDj6b4N6eLVS0nLK9wkBSJ/cFQkz2septcjyZY7Yq8RZgx/dDUoekbNqB1+NjYyQMRXVcMQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5f372f-99c4-42cf-990d-08d7cef691bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 06:51:10.0767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFh4Qzu+N3qhc/t2BnfXhdd4r8YwsGkBvQR5cJ0wNfDYD/3X5sSEVNxVVd1HjDsaYIwxu5IWoEecdhaGDhby48UOV10iAZnByDpuqbQxPK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.109
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 andrey.shinkevich@virtuozzo.com, "open list:qcow2" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.03.2020 21:36, Eric Blake wrote:
> If we fail to get bitmap info, we must not leak the encryption info.
> 
> Fixes: b8968c875f403
> Fixes: Coverity CID 1421894
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/qcow2.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index d44b45633dbb..e08917ed8462 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4811,6 +4811,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
>           if (local_err) {
>               error_propagate(errp, local_err);
>               qapi_free_ImageInfoSpecific(spec_info);
> +            qapi_free_QCryptoBlockInfo(encrypt_info);
>               return NULL;
>           }
>           *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
> 


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

