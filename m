Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836EFC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504392080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dLfXjKOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504392080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybHx-0000Zk-Is
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iybH1-0008TD-Fk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iybH0-0003AD-6b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:56:19 -0500
Received: from mail-eopbgr30100.outbound.protection.outlook.com
 ([40.107.3.100]:4675 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iybGv-00031N-HP; Mon, 03 Feb 2020 07:56:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1bJgRdiB11AG23LRTZUYL8i5hsGsQKuiMh7DHIQ/UgyrogMVD2+L4SPZTK10x5pGOsDsbiPJiZzoYhC9I6gxoURqr4iCQCe7PUmOHtJLXzAb+qAcBgGSCX+x2xb7vFmCaZ8UNTIO/xJHZw3O+yQIw+CnpvGOjqndcC6DWpgLvsyZlqVglMWBk4ps3VS7mzWL9X1/dfFDJtYWu4cf2lBwEqrNWN7puEs+dh7csQyfseFkbPYk1gkZ4o7T0RSI/4mTGgC8n44t9NiRrT3+Q7CX/D2np+FksTDhC4EiuVfLkJMAkSLdxHFJ8mYArDfUfI7WxZKSVT8wMK/8YCZcoeQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YRyNf1QPqCBry+TSB4b3TpPDtn0G1YK4ZE4u7/9g8Q=;
 b=ijQG5k/URkXxQURTxXuQszrUml6W9uGF0k+KhTxQdEWkw9ZbWnu9dvy6/3OH20YZx5lYvy2BJZR950xN3SQjD+AQUFwMElGY9SCXoRL3fP52C+BSip/aJbRJ035kyTYeuCy2PNooDYBddmGXURSnENjUDhR4cz1kO7nuZmoB32rTvjPgv8HPf8hkOcB2PXz2QaA3xSIALEJ3u+xhhjuYzuwS5WBCOmUAVWjLwkNIDelKsfh767U/yMXlJ+IEt2myqJZT0x/N6jWBwF1NobAIfqzg8nG0vuhvvVBR7XpSo3HkTKODseIJAf6TaGGw/Ckxu5k21BJcO45CyJj8gc+eEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YRyNf1QPqCBry+TSB4b3TpPDtn0G1YK4ZE4u7/9g8Q=;
 b=dLfXjKOzrmtLon9ckzyBKvnpVX9xbLL3K/fZ5rGy3Xc5TXRni5JCCVZjN7iRGd1W4fZYG50RQ1qaGIy1pZy/1HKJwfMKjngSSS7CxUdSBfPO//N3VuKT6Z3vnGdzeg4EU+QYXju8kkXn9VUdBy+M4J3sxdICVnZPtg7RQMe+gEM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5169.eurprd08.prod.outlook.com (10.255.31.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Mon, 3 Feb 2020 12:56:09 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 12:56:09 +0000
Subject: Re: [PATCH v1 1/4] virtio: introduce VIRTQUEUE_DEFUALT_SIZE instead
 of hardcoded constants
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-2-dplotnikov@virtuozzo.com>
 <20200130083800-mutt-send-email-mst@kernel.org>
 <ad737ab5-2931-0a56-20d2-abc2bbf1838a@virtuozzo.com>
 <20200203075041-mutt-send-email-mst@kernel.org>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <beb426a6-207a-c50e-199a-4242483edce0@virtuozzo.com>
Date: Mon, 3 Feb 2020 15:56:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200203075041-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0216.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::16) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (46.63.156.34) by
 HE1PR05CA0216.eurprd05.prod.outlook.com (2603:10a6:3:fa::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Mon, 3 Feb 2020 12:56:07 +0000
X-Originating-IP: [46.63.156.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89db8185-d466-469e-7f5f-08d7a8a8705c
X-MS-TrafficTypeDiagnostic: AM0PR08MB5169:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5169BF9097E86C4B708B2585CF000@AM0PR08MB5169.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(366004)(39850400004)(396003)(189003)(199004)(6486002)(31686004)(16576012)(316002)(31696002)(86362001)(2906002)(52116002)(36756003)(81166006)(478600001)(8676002)(81156014)(8936002)(107886003)(4326008)(66476007)(66946007)(66556008)(7416002)(186003)(53546011)(5660300002)(2616005)(16526019)(26005)(6916009)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5169;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHuVR2va8FDDsHnmTGXQyEJIeDMLOD4bArBeEh5EiTNUqPxThqq6+EQ5fFvQ9qEBFMxUx8Nnl6Ikpggp+kEr1SiuQaNi2Yb1ccAhcYM5wQBvy9vi16ImHhxnptqjag6QHnSOw/+eoZ9WIGEnz/U7vlY+5TpYSleeqc54M8JusGiwndRaQnELGdci579cimuSbo8AO17OdzW2Xv6OX6F79yxwUP+SPhiTwFv8K/kRAl/C8iU2xTiZTuWTNSpq4uPpA9P8VyqeAEpdJVkbneZ9TqeXXPh18NeS4faPhqqE88HUF4XBeIHKp53ZUWxoaZeKAwg+XGTOgn2+q2X7Q1c/TUw1LC8F0D9Pp9OXOrvVEUn+Uuc1w8advupkdkpTvPVoIII3VOSDbqMA+pDCGAyVQZ1p2b0uoYrH5glC0zupWJ+kwpbPg+soEhc3v8ponQC+
X-MS-Exchange-AntiSpam-MessageData: JCQCX9dvN+wGKFOUsW633wsNKsxIPrP1wuvyYBxsKScUU7so0bUWcnwLTs2mFNKIoNtN3r7eSKPmCO5i39gKLtsXdaZecuBz9s8LwCONuVNkMlc98K0xjgaKgr9KL6FRypOW1mc6HiTd/KsBJZ/1IQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89db8185-d466-469e-7f5f-08d7a8a8705c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 12:56:09.0496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43TBGXQ69d6H1rACqwfaol/kjInJgu9+p5+v3gsRoKqNe1aAr97gHHSG3qyyffxtVfPZnyZa254ie0bcYB2LwOTFAhd8c+jig1IC7gAdxZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5169
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.100
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
 ehabkost@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 03.02.2020 15:51, Michael S. Tsirkin wrote:
> On Mon, Feb 03, 2020 at 03:17:07PM +0300, Denis Plotnikov wrote:
>>
>> On 30.01.2020 16:38, Michael S. Tsirkin wrote:
>>> On Wed, Jan 29, 2020 at 05:06:59PM +0300, Denis Plotnikov wrote:
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> I'm not sure what the point is. It's more or less an accident that
>>> these two devices share the queue size, this constance
>>> makes no sense to me.
>> Ok, then let's just make a separate queue length constant for each type.
> it's just a number, I don't think we need a constant here.
> If you feel it needs documentation, add a comment!
I just thought that the meaningful name for the number would be better 
for the code understanding.
Anyway, If doesn't improve anything I'll just change the number and add 
a comment what it means.

Denis
>
>> (Will redo and send in the next series)
>> Thanks!
>>
>> Denis
>>>> ---
>>>>    hw/block/virtio-blk.c      | 6 ++++--
>>>>    hw/scsi/virtio-scsi.c      | 5 +++--
>>>>    include/hw/virtio/virtio.h | 1 +
>>>>    3 files changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>>> index 09f46ed85f..72f935033f 100644
>>>> --- a/hw/block/virtio-blk.c
>>>> +++ b/hw/block/virtio-blk.c
>>>> @@ -914,7 +914,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>>>>        memset(&blkcfg, 0, sizeof(blkcfg));
>>>>        virtio_stq_p(vdev, &blkcfg.capacity, capacity);
>>>>        virtio_stl_p(vdev, &blkcfg.seg_max,
>>>> -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2);
>>>> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 :
>>>> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>>>>        virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>>>>        virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>>>>        virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
>>>> @@ -1272,7 +1273,8 @@ static Property virtio_blk_properties[] = {
>>>>        DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
>>>>                        true),
>>>>        DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
>>>> -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
>>>> +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size,
>>>> +                       VIRTQUEUE_DEFAULT_SIZE),
>>>>        DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, true),
>>>>        DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
>>>>                         IOThread *),
>>>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>>>> index 3b61563609..36f66046ae 100644
>>>> --- a/hw/scsi/virtio-scsi.c
>>>> +++ b/hw/scsi/virtio-scsi.c
>>>> @@ -660,7 +660,8 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>>>>        virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
>>>>        virtio_stl_p(vdev, &scsiconf->seg_max,
>>>> -                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 128 - 2);
>>>> +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 :
>>>> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>>>>        virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
>>>>        virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
>>>>        virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEvent));
>>>> @@ -965,7 +966,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
>>>>    static Property virtio_scsi_properties[] = {
>>>>        DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues, 1),
>>>>        DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
>>>> -                                         parent_obj.conf.virtqueue_size, 128),
>>>> +                       parent_obj.conf.virtqueue_size, VIRTQUEUE_DEFAULT_SIZE),
>>>>        DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>>>>                          parent_obj.conf.seg_max_adjust, true),
>>>>        DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>> index b69d517496..a66ea2368b 100644
>>>> --- a/include/hw/virtio/virtio.h
>>>> +++ b/include/hw/virtio/virtio.h
>>>> @@ -48,6 +48,7 @@ size_t virtio_feature_get_config_size(VirtIOFeature *features,
>>>>    typedef struct VirtQueue VirtQueue;
>>>>    #define VIRTQUEUE_MAX_SIZE 1024
>>>> +#define VIRTQUEUE_DEFAULT_SIZE 128
>>>>    typedef struct VirtQueueElement
>>>>    {
>>>> -- 
>>>> 2.17.0


