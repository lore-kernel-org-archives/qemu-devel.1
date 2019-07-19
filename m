Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD3C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 00:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0986321849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 00:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0986321849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoGYH-0008PI-6r
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 20:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60197)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hoGY1-0007zT-TS
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 20:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hoGXy-0006bI-EV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 20:14:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hoGXq-0006Xf-H7; Thu, 18 Jul 2019 20:14:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39286307D974;
 Fri, 19 Jul 2019 00:14:39 +0000 (UTC)
Received: from [10.18.17.203] (dhcp-17-203.bos.redhat.com [10.18.17.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C70060E39;
 Fri, 19 Jul 2019 00:14:38 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>
References: <1563206804-396512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7ee94c65-4ece-21ed-928d-09092bff1f6f@redhat.com>
Date: Thu, 18 Jul 2019 20:14:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563206804-396512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 19 Jul 2019 00:14:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Set read-zeroes on in null block
 driver for Valgrind
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



On 7/15/19 12:06 PM, Andrey Shinkevich wrote:
> The Valgrind tool reports about the uninitialised buffer 'buf'
> instantiated on the stack of the function guess_disk_lchs().
> Pass 'read-zeroes=on' to the null block driver to make it deterministic.
> The output of the tests 051, 186 and 227 now includes the parameter
> 'read-zeroes'. So, the benchmark output files are being changed too.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

CC qemu-block;

Do you have a list of which tests pass cleanly via valgrind and which do
not? At the moment when I try I get a lot of errors from loaded
libraries, so it's hard to sift through.

--js

> ---
> Note:
> The change in the tests 093 and 136 reveals the race condition in chardev.
> The patch "chardev: race condition with tcp_chr_disconnect" has been emailed
> to qemu-devel@nongnu.org on July, 12 of 2019 with the Message ID
> <1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>
> 
>  tests/qemu-iotests/051        |  10 +--
>  tests/qemu-iotests/051.pc.out |  10 +--
>  tests/qemu-iotests/093        |   9 +--
>  tests/qemu-iotests/136        |   1 +
>  tests/qemu-iotests/186        |  20 +++---
>  tests/qemu-iotests/186.out    | 152 +++++++++++++++++++++---------------------
>  tests/qemu-iotests/227        |   4 +-
>  tests/qemu-iotests/227.out    |   4 +-
>  tests/qemu-iotests/238        |   2 +-
>  tests/qemu-iotests/240        |   8 +--
>  10 files changed, 111 insertions(+), 109 deletions(-)
> 
> diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
> index 200660f..ce942a5 100755
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
> index 2d811c1..000557c 100644
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
> index d88fbc1..4b2cac1 100755
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
> index af7ffa4..a46a7b7 100755
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
> index 7e7d45b..5f6b18c 100755
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
> index 716b01a..5b35040 100644
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
> index bdd727a..637d7c3 100755
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
> index e77efaf..3dd3ca5 100644
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
> index 1c0a46f..08bc7e6 100755
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
> index 5be6b9c..f73bc07 100755
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

