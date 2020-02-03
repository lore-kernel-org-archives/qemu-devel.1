Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BEDC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C472084E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RRuL79+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C472084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyahF-0006FI-7v
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyagN-0005hC-Ak
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyagL-0004KG-VF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:18:27 -0500
Received: from mail-eopbgr140115.outbound.protection.outlook.com
 ([40.107.14.115]:37538 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iyagF-00045I-2v; Mon, 03 Feb 2020 07:18:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iN8Osiv9NN5Dk6ljEJtydfQF8qv7b3XnsL1jC0ClvnDvreyAKd3Bbj8+2EeLTN3lyuopzjPOAEDxtegIrxaddZ6CozO4kq0rXr2idkh9a9taqPwlfLyqU2c65dqX+pjQTRN/PLP/O/yvrUG7T3mu/M21fSevCCvi3p7XzSzw881AqODFVe5u3GQXmtC39+aRb2L2IMn3UoYMPfVMAGZK8LuNC4SVmMDUiTz5spo6nHu877NGB0/NFDIpYwNrw4cZNBF5qG5quZgGkRL1Bf8FC/5WtuzDoIBs5bWmTFVJPbLCuAx/E6xvrZzOU+39Y4E6+SVk+Qt2KErZ/8o32/grfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9popD9sHmdKxwP8LN1QH5/Za/LeozRtlEeumjesoLs=;
 b=kolw8ylVSPAJD0U5PNO4oquGhCRjniAhLoUFg3djCk0gGb1mBUaPwN7m+et2zmriq8vwne1qnhb8rRuCXB2J0nX77uiaDJZnzvHM0U2U6uhmFMzelr11/+f47BijEQ6+ruYLImP4q/hM+NWoWx3Ner6uy5M2IusV7vhlyOzZ30TUA8YH3KfECFOxue69/L8S2V0LEDDLD82FknBH0sxl1W9NOXT0i941BHHeH1JpPxjM8nAQ6GpRCwO6G4FrstrbJOclaax80JkpXIcG1WGaQ2OZDmW7w92yoPqycyQrZ43spoiB362gexpU8h2YToLbUgxCRXDIYPYmeYaRWQDPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9popD9sHmdKxwP8LN1QH5/Za/LeozRtlEeumjesoLs=;
 b=RRuL79+0bnVYFRnXLltiaTdu3UI8zCXoxjrnkzFGoSqfOkF7Ct61ONhPcP59LZSOCYFnMcQB+2os5I3Z7UyAVjeTBjPRVw7tkCV7tn+Nb31TmHbnqeYGAolI0+f0A8CK7GeFzjaaQlQkvxr7DCS5I96/wFezYjit4Q4xZU1UaL0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4500.eurprd08.prod.outlook.com (20.179.36.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 12:18:14 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 12:18:14 +0000
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
 <20200130084000-mutt-send-email-mst@kernel.org>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <4f866f22-34ea-e70e-4f41-22c10ea610b0@virtuozzo.com>
Date: Mon, 3 Feb 2020 15:18:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200130084000-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR09CA0071.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::15) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (46.63.156.34) by
 HE1PR09CA0071.eurprd09.prod.outlook.com (2603:10a6:7:3d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30 via Frontend Transport; Mon, 3 Feb 2020 12:18:12 +0000
X-Originating-IP: [46.63.156.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16919d63-aa2d-4cf2-ed99-08d7a8a3245b
X-MS-TrafficTypeDiagnostic: AM0PR08MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4500E2AB673B1A037009C382CF000@AM0PR08MB4500.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(366004)(39850400004)(346002)(199004)(189003)(8676002)(8936002)(956004)(2616005)(36756003)(4326008)(52116002)(53546011)(81156014)(81166006)(6486002)(478600001)(316002)(2906002)(31696002)(16576012)(5660300002)(6916009)(107886003)(31686004)(66556008)(66476007)(66946007)(86362001)(966005)(26005)(16526019)(186003)(7416002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4500;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lAKnc81RcATC3vlXtqRFGGYzNwTgJ6SmH34r8QsycynsLuBYsMI36VHYymiGoIOrCBU+w21suy5DNx683FiahT+4egyMk27TSGCZFrnmnwsHhI01giFY6bKxMsJcJIeT/v9b325JjFsPtbxFCgKUWYPHUnD7fEhsZajBdHQtkSm0xRPmS4C/HHxIMraTE6bArYzDNHzCUCA1zP4EUTyaiU84nvid8Yh8YpKCSvOMZehzeNpEuayB6JOGssu69Kq/epgmIRA6IV+CGt3eigExAM233Hf44iiO4kkKs6nSIJnv4ws2SIYoEI3psSaDqZvz+hC+CLasedpOZDgn3JHdrEfyQhI+kIqQV5WKn8dIb+Som3FRd8eeaxGcAHTs54sNZbrpsgZOiR0pUFkysCqEOLrSRu6LBFKI2MnaIg7UkM+2rov1wgNbmpIhAamUO2YFf/tJJ8jXCISbgNo02xCWR/RXdtlAyWEHy7Vvnhxc4mBWabugcy6G6uPmM2vSmVKlaRDVSIwKmBAqQXcwMUZzmQ==
X-MS-Exchange-AntiSpam-MessageData: 97U3Edq8TNni/pEyhzsj7PKlLXfnpuNEvpoOwPoRrvta1eaqvjYoxaRd/Y/4u9WtMg3BOwr9KWyTspspbBepgyYNwq2sUrY3qMXa98Cvx5V+TbEwd2ue2SUQPmsNVNCteTJY4tnSuXdopmW4gUKQ9A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16919d63-aa2d-4cf2-ed99-08d7a8a3245b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 12:18:14.0343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xg3FQmDWME//3Pgz+0v0u9xk06Hf3fnkedZUit8fPQ2tQUTcbJUHX8YC7YvY+W1FYR80SXqvBf2ZMWzMLb91qTFwoX9Oa8FJCK4WsHlLan0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4500
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.115
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



On 30.01.2020 16:40, Michael S. Tsirkin wrote:
> On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
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
>> of data to be read/write from guest disk.
>>
>> More details in the original problem statment:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>>
>> Suggested-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>
> looks good but let's just patch each device separately.
Ok
Denis
>
>> ---
>>   hw/core/machine.c          | 3 +++
>>   include/hw/virtio/virtio.h | 2 +-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 3e288bfceb..8bc401d8b7 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -28,6 +28,9 @@
>>   #include "hw/mem/nvdimm.h"
>>   
>>   GlobalProperty hw_compat_4_2[] = {
>> +    { "virtio-blk-device", "queue-size", "128"},
>> +    { "virtio-scsi-device", "virtqueue_size", "128"},
>> +    { "vhost-blk-device", "virtqueue_size", "128"},
>>       { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
>>       { "virtio-blk-device", "seg-max-adjust", "off"},
>>       { "virtio-scsi-device", "seg_max_adjust", "off"},
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index a66ea2368b..16d540e390 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -48,7 +48,7 @@ size_t virtio_feature_get_config_size(VirtIOFeature *features,
>>   typedef struct VirtQueue VirtQueue;
>>   
>>   #define VIRTQUEUE_MAX_SIZE 1024
>> -#define VIRTQUEUE_DEFAULT_SIZE 128
>> +#define VIRTQUEUE_DEFAULT_SIZE 256
>>   
>>   typedef struct VirtQueueElement
>>   {
>> -- 
>> 2.17.0


