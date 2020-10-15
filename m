Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DABC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DF121D81
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WYLrR8fC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DF121D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT8ax-0002tt-VN
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kT8aM-0002U2-7N
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:06:46 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:38187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kT8aK-0001sd-Cg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1602788802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjDEs6/BNQDMapG4FQokd0cnYpI1Pr4o8ivZ2a1+KXU=;
 b=WYLrR8fCjG7iMu7wiODM7jkfvIUU7IFSJuIWLVB5ULnufYrMUjlKfCPvLzLWJLgKeJp2ff
 aw/aPZRH38RXu2FtOUCAQTE2vqpWtKEkGEFBYNoIIdCivue5oyvZ0lzOk+YMJsDUGdaoGD
 LJQ0O6zDTBtCW/cD1iaO9MgEhFJ4Ru4=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2052.outbound.protection.outlook.com [104.47.14.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-2Gj5DAUnM66FQ7JpriR8xw-1; Thu, 15 Oct 2020 21:06:41 +0200
X-MC-Unique: 2Gj5DAUnM66FQ7JpriR8xw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8bGuwFr0Vbwq0cOC/mFpwIKvWEtdey0N8AO+GC4C0yN58m+QQHzBYvioxyCeY66BlPaXCIZn2jURBQBVakLvIWWaE+PaFytI2zEzLU/iw/RP+oXWrzusxsG1ZxAt7tCv/LCMsbMNOl1n7mEi51P1XBoWqsck5z7dW1GLcAhngk9ra74ogDk3bXied6rE4lKy85UaLQTVhdnDbFR3EtQkC+uP2ySNHifpFzj+bUKEz4tmsOS/VKCZc0kG6Bky4nnOEsy26O8VuS+KQL4RhI76RfPwdYsiwVfhXCbENtuRP56xDe2dB2J5ls2ui/rhqTphCrHKKHs5JX9ptspWCwLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjDEs6/BNQDMapG4FQokd0cnYpI1Pr4o8ivZ2a1+KXU=;
 b=EqBoZq0izQ19/8YvThQ7XlYp6MAfp6x+dqaB3EoJ68Y95ElsV+cYHW/y4B2aAVh3F9EuMaZZpbqYqj4gdnVCkkmNhOrwppIkIWr0mG74J45Xq16ufQlH7h6yp1ZUmSYBiz2C51LItQ1g/BVNMqZ8z2UX9wt9K9XTzACcmivM7eZYgDlUTJoHsov3AvFR+HBoRdiBTIi/88v3lpppikasZYfHKzc3eiI7r868rBccZYULCepnH4YV8dbp/x3cQiM9Soqj1Osy69uxnbO4tA5VkyjaBPSrmG1AVqnh4tHcCy4RQt49+6KpPUXigBI6KRg0j/3tT5lVK0QeY3/nLAA0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR04MB5633.eurprd04.prod.outlook.com
 (2603:10a6:208:12a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 19:06:39 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9891:ed4f:b5a2:6441]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9891:ed4f:b5a2:6441%6]) with mapi id 15.20.3455.030; Thu, 15 Oct 2020
 19:06:39 +0000
Message-ID: <1662d9e685e2c07e18fcf5b4630a55c3cb8db717.camel@suse.com>
Subject: Re: [PATCH] configure: fix handling of --docdir parameter
From: Bruce Rogers <brogers@suse.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Oct 2020 13:06:32 -0600
In-Reply-To: <20201015190233.270296-1-brogers@suse.com>
References: <20201015190233.270296-1-brogers@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [63.248.145.198]
X-ClientProxiedBy: AM0PR01CA0168.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::37) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.5] (63.248.145.198) by
 AM0PR01CA0168.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Thu, 15 Oct 2020 19:06:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cc7c4ea-d185-4484-52f5-08d8713d71f1
X-MS-TrafficTypeDiagnostic: AM0PR04MB5633:
X-Microsoft-Antispam-PRVS: <AM0PR04MB563391AD5867E9B3B1664D36D9020@AM0PR04MB5633.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlNgc6hsUBTu4gWUfzvGvnnmInDsnMbefM3YaMdSe25si5JczSTFdYVQg35T55NGEzGnuOtZikmv0aE9VmJ6oI84qPE+AzrvTNwaJtNhI7WCdL7q6mTfGdgSoUjEy0Gh+KJjSY6hHDWqPMzBZR9V9cB3rla6z3lp+9huzQ/UsNY4YiZaYco2E7a6nGnKE6+huwd3+bCTdJZz2+pbkCSvqbFtm71qStCIw5Rx9K3UuO5x8VcowadSls4d88zLveO04X+amPts/YC+30q7HfDCX4k7PhuaOW/JouyH+jlGi21uOLPC8adiH/H5zAURHtovHL/nrXdYSs8FJxSExEKF5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(346002)(366004)(396003)(39860400002)(52116002)(956004)(5660300002)(2906002)(66556008)(66476007)(6486002)(186003)(66946007)(16526019)(4744005)(4001150100001)(4326008)(478600001)(6916009)(26005)(86362001)(8936002)(83380400001)(8676002)(16576012)(2616005)(36756003)(6666004)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iVyHYNZeVfDx0Ex1B8ySnNC9iepuGZvbRERKc9bXKuDVQ2MBQ2iShIk14ray/y0/5VLaVZ6pGBdcBYmUwTmLp2m+uSi6iLIBgIt2kDWmidTbuKH7QtQcePCnFGT8kO/JAKPze+goRnR6KL+0dWbEp0TAvtyjbmfsOTed/YkUpuiuOfVu81liwRL8e4FIWVZqJzuSspIpkdPsgKLUtzhnoXnX91RKOUm/ZWS359RMxaHG/0uhcDYp2I6LIfkNCCfLRCwNW8udulfsqTLT09RqEFkIV5fjyoCKQW/2nx1jCVGgwsx3pLluw6z6MWodPJzLWA7jqSKQP/GqKjzLBRFA84v2WYlqDUSagLhClIXZ0FoupzjCN5S/un7KnoodbqfsHbh9PpcMlX0zIVvjAJGik+iJIHSIHPCBZoZLr2yk2u3/FOAW0rDebvW/7PLOdxcddOloDBdurL6u2uRElmgElbILb8/VmefbwZsG/ACyvEci2uRIRDigj5eEPSsco2MkTaAe17Cd9T6QF9skMZEszdfY9OLVLn8qd3l9SYzTFQj8jT88CzV96mW3/EC/wZvqQGT5dhAdjwX3VnawoGrivGyMQGwIesjo+0QGsWsGUTkmrpq4i7Clx4sZXoCgc9RSusglMint9AvFyDBD43S7uw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc7c4ea-d185-4484-52f5-08d8713d71f1
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 19:06:39.3708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYZSKuSvBFtLVKDBQ4QRyV4c1hiK9tkljHBhNtn7PI1Ky862Fg4hTxYMxWov4sax1ewc5yiWiWP6RXZ0bN6Ugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5633
Received-SPF: pass client-ip=51.163.158.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 15:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: richard.henderson@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-10-15 at 13:02 -0600, Bruce Rogers wrote:
> Commit ca8c0909f01 changed qemu_docdir to be docdir, then later uses
> the
> qemu_docdir name in the final assignment. Unfortunately, one instance
> of
> qemu_docdir was missed: the one which comes from the --docdir
> parameter.
> This patch restores the proper handling of the --docdir parameter.
> 
> Fixes: ca8c0909f01 ("configure: build docdir like other suffixed
> directories")
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index f839c2a557..07acd01a25 100755
> --- a/configure
> +++ b/configure
> @@ -971,7 +971,7 @@ for opt do
>    ;;
>    --with-suffix=*) qemu_suffix="$optarg"
>    ;;
> -  --docdir=*) qemu_docdir="$optarg"
> +  --docdir=*) docdir="$optarg"
>    ;;
>    --sysconfdir=*) sysconfdir="$optarg"
>    ;;

Oops! I got the wrong CC's put on this. Let me resend with the right
interested parties. Sorry for the noise.

- Bruce


