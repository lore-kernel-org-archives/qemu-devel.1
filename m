Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB817C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89EC20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LXH2ECWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89EC20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jifJj-00063I-TD
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jifEo-0007qJ-7v; Tue, 09 Jun 2020 10:28:26 -0400
Received: from mail-eopbgr60092.outbound.protection.outlook.com
 ([40.107.6.92]:21058 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jifEi-00025M-UY; Tue, 09 Jun 2020 10:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKIx18wTH/0KaRysvGsaYBu8TKS0XfC/8z+7LsvGoIDp3IYXbhYqiQo5lAb2f2y5SmObzSUBq/+TJPi/+Cp8svyzDlHPc83UuGg5sAoA1yh7nvxmS5SPebhn3BzJNmOgrNd3vpCq/jJVOtb1dn7zRK1OsEkfsJhzdr66Cv8tmKHrKDb1DMrzBVoqNe6ttSVqc0rk3/9TW36M8Xq4+bhk3xPHESzbs4Gs7CacSrDd45R2yyAVtKpXard9MFZhlIct+ifPcnjszeprtV5IRMgYDQp20uf7ZZBOMVrALgX3o6/pYuLrBHJFCKieNCINJuImajdulMEKCKCaOEAP8BQdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eOhON44xfYpisK+zkP/jxQP7VLHcJ40uRTcOhoZzds=;
 b=mS9yCAKny1ndVFIvrCXF0eavfawkco6MrOGc82ke53D7DUNFndWMEvRck5KUtW1HiBjGIIUcI4IAYn4D7DF5ybxBZdksIMFtHJ0gvclbmN1wBzRPNmpW+LhjzG8aTHnW5PqtxmDGuUFPJGX8fyvRV2RWf0kJFvWRFGSz66Tt/d+vPHEgn+/7/aebMxqH4yJwg0WzJCRnt6rpuWOvy+udvpR7ptUo8TjdJtVdpqBVObbfI+0N23ZPMdi0KWB6SYMEfDXnOdoikm0+9ReDBwV0rFp9MLOjE7sIkMB06ixl0YcIoPJ3Z9QDw70ZfUtBKJ78JnrV1QnXjTdyHyVo+ummUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eOhON44xfYpisK+zkP/jxQP7VLHcJ40uRTcOhoZzds=;
 b=LXH2ECWZW3KneOBeBFb0bDs7iNFPDxWGDxArHzT/mv5mltImDA9VdCgV7VUtZqvAAErByNxpa7rvd7lU2LKDStCLRmXrE44gr5g+dPwHjzqODDmQyC+L47STwL138ukfuQWs9pn3QQaSOgx/2iex9YCx4/8DhgDFFsnBk/jHSM8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5461.eurprd08.prod.outlook.com (2603:10a6:20b:10e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 9 Jun
 2020 14:28:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 14:28:17 +0000
Subject: Re: [PATCH] qcow2: Reduce write_zeroes size in handle_alloc_space()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200609140859.142230-1-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <02e24dca-99da-873d-8425-09a07571e675@virtuozzo.com>
Date: Tue, 9 Jun 2020 17:28:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200609140859.142230-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:207:8::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.180) by
 AM3PR07CA0146.eurprd07.prod.outlook.com (2603:10a6:207:8::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.7 via Frontend Transport; Tue, 9 Jun 2020 14:28:17 +0000
X-Originating-IP: [185.215.60.180]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f23449-6db6-4a2e-03bd-08d80c815a32
X-MS-TrafficTypeDiagnostic: AM7PR08MB5461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5461191987E30386B890898DC1820@AM7PR08MB5461.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pp/mjyVdKnipCpbY7lws8L1C83mdBNtGTh8nEAbX5Cj2SUya73MflV/ILwWV/nOHHLDMtSligHoLlCVulaz/seJpcl2v3WBV3ZdqFBDI8OIbYCHUkNOLvutP29+1/sbWIbSCzJtqbYJtXgYG5THuCBAaQkAfGDgAukohSLcfccahHVHhajTUy7EiZ3ugpX4Z0f7tde7lUZveYO3qIOAQcXsKKx71OV2I93coExM7l2K6PGJmg/b4StZqcklhKPQ1lHKlI98hXEX9piiaQrxoN34eh1sWCpbNguJ8L2axMkzJiwXG7l7lYbCPPO8J5QrGrzkNzqzgTtR6jyDXa0k6iVYAM2w8dffrABp0xBwJcqcla00wj3DTcfKx4TquL3pk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(86362001)(5660300002)(26005)(66476007)(66556008)(83380400001)(36756003)(66946007)(31696002)(956004)(478600001)(316002)(2616005)(52116002)(8676002)(31686004)(8936002)(16526019)(2906002)(4326008)(6486002)(16576012)(107886003)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: U26GVe8ubhVhdsVZKSTekSOwbPQkgbT/eNGTUJHqgAlCsDSgcDZQI+s5ucmRRaEG1jNnIp+VD2bidYw+HY37Ono1GS6tPw7IwvGZEJYx85aS359bUohS9YJPvGkWLNgyHLLVl+qciMx1LEcdeh6agV523lcpjV4G/4tJk6HQFoDwTjHG/bAHE6KbMG14Gye4+6CaTkdd5DZuFDgT7JobAvE7eTA0C0psQl7lwlzEdxoHJyERlprtJp4XCO6DXNz/Yg0PP5uyUrbtPUsXRDIYDyrYldXTnm92zXw5wWYQccC+N5c5DYax5moq/ebiWQ0DsP1pI2uUZBAwPlgjXKLtNSO2bjg6gdT8qBStiG5YAsw/Png/djUEBLqUDcAzg1lWiYW6QXMzTyG3ReucV8Y489zmlR0bnciBis/OMxKcfC5mJKHkm5p+FrflgqPDLN5ByAyojtRhFP2lg6jLCYdmdTt0gQdaeoiVN6C1eitsJ1M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f23449-6db6-4a2e-03bd-08d80c815a32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 14:28:17.7950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9vaMQRBrJmDfdrmB5N5YgKUS3t11nFJiNV8xGyj36viy6Uw9qaY6FYXwFNui6a0i/OT/XTuqyic8geadz02OxLNhRPa4YR1zePEZ5asGkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5461
Received-SPF: pass client-ip=40.107.6.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:28:18
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
Cc: "Denis V. Lunev" <den@openvz.org>, anton.nefedov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.06.2020 17:08, Kevin Wolf wrote:
> Since commit c8bb23cbdbe, handle_alloc_space() is called for newly
> allocated clusters to efficiently initialise the COW areas with zeros if
> necessary. It skips the whole operation if both start_cow nor end_cow
> are empty. However, it requests zeroing the whole request size (possibly
> multiple megabytes) even if only one end of the request actually needs
> this.
> 
> This patch reduces the write_zeroes request size in this case so that we
> don't unnecessarily zero-initialise a region that we're going to
> overwrite immediately.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 0cd2e6757e..77742877fb 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2403,6 +2403,8 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
>       }
>   
>       for (m = l2meta; m != NULL; m = m->next) {
> +        uint64_t start = m->alloc_offset;
> +        uint64_t len = m->nb_clusters * s->cluster_size;
>           int ret;
>   
>           if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
> @@ -2413,21 +2415,25 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
>               continue;
>           }
>   
> +        if (!m->cow_start.nb_bytes) {
> +            start += m->cow_end.offset;
> +            len -= m->cow_end.offset;
> +        } else if (!m->cow_end.nb_bytes) {
> +            len = m->cow_start.nb_bytes;
> +        }
> +

Hmm, I'm afraid, that this may make things worse in some cases, as with one big write-zero request
we preallocate data-region in the protocol file, so we have better locality for the clusters we
are going to write. And, in the same time, with BDRV_REQ_NO_FALLBACK flag write-zero must be
fast anyway (especially in comparison with the following write request).

>           /*
>            * instead of writing zero COW buffers,
>            * efficiently zero out the whole clusters
>            */
>   
> -        ret = qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
> -                                            m->nb_clusters * s->cluster_size,
> -                                            true);
> +        ret = qcow2_pre_write_overlap_check(bs, 0, start, len, true);
>           if (ret < 0) {
>               return ret;
>           }
>   
>           BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
> -        ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
> -                                    m->nb_clusters * s->cluster_size,
> +        ret = bdrv_co_pwrite_zeroes(s->data_file, start, len,
>                                       BDRV_REQ_NO_FALLBACK);
>           if (ret < 0) {
>               if (ret != -ENOTSUP && ret != -EAGAIN) {
> 


-- 
Best regards,
Vladimir

