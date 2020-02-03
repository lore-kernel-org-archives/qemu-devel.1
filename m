Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4FEC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D1B2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QtdWU8de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D1B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyafv-0005J2-NY
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyafG-0004jB-O7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyafF-00031S-HF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:17:18 -0500
Received: from mail-eopbgr140104.outbound.protection.outlook.com
 ([40.107.14.104]:39301 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iyafC-0002vL-VY; Mon, 03 Feb 2020 07:17:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxGQfoP8SAAaHNZ5r8sWJjVgMvAHPH8HtmbsTSq7pfKaliQahphniVfHbL5lnDq/kxKzycay082tg8XSOsTpWbAHpfBincUrnlinKbRLu6sRyxOuWhiEZedJvIEuJYb6KhCIKcZz1VRTk0k2/CLcGRCmhRNiNKHd9c+mi3Dp2ndancwn2FZvylc2UIQmW2lHg8TlB45yXb1maEkL+eQ1aXOCxniPo4crj73dwDTt9l8FB2VBP0Ti/UxLcxSZqCDbaPQ1qIDY7eEKsdFoneTr2k28+UDWlTPXtAGXO6lKCQPOre/bdCwjVha7CWvltFLut+r2E3yr3uCxbATjrUYZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UROMo3X7M240eluFlpmPRGhG+zDafOIlGb6FQw326eo=;
 b=hIXQuw+i2XJq0zFTP56h9dMAIBfnEfm0C7FFWQKsD/yeP1/gO56fDX9lXt1WICjbWUvT8T2fVQ4mmWq9N4FBSmDleiVF/Ib4FmBauAWzudypHGRbXz8cjOppYMtMt4EGVL77jbq+33udlpT8rZzyxwrCrDN5T5mdLHVXpIR79+MMDxZmkgkWw7H6iIRE8vJPspj4fy4BomvMo4W0Me1bJZiCdPoO5dMX4HKm9Tpnlbs4Dw7QEkAtyF4I8XyvK/P2iIIcT52mcUKTWre3g+cZ5IchDzLcNJdLDdwoxXkTjXA4sjFzwQZuA9rvvpcffo/JPVrydlH0TQaSgWE7ahvxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UROMo3X7M240eluFlpmPRGhG+zDafOIlGb6FQw326eo=;
 b=QtdWU8deNAEdljL8MjkWi0WYzKGBjrUu3KQaXg+iFBVHmNBcqssq44ZwZlPHUowZSZLKvrxnGvp5mfMPB5T3s2j3DjPqK6dQNsA1aubsQ65RY66wKv0eNMh0elY2Bcvr4otZqsfmCRXQ9ykPkqsP15LMpElPXQ2eYNt5ifGq2x4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4500.eurprd08.prod.outlook.com (20.179.36.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 12:17:11 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 12:17:11 +0000
Subject: Re: [PATCH v1 1/4] virtio: introduce VIRTQUEUE_DEFUALT_SIZE instead
 of hardcoded constants
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-2-dplotnikov@virtuozzo.com>
 <20200130083800-mutt-send-email-mst@kernel.org>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <ad737ab5-2931-0a56-20d2-abc2bbf1838a@virtuozzo.com>
Date: Mon, 3 Feb 2020 15:17:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200130083800-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR09CA0081.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::25) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (46.63.156.34) by
 HE1PR09CA0081.eurprd09.prod.outlook.com (2603:10a6:7:3d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Mon, 3 Feb 2020 12:17:09 +0000
X-Originating-IP: [46.63.156.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1acdf6c-3119-4b9c-0393-08d7a8a2fe9b
X-MS-TrafficTypeDiagnostic: AM0PR08MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB45001EA3DA03C692BC1D2BB2CF000@AM0PR08MB4500.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(136003)(366004)(396003)(376002)(189003)(199004)(86362001)(26005)(16526019)(186003)(107886003)(6916009)(66556008)(66946007)(66476007)(31686004)(7416002)(2616005)(956004)(36756003)(4326008)(52116002)(8676002)(8936002)(2906002)(316002)(31696002)(16576012)(5660300002)(81166006)(81156014)(53546011)(6486002)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4500;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLyPsIY2mQH7olUSDtQ4yAUUY8GRmEIUO4Yn6u9A0MQaSqfsCPTA61l/hMmlmXB8b7rCWND9LCOq5Wl95PUNY1JXE1k/nekDWLM3tqvC+SLpIy6og3iNK+ckb1lBqptgQs6D9lTFjzgMJnoccCX167l4GE6Kts/QxHtcYy0B6Fzxb5ju118Hy2TYLzK6HfFqAERKF75qR0WKsHjUT/qvzkWI2Jvz4PL7ZkZ70ZQ+jBorr1ElX2onrBG+JDZ8SeXkhqeKJ2tWUFCWVv2mv/ci48Mhp/TE+DUVnjSjDOdECvpJBmcaEtaDW0sA7q5DOFMM/JaLqQnsulR1Ggzs+ryn8CMUs0ZgOdcu44EPlD3VgfqQKwOpuPaoSUW4ibuzyYTh1ngnthN67waZ+alOJD2GJ1DtnvzealBwglwK8MiTfsQR4qvDG/HvMr5ILn0UibNU
X-MS-Exchange-AntiSpam-MessageData: JDU6tCAKf5Be8G+3dS/cHbXlGc8JncLKoE7z3UeNsYOCR4n6WfMcX8ollGfU1VeJ4wJxaxAz+pEV+l1AS10AOPkBwYjTBMegVnfVRnZgegm+aq0tMENOuEozKoKvv4m2ppgEv4aX37ZaOa0YySQsYQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1acdf6c-3119-4b9c-0393-08d7a8a2fe9b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 12:17:10.9772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FbQxdaDyrL4Ja8bxs3r1Ok6lDmkzw7WBbnVsuchWMZIMZGKWdcuxbJeL0w9NtaJszjzahjEq3n6OuHHaTZk19cdwczTQBpj6jS/U7baRd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4500
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.104
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



On 30.01.2020 16:38, Michael S. Tsirkin wrote:
> On Wed, Jan 29, 2020 at 05:06:59PM +0300, Denis Plotnikov wrote:
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>
> I'm not sure what the point is. It's more or less an accident that
> these two devices share the queue size, this constance
> makes no sense to me.
Ok, then let's just make a separate queue length constant for each type.
(Will redo and send in the next series)
Thanks!

Denis
>
>> ---
>>   hw/block/virtio-blk.c      | 6 ++++--
>>   hw/scsi/virtio-scsi.c      | 5 +++--
>>   include/hw/virtio/virtio.h | 1 +
>>   3 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>> index 09f46ed85f..72f935033f 100644
>> --- a/hw/block/virtio-blk.c
>> +++ b/hw/block/virtio-blk.c
>> @@ -914,7 +914,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>>       memset(&blkcfg, 0, sizeof(blkcfg));
>>       virtio_stq_p(vdev, &blkcfg.capacity, capacity);
>>       virtio_stl_p(vdev, &blkcfg.seg_max,
>> -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2);
>> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 :
>> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>>       virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>>       virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>>       virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
>> @@ -1272,7 +1273,8 @@ static Property virtio_blk_properties[] = {
>>       DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
>>                       true),
>>       DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
>> -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
>> +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size,
>> +                       VIRTQUEUE_DEFAULT_SIZE),
>>       DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, true),
>>       DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
>>                        IOThread *),
>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>> index 3b61563609..36f66046ae 100644
>> --- a/hw/scsi/virtio-scsi.c
>> +++ b/hw/scsi/virtio-scsi.c
>> @@ -660,7 +660,8 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>>   
>>       virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
>>       virtio_stl_p(vdev, &scsiconf->seg_max,
>> -                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 128 - 2);
>> +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 :
>> +                                          VIRTQUEUE_DEFAULT_SIZE - 2);
>>       virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
>>       virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
>>       virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEvent));
>> @@ -965,7 +966,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
>>   static Property virtio_scsi_properties[] = {
>>       DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues, 1),
>>       DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
>> -                                         parent_obj.conf.virtqueue_size, 128),
>> +                       parent_obj.conf.virtqueue_size, VIRTQUEUE_DEFAULT_SIZE),
>>       DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>>                         parent_obj.conf.seg_max_adjust, true),
>>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index b69d517496..a66ea2368b 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -48,6 +48,7 @@ size_t virtio_feature_get_config_size(VirtIOFeature *features,
>>   typedef struct VirtQueue VirtQueue;
>>   
>>   #define VIRTQUEUE_MAX_SIZE 1024
>> +#define VIRTQUEUE_DEFAULT_SIZE 128
>>   
>>   typedef struct VirtQueueElement
>>   {
>> -- 
>> 2.17.0


