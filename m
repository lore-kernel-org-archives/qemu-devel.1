Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93759C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AE821D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TQngzrS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AE821D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLwJ-000200-Cj
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXLsj-0006zj-1j; Tue, 27 Oct 2020 06:07:10 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com
 ([40.107.8.103]:57929 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXLsf-0002wO-0Q; Tue, 27 Oct 2020 06:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngZGPfJWXNYlyrhUru0oZMaRhRdH2J0KF7Js/fBnaGgtX3RQpGr1vS6EcpZJFy5ynFwGoFnkQm/V6ujUQCFZ28lNd3bexx8emhtSbo0bVjiSjocWGIRCayOYPXpZUq/MWGzd/0FEgyibVbr7NiZW8mKEw2UpI1PSojnX/g3/4iNlGeiwjIfP8sWKNKhFx09RCjzR//ryJ/nrA+b3eAFDHBDZpytOLX5nyi6NddtnalqOPpNOOANBBKrTvetPzy8tgzbDXGykkSbsCJyzHmBuutHhqjnJ0XCXjB6MJdX5KdiVaYa7Kczd7ZVKGf4bx/yXQ253+HEGVmZNHLHU4Ly2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieNWU50WgTWISN6GqAMDfspUHUTDjK7cljqBP8GEZwk=;
 b=L5ViM1iIOuZYJWitwFMUwwLRgQIGyPd8l3ttjrTaks4S75TXsSNWrORGu82waUfireDsgWu7cpLrUkJwlJnkkdrfEJ6SwR2LDos/V3k6LumT3kbSPk818mmHhENcBMjkTjQcik5gOJiK2QxisbiqTaIlikJUwX2bg2v/eDHRU/cWTZQ30ePVzU5OfyG1X12LaU92v3J103CbPwI1STkRq07P/7KiTWnlBHaK6HTK9wsbZRPUchx35Ung3YlHYbWqyhhQwatLie9yavmrSZjjYLj2FYdF6sLZaRxL4H48o+uG8l9m5Tk0uxUDktnav3e9a5W/Xitgid9S/gLn3Hd19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieNWU50WgTWISN6GqAMDfspUHUTDjK7cljqBP8GEZwk=;
 b=TQngzrS8pJNuJ6tKlucmIaM3O1AFwBZPsLSzUxMZbjtVnOO4PHwzRcefVLALPUj/64vaBdjONuKXv7OLvnJSrjjRJvmMwL0XiTiksS/pmPD6F4XAMk3+4R+YvqYCXzcJYsP/8lJcp+w/rXnJn8lTkosLDiWdX+fvkSpdVXGsFBY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR0802MB2224.eurprd08.prod.outlook.com (2603:10a6:800:9f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 10:07:00 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 10:07:00 +0000
Subject: Re: [PATCH v6 01/11] block: Simplify QAPI_LIST_ADD
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, armbru@redhat.com,
 rjones@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fb7663c3-6477-934a-4f09-800fec62f3a4@virtuozzo.com>
Date: Tue, 27 Oct 2020 13:06:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201027050556.269064-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM4PR0501CA0057.eurprd05.prod.outlook.com
 (2603:10a6:200:68::25) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM4PR0501CA0057.eurprd05.prod.outlook.com (2603:10a6:200:68::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend
 Transport; Tue, 27 Oct 2020 10:06:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd4a5007-8069-401f-6e33-08d87a600b4f
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2224:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB22249CED92D8B04CD7634B97C1160@VI1PR0802MB2224.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GonQ08Fk6DpKWJepzhr+RCqX3PVMGgMfmpftHPfW5OdS+XcpTA5JW+rCYbUYS+HPEXfySFPIzMCGmXyWxtu5/Ky93oQYQWMCPGVBPtbPc9tkMZ1y8nUq8uDSkcsGYMi1RKpK0QpAGMDxSU036JDXWLOBOM37dUQ+g3Y4t/X6KzOcvMZ7hY7TwHaSiz7X4tGKoLrA7Ol5Gys2PBOROCkzIH6skuLwBC6KD/yVoGV/EtxbDEcSg7LWRCStpmVzMwelevpN8qiZSVqVUC+Zoj60tNzIjCfHjjKBeSNFcvJp/IhpucCNBbMedX7YMKa0ypFSa+/lCpAGcrNpshx7mjIfUMdyIZ7h82VDZpu+bjX8jNW9TIclLEdmASFiE8/VTvOF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(396003)(136003)(376002)(346002)(26005)(16526019)(8936002)(8676002)(6486002)(478600001)(52116002)(4326008)(2616005)(186003)(66946007)(956004)(31696002)(66476007)(66556008)(31686004)(86362001)(316002)(2906002)(4744005)(16576012)(36756003)(6666004)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1QDymI9xZZ3evmspXC+vAPegpBYF5banUYnMGxdx0eP8cWmGxNvx9UYiSUplncSbaae3dWzj+nIlacPS7UNpYbkAIS9rgLfmIApAyzFOh8Pzm2p49NrfUviFSXn9zwK6egxZ4w5927EOpHgK5SZHsyfiHg8i7lxOytoV6zB0TZ1JaXsXj1yc6+7AFoyst7FDkdG97UYCjalSZitt49JL4xcax6stYT6dKu0S8jipyYIo5VZ+pz7SiZtpbpVEG+jiv4Cmj01g43qT3ENwezu5w0Wg9DXZWMlFCvTNa3gGLXMkOs1tBDG0sFyQGEgSMrgI8GPC6Xigtt7crd/wF4rImCFJzH/BEKsrY1JUOkCcttcLrHPaSH9DmfdFDwiZBOS6EKBEJNXslSG/F0DTe4byjWFmd4H1OmxBUxJe2Vmcdd6ttpTFEZHSCjZ6DQvMgB/M4+7wxTCqbjoPljNwgaQH6AvBCfTp2CJxZzuxeCyBHL8hjyPgIn4ymH/eqRpfrxpv1iOvUUZQ6TsUL4LkJovB5lPFm7djEdx182ozkLiEoFmlgQfSss/2cROKYmH5UXFga8IX1NatesXsnfBd7D+IFyfyxQZJtA7/sYuokg9+8SG/RwHl3fIbE/tr7PMx54bqoKalfff3LZwZcHb0PX/YCA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4a5007-8069-401f-6e33-08d87a600b4f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 10:07:00.0239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDq5nd5+kd+jRQEX2ZGhy7czeEbWtyl5aPppW2w5kZ/2cnITivRoh5ABe53Cy5m/+qlieS2fRCzpYyhDuaLURqqPFftAx1HFVG1E0E+UuXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2224
Received-SPF: pass client-ip=40.107.8.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:07:01
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
> There is no need to rely on the verbosity of the gcc/clang compiler
> extension of g_new(typeof(X), 1) when we can instead use the standard
> g_malloc(sizeof(X)).  In general, we like g_new over g_malloc for
> returning type X rather than void* to let the compiler catch more
> potential typing mistakes, but in this particular macro, our other use
> of typeof on the same line already ensures we are getting correct
> results.
> 
> Suggested-by: Markus Armbruster<armbru@redhat.com>
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

