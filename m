Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F72C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B06214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K0N6KVqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B06214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP4G9-0002ef-HF
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 09:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jP4FS-00020p-MV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jP4FR-0006eE-Kg
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:08:06 -0400
Received: from mail-am6eur05on2111.outbound.protection.outlook.com
 ([40.107.22.111]:39648 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jP4FN-0006aQ-Kz; Thu, 16 Apr 2020 09:08:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHIXqc9XNQ+iB2e0pQFKz1wpZXEIOo2eFV72Xk93e8zC7j3bz6qjIxf321BTslb4bfXyJ03GxpjnQCgRlouegx48T09wSyZrJ6c0PnrHMmzyKMzkysV9DmAbT/d6TvFdnJl0j7mTCvZ5Gj1qMYC3IbgHhBzYfNViPBObQa6WQ4i4KhGxDh+9X9U1sX16Rb/VJf5rRehTE66677dyLmKt4crJOOnUOyR4HYJSOyA4mBD5M6lPlQlTVKmEzJ2dccRlUfANQMNjQdmSghLJazZ4KWh+hCoz5h7T1Jw6cV21YcrNqkpeEKCpAMtn7H9s9mY0F+43oIMX2BzFd2byCzHG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JGmgMs4hPlrqB/Obgdf9IYn4RFtGiLGDCtxkzl2j+k=;
 b=Ss8NAZzIMLabu02L0Bl+Q1ZOyLNEnLKdEgL9ZT+aNYYXKAawmn6AES0gNZ8VYQ7sNBUGvYJT+NoWRn5b0IwmG8eVhPd4H5/3x8s/erEK/n5qxeUPTLDnd2cHGNUL+gKziOmgb4JBhigakmtBQXKumvrrnXkUZNNQCVDQL+MJ9LEHrnNLTgVnfOAw+cjy+wj/M11I03CYO6Im1Cpw2OkVfrRp00gErRhAuUeX+YZPXeOrGiXENIPhL0iePeH1z4d8xh9kKW51Swj+nla51DYew1rKofLXWt5WMRbT9uoHLOLVqoB7tiWfea9hYwNlSRXDXPpaBwgpUUkd8TPjePImhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JGmgMs4hPlrqB/Obgdf9IYn4RFtGiLGDCtxkzl2j+k=;
 b=K0N6KVqO+oLq/Fey/ezCg0EGmnIxTK8f4VMIM6zEvpQ6BrupSf/m8Lpc5mDe9KkXkmjlCDqBSVEdZb5fOc6vfg1NY9xHM2URru1jSyT8GqCQf0N62Wfv0pce5bR3hRERVPtazyAm+HJ9Q0WO2bVaaTlveAkL2MjII1T+mmqhuZI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB3953.eurprd08.prod.outlook.com (2603:10a6:208:125::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 13:07:58 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 13:07:57 +0000
Subject: Re: [PATCH v18 3/4] qcow2: add zstd cluster compression
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200402063645.23685-1-dplotnikov@virtuozzo.com>
 <20200402063645.23685-4-dplotnikov@virtuozzo.com>
 <w51d087a8uu.fsf@maestria.local.igalia.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <bce6f462-f448-e66b-605c-a9d5d1de31fa@virtuozzo.com>
Date: Thu, 16 Apr 2020 16:07:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <w51d087a8uu.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::27) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (31.180.245.198) by
 AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 13:07:56 +0000
X-Originating-IP: [31.180.245.198]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53f42118-4436-4a6a-c0d0-08d7e2072eea
X-MS-TrafficTypeDiagnostic: AM0PR08MB3953:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3953D12911F30970A5E8AA37CFD80@AM0PR08MB3953.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(136003)(376002)(39850400004)(366004)(346002)(81156014)(16576012)(36756003)(186003)(478600001)(316002)(8676002)(31686004)(2616005)(2906002)(6486002)(52116002)(8936002)(4326008)(5660300002)(16526019)(107886003)(66476007)(66946007)(86362001)(956004)(66556008)(26005)(53546011)(31696002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9hgIfecDVdZEhX2XFxhWg+nFH+iYh7/0zkhiKLdQ/n/7xI3ihW3osOa7OIkDEDAFxrOFC8aZX/+jcgXtATV9wmGfnFZT60FGhH6c5Ill4A2duEr+R17stwLLVGNVmP8MzKttFx4Urnu3ZWXTGJmhUpfeQyB31Da4ajAeWRGlpN6TqJiuUKbss1bAicM5px5OvNiZ0HX8uYKy/jh3C2ZlrBYl3ZJ6oPDpXN+UMNkX3ms5iizGtejFpBYa6qO2ycymyk/gVXP8Op+z41vPqYmAqZnkmJ1gCckPK+y2IpW8gCjEZgRxp/6ldEQjWmkjKw6fo1Eufg5Y2wY510x0INYLpIeuGL3NmjUFyO4XfCTw3lpzKLgRGZF6yVeLZ/4t4OJBAwhWvqaI/3tOTLVeSJtv+MSFGqIbo4gOT28q05Mex+Zl4xGrH3hweljX52anwf/
X-MS-Exchange-AntiSpam-MessageData: gwRRUBuVjVhL1vJVENeSWtrhpZlZUvoilulnc7DZnFrPLlRS0TXelhEOKm9XT9z8o7JPRJWoYkb2EJatIkuZ14bS1XA76hqIvxp/8YGQRn7JpKe26g0SvVZ0jgsGP47xta2WYrsEyzdhWbWbV1H2Dg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f42118-4436-4a6a-c0d0-08d7e2072eea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 13:07:57.7409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLfThFrXqBhu/njWOR9t8Akcr2uFyV/pdfBu4un7McyTafPm4TxByh6nNztNCIpIf8DQNYS9qtp/Vzox2nxFJsjVpcKWWx5C8bvT6nP5gAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3953
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.111
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 16.04.2020 15:55, Alberto Garcia wrote:
> On Thu 02 Apr 2020 08:36:44 AM CEST, Denis Plotnikov wrote:
>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>> +                                   const void *src, size_t src_size)
>> +{
>> +    ssize_t ret;
>> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
>> +    ZSTD_inBuffer input = { src, src_size, 0 };
>> +    ZSTD_CCtx *cctx = ZSTD_createCCtx();
>> +
>> +    if (!cctx) {
>> +        return -EIO;
>> +    }
>> +    /*
>> +     * Use the zstd streamed interface for symmetry with decompression,
>> +     * where streaming is essential since we don't record the exact
>> +     * compressed size.
>> +     *
>> +     * In the loop, we try to compress all the data into one zstd frame.
>> +     * ZSTD_compressStream2 potentially can finish a frame earlier
>> +     * than the full input data is consumed. That's why we are looping
>> +     * until all the input data is consumed.
>> +     */
>> +    while (input.pos < input.size) {
>> +        size_t zstd_ret;
>> +        /*
>> +         * ZSTD spec: "You must continue calling ZSTD_compressStream2()
>> +         * with ZSTD_e_end until it returns 0, at which point you are
>> +         * free to start a new frame". We assume that "start a new frame"
>> +         * means call ZSTD_compressStream2 in the very beginning or when
>> +         * ZSTD_compressStream2 has returned with 0.
>> +         */
>> +        do {
>> +            zstd_ret = ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);
>> +
>> +            if (ZSTD_isError(zstd_ret)) {
>> +                ret = -EIO;
>> +                goto out;
>> +            }
>> +            /* Dest buffer isn't big enough to store compressed content */
>> +            if (zstd_ret > output.size - output.pos) {
>> +                ret = -ENOMEM;
>> +                goto out;
>> +            }
>> +        } while (zstd_ret);
>> +    }
>> +    /* make sure we can safely return compressed buffer size with ssize_t */
>> +    assert(output.pos <= SSIZE_MAX);
> The patch looks good to me, but why don't you assert this at the
> beginning of the function? You already know the buffer sizes...
Yes, that's true. But I thought that it's reasonable to check what is 
returned.
"output.pos" could be less then or equal to ssize_max when output.size > 
ssize_max.
Anyway, this case most probably won't exist, and this is just an 
overflow inssurance.
>
> Either way
>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>
> Berto
Thanks for reviewing!

Denis


