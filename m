Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36145C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB9520EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB9520EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jolla.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvW7-0002WU-QZ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <franz.haider@jolla.com>)
 id 1kVvUk-0001uR-JO
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:44:32 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com
 ([40.107.8.50]:13951 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <franz.haider@jolla.com>)
 id 1kVvUh-0003ox-VE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XctjkuQJogTZyVX5XDG6TVAjyo5HO+EQ3B8ej5bqPGNXZygr3T+gAkq7uBilOfa32bvf0XTDUv/pbQ4vqBxKOi8U9Iw035jFCr5rIP+FZvODt25CMCVNB95Bahc+5Y2RHkVLvLw+H8qnBeY+2CJ6+X2w6CwpUHmapxQfCbPkFrWA5w30zqDausnd6hzKnOibu8csyBQ9phZjzNxJ0CW3gXhnHm9975hUsy7Ca3raG65tmcqawNrafvBrgaX6i3nlSaXuODzKnYyWtPLMYasrosjT21y1DDGRXq3EZZPvtyIF5CccMEZYGwsOPWxNxcxRyFe8ur+cH/6mSR/cKZhemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFV1Sa1WmLI0UI//yFACuvEbTqHpW85Nad0wmDurMZ8=;
 b=Xk7mhem5LTbC00Cod7TzUAC0So4vwYgP6ud5n2/HMwYVILFoX+FIIOX4+92l05yp04cr/GgdKGV5zSF7EQFVqbZWx+o6YygwA6pgeJc9IvQd3LH0+ZdAy0ka4FACdpaL8FExwZnFMXgvxkXa6A+nb2M62H3jZaniuSlde13Gh9Ae8GBkRPTB0F48wM6SNFces74sCWb8RhJiRhXRLVOIvp1X+1Rpq62erIQ638EDGUC7q8aQINtSDBS9qS0gON4dkATo0KTGe7QTg4WvpLw0GgBgBR1OnIZvfM/8aRDiAxRQ1D51cX+yxbiUo5rQ1WXOkp+ZuR2tIUW8BbvjBBm9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFV1Sa1WmLI0UI//yFACuvEbTqHpW85Nad0wmDurMZ8=;
 b=dLxaYHRw8uBK42zUWjS5v2YZ57SyW1IxU4cyWMaUleU6/CKzuQSZ7NmQX5aeC5ZQ9nHOblNUEvVO7szhqn6SQympxsvVrw+AceBey8Ghpad+iulS34Sw9rIdWFJ0k0Uy+JHPuLYDji7FeFB3tKE3KfebbuRWcazHLt3vOaBPYJYj9hwpgZc0c0GK4kZ2F1KmXbfV1OaWNW0+YIabT2rAgSWjPdUl+2bQ0rs0e+ZHC4dmIQfloAPZiDsHCGJSK80BlRMz8Xs5kR8hwIeuGcduJcvY8IWoWSP7EUDUlsdHx5nA2t5c6+JNr0iBMRRoWWPNCqCiNdb73of3X8Ng6pAwxA==
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR06MB3082.eurprd06.prod.outlook.com (2603:10a6:7:19::27) by
 HE1PR06MB3002.eurprd06.prod.outlook.com (2603:10a6:7:21::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Fri, 23 Oct 2020 11:29:19 +0000
Received: from HE1PR06MB3082.eurprd06.prod.outlook.com
 ([fe80::705f:4a3c:86f1:d3d5]) by HE1PR06MB3082.eurprd06.prod.outlook.com
 ([fe80::705f:4a3c:86f1:d3d5%5]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 11:29:19 +0000
Subject: Re: linux-user: Support f_flags in statfs64 when available.
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
References: <2e405fe7-efab-dae5-93d6-02575773fd6e@jolla.com>
 <19d426e3-bc5f-7d47-3674-33384b08ab40@vivier.eu>
From: Franz-Josef Haider <franz.haider@jolla.com>
Message-ID: <16e7f7fa-1b48-e701-0a5d-853b914917af@jolla.com>
Date: Fri, 23 Oct 2020 14:29:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <19d426e3-bc5f-7d47-3674-33384b08ab40@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [109.240.228.59]
X-ClientProxiedBy: HE1PR05CA0262.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::14) To HE1PR06MB3082.eurprd06.prod.outlook.com
 (2603:10a6:7:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (109.240.228.59) by
 HE1PR05CA0262.eurprd05.prod.outlook.com (2603:10a6:3:fc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 11:29:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c13e59ac-c8b9-4ab4-e34a-08d87746e1a9
X-MS-TrafficTypeDiagnostic: HE1PR06MB3002:
X-Microsoft-Antispam-PRVS: <HE1PR06MB3002C116E8AE667DE50DCABA8D1A0@HE1PR06MB3002.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rw7PpTfCS3CfaBgUc2q9p6ct2t58OsVRHL5BDPWazT9d+W6y7fG0dAH9noaKbHmL+1QvUX8mTQHMnfxUHSAYKce3g9PsuRRwKWndPLwsxI2Q5a96GN6MBoTCVc07ufI0DR9+VS4ToEKGe2vFmDSN8bMttYQe1D3fwLAodLLWEGMvAhnzmyF6mrXdEJqX/CIMGTvrI0NpIJdvSNR5sV5h7rn9qHnIb6FtbyDs++tb02hYi/4LKCaqpfvITkxIfNlqhEC2KXWfnl/3LNbRzzQbErJKOP+IenMbw86XFu/z62OEku+PAfGEFtOp1mTEkGmokxDhcC26/NOTr0OOkKE5A4rgRlZe477DNuFTrGCoUfqkKw80m7uJGNDeKL/+eY2jvRy4ULd4GFMxfp1rV5R1/XkCRkyP8mZmrFclgLjs6aH2n9CA1SZPIDvSOirKZnPBUPQJLyAM6ewLxOQfEqdDeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR06MB3082.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39830400003)(136003)(346002)(376002)(396003)(8936002)(52116002)(83380400001)(316002)(26005)(31686004)(110136005)(86362001)(16576012)(8676002)(4326008)(36756003)(2616005)(53546011)(2906002)(66946007)(6486002)(16526019)(186003)(66476007)(478600001)(5660300002)(31696002)(66556008)(956004)(966005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0gqOWZIUxtTIFh3RoRK94M7lsHFLVCqNrbkWDEzt8Ubp/hL1IO9e93rEsHmueWHfh/FMIeRmMTrGU775mPBajJBH4n3xXN5ReotuibUrjb1/jVKyofTSHRUzPSSD3Xp/AzcNjNgjyAOJrUgUyFycxy/k3aIzd74s+6O99we8fP++DbdQmQKxIZFkB9guav/50RbeKRS98D29VZ2t3GKk2ZoSJcMeR9ocLNjljWyAvdp5WNiOLEmvpPrDHMZ+f+Ov5DSDtShtfctmZjY83Bof9g/k2NGjD88UG3c1qWPR3tnIPFVI+SoxFCyFcI5Rx+QDx2iL523931BbkE06aD0iSJt76bq6PtFYbDr8cAUsaiml+UBGklsx6sIRzzxV6Oeq/xTtHD/yNhKdRzqUsWYJ55RIpvcPXuZuB3eax81KOjmeBwaNgFYuLXpAIvM7nfn86kCA0d9ZX1rzgSDP4esOYrO2u7g8TM9mX9xP6Oam76qjw8rjl11PNgmbZ1nlqjl6PQ6sb1S4aOTcIKLjZGtR3dESXNgBAw2BpsrWAiceYTSjUd7bUNiCR9dfOdSd9bW/9HgBAWGpwf1XLQ1vYuXwMlLZahrsZ9l53xMID9/N9CUuVOZIrVcyBm/44CbCRcJewd9riUxCEG3Fp1vfIqlx5A==
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13e59ac-c8b9-4ab4-e34a-08d87746e1a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR06MB3082.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 11:29:19.2667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rqu9i2qzaNPse6GMW7Ko2rP5lMFX4i1IC4XvMY4/xs0G9KT1E3kHom4M0wGbrmPDm6q4GdpogqeP3GfQFUEscg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3002
Received-SPF: pass client-ip=40.107.8.50; envelope-from=franz.haider@jolla.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 07:44:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, is there anything preventing this from being merged?

best regards,
Franz-Josef

On 30/01/2020 18:52, Laurent Vivier wrote:
> Le 30/01/2020 à 14:00, Frajo a écrit :
>> linux-user: Support f_flags in statfs64 when available.
>> Same as d4247ec2d79ef2477cb886fa688706b068119736 but for statfs64
>> When running rpm within qemu-arm-dynamic this could cause rpm fail with
>> an error like
>> "installing package A needs B MB on the C filesystem" depending on what
>> is in memory in f_flags.
>> https://github.com/rpm-software-management/rpm/blob/af06db1d5558870f7fb8f5c502572c2d27af5c71/lib/transaction.c#L164
>>
>>
>> From 6ceb5662b5fae827d2c0cdd9896eec75997c060a Mon Sep 17 00:00:00 2001
>> From: Franz-Josef Haider <franz.haider@jolla.com>
>> Date: Thu, 30 Jan 2020 14:28:24 +0200
>> Subject: [PATCH 1/1] linux-user: Support f_flags in statfs64 when
>> available.
>>
>> Same as d4247ec2d79ef2477cb886fa688706b068119736 but for statfs64
>>
>> Signed-off-by: Franz-Josef Haider <franz.haider@jolla.com>
>> ---
>>  linux-user/syscall.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index d60142f069..45782b1009 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -8997,6 +8997,11 @@ static abi_long do_syscall1(void *cpu_env, int
>> num, abi_long arg1,
>>              __put_user(stfs.f_fsid.__val[1], &target_stfs->f_fsid.val[1]);
>>              __put_user(stfs.f_namelen, &target_stfs->f_namelen);
>>              __put_user(stfs.f_frsize, &target_stfs->f_frsize);
>> +#ifdef _STATFS_F_FLAGS
>> +            __put_user(stfs.f_flags, &target_stfs->f_flags);
>> +#else
>> +            __put_user(0, &target_stfs->f_flags);
>> +#endif
>>              memset(target_stfs->f_spare, 0, sizeof(target_stfs->f_spare));
>>              unlock_user_struct(target_stfs, arg3, 1);
>>          }
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

