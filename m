Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180A2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72A520767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="yJ/PELET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72A520767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttP2-0002Ii-Vv
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jttOU-0001sg-Bp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:48:50 -0400
Received: from mail-vi1eur05on2096.outbound.protection.outlook.com
 ([40.107.21.96]:7081 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jttOR-0008RW-Cl
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:48:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3Xt3g0+Q3yt8UkyZ6qpSNGMrWB8hVKHM9VDyUCjA71aTTUyg5y3Vev2BcEUTAo5g+JiXYT3clC7smCAUW5caWRjKasxeqIf52X584nx8bXjwrucnJtOzEC0w2aBHufHmUxS2211XcKEwp2UoQ81il/yB9stQkCn55O2U9FMyb6/RjZZp8Goa+PKJuUquqZjALq2tLq+HlgbSJmkB1ex56aaHd+R0Wh4G4P6N5OSHG/1TPg/fatr7BablKqO816zyeEGvn4XsgQiNfx5cUfLYmhWgTuMnRAH0QHuVchoPzt1zOBUW7VARKDOw+azWbPG1j2mwQtjrQ7uIEABm6wBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT+L9e4pVNWYazPrK0pk5adVFCpZfC1xygKCCdPK148=;
 b=D/dosvIlLR5fmRXwUeMLcHF6lCQ5Yoe4jdwEc2AEfRtVjnV94CBVmDQkce0vcha59lpWhF9Ujp3I5E9TAx88vvP1CzeEa0F6NNpD6wTwc1WNjy9BibmwVAFZ50gptmJgDUSaGJC0UlYIkgOcSTguI2GoO3oNd6PlmyOWhnztv1DSd87615nu+B/0CNMMHw3nrtH5Bzvv+oK2IpzaxxkQFz5wowluKDCJCH3QtOSrFLyrXnp1MvoWdJty3Omvv9ZsLKRK+pmhQlknT1ofMC9VOk4mUz8lFVym4Y3cE8xwlss2ihApSgtValmFaw3lUAcmmWh7NqpsjKFnmFWPEbFzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT+L9e4pVNWYazPrK0pk5adVFCpZfC1xygKCCdPK148=;
 b=yJ/PELETAEGwedEuuXhISov5JeF4+G984MxP+LCGK0Vb4hTKcHpcWBmixBr/2HxuhYggIQae4DIaU0pTV5VYn6rDB1T4n9WzRoNRqcW22IqsJP07kws4WUuazCt5yirdX19JsLy2GkZMsPJcKXsDtD4Cc/jazjdxMaMAzxQ1GFM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3510.eurprd03.prod.outlook.com (2603:10a6:209:34::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 13:48:43 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 13:48:43 +0000
Subject: Re: [PATCH v2 1/2] linux-user: fix the errno value in
 print_syscall_err()
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200708152435.706070-1-laurent@vivier.eu>
 <20200708152435.706070-2-laurent@vivier.eu>
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Message-ID: <b3606000-ef9f-9578-cdc9-f2fdf88fdaff@syrmia.com>
Date: Fri, 10 Jul 2020 15:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200708152435.706070-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0031.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::11) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.43.62] (109.245.225.186) by
 AM0PR10CA0031.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Fri, 10 Jul 2020 13:48:42 +0000
X-Originating-IP: [109.245.225.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 551a861d-e145-4d8d-b5d3-08d824d7f5a5
X-MS-TrafficTypeDiagnostic: AM6PR03MB3510:
X-Microsoft-Antispam-PRVS: <AM6PR03MB35104B0C5F64F6668DAD50EAEB650@AM6PR03MB3510.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8QvlwcpvaWCvtFzpZ/USsNake3rma2IDFnYdmdmSSBTeXp7qD5aM5O2TggUKWn43o6SP76gPSu4gXgFuErWJ3STwDR+PIjhYEDnJ4/Wrbsa0LyaPgUsccL9i/2di3h+JjDVmVlOvDsf2Wc5VfeihDypCfnLQvH2OnQsZ1zam5O8vfe+w63rrnS0rUVoXj3xPaC507oEuaOjNwqtm1uzzFEnO61rE1u28NbTVi71uKdEnyYgtfwe4POmqRB21HuCfDpMssiZvo46ow62KzocN7zQMAZlUD2LxvTgENuppf2i07e62MIQwmIwRZmCFixsjmhbJnbEtOxi/xZbE5CUR8Egn5Lg3o+daU74zWBXojdINSgCb+c51Ks2Q+L2mf10
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(39830400003)(396003)(136003)(366004)(31686004)(26005)(52116002)(2616005)(6486002)(956004)(5660300002)(66556008)(8676002)(36756003)(86362001)(508600001)(16576012)(316002)(31696002)(83380400001)(8936002)(16526019)(66946007)(66476007)(2906002)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: P1HB9ahDAspTEkxWKcHIr1HQdwa7k4kgLiorQifd7E0pQ+gpoe5t7E39nfgBTJp8bSTH4yuet6++MrFRWQaa2I8RiqBCfu3bHyk9Fq28gw93fvuRcYiVcbrm4jn465lSq2abWTQbfLPqApK2UTzS9ggJsX64JqyZ7JZSrqDROHoLzImOu0wBUT4UkaYVoxudzgE6Pj99zssCNxNmW1Jd/faP/FGkZxwRNfG0TxmDKZ1DdSBiZE8ipg4P4KpMqGw81HBLAXMgujHs75B4G/Ez/URPYpyOIfNuGKBzGW85M/p0p58ZqvoS7j1h1J6yPcQSyt63HBpmVmFO3W1vYOXop+qgrZh/wNYtmU1LUMxedy0KEBrfG82L0nkYyUZuRwfVCrvikXJEncpogW2SA7LNzn8Oqr9VbD9p8CGGNYq4Jtgs85AKSJVF5bdfEroHg3fm6uO6yyMO8aNDPdLaDRf2WFz08NcL2JLFHjQmQJNsk0o=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551a861d-e145-4d8d-b5d3-08d824d7f5a5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:48:43.3280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0dr9qYsOBBpdToXbb6+3tX6q3DiVuulsJ2Ejr+mLcjqRgvaiGs9wy2KyoFOt+3majad5ct8Lq5Wb9rwhCFryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3510
Received-SPF: pass client-ip=40.107.21.96;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 09:48:45
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 8.7.20. 17:24, Laurent Vivier wrote:
> errno of the target is returned as a negative value by the syscall,
> not in the host errno variable.
>
> The emulation of the target syscall can return an error while the
> host doesn't set an errno value. Target errnos and host errnos can
> also differ in some cases.
>
> Fixes: c84be71f6854 ("linux-user: Extend strace support to enable argument printing after syscall execution")
> Cc: Filip.Bozuta@syrmia.com
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/strace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 5235b2260cdd..b42664bbd180 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -731,7 +731,7 @@ print_syscall_err(abi_long ret)
>   
>       qemu_log(" = ");
>       if (ret < 0) {
> -        qemu_log("-1 errno=%d", errno);
> +        qemu_log("-1 errno=%d", (int)-ret);
>           errstr = target_strerror(-ret);
>           if (errstr) {
>               qemu_log(" (%s)", errstr);
Reviewed-by: Filip Bozuta <Filip.Bozuta@syrmia.com>

