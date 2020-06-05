Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591402075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ER8ytGCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591402075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9CB-0003cb-M2
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jh9BF-0002iV-Jt; Fri, 05 Jun 2020 06:02:29 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:6209 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jh9BD-00021b-2U; Fri, 05 Jun 2020 06:02:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8gRnQhCj3P8h+/67ZKUxcqBDnjg1UnK4/6xDIB2IXYQMArULZ+oNQ2nNwRRQ1gnVJ9GiAK+C3cZuNuioK5OEgip6746DGbhtM58QXbQM0L5BOFJDky5FqafAKw5QgrpPBczDqHEjsoCTFwS6JA/CcRUm1aQxzZttp99WZQBxJOOOxV6+qite9qvy1hq10p4BbUd/7wUaFuGjEs2fxzCARICYq1PUkjtJfMYfBhDXwX74XM4KFsUfNCV4D4TG1sS36VmS7+3q9cHhSVD2uEyYDVkwZkfl+JkYVXVT0qk6EfInVkqFc8FOu5l5D8qXg/nL/iKBNg2DLqKvUjXriseOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvs8QBOOtVTyGQmz//VRLzTvqTlMuLTK7KVbwbcFcQ4=;
 b=TQKuuK9IXSWDrC6tTcIQ/l+MGP6BQn0tx0KlMvT+3ivHLD7ZgOj7AUGO8X9nLLGcbvXU4lXiZMLH2XJa3J+qjqaL6tugqgiIt1/WzYcyA6pijDqCZNNxniFpW366GOGJl3EOt5xXBQ4K/E+p8Ocg99EI/CBdADVxoXxUkyEP41L6Bd8W5I5V6Xx7W2d5jnYtWRTGQFKQloiEE4CGNguQwXPB1PV1Kg+AIRs/bZys9qKkzjHwb3Geus+FgVK6NBmPDbE6IWHVlVyD1q9cbjWdqaQd9YsUaCtWWW3Imm3BieUl4MIG49C0PuV1KRPQNniYz+gIOAkzup/DKjmX7KYyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvs8QBOOtVTyGQmz//VRLzTvqTlMuLTK7KVbwbcFcQ4=;
 b=ER8ytGCgrUIimQZhBwUfYwuCV5c0g9+jHg7R632fri3DBr9A+G3jLhqAYQMlutE3Iym3WdiyYGg8l5UpsoJ4nf138Asm+HvLsmD5hxSS9vSSBUVWX5KlC9EcFEC49TIVtX1L0dHvJ17tHsE3nOzGXHhsHv4JC43XSKUhOkKE7Tg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 5 Jun
 2020 10:02:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 10:02:22 +0000
Subject: Re: [PATCH v4 00/12] iotests: Dump QCOW2 dirty bitmaps metadata
To: qemu-devel@nongnu.org
References: <159129809507.14650.2042831377861611531@45ef0f9c86ae>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <82402cce-6bf1-006a-b532-138c190172ca@virtuozzo.com>
Date: Fri, 5 Jun 2020 13:02:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <159129809507.14650.2042831377861611531@45ef0f9c86ae>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0121.eurprd05.prod.outlook.com
 (2603:10a6:207:2::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM3PR05CA0121.eurprd05.prod.outlook.com (2603:10a6:207:2::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 10:02:21 +0000
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eaccf44-236e-4f68-eaf5-08d809378a1d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53177DF42E91D9B7E85FF353C1860@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nd2PkyrmbuPqrZ/Qm8kcr7P3G7b9FIjgYWTKGp2BhwWA2t7xYxMvHJhgu8vM9/tDN2Cvlcz9IH8mlB7/i/Skjv1c0u5D7uNBoSW4B4gn2GrEu2O9gHHSelEFi+ltApdri8NAOVjNwlhKMRLADM4kVaDwv1ev9Qqy67al8f1bcuVbkIO1P4zUy5SGrcSNNoaEdciCBFtswQgQHhIWY3OlE8F5DyJjizHdggJydjDHbN4uIQRzcBUs7z+Hwy+fHlOaI5MGyH6d/nDIdHUwHL/59puJxHiPZPJVLtt4IwdMS4uvNJb8GdBDfOTuWptOdiVpihTCblipvEV52vB2oP0RsV+1klApvMDCtmSyy4cV4aTfoYJuNd7/JVxVjcvw8C5Or6O0l3B4Lz/3mZ74sLawGJwjMpIbiYcsptEbMsZ23KYUYJVEKWbQ4e+LxSgy1vLiDbnMfi4isRFq+suCkR6cOhl5QtliGMilZHsRp9s0RsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(396003)(366004)(376002)(136003)(2906002)(478600001)(966005)(186003)(31686004)(36756003)(6486002)(16526019)(26005)(8936002)(52116002)(83380400001)(6916009)(16576012)(4326008)(5660300002)(31696002)(8676002)(956004)(2616005)(107886003)(66476007)(86362001)(66556008)(66946007)(316002)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hE9Ei7mHPAP/IRvBb+3ql2RN1iupoyRXHORyKssZLpgWbjk9+75y+Vxv2hZEWL9Gp5qiDsQgl3CPHqROzyTdNx9Rm0TerQt0d2vhnBJcGwWSX/wEKRfRGcO/cP8tIzis1eEuNmHXaW2LmI+AA6Vsaf5iy21dM0vrSHoy51Q0pdC1o2hHbiBWSkTa8PF4I9m7grrFXD20rb6ASGvfngmZK8QAWsXL9F2ECEYKb3m5cm8wPLiOMezMohgoNArvhFvW3L1gi8KucTLbzfyqtKElkm7dZZfA88rEyvNz77bt2cmqVsl3bqWqOUKRVxJNcoIk2GzMbCeI4SS4vkMizGnnUWAFW1TIGEAaIPD1LdUtnnMh4QE2n0F4FUq99LYxjNE5rppasNHloI2CnJzAvEjrl+mhsphKn9itnWuOxwaItcYXYabBXkg1jk1mMJnpMXAXdlXazUnRaL5p8q68hdr9GGzzHOCh1WoUOtmiU7nqZE9gD0n7BHOpIbKeO5g4yUzV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaccf44-236e-4f68-eaf5-08d809378a1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 10:02:22.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZomhXyNC96N3YF6VTttZqulm0i3oDdonxrja8SiaBc99+H71K/m1Noyzak0Xo6E1dCW7gA3I6P65TMNcWVo8KJz1YF+Onqvi7uvReZPbX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.8.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 06:02:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.06.2020 22:14, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200604174135.11042-1-vsementsov@virtuozzo.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20200604174135.11042-1-vsementsov@virtuozzo.com
> Subject: [PATCH v4 00/12] iotests: Dump QCOW2 dirty bitmaps metadata
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Switched to a new branch 'test'
> ff3d0e0 qcow2_format.py: dump bitmaps header extension
> 1ca4b4b qcow2: QcowHeaderExtension print names for extension magics
> 4894f85 qcow2_format: refactor QcowHeaderExtension as a subclass of Qcow2Struct
> 5d2d3ea qcow2_format.py: QcowHeaderExtension: add dump method
> 7848f52 qcow2_format.py: add field-formatting class
> 4f0473f qcow2_format.py: separate generic functionality of structure classes
> 78964d2 qcow2_format.py: use strings to specify c-type of struct fields
> 492b753 qcow2_format.py: use modern string formatting
> 7fef737 qcow2_format.py: use tuples instead of lists for fields
> 8fae4ab qcow2_format.py: drop new line printing at end of dump()
> c0b4e4b qcow2.py: move qcow2 format classes to separate module
> 32668ba qcow2.py: python style fixes
> 
> === OUTPUT BEGIN ===
> 1/12 Checking commit 32668ba94cf1 (qcow2.py: python style fixes)
> ERROR: line over 90 characters
> #219: FILE: tests/qemu-iotests/qcow2.py:256:
> +    ['dump-header',          cmd_dump_header,          0, 'Dump image header and header extensions'],
> 
> WARNING: line over 80 characters
> #220: FILE: tests/qemu-iotests/qcow2.py:257:
> +    ['dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image header extensions'],
> 
> WARNING: line over 80 characters
> #221: FILE: tests/qemu-iotests/qcow2.py:258:
> +    ['set-header',           cmd_set_header,           2, 'Set a field in the header'],
> 
> WARNING: line over 80 characters
> #222: FILE: tests/qemu-iotests/qcow2.py:259:
> +    ['add-header-ext',       cmd_add_header_ext,       2, 'Add a header extension'],
> 
> ERROR: line over 90 characters
> #223: FILE: tests/qemu-iotests/qcow2.py:260:
> +    ['add-header-ext-stdio', cmd_add_header_ext_stdio, 1, 'Add a header extension, data from stdin'],
> 
> WARNING: line over 80 characters
> #224: FILE: tests/qemu-iotests/qcow2.py:261:
> +    ['del-header-ext',       cmd_del_header_ext,       1, 'Delete a header extension'],
> 
> total: 2 errors, 4 warnings, 217 lines checked
> 
> Patch 1/12 has style problems, please review.  If any of these errors


Preexisting. And it will look worse if wrap lines.


-- 
Best regards,
Vladimir

