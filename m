Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5ACC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8436C20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="simGy2Yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8436C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyajn-0007qx-L3
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyaj9-00073K-Ab
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iyaj8-0002cG-3b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:21:19 -0500
Received: from mail-vi1eur05on2096.outbound.protection.outlook.com
 ([40.107.21.96]:18336 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iyaj5-0002Xk-8g; Mon, 03 Feb 2020 07:21:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiPWUjSG30FLZkYziGl2QKoSszqtmvHBNkPb1eOF7xMSZtw9LauNLfPpmzSmZAqjKtJE3Z1S2nEyC5jYe0TNg4m+H9k6WUo7v+sWwi66XYH76k34xTuzFsNQsQjj6yZUHFgibnmPJ4c2NlSjpzzGok4+k8RmakP1SqQzxA06UWovY1ut3cLtLc+LCiVSONTwPb4khKdNL3VKyMqFh52ywf3+BADmP+WCcJ9tdjQs531v5HqwNLGiEzrc92K0ko0rEAfJA00KL54CjBwq/qy9YNRQQCDTNT6eu7cREO2swWC4FKmVmnjjRiAj7ySUgvWuSxXm0BIOKHHU/yVzb7jDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yARf1KORb9rkz71/NyEDXutUJaBPAktUMbThvNbcX0I=;
 b=Gdv/aFSE46dpfVvhhqB58pqv6uKu21fuh/dHMFz2LT4DX6inFQxG0ZhcBZkH1YtKlknAAhEFBBEEyALmMaCaENquLtYcLGwAOcvYbmBMYIATCz4Tuq7h0upL1sblBjMs0wprBf6dja/jAp+fiRdSh9az7z4mvn1v+PtiCBf6aBU50/Fis1nwTvwvuddkIUW4sCDnLx7DQLbn49SfotWyfxSihXr/xzYlkrz0PUPlKW+5ZMrHIxdlQ5GJtGXNBNLAcTzCsY9Cg6FgcOEBtdl72RGzIZ/Q8L04yiDcyDh9+UOljksfsIGmnEPh8svBfyZvcz+6DUlFYpmGMPf3T4c8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yARf1KORb9rkz71/NyEDXutUJaBPAktUMbThvNbcX0I=;
 b=simGy2YbHdiWBfPOGiCGkWb/taSgH799qYHcLJI85sVCiFmpCvK1oBo2FzEtuMv+IFdXML2kGM9Vd/jjmeaUI7v9ZFhjjkAFbxYBPDUQWaTDbn/jAILjmsMKFtRQXoO7Y3qML0LvxGCfMkyIYQysrC/wBZoi0E3vpTb9YJQntk0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4579.eurprd08.prod.outlook.com (20.178.82.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 12:21:11 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 12:21:11 +0000
Subject: Re: [PATCH v1 3/4] tests: add virtuqueue size checking to
 virtio_seg_max_adjust test
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-4-dplotnikov@virtuozzo.com>
 <20200130084045-mutt-send-email-mst@kernel.org>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <00816680-8faf-7b0d-ad28-bea373bd250c@virtuozzo.com>
Date: Mon, 3 Feb 2020 15:21:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200130084045-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0802CA0002.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::12) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (46.63.156.34) by
 HE1PR0802CA0002.eurprd08.prod.outlook.com (2603:10a6:3:bd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30 via Frontend Transport; Mon, 3 Feb 2020 12:21:09 +0000
X-Originating-IP: [46.63.156.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc287c6e-64ed-4b7a-1647-08d7a8a38de9
X-MS-TrafficTypeDiagnostic: AM0PR08MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB45794441EE63993C546ED967CF000@AM0PR08MB4579.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(396003)(136003)(39850400004)(199004)(189003)(6916009)(66476007)(6486002)(8676002)(66556008)(8936002)(4326008)(36756003)(107886003)(86362001)(66946007)(31696002)(81156014)(2616005)(81166006)(53546011)(956004)(186003)(2906002)(16526019)(52116002)(7416002)(316002)(16576012)(478600001)(31686004)(26005)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4579;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:3; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTVTar7V4iv4SPx/cIorTB81mX2Nv1jbW92/aL/FnQExEZm9QYSA6FoI5FqyRrr6fs4HV2ezMQerMgtyGJKhabVD471a8noMSzMbb/wyPqjVFcFo+DaNpDMPCP3j9X7s2B8RnkB3iY0r0k/5PHePVzH6SXnz+kI3yExDiVsa5KXW8m0BtRfdwo2BywDJTfkE7RiSYMuXawYEmirMfR3mYioFk0K43bwXHF2EIAbrtglRqP1PdNJRlChWyCRxhAel/HFnSWl6DyrarfVg1julqd6U1eTXqELdZFHzYUBaXX6jdLMtO4fivbKDQmd5T1tqiz1cuH4owY8xQjYtFx1AxMrOTyn1+4ArvozPv48hO8GSbm+hfVBe5NHaMB+masXbiuZHMWzxBX4fUk3Oe9lrXPgofBxPXgZS1SeMC8McNEh+I+mz1vsxJgWPkViMiOYz
X-MS-Exchange-AntiSpam-MessageData: PkCdkDG1uD5mkolgaHjL1LlGaK7ETp/MjBnEl1jeKBxxzHGwf9PgldKXrX/9Ckk4FuBimYczp2laDhnkLg3dHqR2+0FLC7sQsuHt60ZVkeYB3Ms81mOqr2MJgBCkpWlYp6/C0MmHXMQClEca+rVdew==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc287c6e-64ed-4b7a-1647-08d7a8a38de9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 12:21:11.1432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc+A5RQJzs8Wd07iy4J4Hu/C8ZtjLSVGeCGjXFDodhlcVrOqKP4YgVxotznWp3jl6ZScejx2Fs2tWjcSB0oeZ+/4aWSN/QAmdOAs6MlSpLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4579
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.96
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



On 30.01.2020 16:42, Michael S. Tsirkin wrote:
> On Wed, Jan 29, 2020 at 05:07:01PM +0300, Denis Plotnikov wrote:
>> This is due to the change in the default virtqueue_size in the
>> latest machine type to improve guest disks performance.
>>
> Sorry what is due to the change?
>   
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   tests/acceptance/virtio_seg_max_adjust.py | 33 ++++++++++++++---------
>>   1 file changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance/virtio_seg_max_adjust.py
>> index 5458573138..645d69b313 100755
>> --- a/tests/acceptance/virtio_seg_max_adjust.py
>> +++ b/tests/acceptance/virtio_seg_max_adjust.py
>> @@ -27,8 +27,10 @@ from qemu.machine import QEMUMachine
>>   from avocado_qemu import Test
>>   
>>   #list of machine types and virtqueue properties to test
>> -VIRTIO_SCSI_PROPS = {'seg_max_adjust': 'seg_max_adjust'}
>> -VIRTIO_BLK_PROPS = {'seg_max_adjust': 'seg-max-adjust'}
>> +VIRTIO_SCSI_PROPS = {'seg_max_adjust': 'seg_max_adjust',
>> +                     'queue_size': 'virtqueue_size'}
>> +VIRTIO_BLK_PROPS = {'seg_max_adjust': 'seg-max-adjust',
>> +                    'queue_size': 'queue-size'}
>>   
>>   DEV_TYPES = {'virtio-scsi-pci': VIRTIO_SCSI_PROPS,
>>                'virtio-blk-pci': VIRTIO_BLK_PROPS}
>> @@ -40,7 +42,7 @@ VM_DEV_PARAMS = {'virtio-scsi-pci': ['-device', 'virtio-scsi-pci,id=scsi0'],
>>                                       'driver=null-co,id=drive0,if=none']}
>>   
>>   
>> -class VirtioMaxSegSettingsCheck(Test):
>> +class VirtioPramsCheck(Test):
>>       @staticmethod
>>       def make_pattern(props):
>>           pattern_items = ['{0} = \w+'.format(prop) for prop in props]
>> @@ -72,20 +74,24 @@ class VirtioMaxSegSettingsCheck(Test):
>>                   props[p[0]] = p[1]
>>           return query_ok, props, error
>>   
>> -    def check_mt(self, mt, dev_type_name):
>> +    def check_mt(self, mt, expected_props, dev_type_name):
>>           with QEMUMachine(self.qemu_bin) as vm:
>> -            vm.set_machine(mt["name"])
>> +            vm.set_machine(mt)
>>               for s in VM_DEV_PARAMS[dev_type_name]:
>>                   vm.add_args(s)
>>               vm.launch()
>>               query_ok, props, error = self.query_virtqueue(vm, dev_type_name)
>>   
>>           if not query_ok:
>> -            self.fail('machine type {0}: {1}'.format(mt['name'], error))
>> +            self.fail('machine type {0}: {1}'.format(mt, error))
>>   
>>           for prop_name, prop_val in props.items():
>> -            expected_val = mt[prop_name]
>> -            self.assertEqual(expected_val, prop_val)
>> +            expected_val = expected_props[prop_name]
>> +            msg = 'Property value mismatch for (MT: {0}, '\
>> +                  'property name: {1}): expected value: "{2}" '\
>> +                  'actual value: "{3}"'\
>> +                  .format(mt, prop_name, expected_val, prop_val)
>> +            self.assertEqual(expected_val, prop_val, msg)
>
> Looks like an unrelated change, no?
Yep, I'd better split the patches and add the test improvements in the 
separate one.

Denis
>
>>       @staticmethod
>>       def seg_max_adjust_enabled(mt):
>> @@ -120,15 +126,18 @@ class VirtioMaxSegSettingsCheck(Test):
>>   
>>           for dev_type in DEV_TYPES:
>>               # create the list of machine types and their parameters.
>> -            mtypes = list()
>> +            mtypes = dict()
>>               for m in machines:
>>                   if self.seg_max_adjust_enabled(m):
>>                       enabled = 'true'
>> +                    queue_size = '256'
>>                   else:
>>                       enabled = 'false'
>> -                mtypes.append({'name': m,
>> -                               DEV_TYPES[dev_type]['seg_max_adjust']: enabled})
>> +                    queue_size = '128'
>> +                mtypes[m] = {
>> +                    DEV_TYPES[dev_type]['seg_max_adjust']: enabled,
>> +                    DEV_TYPES[dev_type]['queue_size']: queue_size }
>>   
>>               # test each machine type for a device type
>>               for mt in mtypes:
>> -                self.check_mt(mt, dev_type)
>> +                self.check_mt(mt, mtypes[mt], dev_type)
>> -- 
>> 2.17.0


