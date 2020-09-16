Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E67C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA763224B2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D+H+PkdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA763224B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaY9-00008z-Jv
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1kIaX4-0007R7-Lv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:43:46 -0400
Received: from mail-eopbgr150137.outbound.protection.outlook.com
 ([40.107.15.137]:37351 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1kIaX0-0003l5-IF
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:43:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn3XRiWBi0dc0XTX3lVtXfFxt1pA/+c9xQR6YMeVjAp1VQkXmgkZdZ1isjKYmC21e44ndqlejVPqIYRK4C0zVONVpvZC40NnAHX96NgY+nSXDSZdI8BTUPUgd5lK77xALQn5qt3K64Ei9fCyZeA33UH/F8C0S9oj2CAJCCoPkimkXtONdOiRCMDhHb+zAVFqsRgpIgFvGOviBdnCv7s0GWSIJ3diFr9IvxwcsFTUs01KjCJ6c6nERMZIJqd49UseK9S/YJh+17G1sm2T+qxcQpDRGTVAB6vVYbkstCj7p92x3gKaljN/FBZQ3zUCtpOCbtTPZtozkLtLOF7KoREJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIvSw2Gn7y9pXLwL2XYTxGPo9+GVJxU9koJMXk9hqvc=;
 b=GAvha1KNIBW22ilvFzVjIfJ5Maoyz6/gCWx/5R6rz/E9P2hjxq5X5Z3WrYDaLa1PzgiiRiNz6JpFqlt6WinZGKKjnCCVO8Y0PhQgzZF9y2MLCBavQynhNJnIsxdjRe5Q2RSKB49mcLW8Ih3yOCUoaEN8HYS5DcgO1EOoq//ExY5S/P4ir9YTfPqubqS+0ENMmmhkSNhhc3nKYanNy8uYKcXtZIYYuXaOuNs+QPbilTZl4VGgiQgVdYNRd2zNCKOz6P22yNhaFDysguUt/W8gpsfbXRAWIThD2Fwu0k/EP2BSTpC7BlQHLVmElHm6XKQRTEDsYrxPKZ7/B0fE/7nQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIvSw2Gn7y9pXLwL2XYTxGPo9+GVJxU9koJMXk9hqvc=;
 b=D+H+PkdR/jHqzAHVLiEnC5/A5aBnb+Qm8sE1VwUIqUlgTlJPPafhI3Eo2M+vHpnl08vUhTITJtFogDxaeEYqjW+ODL2JCn/bW0+HM1Auk/0oHfNlEagb0G+17BDcjVfFud3qOYLpFa4AHPmH7VCaY3eksLTNB7f6AcxR/0CRvhY=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM5PR0801MB1971.eurprd08.prod.outlook.com (2603:10a6:203:45::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 16:43:39 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::751c:fc78:625c:ea34%4]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 16:43:37 +0000
Subject: Re: QEMU 5.0 virtio-blk performance regression with high queue depths
From: "Denis V. Lunev" <den@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20200824134431.GA35623@stefanha-x1.localdomain>
 <CAJSP0QW3xniHzHS=_Ok1D-NuAViHUShCxYs38YDo-YjUxC_+ZA@mail.gmail.com>
 <709da6a3-d158-270b-fb63-43ef65dfe668@virtuozzo.com>
Message-ID: <dd5d6d0f-cc52-d3d5-0bbc-c57dcfef6842@virtuozzo.com>
Date: Wed, 16 Sep 2020 19:43:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <709da6a3-d158-270b-fb63-43ef65dfe668@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0501CA0032.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::42) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0501CA0032.eurprd05.prod.outlook.com (2603:10a6:3:1a::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 16:43:35 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a6006aa-ad66-4257-eb76-08d85a5fa825
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1971:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB19710CB252FF7A8B0F35A31FB6210@AM5PR0801MB1971.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNbsUX8U/m5VMURJ1rsFj44J5zaz9nUqxccjCwW/EExqz1fgL8zl6yqAQkQ7Hlu0lj4N0q1SWMgxUtrNppi1+6ofDhF+h776RBwr+CFE61ubmL9nEDnNQ+XJW4jh4LQujKswUKo+NJ4kAsEYdPREPxIHq1S0+f9Re/SMH20Zteg55pH9P9SfgKHIUs/S/1/8DQB7Dzg60Zq6uDH47o524gL48Rfove5VFxSLXFT33/uY/6j8sH9TiIBkhRCL87dSKRy9fac9ZTZoiSUrTAIXZoGXSiDGqmWUJ2IRrkNaxZ0MLJu1sGa1r3uEK/3p3HhGY3IRuCZwvoVxbE/meUsgkQ2TK+uIxHBWyNf9pnjO+2Y0Z4q9QOX6KwR7qxg9JdBkpivU9R/dt4U2+6Rzt9wRGt9bEV3+dExsaC0BGkXZb9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39830400003)(346002)(136003)(316002)(8936002)(6636002)(16576012)(6486002)(66476007)(66556008)(66946007)(956004)(2616005)(26005)(5660300002)(53546011)(107886003)(31686004)(4326008)(83380400001)(2906002)(186003)(6666004)(8676002)(52116002)(16526019)(478600001)(36756003)(110136005)(86362001)(54906003)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pZYo+ps7dKkOhphXPqKHXRT0ZeyNWKOqHYe27J5FCw/nNYwES2tw6wHiCiY6ywRs/DCW7juMMNzQvaRQS13EMP+aTKgGYLiicBLikZUwq01tm7qmLAlBCHuczZwJYFH+TUqUWxFtyEGJJ7F2PLYB+PAd96GRtm5pq6iQS0yGWqaozIARP1lzBbR/tcd8pw88K/slHSOiVUl193po+5skiXoaZSooGfkndFXSajXpf4AAQNvbE95bmjLzUSNQHnNGalye6HeFI+rbB2SF80uaJKmGldrIoucYCBBnZ13H5CM7Y+O6+/P9D6AyghG5asiNuYYGPZzEgKN/ZyWJ65lrDRpsDJHrwiD6uO+Ns3NPBii/0hKk55LfXIY0wgi4hbl3U6aPYFgTH33gGGbKrut57tRDbKs2FwqjvZEbzZPanWWJThkEk88keBnZb+JOFtCiaOA71vHXjqIT5ULmP6iYDK2L1lhjm8bcNWiHG3WxQRNPUyjqIThPS2ItggWlyWQglMwfrCM3Hh0bv2pRUxAhqH4uB39UFCQKONfso6U1SinPlesj/sKr//i2ti2dWSP9WcgDS4udl+tle8JfuuL8SoQLFWOrXSeGAubMjPPiTB3xmx72avyW0yW3wsjPcxBG/UiXLHlYszfcK72I3uSWPQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6006aa-ad66-4257-eb76-08d85a5fa825
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 16:43:37.5688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo9/4bwy1E5zI5gJi+xf5BQmH8Iwo9YUuokWIquBC2R2v9M6FS1WZLgVzV/ihumE0PPkY105SS5hv7lnw2iyig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1971
Received-SPF: pass client-ip=40.107.15.137; envelope-from=den@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 12:43:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 9/16/20 5:07 PM, Denis V. Lunev wrote:
> On 9/16/20 4:32 PM, Stefan Hajnoczi wrote:
>> On Thu, Aug 27, 2020 at 3:24 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>> Hi Denis,
>>> A performance regression was found after the virtio-blk queue-size
>>> property was increased from 128 to 256 in QEMU 5.0 in commit
>>> c9b7d9ec21dfca716f0bb3b68dee75660d86629c ("virtio: increase virtqueue
>>> size for virtio-scsi and virtio-blk"). I wanted to let you know if case
>>> you have ideas or see something similar.
>> Ping, have you noticed performance regressions after switching to
>> virtio-blk queue-size 256?
> oops, I have missed original letter.
>
> Denis Plotnikov have left the team at the moment.
>
>
>>> Throughput and IOPS of the following fio benchmarks dropped by 30-40%:
>>>
>>>   # mkfs.xfs /dev/vdb
>>>   # mount /dev/vdb /mnt
>>>   # fio --rw=%s --bs=%s --iodepth=64 --runtime=1m --direct=1 --filename=/mnt/%s --name=job1 --ioengine=libaio --thread --group_reporting --numjobs=16 --size=512MB --time_based --output=/tmp/fio_result &> /dev/null
>>>     - rw: read write
>>>     - bs: 4k 64k
>>>
>>> Note that there are 16 threads submitting 64 requests each! The guest
>>> block device queue depth will be maxed out. The virtqueue should be full
>>> most of the time.
>>>
>>> Have you seen regressions after virtio-blk queue-size was increased in
>>> QEMU 5.0?
>>>
>>> Here are the details of the host storage:
>>>
>>>   # mkfs.xfs /dev/sdb # 60GB SSD drive
>>>   # mount /dev/sdb /mnt/test
>>>   # qemu-img create -f qcow2 /mnt/test/storage2.qcow2 40G
>>>
>>> The guest command-line is:
>>>
>>>   # MALLOC_PERTURB_=1 numactl \
>>>     -m 1  /usr/libexec/qemu-kvm \
>>>     -S  \
>>>     -name 'avocado-vt-vm1'  \
>>>     -sandbox on  \
>>>     -machine q35 \
>>>     -device pcie-root-port,id=pcie-root-port-0,multifunction=on,bus=pcie.0,addr=0x1,chassis=1 \
>>>     -device pcie-pci-bridge,id=pcie-pci-bridge-0,addr=0x0,bus=pcie-root-port-0  \
>>>     -nodefaults \
>>>     -device VGA,bus=pcie.0,addr=0x2 \
>>>     -m 4096  \
>>>     -smp 2,maxcpus=2,cores=1,threads=1,dies=1,sockets=2  \
>>>     -cpu 'IvyBridge',+kvm_pv_unhalt \
>>>     -chardev socket,server,id=qmp_id_qmpmonitor1,nowait,path=/var/tmp/avocado_bapfdqao/monitor-qmpmonitor1-20200721-014154-5HJGMjxW  \
>>>     -mon chardev=qmp_id_qmpmonitor1,mode=control \
>>>     -chardev socket,server,id=qmp_id_catch_monitor,nowait,path=/var/tmp/avocado_bapfdqao/monitor-catch_monitor-20200721-014154-5HJGMjxW  \
>>>     -mon chardev=qmp_id_catch_monitor,mode=control \
>>>     -device pvpanic,ioport=0x505,id=id31BN83 \
>>>     -chardev socket,server,id=chardev_serial0,nowait,path=/var/tmp/avocado_bapfdqao/serial-serial0-20200721-014154-5HJGMjxW \
>>>     -device isa-serial,id=serial0,chardev=chardev_serial0  \
>>>     -chardev socket,id=seabioslog_id_20200721-014154-5HJGMjxW,path=/var/tmp/avocado_bapfdqao/seabios-20200721-014154-5HJGMjxW,server,nowait \
>>>     -device isa-debugcon,chardev=seabioslog_id_20200721-014154-5HJGMjxW,iobase=0x402 \
>>>     -device pcie-root-port,id=pcie-root-port-1,port=0x1,addr=0x1.0x1,bus=pcie.0,chassis=2 \
>>>     -device qemu-xhci,id=usb1,bus=pcie-root-port-1,addr=0x0 \
>>>     -device usb-tablet,id=usb-tablet1,bus=usb1.0,port=1 \
>>>     -blockdev node-name=file_image1,driver=file,aio=threads,filename=rootfs.qcow2,cache.direct=on,cache.no-flush=off \
>>>     -blockdev node-name=drive_image1,driver=qcow2,cache.direct=on,cache.no-flush=off,file=file_image1 \
>>>     -device pcie-root-port,id=pcie-root-port-2,port=0x2,addr=0x1.0x2,bus=pcie.0,chassis=3 \
>>>     -device virtio-blk-pci,id=image1,drive=drive_image1,bootindex=0,write-cache=on,bus=pcie-root-port-2,addr=0x0 \
>>>     -blockdev node-name=file_disk1,driver=file,aio=threads,filename=/mnt/test/storage2.qcow2,cache.direct=on,cache.no-flush=off \
>>>     -blockdev node-name=drive_disk1,driver=qcow2,cache.direct=on,cache.no-flush=off,file=file_disk1 \
>>>     -device pcie-root-port,id=pcie-root-port-3,port=0x3,addr=0x1.0x3,bus=pcie.0,chassis=4 \
>>>     -device virtio-blk-pci,id=disk1,drive=drive_disk1,bootindex=1,write-cache=on,bus=pcie-root-port-3,addr=0x0 \
>>>     -device pcie-root-port,id=pcie-root-port-4,port=0x4,addr=0x1.0x4,bus=pcie.0,chassis=5 \
>>>     -device virtio-net-pci,mac=9a:37:37:37:37:4e,id=idBMd7vy,netdev=idLb51aS,bus=pcie-root-port-4,addr=0x0  \
>>>     -netdev tap,id=idLb51aS,fd=14  \
>>>     -vnc :0  \
>>>     -rtc base=utc,clock=host,driftfix=slew  \
>>>     -boot menu=off,order=cdn,once=c,strict=off \
>>>     -enable-kvm \
>>>     -device pcie-root-port,id=pcie_extra_root_port_0,multifunction=on,bus=pcie.0,addr=0x3,chassis=6
> I will make a check today.
>
> Talking about our performance measurements, we have not
> seen ANY performance degradation, especially 30-40%.
> This looking quite strange to me.
>
> Though there is quite important difference. We are always
> using O_DIRECT and 'native' AIO engine.
>
> Den

I have put my hands into this and it looks like you are right. There is
a difference. It is not as significant for me as in your case, but I observe
stable around 10% difference with 128 vs 256 queue size.

I have checked with:
- QEMU 5.1
- Fedora 31 in guest
- qcow2 (64k, 1Mb) and raw image on host
- nocache and both threaded/native IO modes

The test was run on Thinkpad Carbon X1 gen 6 laptop.

For the reference, I have seen 330k IOPS for read
at max which is looking awesome for native and 220k
IOPS for threads.

Den

