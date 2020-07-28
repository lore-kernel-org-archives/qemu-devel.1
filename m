Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A134DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B553206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k+mkR/l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B553206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Pej-0004nb-OD
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1k0Pdm-0003ni-20
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:27:34 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:45953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1k0Pdk-0000ea-7I
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1595942849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/GaXz9TssWXI/jgyMHNEB0PkE0RFgkE9ffDILPOkE0=;
 b=k+mkR/l3GiH7A+GCB0cSpCisywb0TzF5w0XSy+NVvFFAvyQ/ArhvRE81GZ+k1u8TWvd270
 D/FarvVq+LrwvNpppuuCtietAaAEgDYrFvKUiAq0D9DJocWejv7M0+FZn0cMdmHGE6FXEl
 J8bwy3lPGYlBO7ii+r93EesssC2m8BI=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2059.outbound.protection.outlook.com [104.47.1.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-kRpEmDV4N-OoQ1xdx5Nx_g-1; Tue, 28 Jul 2020 15:27:14 +0200
X-MC-Unique: kRpEmDV4N-OoQ1xdx5Nx_g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwUZFnZ7qYiGr2LcE99j2yHfH88RVwL+p7EzVNPYPUL+UUAO9FL9iw1LgQsnLnbrk06NYdY3OJVYBe3ig+aK4JRgLtLLgE62agDsRl+1nj1E2X/pneaGbP5xyyWwVDsnc2JdOsw9xBgUob7KJOKQdBVvUBxOO4V7KDKGOCCwi/deSIPC9FE/r0kB34kEKGfMokCvBF5EDtevHru65NJ+m2qc7vSB2s0PrFI1xyL/hIurAl59vOUPpfYMogmp7ntAb83JnQdFS6EDcdLyn7gP7Xskuzjd8LB8uH99aLlCjAV9GfYW3JN/LD7hZhJjfypLBBvq1KTAdRZcXtQ7E6JR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/GaXz9TssWXI/jgyMHNEB0PkE0RFgkE9ffDILPOkE0=;
 b=X4sRCLBkRRqQzgRc0diRETZnu3VaEn1dXV1wluoHJNN08mJaPajRrHTiDqKyMgQBjp7JXNJgHalB9yKuRsKGoEDsjOdDb9n86AgPXFtHhWEtwDVynli6v/znUdvzpuqcxuvv9dkGfQ/AYGO4K3PTECsQjo35oTo2tBgx9CNLqPuDAsNWTfnY7bKmOb/4cejkxPLrAU24iuA+3zf33pagA1YPL8bv6rQmdIsVt60LGB3FGh3wPabncVrJ18F+Ibzf1mlWcoyc5baPKO7y4PzVNpCCLXw7aCpyVPJ7GMVjvkuCGk739LaB6bubtLQEJFjoY3illr5BV8ELhWiUkNRtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR04MB4931.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Tue, 28 Jul
 2020 13:27:12 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::ac1e:4b9f:464c:d660]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::ac1e:4b9f:464c:d660%12]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 13:27:12 +0000
Message-ID: <f0c84ec41eb338bce1b9ec4d5a8f7e13e7eadc0e.camel@suse.com>
Subject: Re: [PATCH for-5.1 1/2] block: Fix bdrv_aligned_p*v() for
 qiov_offset != 0
From: Bruce Rogers <brogers@suse.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 28 Jul 2020 07:27:06 -0600
In-Reply-To: <20200728120806.265916-2-mreitz@redhat.com>
References: <20200728120806.265916-1-mreitz@redhat.com>
 <20200728120806.265916-2-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0120.eurprd04.prod.outlook.com
 (2603:10a6:208:55::25) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (63.248.145.198) by
 AM0PR04CA0120.eurprd04.prod.outlook.com (2603:10a6:208:55::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Tue, 28 Jul 2020 13:27:10 +0000
X-Originating-IP: [63.248.145.198]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5d5c6f2-2164-4367-df6a-08d832f9efcc
X-MS-TrafficTypeDiagnostic: AM0PR04MB4931:
X-Microsoft-Antispam-PRVS: <AM0PR04MB493105275ECA5D71429E3243D9730@AM0PR04MB4931.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PpkWSI0F7L+flMeEGmSVD0z/kKIv49Aq1JJ+EtPQji8dnXXk6DzdhATai4ynxJ7W41FA2AHFBLPSfV6f31kLppPQ0S2U6dBMbg9c137Z5oXXqjJ5QJS2OxkyxhBz4ekqz3XGzTLasz4OI023Aq+BDNFqCVIM8xfKtROkes/0+nT5NpQZfI+JJNxX5czrJthJCXlZp6nYyoFE9gPxN9PdI1abfhqjRjSunee1JSV+hBI1IibbcQqfny1FA0Vr8yqg6GNZuUA0qCnVs4I7QPqyu3Sk9yA7wWVAAm6rxdwxkvd722cTIorLmXeSAvCEeKeq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(66946007)(66476007)(5660300002)(66556008)(16576012)(86362001)(8676002)(52116002)(478600001)(316002)(54906003)(186003)(6486002)(4326008)(16526019)(956004)(2616005)(8936002)(26005)(36756003)(83380400001)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gVO1OzfFOnB+ekmvUq80Cw8qwDb5OFIwVImtYk2i/dKh9PmmySF4mNiaE54RTziZLNvk0cRhin4uNPCPc9huQsCnj8u8qAGcd/b/OTwrcT5uuzZNImfHUI+sTMJYw/SWnOqDxA8xhJSlt584ecJE6z7OwChgknVec8W9r7gIRLDsepy+CsGzdeRjRPVMO3mPh4mZznr+VPASW1ubUQq1FQYDfQ6d4XwDSEe4xgNrwHopa8nJP7FwlvuB8MorWaOi8blPLmLBqAtS3X1Z2o4t9RlCMtwjjusMs/mqELQC3+3ZoVDL+CfnQ8LTqmislpsH2t/c/GMFqi+8rzZrYIAWtRh6JDh15ECdId49OHZIrNXCbit9X0jWkAU9eslN7t/AXsjF12GpDSAA2I9O++A38vxIZRuSgJfGM3i4lGYYgX5ceWGqpCT3VEewsvK1Jm8pLikPElHB3g0jbm+g098aktRYzXjceJ2462P7A4Nh2BA=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d5c6f2-2164-4367-df6a-08d832f9efcc
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 13:27:12.7500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixdkIDEa5YsMu+n4SKhYaIE/ukqFleV1rrbWvlwnoeXod67U5tyMpwYsZkICKjmKudP921/+uY14mRrWYDjgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4931
Received-SPF: pass client-ip=62.140.7.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 09:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-07-28 at 14:08 +0200, Max Reitz wrote:
> Since these functions take a @qiov_offset, they must always take it
> into
> account when working with @qiov.  There are a couple of places where
> they do not, but they should.
> 
> Fixes: 65cd4424b9df03bb5195351c33e04cbbecc0705c
> Fixes: 28c4da28695bdbe04b336b2c9c463876cc3aaa6d
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Reported-by: Bruce Rogers <brogers@suse.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index b6564e34c5..ad3a51ed53 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1524,12 +1524,13 @@ static int coroutine_fn
> bdrv_aligned_preadv(BdrvChild *child,
>              assert(num);
>  
>              ret = bdrv_driver_preadv(bs, offset + bytes -
> bytes_remaining,
> -                                     num, qiov, bytes -
> bytes_remaining, 0);
> +                                     num, qiov,
> +                                     qiov_offset + bytes -
> bytes_remaining, 0);
>              max_bytes -= num;
>          } else {
>              num = bytes_remaining;
> -            ret = qemu_iovec_memset(qiov, bytes - bytes_remaining,
> 0,
> -                                    bytes_remaining);
> +            ret = qemu_iovec_memset(qiov, qiov_offset + bytes -
> bytes_remaining,
> +                                    0, bytes_remaining);
>          }
>          if (ret < 0) {
>              goto out;
> @@ -2032,7 +2033,8 @@ static int coroutine_fn
> bdrv_aligned_pwritev(BdrvChild *child,
>              }
>  
>              ret = bdrv_driver_pwritev(bs, offset + bytes -
> bytes_remaining,
> -                                      num, qiov, bytes -
> bytes_remaining,
> +                                      num, qiov,
> +                                      qiov_offset + bytes -
> bytes_remaining,
>                                        local_flags);
>              if (ret < 0) {
>                  break;

This patch resolves the reported issue for me. Thanks!
Tested-by: Bruce Rogers <brogers@suse.com>

- Bruce


