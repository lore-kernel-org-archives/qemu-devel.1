Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A521C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13B920734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 08:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fVdXHGbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13B920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiwGk-0000GN-VY
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 04:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiwFy-0008Gx-JY; Wed, 10 Jun 2020 04:38:46 -0400
Received: from mail-eopbgr40103.outbound.protection.outlook.com
 ([40.107.4.103]:24046 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jiwFw-0006GT-QL; Wed, 10 Jun 2020 04:38:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3GvAo+k8kQniIYru8hrJgALi156NwGx4uDuEq6Eqqj68GBpNOLcebELTUvDkPszAO+kIZsKLtvg7R2+u1V3QSnx6c+eeLPjEkdYmqvGVu+3avFwTDrl99x/wexNjKlE7GULQRxElf9SmRFdNmMVe2AcDwGPIux19jNIuC9NHgTPEXKg0iQsl9Z9Hm9LIoHISWZZA9FLaVSbLNycX2l0gbBj+mlogKd6NVQO10caO2Vs+Kzgj0A2HyI5LV2kE16Bb1lBpdpx1IAwDYCy/GKjWj0t1rn4BFvqLawu626GvrvlfzcDSlwNRJoZC364tZ1i7qJX4niL17Vi58L738i7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RizIPGBcaWp5onlSl3XsqxrwsiAV6Px4vXd76N2wVc=;
 b=MJdCmQVBruy0NRWCYBBTzINqbpM5OpaYj15ARDZ8DMiuk60Rgue+czQFjOiql/ZFyQa78+OQ7r3pfIP8NK3uaz3wil9W+rXaechRmfjCz9zUn0dBuN5FaUDsBVDybeX7xGlJSI7eUoxy/HwJQIrx0EeN8nigOZ+TVSnvQa5kIQn3lXkx7nu7GTgTuHLfv4+MkACRLP0r4cCmJ3E6yzm/K/7Prx+4VrQ4J8ZhhHfOkaJOP5CwWITj2/EGb9l+JhIzVNmIjBTznedGDGJUPTpa1hkhGisw5MZ4BlaJ3lMYlaQ0VRuQPWt3iH7X4fV3n3yOLhtYOMApA6dx+86AXYg0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RizIPGBcaWp5onlSl3XsqxrwsiAV6Px4vXd76N2wVc=;
 b=fVdXHGbvjRpboId3yiF4iqI/SMqkZUsfdiCxzV5h5pQ5f9fSw0UNpN67nKZpYXZuI1ZllTFZvUrZHN5Y70PuTyfzn1hSBb3OYtcY5mG5XnrXJK7/KwxN8jgSBrdJgGdCSxb4pnEUbcHe0eY50QZ5BPMYK0f0WBfu+GkRlWkJNvw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5319.eurprd08.prod.outlook.com (2603:10a6:20b:dc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 08:38:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 08:38:41 +0000
Subject: Re: [PATCH] qcow2: Reduce write_zeroes size in handle_alloc_space()
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200609140859.142230-1-kwolf@redhat.com>
 <02e24dca-99da-873d-8425-09a07571e675@virtuozzo.com>
 <042f0b8f-dd51-acc3-8498-ac9a5532df15@redhat.com>
 <20200609151810.GD11003@linux.fritz.box>
 <177d9401-e040-13bd-2e77-26bfeda4a3d6@virtuozzo.com>
Message-ID: <227358e7-baf1-67b8-e4d4-28786b670f89@virtuozzo.com>
Date: Wed, 10 Jun 2020 11:38:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <177d9401-e040-13bd-2e77-26bfeda4a3d6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR04CA0142.eurprd04.prod.outlook.com (2603:10a6:207::26)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM3PR04CA0142.eurprd04.prod.outlook.com (2603:10a6:207::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 08:38:40 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 946d1253-ac15-4535-7c30-08d80d19adbc
X-MS-TrafficTypeDiagnostic: AM7PR08MB5319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5319972D5A3448CBF41BE83DC1830@AM7PR08MB5319.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGpLru5wBC82zxSH0ER+TYsBif4UX9r2Hi5VdZcVRa424+Ts6qIDgkFUH5q3vWpvyRrbQEn0DQ5LcsJBpJcvXNprZSejRvGEEk7i0zKDE7A8H/sQP7f6N9LmAdQWkqfxII9zxi4uf+Pt/OwGy+4qGaX92avbI4elJLe/pfZ5AOoaxneQb9/1by1WBiV1uvqy7uKXDqiNESze4biBDoC9umUKBTMc6dA7CiXmsZbEFHdR1CHdyDEo83qgiiMqQ48PksW5nzq9vPl9reIk7f0rMI/fOB8dIT0PPie9GM0FjbzJPRqAogXFXyv1/B1sLQ7t/Hs0I/UaBzxMRfFTBfXZc7d9JFIRMHH1AhEJH5eqxkf98XbxEMzyTjjZi+ewVnIz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:ro; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(39840400004)(136003)(346002)(956004)(86362001)(6486002)(83380400001)(26005)(4326008)(31686004)(52116002)(8936002)(2616005)(8676002)(31696002)(66946007)(66476007)(66556008)(186003)(36756003)(16576012)(110136005)(5660300002)(316002)(53546011)(2906002)(16526019)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uZaSGIsHOiDLkoat4OGldmcmZGU+df19TgGV6dhnsgM8Zr4FBXXOkL1xiEG+cgKLcABLWvcqVDA+n+YljdSLa52xVEdeGBlMcPKgeMgvptfvi9K81ld5LNN16cNP7DC629iXxSMSxfDHU2kbu3Ixu3/b/hGHaYhESk/FzRdUh5i6YbVKQGo2odqG7E5UhYBsYpS3pJdqLSVFclKfn+onuW3fbNi97S1FXBPowJZDRua/3DJKpOjTEYOk2eqgiV64It6UR0YA74i+B6EgJwLKdpzyEgNAhOx50gmS651dRKDhK8Y5MqJ0RxRYgSoTrv+i+ygB5QRhzc250musrgszUG63eyyby0aO0XP7GwszokLi7R3JRHQ3PMIVqHORSPfplHqUgVGj82T6Hbch642PcxEvaB2eFTSsLryGaRbwRsJ3Lz/N/tVlsMc1r5rixYV2TKHpRM3iZPRXzKhMymIt5uGp0JWwYT5TmHNQG4rCrkyI0RyCxv6wsU1XspDcW+0C
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946d1253-ac15-4535-7c30-08d80d19adbc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 08:38:41.4344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVDoOaO45De9Xek3AB7qWwuMO2AMOglh87rxRuVz2A8RRZe2h0EWXmif9RLSfR/biKcIG5uAp96HW9O/0txl/hhMUG4qJwkGwWQk+46icvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
Received-SPF: pass client-ip=40.107.4.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 04:38:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.06.2020 18:29, Vladimir Sementsov-Ogievskiy wrote:
> 09.06.2020 18:18, Kevin Wolf wrote:
>> Am 09.06.2020 um 16:46 hat Eric Blake geschrieben:
>>> On 6/9/20 9:28 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> 09.06.2020 17:08, Kevin Wolf wrote:
>>>>> Since commit c8bb23cbdbe, handle_alloc_space() is called for newly
>>>>> allocated clusters to efficiently initialise the COW areas with zeros if
>>>>> necessary. It skips the whole operation if both start_cow nor end_cow
>>>>> are empty. However, it requests zeroing the whole request size (possibly
>>>>> multiple megabytes) even if only one end of the request actually needs
>>>>> this.
>>>>>
>>>>> This patch reduces the write_zeroes request size in this case so that we
>>>>> don't unnecessarily zero-initialise a region that we're going to
>>>>> overwrite immediately.
>>>>>
>>>
>>>>
>>>> Hmm, I'm afraid, that this may make things worse in some cases, as with
>>>> one big write-zero request
>>>> we preallocate data-region in the protocol file, so we have better
>>>> locality for the clusters we
>>>> are going to write. And, in the same time, with BDRV_REQ_NO_FALLBACK
>>>> flag write-zero must be
>>>> fast anyway (especially in comparison with the following write request).
>>>>
>>>>> Â Â Â Â Â Â Â Â Â  /*
>>>>> Â Â Â Â Â Â Â Â Â Â  * instead of writing zero COW buffers,
>>>>> Â Â Â Â Â Â Â Â Â Â  * efficiently zero out the whole clusters
>>>>> Â Â Â Â Â Â Â Â Â Â  */
>>>>> -Â Â Â Â Â Â Â  ret = qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
>>>>> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  m->nb_clusters *
>>>>> s->cluster_size,
>>>>> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  true);
>>>>> +Â Â Â Â Â Â Â  ret = qcow2_pre_write_overlap_check(bs, 0, start, len, true);
>>>>> Â Â Â Â Â Â Â Â Â  if (ret < 0) {
>>>>> Â Â Â Â Â Â Â Â Â Â Â Â Â  return ret;
>>>>> Â Â Â Â Â Â Â Â Â  }
>>>>> Â Â Â Â Â Â Â Â Â  BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
>>>>> -Â Â Â Â Â Â Â  ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
>>>>> -Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  m->nb_clusters * s->cluster_size,
>>>>> +Â Â Â Â Â Â Â  ret = bdrv_co_pwrite_zeroes(s->data_file, start, len,
>>>>> Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â Â  BDRV_REQ_NO_FALLBACK);
>>>
>>> Good point.  If we weren't using BDRV_REQ_NO_FALLBACK, then avoiding a
>>> pre-zero pass over the middle is essential.  But since we are insisting that
>>> the pre-zero pass be fast or else immediately fail, the time spent in
>>> pre-zeroing should not be a concern.  Do you have benchmark numbers stating
>>> otherwise?
>>
>> I stumbled across this behaviour (write_zeros for 2 MB, then overwrite
>> almost everything) in the context of a different bug, and it just didn't
>> make much sense to me. Is there really a file system where fragmentation
>> is introduced by not zeroing the area first and then overwriting it?
>>
>> I'm not insisting on making this change because the behaviour is
>> harmless if odd, but if we think that writing twice to some blocks is an
>> optimisation, maybe we should actually measure and document this.
> 
> Not to same blocks: first we do write-zeroes to the area aligned-up to cluster bound. So it's more probable that the resulting clusters would be contigous on file-system.. With your patch it may be split into two parts. (a bit too theoretical, I'd better prove it by example)
> 
> Also, we (Virtuozzo) have to support some custom distributed fs, where allocation itself is expensive, so the additional benefit of first (larger) write-zero request is that we have one allocation request instead of two (with your patch) or three (if we decide to make two write-zero opersions).

Hmm, Denis Lunev said me that double allocation should not be a problem, as it is happening almost in the same time, fs should handle this. So probably my counter-arguments are wrong. Still, handle_alloc_space() attracts attention often, and some benchmark-tests around it will not hurt.


-- 
Best regards,
Vladimir

