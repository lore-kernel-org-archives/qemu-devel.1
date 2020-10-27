Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA7BC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A239722263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pY7K/qdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A239722263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMJZ-000302-Ew
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXMIF-0002JT-Uj; Tue, 27 Oct 2020 06:33:31 -0400
Received: from mail-db8eur05on2103.outbound.protection.outlook.com
 ([40.107.20.103]:9761 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXMID-0004Yb-Ky; Tue, 27 Oct 2020 06:33:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpmR3yiVVAhL818FbxVpk1RQiWkP7wTyW+eMvnCm/icCr0JyWajC5tluFTAhUPCyQQlFX1mfnFXuDcWv4CcOPd99zVcobNdAoY4x6dQj94ZnurjDqCir/nuNGHNNQAKAqHnEjAwPC97SN1aYhWzPR+vea1/TGjWwQffEdjj/ZDWsng+KRm84u94SuTjfvJJxlSYSpHD0mp56skrYIZcqIE1IehMYKPOP/jXFRkqT5E2lbsVrxmsCCmAd6RHjbH8LmHlaRZ0S+2MYj5Aht2d9sLIRYfXhFZais2GUP1INGYnUQe6i4BJeZ5Vuy/tVBaoXDLLGvXUVbx8eVJV7fR43uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iG0PlhTHOnmSGs73rp/nJwEEfLFbH7OXyMAQy6WctSg=;
 b=JSuqrNGEayV78tLIqKo7LYfnW3KYIqW0b75xMeUVjw5oyC43S68VO3Xd0g1x2psNf/dgc8LmIw9wJtnxlySAdZjIna0LFmZGINumzFp7awHX/Sco13Ut5eam1Csm0C0rYvb2O/3c7ZS7gWHmpxxmEhEv4fAojdD4NtabGOCW98uTnn1K4uNcOz3O7M+3K1AmgiHGuaTx6VC23HkmtvaXBX0lsBDxSzIfr2n9ULJVvNMgJgWClayblMl8AkP6FjUxrZfbu56rOc5pk470cffa4EpRNuddDfxOYcN7K3Vdmds16Kx2DT+D3+Bav9AaPrJ/FbYaPKd+gO8gk15A3VTURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iG0PlhTHOnmSGs73rp/nJwEEfLFbH7OXyMAQy6WctSg=;
 b=pY7K/qdbKTvv28i/vgjoooDlmNYD+RJdHNKLITkiXeOThXTa7R1wnqzuIN/ql8QyKkmRwOrGVc0yZcRoBsherIusjYpf5JCSihSm9hVsrKWn5tmQklftQp9O0X4Ap/0WlHX2HzKDdPElLEF/5zl2Q2fpQU9tSYOr63pONGJ5jJg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR0801MB1855.eurprd08.prod.outlook.com (2603:10a6:800:59::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 10:33:26 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 10:33:26 +0000
Subject: Re: [PATCH v6 06/11] nbd: Refactor counting of metadata contexts
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, armbru@redhat.com,
 rjones@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <485c13c0-9158-aa54-26bd-900f4d59def7@virtuozzo.com>
Date: Tue, 27 Oct 2020 13:33:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201027050556.269064-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM0PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:208:154::37) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM0PR02CA0096.eurprd02.prod.outlook.com (2603:10a6:208:154::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend
 Transport; Tue, 27 Oct 2020 10:33:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da085d88-aa5b-4d84-a964-08d87a63bcbe
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1855:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB185582310EDBB514C25BBA8EC1160@VI1PR0801MB1855.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9yB6GInjWiTmbnr5RfraoVLhz+IS/9cV2+T3K9rbv7ANIisjJaneRf8jCN0TymC08hP569Y8eM5A3LUtXAGe8TzdboB2N82E0+ReiWboBAuihCvtKibjQq7ml1p6A40Stv8YtIBOr2HplGbs+4dR5ILHjpOKNy/qk80clEQTD5eWkqkf0Ac34c4WaW86uZH0aYEC2cbS23ICQYVYossMdmL5z6Nsp0lLEJNf93sGIKrYp7t7pfTT6zSvCgBtXDdUYLPVMeqh3eFLwCzWfdOZaiF03F2qRufCheo2SsECVCpCUUitC5sQdxZmG/0pZI5D/ckZOYSqQFVIHLH9Kl8Eg3GAxsf5S+k4SPAhn89FXoQ4yfkD8jAPbWSqbMpvG+d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(346002)(366004)(136003)(376002)(86362001)(2616005)(478600001)(26005)(6486002)(4326008)(31696002)(4744005)(66556008)(16526019)(186003)(66946007)(31686004)(2906002)(956004)(16576012)(8676002)(36756003)(66476007)(5660300002)(8936002)(52116002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: e+K3JyS8OfEus7uGOobffoHLdyIRcOhyN0CHr5ZEfj6cfGVPqOp6RZmPZ8f3Ao4jHxB0ow9bpLtVZVZOHuMNMKG+uQA7Sh/pS9IcfFqBI+jSyr5EsN4kvfDBISxIbbBtw0tTjjmKXiiKYoCW32lRz/4aZBi9UckMag52BeIfoc8s6fFThxhxd/6Km+QhEg1qJfrd7E0DDOwOxpSRDJDkoBn5C1bPeBGCjzgjWb/WOxnv0isHRW+thOBbqaeDnBWpCj8OApvX4ID5BbPsxAgAETeEyDMuIccpsE976ECjrsl0ue24r3UbfvULqQr1xEEhNTXaM3r+6kO5PbgIt3TDVKlcxyELOpJKtS6qhn4dfdAAw+sq/ZBoWEhDn9LOgrJ7mNBIZrDmPYnyiSUcWk0XwHNE6k9kYtbXgEdwPO/WOoDab25c4YzBj2XHUGOQ8Vo8vd60yKq59cYCObIZ83GC6w6GsGIFrx25w5B+XpRE7hkmFWw9wVhjq+dqMor6HR91gPhlS5XTM0aovsu33hEFFmdQm6+sUs+hr+TL75zgEb7MfHROhoWGxDxKfsxZn1KsjF9pXpYypl0zy78YGPyGlLlZSsxvyQipeEm7T+3bWE+sms+0qBUB4aCSnDoAdlTRgUSTLjxU1u/dJ2/B1VXi6Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da085d88-aa5b-4d84-a964-08d87a63bcbe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 10:33:26.2108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz/dAIT0sJT/cIxpThd1MAIKZeDDm2B7snw45gLjyasgA817W0A1QWnVKK2YNpyRVaDqrjqMETL2+kfzPdcb8fn/GM3jisQhCxIIPf5GSZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1855
Received-SPF: pass client-ip=40.107.20.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:33:27
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
> Rather than open-code the count of negotiated contexts at several
> sites, embed it directly into the struct.  This will make it easier
> for upcoming commits to support even more simultaneous contexts.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

