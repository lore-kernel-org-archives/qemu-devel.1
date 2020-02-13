Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C8C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84D22073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lNYuWKiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84D22073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j29ZD-0001mg-6z
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 03:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j29YT-0000s1-PO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j29YS-0001J4-C4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:09:01 -0500
Received: from mail-eopbgr30095.outbound.protection.outlook.com
 ([40.107.3.95]:9815 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j29YO-0001Ec-71; Thu, 13 Feb 2020 03:08:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig8Z4Url2VKHrhnpGB1IGAUkjogNeaV3rZQZPs7Jd2FJFKggmyfvSW9oZqXMiN9MQx2zeQvJmgZRGT5H2wsiibl2O7P+N3qHwqL2jj7f091ruoNmgClSPAvEcayQI818pc3hPQNO0VJSywexqIegcDFkTnz/VKbzwKVmtKzNPSBMXeta9gMYJMi+rlS9feq+ggqtspLrb+9C1odMrS6iu7Cz9E6ywXTfh3ms2cFVHl5C8bjEcUrs15tBXs7IjjMsSQkY64zPzqJI790olulfQnA3GMoRLZaWQtb2TFjaLdHMrfClchNyqncXMrrFq2dKE4ymtNac92sgjHU8nvKW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVFemo9SaIoHwDBn+mUBtvQelSA7tRs262J01peOn1Q=;
 b=eRZXH3ylRtNwZlkU/6F6l/TX+cPKlyU6x2WNMA/5MSfG9ClwJRSLcb9P4ZxlbPxN3qlrsYdnFKL66UDfBfqmiIsq2p9E9Ojc/cm2TC0jD5bs43IrImJg96wArsL5l7kmIV6MO90sUQ22/1AMQdL1T1bFcHdZmDXoQakwfQsbnnMAmkV8tDJg5SVxYIgR6B+cvCA3lLVBKTaxJM+uZRP++z50lW7yMurC7lZ79cWRkyQIpJULbnMLG2zEvnCaVvJy2SwsAk/oZ7PWB4T+HXVZvINAtK/UE7iB5RBorHV3U0vXJDu26K4O3/8U8tv8kMr53sMBmwxjRTHdoeqHxdAh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVFemo9SaIoHwDBn+mUBtvQelSA7tRs262J01peOn1Q=;
 b=lNYuWKiUX2PQEohY8ieFiyPn9cWP71jQGoIbkutsB0acY+zon6WpqFpIhFa1CxDpuPG1ZBgQDM7nL9nDx0t2t1pKEPvu5/2PTPIxlfAgW0VonDcoDrXsprr6npROVyXVZOfxqClGWq+EfAw9d64W8a9DWdeLYwrPsaHLYSX7cUs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4465.eurprd08.prod.outlook.com (20.179.32.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Thu, 13 Feb 2020 08:08:40 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 08:08:40 +0000
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200211141414.12149-1-dplotnikov@virtuozzo.com>
 <20200212154337.GG432724@stefanha-x1.localdomain>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <f4e65d26-3dac-fbd5-ad63-2d2955ad8d97@virtuozzo.com>
Date: Thu, 13 Feb 2020 11:08:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200212154337.GG432724@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::32)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (178.34.162.46) by
 HE1P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 08:08:38 +0000
X-Originating-IP: [178.34.162.46]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af647553-e1bf-4cac-ea1c-08d7b05bef35
X-MS-TrafficTypeDiagnostic: AM0PR08MB4465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4465F3136609704C4814E8D9CF1A0@AM0PR08MB4465.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(376002)(39850400004)(396003)(189003)(199004)(16526019)(956004)(2616005)(2906002)(4326008)(478600001)(6916009)(36756003)(186003)(31696002)(66556008)(107886003)(86362001)(966005)(66946007)(26005)(6486002)(66476007)(53546011)(8676002)(81156014)(316002)(31686004)(81166006)(6666004)(5660300002)(52116002)(7416002)(16576012)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4465;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjY19HyiDlszv4lHKJcKbDQ/+YlPsThIFns+yMpjMeycE99b7o2CA1WlAKymQ/pEjpjZ8nuTlhPzS3oqp2nq9hq90mkqFJZL9PuisvVYTjgYJ6cE1ESWGkT2/9fAb0jYQ7yboVnep+ZewQLz4pGTh8XTVfy1zmde6dqcrEOpsBzu997Ud+bfjcnUeeln4FAZts/NgkkH8X22ZT+A+LSw60KsBIadZdmrstxX2mwk4JE8IlZEgKFQ7MVakmgeS69G7bbXRAIOji8RUEJgg4fwx359cdkh9UeNaqjO2FU9HPaUiVfnebZNqyg2HPBsmpN25HCY8qsXO9HNu53J1P7EshQsUpXFx0o8mNtTEFiwG8M17B9NnxdtAfBlRYvhwJEZx6vPRlKX4eBf9KLETYbVgE0nQjWdb/AzaH5GRRQ6nq9W6yw754sMHeLViHRvbbfc/QwbqvRq7Qt8FFLwHwKromKFDi/4rtohKLH9caq9PTxMDGlj+ufl5sgpAKbnp6sSIjoSuq945pPXqf/APkrpaQ==
X-MS-Exchange-AntiSpam-MessageData: aG/EJsLtUbP6NQaHsOkKW0tVjZ1tRZFaO3kHlXjfKVdYQ/Nb24WHcrU2t8FYFbpw15nbY3S4S0dtfFc+/i+NJKJhUicMN9l2oM4k3X+RvQgefpdIF/MwAKeUmq8pss+hiufTgtMuoiX+0UrAPl6VFA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af647553-e1bf-4cac-ea1c-08d7b05bef35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:08:40.0893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu6LxOjXMCMClPwdT8LeA8IqLXKgQJTG64hQkOAjbWBuYS3WB/cLG/Nh80hDvgn8DuV4cA4lpWfy9LpeE4isWTnuE7bUzc4QnwHzq0SPz9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4465
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.95
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12.02.2020 18:43, Stefan Hajnoczi wrote:
> On Tue, Feb 11, 2020 at 05:14:14PM +0300, Denis Plotnikov wrote:
>> The goal is to reduce the amount of requests issued by a guest on
>> 1M reads/writes. This rises the performance up to 4% on that kind of
>> disk access pattern.
>>
>> The maximum chunk size to be used for the guest disk accessing is
>> limited with seg_max parameter, which represents the max amount of
>> pices in the scatter-geather list in one guest disk request.
>>
>> Since seg_max is virqueue_size dependent, increasing the virtqueue
>> size increases seg_max, which, in turn, increases the maximum size
>> of data to be read/write from a guest disk.
>>
>> More details in the original problem statment:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>>
>> Suggested-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   hw/block/virtio-blk.c | 4 ++--
>>   hw/core/machine.c     | 2 ++
>>   hw/scsi/virtio-scsi.c | 4 ++--
>>   3 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>> index 09f46ed85f..6df3a7a6df 100644
>> --- a/hw/block/virtio-blk.c
>> +++ b/hw/block/virtio-blk.c
>> @@ -914,7 +914,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>>       memset(&blkcfg, 0, sizeof(blkcfg));
>>       virtio_stq_p(vdev, &blkcfg.capacity, capacity);
>>       virtio_stl_p(vdev, &blkcfg.seg_max,
>> -                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2);
>> +                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 256 - 2);
> This value must not change on older machine types.
Yes, that's true, but ..
> So does this patch
> need to turn seg-max-adjust *on* in hw_compat_4_2 so that old machine
> types get 126 instead of 254?
If we set seg-max-adjust "on" in older machine types, the setups using 
them and having queue_sizes set , for example, 1024 will also set 
seg_max to 1024 - 2 which isn't the expected behavior: older mt didn't 
change seg_max in that case and stuck with 128 - 2.
So, should we, instead, leave the default 128 - 2, for seg_max?

Denis
>
>>       virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>>       virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>>       virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
>> @@ -1272,7 +1272,7 @@ static Property virtio_blk_properties[] = {
>>       DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
>>                       true),
>>       DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
>> -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
>> +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 256),
>>       DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, true),
>>       DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
>>                        IOThread *),
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 2501b540ec..3427d6cf4c 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -28,6 +28,8 @@
>>   #include "hw/mem/nvdimm.h"
>>   
>>   GlobalProperty hw_compat_4_2[] = {
>> +    { "virtio-blk-device", "queue-size", "128"},
>> +    { "virtio-scsi-device", "virtqueue_size", "128"},
>>       { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
>>       { "virtio-blk-device", "seg-max-adjust", "off"},
>>       { "virtio-scsi-device", "seg_max_adjust", "off"},
>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>> index 3b61563609..b38f50a429 100644
>> --- a/hw/scsi/virtio-scsi.c
>> +++ b/hw/scsi/virtio-scsi.c
>> @@ -660,7 +660,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>>   
>>       virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
>>       virtio_stl_p(vdev, &scsiconf->seg_max,
>> -                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 128 - 2);
>> +                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 256 - 2);
>>       virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
>>       virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
>>       virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEvent));
>> @@ -965,7 +965,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
>>   static Property virtio_scsi_properties[] = {
>>       DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues, 1),
>>       DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
>> -                                         parent_obj.conf.virtqueue_size, 128),
>> +                                         parent_obj.conf.virtqueue_size, 256),
>>       DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>>                         parent_obj.conf.seg_max_adjust, true),
>>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
>> -- 
>> 2.17.0
>>
>>


