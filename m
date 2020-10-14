Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AEAC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B3B20848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jtc7uWOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B3B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfMT-00010R-Hm
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSfKw-0007yc-1n; Wed, 14 Oct 2020 07:52:54 -0400
Received: from mail-eopbgr30135.outbound.protection.outlook.com
 ([40.107.3.135]:29250 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSfKr-0000Rm-RX; Wed, 14 Oct 2020 07:52:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMqgRHyKeesi2eBFOCCxglM1vTH0BZbJ5GDKfm4nU/1zAWi/7fUIXT2X+5z5+Q7hFDgZYaVeIkfgtnLV4KlvFPkFTXcsyYNGWSlxPzNZPSCP9CLkR6jC7o64SVBA4f3x4kSvV4x1pmIz5UhVG9I9SpZapmpTlbbFs3EJ4WG+wJaOZPtpQlFXcmgOHL+vukgvO5pCvkb1bXsDWUhAB5lSkDXCQMhnl/LKuwMj1fNI7t4hCtGvuvBui72ltsi8hUhJUCbXh1vL7nolt2NiGScW4CGAeueEB1dWIIjtVOz4JOrNtHEytgkNy/9Zqx6M4X1/TQdeGfNQ9mKO0S52UKdlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLVz5NCilUKafIf7zZgW6IF7GrRcUz5DshLT8YeJ4O4=;
 b=X7aSgvulmjm2zv0iwqJZcr6yE9ddUO+IKpI/cLMi+I5fTVxgSkvfC2/SDJFOAf0IGREB/gejM6hyZcwe3vv3ucmEyQOoDBh6WQ5eM0PMdQBoOgwyIGmNLuOsRynBO0RiVUxSRdt6RcwnCKHb5KwJj9K01vsdlNRzfWQun/qvHxNO+fBuf2fdyKDQS1BnokhvgwvfVsKFfUlcVaOfWnjGiDmb+Pfg/8MKGNgUnY4ZC/doavpxqMtnW7gqHlTJng7+xxLW3OnCgcnq0L8ZLOFX/uAcl7PfxQTogOvN8eQAePMR75HsDUk+8uE7QcK4cR2771ljI8fuW3mlSYzj77G95A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLVz5NCilUKafIf7zZgW6IF7GrRcUz5DshLT8YeJ4O4=;
 b=Jtc7uWOFONETZWjjfhyM6chZIj97g0n045m+sVCYtoHTQBOAIG18s0IpJDyb+E9W/jDCKQXiSrTxqSWKN5wyOMzjy/vmw3Acu4WnKdTmB6S30gvLQN6tzGLxxB11Uj05axIdtwiHU3k7iHVAWpZTGGW/Dwih9UomTGpJXe4B6Qw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1649.eurprd08.prod.outlook.com (2603:10a6:203:38::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 14 Oct
 2020 11:52:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 11:52:43 +0000
Subject: Re: [PATCH v4 2/7] nbd: Add new qemu:allocation-depth metadata context
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, rjones@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
 <20201009215533.1194742-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <85c7c5bf-a6cd-77d0-3dba-3e0df0e9570d@virtuozzo.com>
Date: Wed, 14 Oct 2020 14:52:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <20201009215533.1194742-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM0PR03CA0045.eurprd03.prod.outlook.com (2603:10a6:208::22)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM0PR03CA0045.eurprd03.prod.outlook.com (2603:10a6:208::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 11:52:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ee5d4e-54db-4aa8-e0c2-08d87037a8be
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1649:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB16497B3536D2E4CB6512F706C1050@AM5PR0801MB1649.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpW+r0l7EecGGrMnEsy5rUEXIjEqDTzAhezsEaji38I6TYNO63XatIjeIa9/WCIQSPjA7JwR88hAtK8TqGa7UbYINmLzaic1Nev9vp0GiWf1lm+rVnJcY7CGRGvPavDMRxkN2StDvvumhaVERQrosuZdRBixVFY+O1Rjt2V6uAQ5uISKu8dyr+Yt42aAhLGaMZeVP2B0zFHTrZV34NsVQT1rm4URjheXIaQpCDKiNxqSNAAoszZzzZzMCeVQI2e9tGdogAyGLBXp/szCMyM6TDtLLYLVJDUAcLAvgONRz3HVVAXeOtRsLWcoIRpV2Vp8XqURV+mT7OfgXSfyJ8VjRdCH4OIQ755pmEzSCaaIOrDtOyiijtTvWYpf4sqkTsuv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39840400004)(366004)(346002)(376002)(396003)(83380400001)(86362001)(52116002)(4326008)(16576012)(8676002)(8936002)(2906002)(5660300002)(16526019)(2616005)(26005)(186003)(316002)(31696002)(36756003)(6486002)(66476007)(478600001)(66556008)(31686004)(956004)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: enpaWgD2UdGu/Ypg4JIyOVB07Dkk4zVcVSKizuHBXm+0dyC6OEh/JdxOsdzDWdp6Q6mg/CNz9SRr7wGFXfV0Act19W2TJfkjmbAkZGvp5Yw3UO/NKCNcI+aMMB3yRWajd/++8PUK7DVxGA8mDo+krfSo5fvdoaQtykTuFkD3e1otbWouypqRdbPgrPghl46loyYnej7CYig0D7e4dvvw7eqAFDMv2ulF99LW4CrY+oRZx7/SXvxO0CoGrGBZPboveDESyDodkhpYvhBYj16Z9k5t/1LxQ+UWOokvz2yLYdhCXGQKupxX5dtavTJHWJSzajTN9r7PGd+z6fx/ntHzMznQIy+n/ImzyxbFMiN+kdEItg3Ergv8+Uqv22LF7ojAMLN9tdxyXHyQuLvhhWalv8WDL/36MRDgVzndsFcxxe1EsRt5UwfXMFc84Rs1gWLjI2Q/uaLQR6MQeAgwbaVUrlXhSf0jplFV9tboGS0C2KiBrUrjfTlb6IBbnhUv4aQj+r6ILP7XHeK1lNscsQXBd9fbyxhlJbpbs+YESph8dzF4W5XTcp3YRkXQD2X8CQYmf02DzgLDR1dUfdw6EGBdn8jcundPubcwd0sPOSuidrSY/DUsTS2/NXO8edKu01BzDy8aZiigoV0UOCmJrn2cnQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ee5d4e-54db-4aa8-e0c2-08d87037a8be
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 11:52:43.0315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvVWlMey7OqIc4LdrTKgvJEseZpW78qfU3H3Gyf34EeduDiYSU+D2UHRfKHs+uv5cAehBTneaqYSHU+d2r5Pki+pNFWznFNudO0Ta6r9IKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1649
Received-SPF: pass client-ip=40.107.3.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 07:52:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

10.10.2020 00:55, Eric Blake wrote:
> 'qemu-img map' provides a way to determine which extents of an image
> come from the top layer vs. inherited from a backing chain.  This is
> useful information worth exposing over NBD.  There is a proposal to
> add a QMP command block-dirty-bitmap-populate which can create a dirty
> bitmap that reflects allocation information, at which point the
> qemu:dirty-bitmap:NAME metadata context can expose that information
> via the creation of a temporary bitmap, but we can shorten the effort
> by adding a new qemu:allocation-depth metadata context that does the
> same thing without an intermediate bitmap (this patch does not
> eliminate the need for that proposal, as it will have other uses as
> well).
> 
> For this patch, I just encoded a tri-state value (unallocated, from
> this layer, from any of the backing layers); an obvious extension
> would be to provide the actual depth in bits 31-4 while keeping bits
> 1-0 as a tri-state (leaving bits 3-2 unused, for ease of reading depth
> from a hex number).  But adding this extension would require
> bdrv_is_allocated_above to return a depth number.
> 
> While documenting things, remember that although the NBD protocol has
> NBD_OPT_SET_META_CONTEXT, the rest of its documentation refers to
> 'metadata context', which is a more apt description of what is
> actually being used by NBD_CMD_BLOCK_STATUS: the user is requesting
> metadata by passing one or more context names.  So I also touched up
> some existing wording to prefer the term 'metadata context' where it
> makes sense.
> 
> Note that this patch does not actually enable any way to request a
> server to enable this context; that will come in the next patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   docs/interop/nbd.txt | 27 ++++++++++---

[..]

> +In the allocation depth context, bits 0 and 1 form a tri-state value:
> +
> +    bits 0-1: 00: NBD_STATE_DEPTH_UNALLOC, the extent is unallocated
> +              01: NBD_STATE_DEPTH_LOCAL, the extent is allocated in the
> +                  top level of the image

Hmm. I always thought that "image" == file, so backing chain is a chain of images,
not a several levels of one image. If it is so, than it should be "the top level image".
And "levels of the image" may designate internal qcow2 snapshots unrelated here..


-- 
Best regards,
Vladimir

