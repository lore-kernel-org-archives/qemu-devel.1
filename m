Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED15C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214DB20936
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q0pkputF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214DB20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWFgk-0004wi-Uj
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 05:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWFg2-0004Ll-SJ; Sat, 24 Oct 2020 05:17:30 -0400
Received: from mail-db8eur05on2104.outbound.protection.outlook.com
 ([40.107.20.104]:42881 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWFfy-0001Zz-C4; Sat, 24 Oct 2020 05:17:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTNcjoWkrboHCHXAEBkJDugakxQMqxTa7yTIbfBsa7bg6+1AIn3UIG8AhiV7r8xZGrDvG68kglg0k+Pf/5UYS5YLz8sbIAnBiEwosj4B/Zw5HS3SlY3f6GrdSENqfu4uJN0gOrDwYnm19h4WmO0llAi9AXNoMWxcz8XMv9cmgApfG9ksq8akBrNpnN7sSEoZWiSfGubWuRL3n1J8UJfCKkil/wlP5FWEGU+sBqCrJoWGVCVILfhdghuudC58SQuevH+6RYi4ISSJ5JSkUwIo5aUAm3ci0hjHq1C8bAA03Oe6g2wqWIysCtwpIfoxZL4REFXJEeXm/3ylMnk2SjbMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L77dwLlEbqAgN0WCHcCwVuvFaqNNLTw/anSK1zIu8Vc=;
 b=Zuz2uvY3qaRXAM1EUw7SAfOJGmubx93hWdSJM0NEy1OT6XGWxVoUxu1s//K3BpF7iyiSZcH5kvV7VSHPqDpeS2ZbQ1dwyopQYJQDCb7L/iwFxFJc7MSnEgB+R6DgTRhaU7sKNcLb8zIMo4CKSJf/FASt8ELOPwN5CglGgEAt2AxN6aLrARlyNR12wRhWvDJAPtPVM4a5MhtXUY34Ikl2PwOTdf9d3jLaFWipxcvKM/rma9UvWw2Wleq3yo1Ew9N64xtB7uP09pLsPqiTDajO/tEtIkFz99QPJW8zLegtEpLQ6ywLm0fIE5FDjkP6ahl0wCh9RovgPZZjhpnAe7D5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L77dwLlEbqAgN0WCHcCwVuvFaqNNLTw/anSK1zIu8Vc=;
 b=q0pkputF6YRKsDIc7AV5Ui2fl3n684lyG89dr2w7xhMTZgNVeANvqVVHDRPdODs5iiogEXXFe3l9dzU1PTAD9BcLZ85F74cZufvnGNYBJuoTHq1EKVQ0+/ik+VvlvdQPlSQBBEDVADKXm64lQE3auqF4yoyv7IT0iN680Hidr7E=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1780.eurprd08.prod.outlook.com (2603:10a6:203:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Sat, 24 Oct
 2020 09:17:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Sat, 24 Oct 2020
 09:17:22 +0000
Subject: Re: [PATCH v5 03/12] nbd: Utilize QAPI_CLONE for type conversion
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 rjones@redhat.com, Max Reitz <mreitz@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2514a7a4-8388-bb29-9482-39870c395257@virtuozzo.com>
Date: Sat, 24 Oct 2020 12:17:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201023183652.478921-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM4P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Sat, 24 Oct 2020 09:17:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1576fe7-77fc-4e56-33b8-08d877fd9d49
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1780:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1780A8C6168C70AAB7A64A50C11B0@AM5PR0801MB1780.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzQSimEBY2b4l7m80s1OL9kPsYI0mVaLmg4v3e7jCRBUU4x55xHFYr31eqwY11bI8SZtDz3j7g3TuxFIyYuzWFcfUOtusYTSbIdh5kei7EwtWLjIeJ1GJjC9sTmEXHznRBhEzhbF5j8stFJ5vjGsSDt82PNRLi3UAieesz8Waj09CkJ9wesjx3MlCsXXfR2m9cFxpIlUMyS94NJl+UuiEc+zONG/PQTJkmXA2DL8hwdWdscs5vdxgBcbtVfM4A43huNJGmadybMJZDQDIyi61PzJE+GU0cB7t52m2MpzDe2fdUEnyNEN0PMwiZLd9nZu+qba3R4lSCgT1VTaRFADQFRyfIfS8aCCvYQIVdEz2QZhnbg8lfZLC71ht+vCMDpz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39840400004)(396003)(366004)(26005)(8936002)(16576012)(316002)(83380400001)(86362001)(31696002)(4744005)(16526019)(6486002)(2906002)(186003)(66556008)(66476007)(36756003)(31686004)(4326008)(478600001)(5660300002)(8676002)(2616005)(956004)(52116002)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TUb6C7MbYubvYHxIdbsKtn865oU5cvoQ5rMYfFVcubZPfTtvSoFtOrrDKNVxW1V0PI4EmzOkJ2excQI5Qg1NWuHtBsrAhzdouReBbmaNSZBAWajmfNaU0iv+RIAr3AI98IRJ1NnS8PJ70bv6SK1MRf9+mO91LkOXg81NqSwCtP/2zWTGxWMIMW1J3sWzrTQDFzvULkWxxfYxGkTrr11jX66C8v3+bb4xRpxFarNfwBfLIpnEq35JzbIe7xpeApeOsqwlu6WK6kKhDfGoEza3A3XdV1NhdPmuwpwjN+XJXMrwfBGWd7P3n0+tEW6xKlg6yNCnBSHJ9A4kg/mF7kwW1vU1N3DhM4X+uMLTrkdNlDdXqTNEjWXRhLFcMbsbSBZw8kOJMPxZsvGm/5vE2YkozQf6dxtDRR9PkVahxS9JG8Xom00Yg4VGSPmWCu2QE5BTVmp2BpFfuY735Nddr/D+CnKcKu0+RAIIqCGKijcVFBJVrZBcSx14G2KrG5JKYer7eXxUfPryoYtc3lruDtIN46X46iMQHarPQfPEs+tfieDxOBnZGMOZZWHf+uIP5a9RwlRn/az/5+MrI+S0ZpbETJdcAcxu+DKxW/TcxxYuJR5swxSVK1F516HbCJ7s0odvcrr8ZMWFOuE5aGTy8aoGJA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1576fe7-77fc-4e56-33b8-08d877fd9d49
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2020 09:17:22.3212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM/Yx0tGquNZnFB3/xHOc8NdZ1vZxPVh5fxn9znTvsDUMJXNY++6jmF5cQrxD4Ldic+vkBCYMRgxbTYv1+A5O7Z/Y9SqlPj14r4/fmbiwR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1780
Received-SPF: pass client-ip=40.107.20.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 05:17:23
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.10.2020 21:36, Eric Blake wrote:
> Rather than open-coding the translation from the deprecated
> NbdServerAddOptions type to the preferred BlockExportOptionsNbd, it's
> better to utilize QAPI_CLONE_MEMBERS.  This solves a couple of issues:
> first, if we do any more refactoring of the base type (which an
> upcoming patch plans to do), we don't have to revisit the open-coding.
> Second, our assignment to arg->name is fishy: the generated QAPI code
> currently does not visit it if arg->has_name is false, but if it DID
> visit it, we would have introduced a double-free situation when arg is
> finally freed.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

