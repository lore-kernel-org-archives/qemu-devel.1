Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05283C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C753723403
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KvUuluKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C753723403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqEr-0004pv-0R
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqDd-0002p7-D3; Mon, 29 Jun 2020 05:36:53 -0400
Received: from mail-eopbgr70130.outbound.protection.outlook.com
 ([40.107.7.130]:44755 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqDa-0000FG-Ol; Mon, 29 Jun 2020 05:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYi3KmgLhXmkJsQTjOqMiDmdonXwLWN3PGBoz/N2+Q+FlIqpQQyQZrqPBk7UE/ax6OrlFuBoCmLifh/G4zzNGb9QM/5uIKge6t+RaPqGEIzuhrAQO+DTgaOBvnZZeZAnWwNKWlPm25DlyzStQ86E6fFS6isgRGkaD/LHSzsQvM5hZiV08OWFjKBhx7z61YtC7gwG+/ex5WvY5WQbRS0zopZgSEcJo2R3rAXzk1J+nyybF7uCqYYeIOoXrlc6yKcUD6RLWNdFXfPGawETx2kI5brWhXNtTyiWbFx+OnQPrFCmVu4SipH2ei4OjL5k6kBswxaD/LcrtLZvMaB2gylZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/kZ9vcfxY9MWR+uleHIFam4CXeRQ4W6WzewJGWzwQg=;
 b=cT3SeqOEjGvme+nrJcr/i7g0VUdCSfkbeLb8+U6t78ipExavtveAqE8bXPcPD9hldJYlR8cGe3oz0iIl8yTWOejWicBEm3iGj+vAVFiVfIkOu0i39dON05NO32SiVdH+RpyqlNQFijHn4g5qH6g1btCc0gHHDwFFryO43UDZeezsZIwvjnG0T9taG+N2epfFlm6x3sraOnvgRsFoJA5Ou/iTNjXH6WenxiQMTg+aSAgFgxkY0WTYFR1BKt/X9yDD4AlctE/r2vLBCBXWz43UkLxiI2jpW4DcwUyKUi6/flJWSxq/ECwMAiZFIN3rE8m89FGvd0n29pF0LTZ2u5ol7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/kZ9vcfxY9MWR+uleHIFam4CXeRQ4W6WzewJGWzwQg=;
 b=KvUuluKCWQNPmRYMmZfr3XWdTo/Yxet6Lvr2qWmbj8isL8ccXRMS9MDQJVPTkVm3kPj5ZdHOcA6ReCas+Ltw2OGltRuVP2tB83Jl2vJdL8uSW7Es7nR890CH3qxq0v38AVy0Jwt//t0WFynNB6gTnRml8S32t2g9KNWs10hYWRY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3767.eurprd08.prod.outlook.com (2603:10a6:20b:84::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 09:36:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:36:46 +0000
Subject: Re: [PATCH 11/46] qemu-option: Make uses of find_desc_by_name() more
 similar
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-12-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a73876ff-2ac1-b077-9fba-a135d97ba9a8@virtuozzo.com>
Date: Mon, 29 Jun 2020 12:36:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0152.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM0PR01CA0152.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 09:36:46 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd204f9-2144-42ed-4ecd-08d81c0ff0e9
X-MS-TrafficTypeDiagnostic: AM6PR08MB3767:
X-Microsoft-Antispam-PRVS: <AM6PR08MB37679BCA0313FDA05176C306C16E0@AM6PR08MB3767.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yp812NT6C4ab4jp0L0K5aFV+H2OHywDBmWw2bsOdEIVcPKs/SqfsYnM52TCDQR+Sx8R28jdEhi1G4mABJ1Yj3hnxcjKm/HID/mqyc+TAjYw171EtYQBoxRi8wqOMh6p1liUV7GYkpu13Jcq6YBnhdJsCL2dsPAPxgjS42/jy1Pew/gBHBxwQ+dR8ExegYu5sLBX5hYYjxuWIK+JGBMXgE/oypOp44wOeYuRI3G96qC/rSN1Ri3Z35NC8tPy3VnkQqBdCPSN2zxyy6PR4YqsR1OyHKcSv3Y8VrnaOIizoDGJRd1uWTKniK0Co562AN5CpA+IPs9yhreY5eGKD97zvni7cBZCsXUMqpeabstl+aLJ/8vR0kqyGhCrjno/S3p+P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(136003)(346002)(26005)(478600001)(316002)(83380400001)(4744005)(956004)(36756003)(2616005)(6486002)(2906002)(52116002)(31686004)(16576012)(8936002)(8676002)(5660300002)(4326008)(86362001)(16526019)(186003)(66476007)(31696002)(66556008)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: v/HigTeJPI0tOo6Kf3/DqZvziAlwgfhaCaCQfjuV1frJVSgzvnD8VN+LIXPWtBr10h7NMt7xxAz+ngNW5hkIPbLP1I34UsDLJPFbby2CVQsMbRxsPcKdeK53omFIYn1vPGXVnP13189kgw1STCRGfcMWHfCJRAEs+Gn4H3+tYrIPP/xahR6j/AcXnSzULy7Tdh4PggW02258k3xHeeA3BHcibINIvbf1xrqP1/5rHQ7an+9mYz8lOA08MMtxBkmVaHc+FfLm5Rr9ElSVpSXnS0TWnvB2blXIXTTv/lpJxAaXaDL8BJzhbugWHVC4gskphYpXi/u1dMVVAjOU8XN4xXMwCneBp34fCHJWkrIwCjP6NlGEMDOiPN6632VDKgSybO50eHKn/36ocpByeD5jaKm7vz1IDaQgHvXirLlTMEy74S0+H7IWlUUHSvITmFZZ4eQJZtdK0YumOt9AW5btKKmIv3g1TkEfciB4f1Iizk4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd204f9-2144-42ed-4ecd-08d81c0ff0e9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 09:36:46.5999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03G7o6mtARFRCbvN+jNA0/qNxeb+ka+/MXLVwyuLDlla669W4aN+bnUXQvru8C07y4yqLfN27RdTj413GLtVNPomLsKjthQDIufMWhVar4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
Received-SPF: pass client-ip=40.107.7.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 04:22:42
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> This is to make the next commit easier to review.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/qemu-option.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 6119f971a4..9941005c91 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -270,6 +270,7 @@ static void qemu_opt_del_all(QemuOpts *opts, const char *name)
>   const char *qemu_opt_get(QemuOpts *opts, const char *name)
>   {
>       QemuOpt *opt;
> +    const QemuOptDesc *desc;
>   
Honestly, I don't see how this hunk helps with the following patch, which is simple anyway.
Keeping desc variable scope smaller seems better for me, as well as further scope of
def_val. (Still, keep my r-b if you don't want to change it).

-- 
Best regards,
Vladimir

