Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358FEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AC020663
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="snqsm36A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AC020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYXh-0000ah-1Y
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1kIYKp-0006lH-Vt
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:23:00 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:26643 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1kIYKl-0004CL-Vd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:22:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNPNYnB1NB5x0vnY355Y8qiJmo7NpaPzL6sEYIzeNDxCgt77LAHh4fuqneWj5dtm7JcypLiUWjO5bwU4SwRpDOFeg+k8XeiMHeuEAJ56y1TYB9j7HvTUgEapy4oWZg141v34Tn99dOJBetTSDXCr3mDiGPqOhG6u/k7GxLLsrqOtm3dkON092bdibTDUFU8/sDH9UlEaqFcrks1OjqaH/70sMeQcFDZ2Cv7aPxOhhDUBZIQXS5maUC/NKA7f3RqWuWvJJ97lfDE7FC52Tj4J5ctTk93wz397+Xo/Mkau6OCljxscOcK5q8943m3j/MSVUv88MVjnQhGt4/mE0ir5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cex55z24UEgkOparqAX2ylZcIvCIcOJo+6qiWZHNdBU=;
 b=A5RI/G/bSjxQUSAkIZhANk745dRqtDR5CoobgQujqTu2yDsh8WjM6FOLBduhHpm5q77lqCCVbHNM6x/t9hOSc/ShvC5OlhmVNOSvyVI+pRZE+ZdNblXOesH4CjK68fmH38dlB4dKwXabjH6INOZp3l6jNhHLepXUL2jPkHXi1+vuVmDLzXw62V2EHmzVHmQl5bUBbOJ61q3T63qAhCHC8q/ur8nWMJMtKZq5IkY5QN9LxDxtW364aaXlI9iHttkvnb3C+fbKoRnLAI97LSfJl940nAjv7xBH73q7ohNcfvz1cHqGW1Bv4Ts+VtV3Qx4D06A7X4FToLk2qsd9lmN/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cex55z24UEgkOparqAX2ylZcIvCIcOJo+6qiWZHNdBU=;
 b=snqsm36AkoGRkRiYN0/m7nLatbchZbnequb4ZzfqtgMUvTZ/MBuEBsESnlql7gTnJR/Y4p6AaoYUrKgxOFdI1baJcLkIsGu73I70mXfsP8JeSjRU9X2lZ+O/zJMa+9Yy74qq1WYR4WugFePx5c/DnPicPHGqHFXtkdx1fXmQNy0=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3031.eurprd08.prod.outlook.com (2603:10a6:209:45::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 14:07:49 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 14:07:49 +0000
Subject: Re: QEMU 5.0 virtio-blk performance regression with high queue depths
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200824134431.GA35623@stefanha-x1.localdomain>
 <CAJSP0QW3xniHzHS=_Ok1D-NuAViHUShCxYs38YDo-YjUxC_+ZA@mail.gmail.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <709da6a3-d158-270b-fb63-43ef65dfe668@virtuozzo.com>
Date: Wed, 16 Sep 2020 17:07:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAJSP0QW3xniHzHS=_Ok1D-NuAViHUShCxYs38YDo-YjUxC_+ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR02CA0116.eurprd02.prod.outlook.com
 (2603:10a6:7:29::45) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR02CA0116.eurprd02.prod.outlook.com (2603:10a6:7:29::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 14:07:48 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 896aba92-4287-4f52-665c-08d85a49e4d8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30319EE24C88F01C1C7FDE47B6210@AM6PR08MB3031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fwwsHCOMPOkVMlEA2pbUlRw8533AOH7rWmDlu9tjAtks2b7FLYqW3DktPhEInfaKXLPLtOpU36JaCICl47lypw36pYp0whLnlHMTTRiL2CAlgr2NpCvbjsmNHb9gT7rxO/i9GAPf3nGQWe3hTncXzyrUQw00YzLz8DyOLPSPc2jAqglKxt2ZxmygnWgWs7fSW4Gvp0aKhRvj/qb9R6VHq1z9sfL5wzMBCG9I2aksXbV9K6MqRDFqABQXeyXcywcS1gSbq6eIErOEk2b6KxWPl+I/mRkUFfOqKy/0FSkCjaClDzZkn4sxW9tQGo9Iddqi/Gabe6TXZs2vx0zMNDgBV+/XQ5rGWlast8BxPgULrOi3Oy/ShRN5yPaJPcLcoqb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(376002)(136003)(54906003)(316002)(8936002)(16526019)(31696002)(86362001)(16576012)(6636002)(8676002)(83380400001)(52116002)(186003)(2906002)(36756003)(5660300002)(66946007)(26005)(110136005)(4326008)(107886003)(53546011)(66556008)(6486002)(956004)(31686004)(478600001)(66476007)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tLfteKqnabBeCh2wpGJ6Q9mwlkzJrctzkZBjMFmeA4+zgGr2bbMOExEJaau9NCNknWHYP85hTCP3MmUCROWOr8Cb/N5wlSNDe4dHuW3QM61s+QrCYBmf69q5jzX99CGoUrulOCg3lqlAfB2zMfhSqxBfBOXh+fjhU3V3zLbk5FHEr0ml1Pdr2rUlJgTt/Ww1OFz6lAEhN3XGG/TxRr5SyF15yxSeOrZ5X/q09iWFC0Ds/Y15YR+bcf5wHm5bDUQOaPaOt6UX8B0cIBnVFcb13NRlKcogT+0OpYXGe3JxBo2l5HB6czc0pWWYbB98mpwUzRI00BOFML2ObsskK9fHQbfuipYBnPf0O10klJvux/ow3YGveFbIpasO8iREbMTCI4EXh0rieO5cqx2r7i7UkA/48gXvi4N/CeqTVawK+5S2DCpPrIQ6iaAnjACDINUinDbwy5I8N9TwGxXzJNOaiwtffmMaVrYhyaAA4wkxUbE4qvXu+J9F7DufgNtHVTWnVfcI+HlLPVrV5dFoz2Jow0XTNNRhWEfHDbo4E/h+J01FBS6DGKBwLbDjKjxkXaIJU0R26NrXhQecDgCwec3HLvvb7/Q8FRYdgnPxMgCiYydpeZEKxUjfyk0KohFSPRAjxIBE8J6y+frSO2TjjeaOmQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896aba92-4287-4f52-665c-08d85a49e4d8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:07:49.3243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqWVpsByTLeC1G5X5xyj6Uu8/Z8lVbIUHMctiR8FVU62ZXoBCVI59gNuYYycSkPJvccGx7nKThY/ygVEREDzAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3031
Received-SPF: pass client-ip=40.107.3.115; envelope-from=den@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 10:22:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_LOW=-0.7,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 4:32 PM, Stefan Hajnoczi wrote:
> On Thu, Aug 27, 2020 at 3:24 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> Hi Denis,
>> A performance regression was found after the virtio-blk queue-size
>> property was increased from 128 to 256 in QEMU 5.0 in commit
>> c9b7d9ec21dfca716f0bb3b68dee75660d86629c ("virtio: increase virtqueue
>> size for virtio-scsi and virtio-blk"). I wanted to let you know if case
>> you have ideas or see something similar.
> Ping, have you noticed performance regressions after switching to
> virtio-blk queue-size 256?
oops, I have missed original letter.

Denis Plotnikov have left the team at the moment.


>> Throughput and IOPS of the following fio benchmarks dropped by 30-40%:
>>
>>   # mkfs.xfs /dev/vdb
>>   # mount /dev/vdb /mnt
>>   # fio --rw=%s --bs=%s --iodepth=64 --runtime=1m --direct=1 --filename=/mnt/%s --name=job1 --ioengine=libaio --thread --group_reporting --numjobs=16 --size=512MB --time_based --output=/tmp/fio_result &> /dev/null
>>     - rw: read write
>>     - bs: 4k 64k
>>
>> Note that there are 16 threads submitting 64 requests each! The guest
>> block device queue depth will be maxed out. The virtqueue should be full
>> most of the time.
>>
>> Have you seen regressions after virtio-blk queue-size was increased in
>> QEMU 5.0?
>>
>> Here are the details of the host storage:
>>
>>   # mkfs.xfs /dev/sdb # 60GB SSD drive
>>   # mount /dev/sdb /mnt/test
>>   # qemu-img create -f qcow2 /mnt/test/storage2.qcow2 40G
>>
>> The guest command-line is:
>>
>>   # MALLOC_PERTURB_=1 numactl \
>>     -m 1  /usr/libexec/qemu-kvm \
>>     -S  \
>>     -name 'avocado-vt-vm1'  \
>>     -sandbox on  \
>>     -machine q35 \
>>     -device pcie-root-port,id=pcie-root-port-0,multifunction=on,bus=pcie.0,addr=0x1,chassis=1 \
>>     -device pcie-pci-bridge,id=pcie-pci-bridge-0,addr=0x0,bus=pcie-root-port-0  \
>>     -nodefaults \
>>     -device VGA,bus=pcie.0,addr=0x2 \
>>     -m 4096  \
>>     -smp 2,maxcpus=2,cores=1,threads=1,dies=1,sockets=2  \
>>     -cpu 'IvyBridge',+kvm_pv_unhalt \
>>     -chardev socket,server,id=qmp_id_qmpmonitor1,nowait,path=/var/tmp/avocado_bapfdqao/monitor-qmpmonitor1-20200721-014154-5HJGMjxW  \
>>     -mon chardev=qmp_id_qmpmonitor1,mode=control \
>>     -chardev socket,server,id=qmp_id_catch_monitor,nowait,path=/var/tmp/avocado_bapfdqao/monitor-catch_monitor-20200721-014154-5HJGMjxW  \
>>     -mon chardev=qmp_id_catch_monitor,mode=control \
>>     -device pvpanic,ioport=0x505,id=id31BN83 \
>>     -chardev socket,server,id=chardev_serial0,nowait,path=/var/tmp/avocado_bapfdqao/serial-serial0-20200721-014154-5HJGMjxW \
>>     -device isa-serial,id=serial0,chardev=chardev_serial0  \
>>     -chardev socket,id=seabioslog_id_20200721-014154-5HJGMjxW,path=/var/tmp/avocado_bapfdqao/seabios-20200721-014154-5HJGMjxW,server,nowait \
>>     -device isa-debugcon,chardev=seabioslog_id_20200721-014154-5HJGMjxW,iobase=0x402 \
>>     -device pcie-root-port,id=pcie-root-port-1,port=0x1,addr=0x1.0x1,bus=pcie.0,chassis=2 \
>>     -device qemu-xhci,id=usb1,bus=pcie-root-port-1,addr=0x0 \
>>     -device usb-tablet,id=usb-tablet1,bus=usb1.0,port=1 \
>>     -blockdev node-name=file_image1,driver=file,aio=threads,filename=rootfs.qcow2,cache.direct=on,cache.no-flush=off \
>>     -blockdev node-name=drive_image1,driver=qcow2,cache.direct=on,cache.no-flush=off,file=file_image1 \
>>     -device pcie-root-port,id=pcie-root-port-2,port=0x2,addr=0x1.0x2,bus=pcie.0,chassis=3 \
>>     -device virtio-blk-pci,id=image1,drive=drive_image1,bootindex=0,write-cache=on,bus=pcie-root-port-2,addr=0x0 \
>>     -blockdev node-name=file_disk1,driver=file,aio=threads,filename=/mnt/test/storage2.qcow2,cache.direct=on,cache.no-flush=off \
>>     -blockdev node-name=drive_disk1,driver=qcow2,cache.direct=on,cache.no-flush=off,file=file_disk1 \
>>     -device pcie-root-port,id=pcie-root-port-3,port=0x3,addr=0x1.0x3,bus=pcie.0,chassis=4 \
>>     -device virtio-blk-pci,id=disk1,drive=drive_disk1,bootindex=1,write-cache=on,bus=pcie-root-port-3,addr=0x0 \
>>     -device pcie-root-port,id=pcie-root-port-4,port=0x4,addr=0x1.0x4,bus=pcie.0,chassis=5 \
>>     -device virtio-net-pci,mac=9a:37:37:37:37:4e,id=idBMd7vy,netdev=idLb51aS,bus=pcie-root-port-4,addr=0x0  \
>>     -netdev tap,id=idLb51aS,fd=14  \
>>     -vnc :0  \
>>     -rtc base=utc,clock=host,driftfix=slew  \
>>     -boot menu=off,order=cdn,once=c,strict=off \
>>     -enable-kvm \
>>     -device pcie-root-port,id=pcie_extra_root_port_0,multifunction=on,bus=pcie.0,addr=0x3,chassis=6
I will make a check today.

Talking about our performance measurements, we have not
seen ANY performance degradation, especially 30-40%.
This looking quite strange to me.

Though there is quite important difference. We are always
using O_DIRECT and 'native' AIO engine.

Den

