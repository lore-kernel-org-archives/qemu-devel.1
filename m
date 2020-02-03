Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9364DC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD452082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KWsxFmGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD452082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyae6-0003z7-JN
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyadF-0003LK-Sn
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyadE-0000d9-9l
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:15:13 -0500
Received: from mail-eopbgr70102.outbound.protection.outlook.com
 ([40.107.7.102]:49411 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iyad9-0000K7-Mj; Mon, 03 Feb 2020 07:15:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnoN+nE9ky3bVPOkunP4IzfK+iE+X1ntN2iTOC8Haf/d7HhDvQ+1Up48TmCJswljS7ZZVSFephRZzSgGM7vf/z5WsTvX5n8m0IP19Pe43IhJZRbD5ymDTM/NvBoxfCNT7F0/RnDovJ34b3XpWSKtl6uhokkkeYQIQVNGpkb/5mtpjrU291AyKw3wBba+r+KdeyPB3Oz3gCz5SOWTFOfKYkBMDDvdl7ySOF1QgiqkQOBUTn8gHDfRmjj2JwTcVvlYnQpT7CHA69eIpd+fVupnHcFh5ef7G+CfsQs6z/6mt1wXq79ZxyPw6YjdFtxhcUXzq9xrlraCYZDSUaZXBKBT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn31jnvcwnGJqdFZGgW/ZjrjvMzobzBIB3gIQ1hkvls=;
 b=iOBtXls4AIowzs1NM7sWS/Fv2hfm9TW8gLMOyFpCBLNcBPOLsn4sFDPeVPtOFpcTFTen5LIrJk06eueSvKTKYmlHBLDnJANbCE6zGp9rCTACnjyOSY9nt8Iadq6N0ImT8CkmbKWhNK6TyzpbicoT+jVS1VwdWWFNnQLFe2eqYOpJ9imkGsMfN8qoP4Fn5//HPIAXtmJmnF4TpYxj5DLK+5VGbtIchXBu5x1PAQPGdQDkdz+3ZRJQmCMyRDPja8CrsQL2rMsPzDbaQtIUdFvh0SKnEerq8SM6UGiXSzEcrSujXJcZ7aSRC0Ih8HNf6o9XJ20w8h1cJLQzOGNqUvvnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn31jnvcwnGJqdFZGgW/ZjrjvMzobzBIB3gIQ1hkvls=;
 b=KWsxFmGZZQ4g0RBcVK+rENVZ7L1z481X5d2xN1mQdojTTewd75N4MCnwEclXuleHj/WMVD/UrFv42MI3v1tdob4TcbdgM+RAQN1rwsosejM7vY0BJwsUFNuYPWfkdwQELwiopT1+xqkUSe0jNLCS0YYps0aG5Eoc2Z2VbmV84Do=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4132.eurprd08.prod.outlook.com (20.178.118.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 12:15:03 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 12:15:03 +0000
Subject: Re: [PATCH v1 1/4] virtio: introduce VIRTQUEUE_DEFUALT_SIZE instead
 of hardcoded constants
To: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-2-dplotnikov@virtuozzo.com>
 <20200129185518.5c7216be.cohuck@redhat.com>
 <20200130145613.GG180311@stefanha-x1.localdomain>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <c1aba50a-dd95-eef1-a9df-0b6b1ae7f6a5@virtuozzo.com>
Date: Mon, 3 Feb 2020 15:15:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200130145613.GG180311@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0195.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::19) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (46.63.156.34) by
 HE1PR05CA0195.eurprd05.prod.outlook.com (2603:10a6:3:f9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Mon, 3 Feb 2020 12:15:02 +0000
X-Originating-IP: [46.63.156.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 814445e3-98a5-4240-4e25-08d7a8a2b2a9
X-MS-TrafficTypeDiagnostic: AM0PR08MB4132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4132FC11A22652D9DD3CC986CF000@AM0PR08MB4132.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(366004)(396003)(136003)(346002)(199004)(189003)(53546011)(2906002)(36756003)(8936002)(31696002)(86362001)(52116002)(8676002)(81156014)(81166006)(16576012)(316002)(4326008)(107886003)(26005)(110136005)(186003)(6486002)(2616005)(956004)(5660300002)(16526019)(31686004)(7416002)(66556008)(478600001)(66476007)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4132;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9A6iR+FC2iWPkJOJuFWxcizri+lfBkEuKgp+zlXEspFuHdjbu15ZWZ/gR+pAXPO4Cqo7d4ygy3v07jAIRhAp7VeDFh2RxLkTpNsbv9/XDoUhO5jR3EDxm6G0rxp2D9mhtmjqFyJLu790V4clk60yt//LwJCGUaC3Fdcz4cFNT1o4lt9nNsOYHGXIo9GZRzETEV6WdK326+DA6wpb6M3ANT0Crp3C9XCDJUnduqNeiNKPdjpaa3gcTNwG1kRdnsd1686lCi8Jm1DWXtO+Wt5orqvt5ABtJmPh2mSU+eiA7ut6lB0UO2FsRTbWE5f4DUvI1QGJ0hXaIp8wtBizR4EviuGG9OFFbW1ZGTXEUidwdroCJo1jz3jtsJPF5s60J4KQLKC2+T4wa7hl9+aSYKg+bYZxaQ+qYa228DXHhj7tJSgT6bk9f1rnRI3klEvZWO9g
X-MS-Exchange-AntiSpam-MessageData: K7UgAqWuZajLNbBBNrl33iG3A+7jvDdNod0LYa7FzitJOf1Fs/wvFXq8mXjC7q7IdSuQVsOSYz4FZegiELr76y0xYxLrB9CdjchcjjAVVICTp5HjvSuJVE+ilyuc8UqanIfaniWvqCFNiRC0j1s6Zg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814445e3-98a5-4240-4e25-08d7a8a2b2a9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 12:15:03.3072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVKuas0VE03AByRqOHSugt84KYeO3gXbe5jmXsjsaAUW3vnz69Gy5xUVHh9SEcltB/orQdJLEXL8uBSEFoHH6LmgMPBVoH+QORceFG5GVjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4132
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.102
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 30.01.2020 17:56, Stefan Hajnoczi wrote:
> On Wed, Jan 29, 2020 at 06:55:18PM +0100, Cornelia Huck wrote:
>> On Wed, 29 Jan 2020 17:06:59 +0300
>> Denis Plotnikov <dplotnikov@virtuozzo.com> wrote:
>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> ---
>>>   hw/block/virtio-blk.c      | 6 ++++--
>>>   hw/scsi/virtio-scsi.c      | 5 +++--
>>>   include/hw/virtio/virtio.h | 1 +
>>>   3 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>> index 09f46ed85f..72f935033f 100644
>>> --- a/hw/block/virtio-blk.c
>>> +++ b/hw/block/virtio-blk.c
>>> @@ -914,7 +914,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>>>       memset(&blkcfg, 0, sizeof(blkcfg));
>>>       virtio_stq_p(vdev, &blkcfg.capacity, capacity);
>>>       virtio_stl_p(vdev, &blkcfg.seg_max,
>>> -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2);
>>> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 :
>>> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>>>       virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>>>       virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>>>       virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
>>> @@ -1272,7 +1273,8 @@ static Property virtio_blk_properties[] = {
>>>       DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
>>>                       true),
>>>       DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
>>> -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
>>> +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size,
>>> +                       VIRTQUEUE_DEFAULT_SIZE),
>>>       DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, true),
>>>       DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
>>>                        IOThread *),
>>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>>> index 3b61563609..36f66046ae 100644
>>> --- a/hw/scsi/virtio-scsi.c
>>> +++ b/hw/scsi/virtio-scsi.c
>>> @@ -660,7 +660,8 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>>>   
>>>       virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
>>>       virtio_stl_p(vdev, &scsiconf->seg_max,
>>> -                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 128 - 2);
>>> +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 :
>>> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>>>       virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
>>>       virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
>>>       virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEvent));
>>> @@ -965,7 +966,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
>>>   static Property virtio_scsi_properties[] = {
>>>       DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues, 1),
>>>       DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
>>> -                                         parent_obj.conf.virtqueue_size, 128),
>>> +                       parent_obj.conf.virtqueue_size, VIRTQUEUE_DEFAULT_SIZE),
>>>       DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>>>                         parent_obj.conf.seg_max_adjust, true),
>>>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>> index b69d517496..a66ea2368b 100644
>>> --- a/include/hw/virtio/virtio.h
>>> +++ b/include/hw/virtio/virtio.h
>>> @@ -48,6 +48,7 @@ size_t virtio_feature_get_config_size(VirtIOFeature *features,
>>>   typedef struct VirtQueue VirtQueue;
>>>   
>>>   #define VIRTQUEUE_MAX_SIZE 1024
>>> +#define VIRTQUEUE_DEFAULT_SIZE 128
>> Going from the header only, this looks like a value that is supposed to
>> be used for every virtqueue... but from the users, this is only for blk
>> and scsi.
>>
>> I don't think adding a default for everything makes sense, even if the
>> same value makes sense for blk and scsi.
> Agreed, this value is too general.  VIRTIO_BLK_VQ_DEFAULT_SIZE and
> VIRTIO_SCSI_VQ_DEFAULT_SIZE would make sense to me.
>
> Stefan
agree, that would be better.
Will redo and resend the series.

Denis


