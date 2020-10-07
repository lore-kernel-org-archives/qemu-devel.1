Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880FBC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48502076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="u8XeneRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48502076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQA4Z-0001iZ-Hu
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQA2G-0000Cd-PD; Wed, 07 Oct 2020 10:03:17 -0400
Received: from mail-eopbgr70137.outbound.protection.outlook.com
 ([40.107.7.137]:64475 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQA2B-0000hs-8F; Wed, 07 Oct 2020 10:03:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M78sAQwqZkpANc3rk4Ub4FyG7CM8Ljl2fSZMuZN9yISBJmixpVClZYvpmz3U5NuHSGcc8H9eIUzh0T249eOZjgvgCEd1amBmv1y7EHAwlO83fYp8PXlJn8sFgry0q2RUDRey3lnBeb4u7ne1QTeEaTHx1XmV5ZghnVJ3C0Xml1LGhihrzJ6J/rFxUnleHXC6ikbk92aVfYO9l1IkNKKEGH+OnuSmgp5PCZZY+n+gufzx5QYU9jbc+XyFoOrZt272JKdo+qdVLuDCJ2piTV6ZilZRllbCg5wi1VHg1i4B24yWkEUDDIJ+IdlGx1NES4dmTghXRzRzJqypQ7LKzR2ysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck8+7GdxArCtSEX3LeT7+LIomGs0eRzxmRbudzOUBi8=;
 b=ck818mkr85isTqNek5BeUAH7lU41q9FxI5KAy187klpiHB8TX2NdTy1iXtclDO/hHw/Dr5z709wGTuZQJvjDh7oLj7FTrUnsNQJIhIbKqDiDycbolwFEa+Z/+SONzOn0UDa3gxTf4pjGAiwUSZu7sHlLx2lwkZUdZKzM8MGUgyFwhqtbii3TtwPEJnUUgsEcLvCN7/Z2HHeyP1LrQ6BQlTKKRUPcbIQE4q5Nxxl1N0PEnM8m2Jnll3J8EuOym76lhzLQiOUiSttfjGOC1EGmk90DBJm6suv04rahI2Aqc4vw5wXs8MCLkfecgvttyRZWLd6DkTsFyKPMMeQRW7n68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck8+7GdxArCtSEX3LeT7+LIomGs0eRzxmRbudzOUBi8=;
 b=u8XeneRKhQZWqZYtLHWuA+1NCZVa6ZX2Uk6iYOLgq3ntIrxjclgIwy9MSdGR1b7xVmIzUNP7+aXITZUDBfvU4qpAWz9HzuaYQFu32E7BmVnDWYrWF88nTeFk0fJQ6Ii+VSWWQYQCEJfeTtByqG1Y9+5kVTm/sYOCWm9t1OZH1kw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1777.eurprd08.prod.outlook.com (2603:10a6:203:3a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Wed, 7 Oct
 2020 14:03:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 14:03:05 +0000
Subject: Re: [PATCH v2 5/5] nbd: Add 'qemu-nbd -A' to expose allocation depth
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-6-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <636b2565-b453-cbfe-6205-0699dfbd8457@virtuozzo.com>
Date: Wed, 7 Oct 2020 17:03:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20200930121105.667049-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM4PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:205:1::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM4PR07CA0003.eurprd07.prod.outlook.com (2603:10a6:205:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 7 Oct 2020 14:03:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 867672f9-8d32-4834-bf3f-08d86ac9b61e
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1777:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB177775EAFB0C3DDB3042AAD6C10A0@AM5PR0801MB1777.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ssbPwW8+e+ltU+P1AcpVVfGrEZofsqOTEIjEVMJspfyYnYSLjWBCAEF3MCVPgtgiD4CP66M9fIMzrs2ceUnHcIMMKlRvUfD6pknKHlCvVTX5HUtxn0UFtkeSDpRSYsTqzs/Y4HEOWdVh9YEn/0jnYK0EfWFNQXbbMutKM9DEHHomtvX1Rnw6/kA1zCZfQ8EYjD2VULFcp7Ey14h/BN6FOjlotNmMyINvWEI+mkFCGLbYNZx56ye13+zbZVMkYOBprwqEC2E7AUZxqqotsSBiSAReA+6wXuWMUHJg7B8NIRL+oxkGwNE3kzsJ9P/naVdKWeFEjyu6aGqjlQ6Rr9hnUG4fRgQ2BKcoVikvhlTgRcx3lmKNPuVfozGbyR5vUbp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(83380400001)(186003)(16526019)(66476007)(31696002)(66556008)(8676002)(8936002)(5660300002)(31686004)(2616005)(66946007)(36756003)(6486002)(478600001)(86362001)(52116002)(54906003)(956004)(16576012)(4326008)(316002)(26005)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aUiH4BwBWNSgeOXxh0wIFyrUXaaDQxXVbYbK2ui28ZGHmG8d5lm+4DFITpqLCGos9RpRjecOyqTKFPpnyvZ5cRphAujfF9Nm/z2LQWP6UcRPs7ARsyfBq3fkKxMYslZOiaXyauO747AHDTb0fQalIMe5FrjAacyobkZY+R9m7S2OXuQ+8oLaxkiqsHdAc5jFfOiaH8+utoWg8kg0LwAAuXd+ocP5B0hfL0wbrg8MA0a5ZFiSw1B7EvcbUVGGlojG4c3RQPL1jOu24HY/0iHuZgTXGNMYYmjHhPemct/79xYNn2N01eSPFTZzNROvlkrImvtXZioknRkF/sIxgNeCrRkFahz166AeRZopNwFuzN5JuJnBicZzOe3yF52ka4FisPOzvU3FKRChp9Go6ZD7bGsYwFenEjtVJBWKZwlDkZWmG2yKv1kCXEHFPqk0TZB3kfCBneGANP031XHfz2nak+aEiTy2FwznqC0wPorxtk/1h5FlYj7SDNAy6S4Mmh111BvNeILB2hTRvvVAoM0JT+vGBd6uV9YEIaIeXJHc+K2tkm3y7iFBfYIyiYcWRfhM4kvX11Z+6siXi7S/z1NDNQYZVUJdElOSbYe7N/nL2kokjTdnTNh/l07WfQ7sr4OGjBt0M1MS9cmFHRDsFva9UA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867672f9-8d32-4834-bf3f-08d86ac9b61e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 14:03:05.0071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tKv/QUgFbIJGa9NUR1nZDTeO8kMGM0ZHjvnpk+lYfxXKb6Or7dhOltRVcWw3r54ADSjxQCuNtQfC0fcGJKOTe4cqJpKVIPnB6Xfbt8Q6gQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1777
Received-SPF: pass client-ip=40.107.7.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 10:03:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

30.09.2020 15:11, Eric Blake wrote:
> Allow the server to expose an additional metacontext to be requested
> by savvy clients.  qemu-nbd adds a new option -A to expose the
> qemu:allocation-depth metacontext through NBD_CMD_BLOCK_STATUS; this
> can also be set via QMP when using block-export-add.
> 
> qemu as client can be hacked into viewing this new context by using
> the now-misnamed x-dirty-bitmap option when creating an NBD blockdev
> (even though our x- naming means we could rename it, I did not think
> it worth breaking back-compat of tools that have been using it while
> waiting for a better solution).  It is worth noting the decoding of
> how such context information will appear in 'qemu-img map
> --output=json':
> 
> NBD_STATE_DEPTH_UNALLOC => "zero":false, "data":true
> NBD_STATE_DEPTH_LOCAL   => "zero":false, "data":false
> NBD_STATE_DEPTH_BACKING => "zero":true,  "data":true
> 
> libnbd as client is probably a nicer way to get at the information
> without having to decipher such hacks in qemu as client. ;)
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   docs/tools/qemu-nbd.rst    |  6 ++++
>   qapi/block-core.json       |  7 ++--
>   qapi/block-export.json     |  6 +++-
>   blockdev-nbd.c             |  2 ++
>   nbd/server.c               |  2 ++
>   qemu-nbd.c                 | 14 ++++++--
>   tests/qemu-iotests/309     | 73 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/309.out | 22 ++++++++++++
>   tests/qemu-iotests/group   |  1 +
>   9 files changed, 127 insertions(+), 6 deletions(-)
>   create mode 100755 tests/qemu-iotests/309
>   create mode 100644 tests/qemu-iotests/309.out
> 
> diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
> index 667861cb22e9..0e545a97cfa3 100644
> --- a/docs/tools/qemu-nbd.rst
> +++ b/docs/tools/qemu-nbd.rst
> @@ -72,6 +72,12 @@ driver options if ``--image-opts`` is specified.
> 
>     Export the disk as read-only.
> 
> +.. option:: -A, --allocation-depth
> +
> +  Expose allocation depth information via the
> +  ``qemu:allocation-depth`` context accessible through
> +  NBD_OPT_SET_META_CONTEXT.
> +
>   .. option:: -B, --bitmap=NAME
> 
>     If *filename* has a qcow2 persistent bitmap *NAME*, expose
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index d620bd1302b2..0379eb992db8 100644


[..]

> +echo
> +echo "=== Check allocation over NBD ==="
> +echo
> +
> +# Normal -f raw NBD block status loses access to allocation information

^this comment is not for the next line, but for further lines ...

> +$QEMU_IMG map --output=json -f qcow2 "$TEST_IMG"
> +IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
> +nbd_server_start_unix_socket -r -f qcow2 -A "$TEST_IMG"

... should it be here?

> +$QEMU_IMG map --output=json --image-opts \
> +    "$IMG" | _filter_qemu_img_map
> +# But since we used -A, and use x-dirty-bitmap as a hack for reading bitmaps,
> +# we can reconstruct it, by abusing block status to report:
> +#    NBD_STATE_DEPTH_UNALLOC => "zero":false, "data":true
> +#    NBD_STATE_DEPTH_LOCAL   => "zero":false, "data":false
> +#    NBD_STATE_DEPTH_BACKING => "zero":true,  "data":true
> +$QEMU_IMG map --output=json --image-opts \
> +    "$IMG,x-dirty-bitmap=qemu:allocation-depth" | _filter_qemu_img_map
> +
> +# success, all done
> +echo '*** done'


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

