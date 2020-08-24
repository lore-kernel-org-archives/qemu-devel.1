Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB08BC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACAE20639
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="REYqueYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACAE20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAGet-0004Z5-Pa
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAGeC-000448-JP; Mon, 24 Aug 2020 13:52:44 -0400
Received: from mail-am6eur05on2127.outbound.protection.outlook.com
 ([40.107.22.127]:19937 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kAGe9-0002UH-CI; Mon, 24 Aug 2020 13:52:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drlr+WqLXzhhm3FWDPVJoR6FXPdaM2bSrCs08dCX47G+jZ56RfvdlKO9ZgnYxtZ+QPf7XO+nLNkVYUq1ba9FmwyiTBQmxfkw3ApR2+l1SHEQK92XVnColcHNC23I8g8KMDVeHuZi1vzNr/4/RyWmh++0a6YVWPYk633E8Jr/FDiE6mvjvY4064PCqk3Z2Sl31+CJ1lEYMeXGd6Pw8f5Iv/FVPpoi4PA4SdK21ewjbN7HrGaFO8bPqPmGOtmU7Fcdd4VGIsM84Y6nYWRp4rLoxDXPmQ+2JJRNvjcNbbnuTAAzTcLxX5tmS4vLdAu/aEhYklJhePdveyFITDEfCAPkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPU2Ch9Bxf5FjZsQUTzG/wgJGOHD4RM+cqlN3GEc500=;
 b=ZbsdSXqrLskDcqCF9dKEp38Xx2qEUVo8JdnDsfOEpRrx+F2bjv1UefI3VQNJbDnZyBPtZPBCNWvEkI2FEv9rGRMCmdgU/GGvKH6q7fogJSboYoc1lgRrIQ+colGz814+dtx8L9OxL506BN6+ffOe4c2woEx+r76IMTquNDNfTmw/jw99KyKUDXP3cEY2TXs0slX0JgFjl3UraunOCT9eYqzA/maVjHPocDC6ko2ZSm5C+IDYgbVw/bRrX+YAGOubxdGhMCTQUKqm8BKqT3QuGLwA+8o5W0nmo0YaVeDFv2Da1o7ILzyZMqQKZmkVoHouHYwltwPbxYoS7nG5hJxlcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPU2Ch9Bxf5FjZsQUTzG/wgJGOHD4RM+cqlN3GEc500=;
 b=REYqueYv62fmB8T4FzOJPw6G/sW+NQ68RFEPhmYv0lLjM9o7foNJNrdb08mcX2TnnC1YfiCZgzgF5c2MpuIZ8DQjA9fzNYX9GzdQC1+qWeCSxv1ptyn2hjjLPYO8L0YAzxf+qI55h11d2UkXWtXa8GUlmSWuihUS5bqooV/P48A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 17:52:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 17:52:32 +0000
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
To: qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4e72d12f-0824-cc2c-4f20-be1491d69069@virtuozzo.com>
Date: Mon, 24 Aug 2020 20:52:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200821141123.28538-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0111.eurprd07.prod.outlook.com
 (2603:10a6:207:7::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM3PR07CA0111.eurprd07.prod.outlook.com (2603:10a6:207:7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Mon, 24 Aug 2020 17:52:31 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f6e65d4-53e9-42cb-df9d-08d8485679ce
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495629AF5E51CDFC91522BCC1560@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcDmTzarXCY568DeKuWe4EIN8yf2h3cyZxFeJEZjpxBs+N2cAG0jU5cp8XfeYAXtUh2dC7pP2VysmDfWOJLb8vUsBo6sEW+eOPAkrBom7YPhvEeFGZ4BcgjRpW0uyUVgxpdX+AS9JD1ktUMIaNA2l5/RfhbJnnt9FP4CfpmkE+DWusC6LKgSPI4zKhHHH4Flg6l6hZYibqTwrNT2oKWIRlUzX2j0NZ2LOUXAbr/yjQNDW4d40TVyfg7W61ELnOvd1QT3Fm54Pqw3FIsTdNsN4rnGq79/vGOkuzKlopbt3aJNvp6lLTdmllCRNNdp+ftQwVcA+RPhPWEHlKWfQcwQuC891bfrUv6ae7MHX64pCPH8efjDAWmxnI5314Nz/8yo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39840400004)(36756003)(2906002)(478600001)(8676002)(8936002)(16576012)(66946007)(316002)(66476007)(66556008)(5660300002)(6486002)(16526019)(6916009)(26005)(186003)(31696002)(31686004)(52116002)(86362001)(83380400001)(4326008)(956004)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: F9h9X9w0KQfhIzZTS9S/f189chZAosJNfZIxge79HzhAqjqsyPkWOyDnyT7U7yzXo4QFVkYRnFRreV91jHiqCm+3yOwonV2xjzaCsVK1v1UCm5shkrjNagEy7CaCsZc6o5fHXht12wrZNDnh49SXIQ/XACcgqyQD6DN14bl/NcXyyOY1BWQBdApZLdWH1Nf7tldELjEwqaOfqZCuTCSakzg+Gx3QpxmiaAvhfJ0l3db+7Nv2LWf4Pd60OglHw1jt1ufx8Sc+p/iucGcgZ4hBt+6gZwkr9dkLk70LyQmzJ+yhUrI57esr12IQmHhxsPIhDwoJ1xjin6JAHFfC+/2mVrzEmINy5b0VGFihfiyVb/Imn153JUucQUPD7A6caj5vpeHlfpGghmeg3nqI2BX4lxwq3A/UHjUlD63p5p4wUlQ2/mAvmMnSHMRBwSjsxP82hasP/Z4gtfni5oggHjwADFkNm131sJ3Sx3lZPBia1nCXNAEUkri+lnRO7OKx7bC1IO7nk4WZxmQYIuq9QbakzKYQpEejY2USHxy3yPi1kb81ZSDI5iG4gAhuCgv4Ty3ME3eAeOaJ8MtCPFuLyXhfe+yqeHElwAOMPtLkwb0Y3Ly4CxHX2Fp9Bdn00+XFGsW+q7826mV+6Aq/Sk58CvfolQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6e65d4-53e9-42cb-df9d-08d8485679ce
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 17:52:32.2795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nheSh3DInwc16sa5qJh5/UNBa8cj+jT/pBhn3Wgx7mOUtFqkC1JyXmgupqACpMxhinOa3Mi4xx8VlQlDomo/o8Q5hD5X37cKSE4fHy0tNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.22.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 13:52:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: fam@euphon.net, kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.08.2020 17:11, Vladimir Sementsov-Ogievskiy wrote:
> It's intended to be inserted between format and protocol nodes to
> preallocate additional space (expanding protocol file) on writes
> crossing EOF. It improves performance for file-systems with slow
> allocation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   docs/system/qemu-block-drivers.rst.inc |  26 +++
>   qapi/block-core.json                   |  20 +-
>   block/preallocate.c                    | 291 +++++++++++++++++++++++++
>   block/Makefile.objs                    |   1 +
>   4 files changed, 337 insertions(+), 1 deletion(-)
>   create mode 100644 block/preallocate.c
> 
> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
> index b052a6d14e..5e8a35c571 100644
> --- a/docs/system/qemu-block-drivers.rst.inc
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -952,3 +952,29 @@ on host and see if there are locks held by the QEMU process on the image file.
>   More than one byte could be locked by the QEMU instance, each byte of which
>   reflects a particular permission that is acquired or protected by the running
>   block driver.
> +

[..]

> +
> +static coroutine_fn int preallocate_co_preadv_part(
> +        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> +        QEMUIOVector *qiov, size_t qiov_offset, int flags)
> +{
> +    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
> +                               flags);
> +}
> +
> +static int coroutine_fn preallocate_co_pdiscard(BlockDriverState *bs,
> +                                               int64_t offset, int bytes)
> +{
> +    return bdrv_co_pdiscard(bs->file, offset, bytes);
> +}
> +
> +static bool coroutine_fn do_preallocate(BlockDriverState *bs, int64_t offset,
> +                                       int64_t bytes, bool write_zero)
> +{
> +    BDRVPreallocateState *s = bs->opaque;
> +    int64_t len, start, end;

int64_t old_data_end = s->data_end;

> +
> +    if (!s->active) {
> +        return false;
> +    }
> +
> +    if (s->data_end >= 0) {
> +        s->data_end = MAX(s->data_end,
> +                          QEMU_ALIGN_UP(offset + bytes, BDRV_SECTOR_SIZE));
> +    }
> +
> +    len = bdrv_getlength(bs->file->bs);
> +    if (len < 0) {
> +        return false;

return old_data_end >= 0 && offset >= old_data_end;


And with this small improvement we make the following test 20% faster (ssd, ext4):

./qemu-img create -f qcow2 $img 16G; ./qemu-img bench -c 150000 -d 64 -f qcow2  -s 16k -t none -n -w $img;

(assume additional patch which inserts the filter).

Great! So, preallocation is generally good idea, not only for vstorage.

What about inserting the filter by default?

I'll come tomorrow with more complete test results.



-- 
Best regards,
Vladimir

