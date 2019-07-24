Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D11FC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C81D21951
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 07:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C81D21951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqBYe-0006b5-AJ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 03:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40554)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <borntraeger@de.ibm.com>) id 1hqBYN-00066W-3U
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1hqBYJ-0001po-As
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:19:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1hqBYJ-0001pP-0t
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 03:19:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6O7DNcA038373
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 03:19:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2txj381pxp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 03:19:05 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Wed, 24 Jul 2019 08:19:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 24 Jul 2019 08:19:01 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6O7J0Gr58327212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2019 07:19:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 268044C052;
 Wed, 24 Jul 2019 07:19:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA7174C04A;
 Wed, 24 Jul 2019 07:18:59 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.116])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2019 07:18:59 +0000 (GMT)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190719134345.23526-1-kwolf@redhat.com>
 <20190719134345.23526-2-kwolf@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date: Wed, 24 Jul 2019 09:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190719134345.23526-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072407-0008-0000-0000-000003004040
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072407-0009-0000-0000-0000226DCF92
Message-Id: <42945b0e-8583-ba6e-16c5-2cdb7595206a@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-24_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240080
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PULL 01/13] iotests: Set read-zeroes on in null
 block driver for Valgrind
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
Cc: peter.maydell@linaro.org, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-devel@nongnu.org, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 19.07.19 15:43, Kevin Wolf wrote:
> From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> 
> The Valgrind tool reports about the uninitialised buffer 'buf'
> instantiated on the stack of the function guess_disk_lchs().
> Pass 'read-zeroes=on' to the null block driver to make it deterministic.
> The output of the tests 051, 186 and 227 now includes the parameter
> 'read-zeroes'. So, the benchmark output files are being changed too.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/051        |  10 +--
>  tests/qemu-iotests/051.pc.out |  10 +--
>  tests/qemu-iotests/093        |   9 +-
[...9


I now get the following on s390.
Seems that you only fixed 051.pc.out but not 051.out

    051      ...        [09:01:49]             ...              051      [1m[31mfail      [0m [09:01:49] [09:01:50]                    output mismatch (see 051.out.bad)
    --- tests/qemu-iotests/051.out	2019-07-09 18:34:26.734654933 +0200
    +++ build/tests/qemu-iotests/051.out.bad	2019-07-24 09:01:50.015024901 +0200
    @@ -149,23 +149,23 @@
     
     === Cache modes ===
     
    -Testing: -drive driver=null-co,cache=none
    +Testing: -drive driver=null-co,read-zeroes=on,cache=none
     QEMU X.Y.Z monitor - type 'help' for more information
     (qemu) quit
     
    -Testing: -drive driver=null-co,cache=directsync
    +Testing: -drive driver=null-co,read-zeroes=on,cache=directsync
     QEMU X.Y.Z monitor - type 'help' for more information
     (qemu) quit
     
    -Testing: -drive driver=null-co,cache=writeback
    +Testing: -drive driver=null-co,read-zeroes=on,cache=writeback
     QEMU X.Y.Z monitor - type 'help' for more information
     (qemu) quit
     
    -Testing: -drive driver=null-co,cache=writethrough
    +Testing: -drive driver=null-co,read-zeroes=on,cache=writethrough
     QEMU X.Y.Z monitor - type 'help' for more information
     (qemu) quit
     
    -Testing: -drive driver=null-co,cache=unsafe
    +Testing: -drive driver=null-co,read-zeroes=on,cache=unsafe
     QEMU X.Y.Z monitor - type 'help' for more information
     (qemu) quit
     

> 
> diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
> index 200660f977..ce942a5444 100755
> --- a/tests/qemu-iotests/051
> +++ b/tests/qemu-iotests/051
> @@ -251,11 +251,11 @@ echo
>  # Cannot use the test image because cache=none might not work on the host FS
>  # Use cdrom so that we won't get errors about missing media
>  
> -run_qemu -drive driver=null-co,cache=none
> -run_qemu -drive driver=null-co,cache=directsync
> -run_qemu -drive driver=null-co,cache=writeback
> -run_qemu -drive driver=null-co,cache=writethrough
> -run_qemu -drive driver=null-co,cache=unsafe
> +run_qemu -drive driver=null-co,read-zeroes=on,cache=none
> +run_qemu -drive driver=null-co,read-zeroes=on,cache=directsync
> +run_qemu -drive driver=null-co,read-zeroes=on,cache=writeback
> +run_qemu -drive driver=null-co,read-zeroes=on,cache=writethrough
> +run_qemu -drive driver=null-co,read-zeroes=on,cache=unsafe
>  run_qemu -drive driver=null-co,cache=invalid_value
>  
>  # Can't test direct=on here because O_DIRECT might not be supported on this FS
> diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
> index 2d811c166c..000557c7c8 100644
> --- a/tests/qemu-iotests/051.pc.out
> +++ b/tests/qemu-iotests/051.pc.out
> @@ -245,23 +245,23 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  
>  === Cache modes ===
>  
> -Testing: -drive driver=null-co,cache=none
> +Testing: -drive driver=null-co,read-zeroes=on,cache=none
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) quit
>  
> -Testing: -drive driver=null-co,cache=directsync
> +Testing: -drive driver=null-co,read-zeroes=on,cache=directsync
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) quit
>  
> -Testing: -drive driver=null-co,cache=writeback
> +Testing: -drive driver=null-co,read-zeroes=on,cache=writeback
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) quit
>  
> -Testing: -drive driver=null-co,cache=writethrough
> +Testing: -drive driver=null-co,read-zeroes=on,cache=writethrough
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) quit
>  
> -Testing: -drive driver=null-co,cache=unsafe
> +Testing: -drive driver=null-co,read-zeroes=on,cache=unsafe
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) quit
>  
> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
> index d88fbc182e..4b2cac1d0c 100755
> --- a/tests/qemu-iotests/093
> +++ b/tests/qemu-iotests/093
> @@ -38,7 +38,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
>      def setUp(self):
>          self.vm = iotests.VM()
>          for i in range(0, self.max_drives):
> -            self.vm.add_drive(self.test_img)
> +            self.vm.add_drive(self.test_img, "file.read-zeroes=on")
>          self.vm.launch()
>  
>      def tearDown(self):
> @@ -273,7 +273,8 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
>      def setUp(self):
>          self.vm = iotests.VM()
>          for i in range(0, self.max_drives):
> -            self.vm.add_drive(self.test_img, "throttling.iops-total=100")
> +            self.vm.add_drive(self.test_img,
> +                              "throttling.iops-total=100,file.read-zeroes=on")
>          self.vm.launch()
>  
>      def tearDown(self):
> @@ -378,10 +379,10 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
>      def test_removable_media(self):
>          # Add a couple of dummy nodes named cd0 and cd1
>          result = self.vm.qmp("blockdev-add", driver="null-aio",
> -                             node_name="cd0")
> +                             read_zeroes=True, node_name="cd0")
>          self.assert_qmp(result, 'return', {})
>          result = self.vm.qmp("blockdev-add", driver="null-aio",
> -                             node_name="cd1")
> +                             read_zeroes=True, node_name="cd1")
>          self.assert_qmp(result, 'return', {})
>  
>          # Attach a CD drive with cd0 inserted
> diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
> index af7ffa4540..a46a7b7630 100755
> --- a/tests/qemu-iotests/136
> +++ b/tests/qemu-iotests/136
> @@ -74,6 +74,7 @@ sector = "%d"
>                            (self.account_invalid and "on" or "off"))
>          drive_args.append("stats-account-failed=%s" %
>                            (self.account_failed and "on" or "off"))
> +        drive_args.append("file.image.read-zeroes=on")
>          self.create_blkdebug_file()
>          self.vm = iotests.VM().add_drive('blkdebug:%s:%s' %
>                                           (blkdebug_file, self.test_img),
> diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
> index 7e7d45babc..5f6b18c150 100755
> --- a/tests/qemu-iotests/186
> +++ b/tests/qemu-iotests/186
> @@ -86,8 +86,8 @@ echo "=== -blockdev/-device=<node-name> ==="
>  echo
>  
>  for dev in $fixed $removable; do
> -    check_info_block -blockdev driver=null-co,node-name=null -device $dev,drive=null
> -    check_info_block -blockdev driver=null-co,node-name=null -device $dev,drive=null,id=qdev_id
> +    check_info_block -blockdev driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=null
> +    check_info_block -blockdev driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=null,id=qdev_id
>  done
>  
>  echo
> @@ -97,7 +97,7 @@ echo
>  # This creates two BlockBackends that will show up in 'info block'!
>  # A monitor-owned one from -drive, and anonymous one from -device
>  for dev in $fixed $removable; do
> -    check_info_block -drive if=none,driver=null-co,node-name=null -device $dev,drive=null,id=qdev_id
> +    check_info_block -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=null,id=qdev_id
>  done
>  
>  echo
> @@ -105,8 +105,8 @@ echo "=== -drive if=none/-device=<bb-name> (with medium) ==="
>  echo
>  
>  for dev in $fixed $removable; do
> -    check_info_block -drive if=none,driver=null-co,node-name=null -device $dev,drive=none0
> -    check_info_block -drive if=none,driver=null-co,node-name=null -device $dev,drive=none0,id=qdev_id
> +    check_info_block -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=none0
> +    check_info_block -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device $dev,drive=none0,id=qdev_id
>  done
>  
>  echo
> @@ -125,15 +125,15 @@ echo "=== -drive if=... ==="
>  echo
>  
>  check_info_block -drive if=floppy
> -check_info_block -drive if=floppy,driver=null-co
> +check_info_block -drive if=floppy,driver=null-co,read-zeroes=on
>  
> -check_info_block -drive if=ide,driver=null-co
> +check_info_block -drive if=ide,driver=null-co,read-zeroes=on
>  check_info_block -drive if=ide,media=cdrom
> -check_info_block -drive if=ide,driver=null-co,media=cdrom
> +check_info_block -drive if=ide,driver=null-co,read-zeroes=on,media=cdrom
>  
> -check_info_block -drive if=virtio,driver=null-co
> +check_info_block -drive if=virtio,driver=null-co,read-zeroes=on
>  
> -check_info_block -drive if=pflash,driver=null-co,size=1M
> +check_info_block -drive if=pflash,driver=null-co,read-zeroes=on,size=1M
>  
>  # success, all done
>  echo "*** done"
> diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
> index 716b01ac3d..5b3504042a 100644
> --- a/tests/qemu-iotests/186.out
> +++ b/tests/qemu-iotests/186.out
> @@ -54,103 +54,103 @@ qdev_id: [not inserted]
>  
>  === -blockdev/-device=<node-name> ===
>  
> -Testing: -blockdev driver=null-co,node-name=null -device ide-hd,drive=null
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device ide-hd,drive=null,id=qdev_id
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device scsi-hd,drive=null
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device scsi-hd,drive=null,id=qdev_id
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device virtio-blk-pci,drive=null
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device floppy,drive=null
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device floppy,drive=null,id=qdev_id
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device ide-cd,drive=null
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device ide-cd,drive=null,id=qdev_id
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device scsi-cd,drive=null
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -blockdev driver=null-co,node-name=null -device scsi-cd,drive=null,id=qdev_id
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": true, "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
> @@ -159,76 +159,76 @@ null: null-co:// (null-co)
>  
>  === -drive if=none/-device=<node-name> ===
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=null,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=null,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=null,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=null,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=null,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=null,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  
> -null: null-co:// (null-co)
> +null: json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
> @@ -237,103 +237,103 @@ null: null-co:// (null-co)
>  
>  === -drive if=none/-device=<bb-name> (with medium) ===
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=none0
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=none0
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device ide-hd,drive=none0,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-hd,drive=none0,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=none0
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=none0
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device scsi-hd,drive=none0,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-hd,drive=none0,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,drive=none0
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=none0
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device virtio-blk-pci,drive=none0,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device virtio-blk-pci,drive=none0,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=none0
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=none0
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device floppy,drive=none0,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device floppy,drive=none0,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=none0
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=none0
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device ide-cd,drive=none0,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device ide-cd,drive=none0,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=none0
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=none0
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=none,driver=null-co,node-name=null -device scsi-cd,drive=none0,id=qdev_id
> +Testing: -drive if=none,driver=null-co,read-zeroes=on,node-name=null -device scsi-cd,drive=none0,id=qdev_id
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -none0 (null): null-co:// (null-co)
> +none0 (null): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      qdev_id
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
> @@ -408,19 +408,19 @@ floppy0: [not inserted]
>      Removable device: not locked, tray closed
>  (qemu) quit
>  
> -Testing: -drive if=floppy,driver=null-co
> +Testing: -drive if=floppy,driver=null-co,read-zeroes=on
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -floppy0 (NODE_NAME): null-co:// (null-co)
> +floppy0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=ide,driver=null-co
> +Testing: -drive if=ide,driver=null-co,read-zeroes=on
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -ide0-hd0 (NODE_NAME): null-co:// (null-co)
> +ide0-hd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
> @@ -433,27 +433,27 @@ ide0-cd0: [not inserted]
>      Removable device: not locked, tray closed
>  (qemu) quit
>  
> -Testing: -drive if=ide,driver=null-co,media=cdrom
> +Testing: -drive if=ide,driver=null-co,read-zeroes=on,media=cdrom
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -ide0-cd0 (NODE_NAME): null-co:// (null-co, read-only)
> +ide0-cd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co, read-only)
>      Attached to:      PATH
>      Removable device: not locked, tray closed
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=virtio,driver=null-co
> +Testing: -drive if=virtio,driver=null-co,read-zeroes=on
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -virtio0 (NODE_NAME): null-co:// (null-co)
> +virtio0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
>  
> -Testing: -drive if=pflash,driver=null-co,size=1M
> +Testing: -drive if=pflash,driver=null-co,read-zeroes=on,size=1M
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) info block
> -pflash0 (NODE_NAME): json:{"driver": "null-co", "size": "1M"} (null-co)
> +pflash0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co", "size": "1M"} (null-co)
>      Attached to:      PATH
>      Cache mode:       writeback
>  (qemu) quit
> diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
> index bdd727a721..637d7c3726 100755
> --- a/tests/qemu-iotests/227
> +++ b/tests/qemu-iotests/227
> @@ -57,7 +57,7 @@ echo
>  echo '=== blockstats with -drive if=virtio ==='
>  echo
>  
> -run_qemu -drive driver=null-co,if=virtio <<EOF
> +run_qemu -drive driver=null-co,read-zeroes=on,if=virtio <<EOF
>  { "execute": "qmp_capabilities" }
>  { "execute": "query-blockstats"}
>  { "execute": "quit" }
> @@ -87,7 +87,7 @@ echo
>  echo '=== blockstats with -blockdev and -device ==='
>  echo
>  
> -run_qemu -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,id=virtio0 <<EOF
> +run_qemu -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk,drive=null,id=virtio0 <<EOF
>  { "execute": "qmp_capabilities" }
>  { "execute": "query-blockstats"}
>  { "execute": "quit" }
> diff --git a/tests/qemu-iotests/227.out b/tests/qemu-iotests/227.out
> index e77efaf4cf..3dd3ca5708 100644
> --- a/tests/qemu-iotests/227.out
> +++ b/tests/qemu-iotests/227.out
> @@ -2,7 +2,7 @@ QA output created by 227
>  
>  === blockstats with -drive if=virtio ===
>  
> -Testing: -drive driver=null-co,if=virtio
> +Testing: -drive driver=null-co,read-zeroes=on,if=virtio
>  {
>      QMP_VERSION
>  }
> @@ -150,7 +150,7 @@ Testing: -blockdev driver=null-co,node-name=null
>  
>  === blockstats with -blockdev and -device ===
>  
> -Testing: -blockdev driver=null-co,node-name=null -device virtio-blk,drive=null,id=virtio0
> +Testing: -blockdev driver=null-co,read-zeroes=on,node-name=null -device virtio-blk,drive=null,id=virtio0
>  {
>      QMP_VERSION
>  }
> diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
> index 1c0a46fa90..08bc7e6b4b 100755
> --- a/tests/qemu-iotests/238
> +++ b/tests/qemu-iotests/238
> @@ -31,7 +31,7 @@ else:
>  vm = iotests.VM()
>  vm.launch()
>  
> -log(vm.qmp('blockdev-add', node_name='hd0', driver='null-co'))
> +log(vm.qmp('blockdev-add', node_name='hd0', driver='null-co', read_zeroes=True))
>  log(vm.qmp('object-add', qom_type='iothread', id='iothread0'))
>  log(vm.qmp('device_add', id='scsi0', driver=virtio_scsi_device, iothread='iothread0'))
>  log(vm.qmp('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0'))
> diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
> index 5be6b9c0f7..f73bc07d80 100755
> --- a/tests/qemu-iotests/240
> +++ b/tests/qemu-iotests/240
> @@ -76,7 +76,7 @@ echo
>  
>  run_qemu <<EOF
>  { "execute": "qmp_capabilities" }
> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0"}}
> +{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0"}}
>  { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
>  { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
>  { "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
> @@ -94,7 +94,7 @@ echo
>  
>  run_qemu <<EOF
>  { "execute": "qmp_capabilities" }
> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
> +{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
>  { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
>  { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
>  { "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
> @@ -112,7 +112,7 @@ echo
>  
>  run_qemu <<EOF
>  { "execute": "qmp_capabilities" }
> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
> +{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
>  { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
>  { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread1"}}
>  { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
> @@ -134,7 +134,7 @@ echo
>  
>  run_qemu <<EOF
>  { "execute": "qmp_capabilities" }
> -{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
> +{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
>  { "execute": "nbd-server-start", "arguments": {"addr":{"type":"unix","data":{"path":"$TEST_DIR/nbd"}}}}
>  { "execute": "nbd-server-add", "arguments": {"device":"hd0"}}
>  { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> 


