Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BA1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C724420661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fWeyLzli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C724420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyup-0003Bs-0X
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyytl-0002ZI-4v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyyti-0004mo-Vy
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:09:52 -0500
Received: from mail-eopbgr20091.outbound.protection.outlook.com
 ([40.107.2.91]:24847 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyyti-0004U5-5u; Tue, 04 Feb 2020 09:09:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bazph1i5lhvtPEytvhsdV61Rwmvf32RMUYwx1L/ikqumlNuCv2LYwsolm+eczWN4fJ4qwTm9CMx72YeL4eQUERf7DBq6JWZVpUt38cJrdA5dRI3+cWqyFeOkjtmsS33FtBdIAOz03qFWhYljiP/kH6FCwS2YnRo128hfeUVWy0pUGBkbMO1I7855evvIvHww1IVHupNMBj/vYwB/fIMQavhRxEK9r/fsegG0owOF30Z7thbcnHX0c5EMFv8N/+zy7o/axsf0G20S9XSttfOggOdpNDPd97O00KlVuMViD6O2lq3IDci0Yx3WptDTkstbFNXDDy/xU0pe6PJE+pnpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVp8vGflJnJWJsmb49WFK6LiIpo7EdEWqGfjOchTIzE=;
 b=mRtmP+RtsVEofPtAKi/8zY3hGqy6tQL2PbdMDaJr4FM39FkrWhOPIIIRvCR9Bx4xvIR6HgT9ajT8f9g7SHHZPiCZoJ/ghXByGdn3J3NLTxXJabO/6aVxn+Gi1oo0kYNVp2XTtctbxKCIzmSrq9VIztngOI6lyTvwfP2ClVpU30o1UIMp6vyUfoBKUiaKm3FLnQjkM3aXcJlK0Bruh+ZgHSn+uWk2GD/o3MUtD4jQAe15u9PQmNeu6Ei2jI2ZPQ48v/OkEmIlcdrP8jSSKP4sajm1gDEsnj5Yn+ivC/YaZNflPym0PjqNTeEUh0BUyKwv3e4+Ooeo6PkOiH51hneXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVp8vGflJnJWJsmb49WFK6LiIpo7EdEWqGfjOchTIzE=;
 b=fWeyLzli7sffZZvqRXI10J3/xoxsvafBw2jZwthG7QO+Um5jSt4S/DiR4GY7j+U+/cqXPKy0OiHmBzPJHhG7PsSn/VZh1si/pFKz12KDyfuSGlvbQpdcFzJAMH4W0jALHBbyN6luzYlRDlD+wNI+mTgW+hTAhj6vu3SYnLjkAWU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 14:09:47 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 14:09:47 +0000
Subject: Re: [PATCH v3 16/21] iotests: Add VM.assert_block_path()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-17-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204170945282
Message-ID: <978b5d21-ccd9-7cef-3d39-585c5764c788@virtuozzo.com>
Date: Tue, 4 Feb 2020 17:09:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200130214431.333510-17-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::20)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34 via Frontend Transport; Tue, 4 Feb 2020 14:09:47 +0000
X-Tagtoolbar-Keys: D20200204170945282
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: def7df48-49bc-4219-ac0a-08d7a97be462
X-MS-TrafficTypeDiagnostic: AM6PR08MB5208:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5208AE5DE64FA6229EAAB272C1030@AM6PR08MB5208.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(39850400004)(366004)(396003)(189003)(199004)(478600001)(2906002)(2616005)(86362001)(956004)(4326008)(6486002)(5660300002)(52116002)(16576012)(316002)(31686004)(8936002)(66946007)(8676002)(81166006)(81156014)(16526019)(186003)(31696002)(26005)(66556008)(66476007)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5208;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obaGxRX5DY18ADo1Ai4v3cqQXQNtzEq9h6GDDAywc1SjKK841OtN6WBOk8thWV00EUI+BgIBzor1c+1AHtyB6VcG0gdDcyEplBWBIiOsQtBTFN/mFsZZ6Zu2g7dTkMVjaRCXPXs5dx2ktWUvIhXFazuCZeASaP/Uzc1Wz2GfqVKbb0DvqNPaRACWdQmq9pjUxENZO8hzDd5HPu41YRQf1AO6Tjn7dSNbM0bCI09VOnH76R8hX3ETx47oxwilKqh1rHYpFndQ9V/zX3erLrbK2MO8jFA1BPq7t5SxZNmzzNnugWjCS/yg2Tl2gBdQUG+tgvnOLnG0MHovhkCR5Wg2Mgeocx4sg9+6ovrfVFEZIveo/8b6nWGs9igR3+91UbYRfJS2M9xW7eyBhCxf8YFs1ikawHi9LaT7fbA3zY5Dy59QfqOtNA8U+2vauouP20e0
X-MS-Exchange-AntiSpam-MessageData: FttHie+zkmR0uTlLc2KevfZP4h3LdjRfyNWyt1tB3gehd9ouEf9i0Sliv5WR2TyAf8/6PGpN7jO5W6tFH0SnCedH6g/NUe+XDLaL9z2mcT8mjrqPM/73Z4GDGxFoRhuMzZF9MwvOENI8UTV0FxhG8Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def7df48-49bc-4219-ac0a-08d7a97be462
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 14:09:47.6476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtXIQUZOnVXzqzIflW2s8HseEmrsEgzPyv0mqHIRizKvvO9q2SvFOUX+uYAfFs4WrQch2FVcRAaP6eewpd+VZCCTo27an6hXOD1Tneh3Hnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5208
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.91
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 0:44, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 56 +++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 01b58dcb50..69861cf05e 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -713,6 +713,62 @@ class VM(qtest.QEMUQtestMachine):
>   
>           return fields.items() <= ret.items()
>   
> +    def assert_block_path(self, root, path, expected_node, graph=None):
> +        """
> +        Check whether the node under the given path in the block graph
> +        is @expected_node.
> +
> +        @root is the node name of the node where the @path is rooted.
> +
> +        @path is a string that consists of child names separated by
> +        slashes.  It must begin with a slash.
> +
> +        Examples for @root + @path:
> +          - root="qcow2-node", path="/backing/file"
> +          - root="quorum-node", path="/children.2/file"
> +
> +        Hypothetically, @path could be empty, in which case it would
> +        point to @root.  However, in practice this case is not useful
> +        and hence not allowed.
> +
> +        @expected_node may be None.  (All elements of the path but the
> +        leaf must still exist.)
> +
> +        @graph may be None or the result of an x-debug-query-block-graph
> +        call that has already been performed.
> +        """
> +        if graph is None:
> +            graph = self.qmp('x-debug-query-block-graph')['return']
> +
> +        iter_path = iter(path.split('/'))
> +
> +        # Must start with a /
> +        assert next(iter_path) == ''
> +
> +        node = next((node for node in graph['nodes'] if node['name'] == root),
> +                    None)
> +
> +        for child_name in iter_path:
> +            assert node is not None, 'Cannot follow path %s' % path

this error message will be a bit misleading if we failed to find root node. So,
may be add additional assert for root node, or at least
'Cannot follow path %s%s'.format(root, path)


It doesn't worth to resend only for this, apply it if you want and keep my r-b anyway.

> +
> +            try:
> +                node_id = next(edge['child'] for edge in graph['edges'] \
> +                                             if edge['parent'] == node['id'] and
> +                                                edge['name'] == child_name)
> +
> +                node = next(node for node in graph['nodes'] \
> +                                 if node['id'] == node_id)
> +            except StopIteration:
> +                node = None
> +
> +        if node is None:
> +            assert expected_node is None, \
> +                   'No node found under %s (but expected %s)' % \
> +                   (path, expected_node)
> +        else:
> +            assert node['name'] == expected_node, \
> +                   'Found node %s under %s (but expected %s)' % \
> +                   (node['name'], path, expected_node)
>   
>   index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
>   
> 


-- 
Best regards,
Vladimir

