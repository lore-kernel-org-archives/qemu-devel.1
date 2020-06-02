Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216EDC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B1D20674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="w7U/C2of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B1D20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6db-0008DW-6I
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stefan.Brankovic@syrmia.com>)
 id 1jg3sw-0005tH-NF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:11:06 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com
 ([40.107.4.92]:56095 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Stefan.Brankovic@syrmia.com>)
 id 1jg3su-00056Q-IZ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGlPeoDBhOkOKcwQoGh9MsgveRI7L3iD4zDArAXbuxVHBRXodiZ5PIqVYNjlP17M06j1oW4t1vMi+9kWZnLRhIFei7XYYk4OwglkXvHohXUlRkxoSugONdMkc9WquwKXZC5hUGaueEuB3bODggZcFJOMYzquP19sZDuNGuQ+fPz6DxxZP2m/mqtsOmDzXkq7A6+EtBWSQihrJ/vFtL4qM52VFB3QcwJcES9H1EHGuivTBzH1OkMYR8//7cschAHAA8PjjG8sFvBhMBCfwo/JOlHh2jn5/Q6QQ+809UOmINQXnWEcbOx9P7k2/q3irGXJBNWWm9/aevPqdoYCui/8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3H5x2NKsOKgA1+kxGEyF1j+NH4j2vGwVOTRnyZRppI=;
 b=RClgpM6c1xJ4S15eONV1/8BTI3AvIpCbIxE9zM3iRdtVg4jbyn/SMOppM6kT74tqODcveHa1c1sYmnpLfjzsQOlv9sM5twmrd7Vxe03KQQODvlFUpnmI9xmSWZb5YSkD5afaLa+Ld+d2pv5WFVX9QTn0rfcMFVG4QCmGxlcLbUFPyAahoxle/lOJDBJvjn1Se5ihHjhZ4hU9Ax/xmHdd0KPmW6IX+8A0AhljCBjvb/e5/Lwao4SPkqUzlxTy3fURJXn1sKjuvHkGBY1pF30EhEqCN3pQ1huxjXWodQKQ5N1xV7cc359OKKMv8vbO+PNtDlN3KNX4on0TfvKBseoSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3H5x2NKsOKgA1+kxGEyF1j+NH4j2vGwVOTRnyZRppI=;
 b=w7U/C2ofPRJwx035erNS/TJ4efICj8pPcA27JRtn2L60ecSZT8z0yov5pUzbjFkpg5cknWMv6yzIrueAiqG7SOGIn5+aC1xcu97D6OeBe7+6grmWTG1yqET9fuUBf/arKecCcsUNZCHszUK2+hqOqfsSHfdT8emvjIP+x1Y4wFc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=syrmia.com;
Received: from AM0PR03MB3844.eurprd03.prod.outlook.com (2603:10a6:208:6b::15)
 by AM0PR03MB5811.eurprd03.prod.outlook.com (2603:10a6:208:15c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 09:55:59 +0000
Received: from AM0PR03MB3844.eurprd03.prod.outlook.com
 ([fe80::948d:5fa2:b171:c070]) by AM0PR03MB3844.eurprd03.prod.outlook.com
 ([fe80::948d:5fa2:b171:c070%6]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 09:55:59 +0000
Subject: Re: [PATCH 2/2] mailmap: Change email address of Stefan Brankovic
To: qemu-devel@nongnu.org
References: <20200602085215.12585-1-aleksandar.qemu.devel@gmail.com>
 <20200602085215.12585-3-aleksandar.qemu.devel@gmail.com>
From: Stefan Brankovic <stefan.brankovic@syrmia.com>
Message-ID: <3777cc8d-3459-b69e-fce0-853e2932e904@syrmia.com>
Date: Tue, 2 Jun 2020 11:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200602085215.12585-3-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0383.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::35) To AM0PR03MB3844.eurprd03.prod.outlook.com
 (2603:10a6:208:6b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.101] (147.91.217.239) by
 LO2P265CA0383.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a3::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 09:55:58 +0000
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b975579-63d3-4ea3-8715-08d806db26a1
X-MS-TrafficTypeDiagnostic: AM0PR03MB5811:
X-Microsoft-Antispam-PRVS: <AM0PR03MB5811203C12BBC91E4001B6D3EA8B0@AM0PR03MB5811.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqGPJ8c88SlNpsU20Q7Cfeat4xEhOjTv3MIH9HwL9abtNNTBuKEoBNql5dvz44P6d69HvdEqYOjELeI9awtxEZeLzKWz7AN1JyqLC00mjeyeKJXierbddkyWGZvPlXB/EldGAu1m7bHnmfd7rj1l6xyBNdkJspy5uJsiQmswRs3yCLPlIHvSFieWb8yQNUoU3e8MQ8dwpFSoIDMlMgO9QqdmOIkqVYr/4XFQw9mf0hf1Uz3zND3yYoOQukfqG9iEDyoffSXP8Kzi6O13Ir9GfQa1HyAaariL2q6J4KHz5FiGrtHxK7/r/nlFJlSonKXczGLMHtX8kyvS0W3DcKUFnCsH5qJM6SgXtLV0VNd/7G9+ViDsv8ztLsT2PdQ7oA6J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB3844.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(39830400003)(376002)(396003)(346002)(136003)(52116002)(5660300002)(16526019)(186003)(26005)(44832011)(16576012)(4744005)(316002)(8676002)(4326008)(8936002)(956004)(2616005)(6486002)(31696002)(86362001)(6916009)(2906002)(66556008)(508600001)(66476007)(36756003)(66946007)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gNwOQiP69BCxu0laxBKUXGRKOW8hJyCzHnzkTjaFhHCQHzI8gtIB7tDEI/QOhG9oKfNAkqvOdy+5zc0meWgykEz0JUoeo4k2xu5XuBbMpgMueDCVwNgNYXqTRzWrVsevAfchyAIRg8DDARveeqTwbubCYQlQgdFy1jOewwexcaDKu+alusVJJZ8oJv5ON6rlRJJqnnJ8Kpcy+/lPS3Pxl3rhKgMiPsG1NaNYAMYY7+OOdaqoIYEu4s4lLeoZUOK65a4IkErg6RP06kuXOupOeCksQyo5b0DfssiEN+42EURK7saF0U6CloM4AlyVPYx0mCuQTmom5Tvt5qn29OLjcawPJ4HMPl1EwPP2zJn1wgh+bo23YpC/oMVS113HNTkC04uHDKOWg9veLP5kRil8kuLbTQDmGCn3nocqr6nzehFNwyZl+iApze7rbHXKBd9I8awnIkR8UF40xa5zjtdN2E2/uD9TBFajU3VPTIfnTLc=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b975579-63d3-4ea3-8715-08d806db26a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 09:55:58.9859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhAkFhdzbKP56ZfEOiL8kcnBICKXKR7Nu8TdG3XxIZ8X0Ea4kWhAFtK84kTGJfeivLfmGmibAI2sXE8CYUH0cs9jyO7/KeU+RhWmbFPaV7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5811
Received-SPF: pass client-ip=40.107.4.92;
 envelope-from=Stefan.Brankovic@syrmia.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 06:11:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Jun 2020 09:04:50 -0400
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2.6.20. 10:52, Aleksandar Markovic wrote:
> Stefan Brankovic wants to use his new email address for his future
> work in QEMU.
>
> CC: Stefan Brankovic <stefan.brankovic@syrmia.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Stefan Brankovic <stefan.brankovic@syrmia.com>
> ---
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 9f2a3a55f9..84f36592ba 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -52,6 +52,7 @@ Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>   Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>   Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
>   Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
> +Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
>   Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
>   
>   # Also list preferred name forms where people have changed their

