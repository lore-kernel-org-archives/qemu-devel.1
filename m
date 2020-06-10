Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4427EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004B62067B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHMnjAV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004B62067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj1fx-0000Wf-98
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 10:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jj1f9-0008L2-7n
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:25:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jj1f7-0005Br-N4
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591799104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8CIxtV1Tg25iXJ85To2ArSrGACimGx9dIZ82s5AYtgs=;
 b=XHMnjAV5ulsjH+lCpdEzr34MKBJb1ZaR2G5x1f5dk09HoXlliLVzGAXQLaS3OCGEvHj/ND
 /ZuSt8mL3QTuHJO8Fm/O+UBhhV71MLdJedOkISoFsXXwuBQgqtGDxjKVmhSk2pctRWPYFV
 WAxs/pHhgWb3mBP5PoWcnsWrG4j2If8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-8xLKYqOMO_WxI-eGVdxqEg-1; Wed, 10 Jun 2020 10:25:02 -0400
X-MC-Unique: 8xLKYqOMO_WxI-eGVdxqEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36F8D1005513;
 Wed, 10 Jun 2020 14:25:01 +0000 (UTC)
Received: from [10.10.117.188] (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB25B7BA19;
 Wed, 10 Jun 2020 14:24:59 +0000 (UTC)
Subject: Re: [PATCH 06/16] fdc: Deprecate configuring floppies with -global
 isa-fdc
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200605145625.2920920-1-armbru@redhat.com>
 <20200605145625.2920920-7-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0e81eced-3cca-d5b1-9b64-b55c3711e9ae@redhat.com>
Date: Wed, 10 Jun 2020 10:24:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605145625.2920920-7-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/5/20 10:56 AM, Markus Armbruster wrote:
> Deprecate
> 
>     -global isa-fdc.driveA=...
>     -global isa-fdc.driveB=...
> 
> in favour of
> 
>     -device floppy,unit=0,drive=...
>     -device floppy,unit=1,drive=...
> 
> Same for the other floppy controller devices.
> 

If you're not aware of any reason for why we need to keep global, then
neither am I.

> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: John Snow <jsnow@redhat.com>

> ---
>  docs/qdev-device-use.txt   | 13 ++++---------
>  docs/system/deprecated.rst | 26 ++++++++++++++++++++++++++
>  hw/block/fdc.c             | 17 +++++++++++++++++
>  tests/qemu-iotests/172.out | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
> index cc53e97dcd..3d781be547 100644
> --- a/docs/qdev-device-use.txt
> +++ b/docs/qdev-device-use.txt
> @@ -104,15 +104,10 @@ The -device argument differs in detail for each type of drive:
>  
>  * if=floppy
>  
> -  -global isa-fdc.driveA=DRIVE-ID
> -  -global isa-fdc.driveB=DRIVE-ID
> +  -device floppy,unit=UNIT,drive=DRIVE-ID
>  
> -  This is -global instead of -device, because the floppy controller is
> -  created automatically, and we want to configure that one, not create
> -  a second one (which isn't possible anyway).
> -
> -  Without any -global isa-fdc,... you get an empty driveA and no
> -  driveB.  You can use -nodefaults to suppress the default driveA, see
> +  Without any -device floppy,... you get an empty unit 0 and no unit
> +  1.  You can use -nodefaults to suppress the default unit 0, see
>    "Default Devices".
>  
>  * if=virtio
> @@ -385,7 +380,7 @@ some DEVNAMEs:
>  
>      default device      suppressing DEVNAMEs
>      CD-ROM              ide-cd, ide-drive, ide-hd, scsi-cd, scsi-hd
> -    isa-fdc's driveA    floppy, isa-fdc
> +    floppy              floppy, isa-fdc
>      parallel            isa-parallel
>      serial              isa-serial
>      VGA                 VGA, cirrus-vga, isa-vga, isa-cirrus-vga,
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index f0061f94aa..9bd11c1e95 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -172,6 +172,32 @@ previously available ``-tb-size`` option.
>  Use ``-display sdl,show-cursor=on`` or
>   ``-display gtk,show-cursor=on`` instead.
>  
> +``Configuring floppies with ``-global``
> +'''''''''''''''''''''''''''''''''''''''
> +
> +Use ``-device floppy,...`` instead:
> +::
> +
> +    -global isa-fdc.driveA=...
> +    -global sysbus-fdc.driveA=...
> +    -global SUNW,fdtwo.drive=...
> +
> +become
> +::
> +
> +    -device floppy,unit=0,drive=...
> +
> +and
> +::
> +
> +    -global isa-fdc.driveB=...
> +    -global sysbus-fdc.driveB=...
> +
> +become
> +::
> +
> +    -device floppy,unit=1,drive=...
> +
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
>  
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 35e734b6fb..4191d5b006 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2525,6 +2525,7 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
>      DeviceState *dev;
>      BlockBackend *blk;
>      Error *local_err = NULL;
> +    const char *fdc_name, *drive_suffix;
>  
>      for (i = 0; i < MAX_FD; i++) {
>          drive = &fdctrl->drives[i];
> @@ -2539,10 +2540,26 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
>              continue;
>          }
>  
> +        fdc_name = object_get_typename(OBJECT(fdc_dev));
> +        drive_suffix = !strcmp(fdc_name, "SUNW,fdtwo") ? "" : i ? "B" : "A";
> +        warn_report("warning: property %s.drive%s is deprecated",
> +                    fdc_name, drive_suffix);
> +        error_printf("Use -device floppy,unit=%d,drive=... instead.\n", i);
> +
>          dev = qdev_new("floppy");
>          qdev_prop_set_uint32(dev, "unit", i);
>          qdev_prop_set_enum(dev, "drive-type", fdctrl->qdev_for_drives[i].type);
>  
> +        /*
> +         * Hack alert: we move the backend from the floppy controller
> +         * device to the floppy device.  We first need to detach the
> +         * controller, or else floppy_create()'s qdev_prop_set_drive()
> +         * will die when it attaches floppy device.  We also need to
> +         * take another reference so that blk_detach_dev() doesn't
> +         * free blk while we still need it.
> +         *
> +         * The hack is probably a bad idea.
> +         */
>          blk_ref(blk);
>          blk_detach_dev(blk, fdc_dev);
>          fdctrl->qdev_for_drives[i].blk = NULL;
> diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
> index ba15a85c88..253f35111d 100644
> --- a/tests/qemu-iotests/172.out
> +++ b/tests/qemu-iotests/172.out
> @@ -383,6 +383,8 @@ sd0: [not inserted]
>  === Using -drive if=none and -global ===
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
> +QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
> +Use -device floppy,unit=0,drive=... instead.
>  
>            dev: isa-fdc, id ""
>              iobase = 1008 (0x3f0)
> @@ -423,6 +425,8 @@ sd0: [not inserted]
>  
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
> +QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
> +Use -device floppy,unit=1,drive=... instead.
>  
>            dev: isa-fdc, id ""
>              iobase = 1008 (0x3f0)
> @@ -463,6 +467,10 @@ sd0: [not inserted]
>  
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -global isa-fdc.driveB=none1
> +QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
> +Use -device floppy,unit=0,drive=... instead.
> +QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
> +Use -device floppy,unit=1,drive=... instead.
>  
>            dev: isa-fdc, id ""
>              iobase = 1008 (0x3f0)
> @@ -661,6 +669,8 @@ sd0: [not inserted]
>  === Mixing -fdX and -global ===
>  
>  Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0
> +QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
> +Use -device floppy,unit=1,drive=... instead.
>  
>            dev: isa-fdc, id ""
>              iobase = 1008 (0x3f0)
> @@ -717,6 +727,8 @@ sd0: [not inserted]
>  
>  
>  Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0
> +QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
> +Use -device floppy,unit=0,drive=... instead.
>  
>            dev: isa-fdc, id ""
>              iobase = 1008 (0x3f0)
> @@ -773,9 +785,13 @@ sd0: [not inserted]
>  
>  
>  Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0
> +QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
> +Use -device floppy,unit=0,drive=... instead.
>  QEMU_PROG: Floppy unit 0 is in use
>  
>  Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0
> +QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
> +Use -device floppy,unit=1,drive=... instead.
>  QEMU_PROG: Floppy unit 1 is in use
>  
>  Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global floppy.drive=none0
> @@ -1177,6 +1193,8 @@ QEMU_PROG: -device floppy,drive=none0,unit=0: Floppy unit 0 is in use
>  === Mixing -global and -device ===
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1
> +QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
> +Use -device floppy,unit=0,drive=... instead.
>  
>            dev: isa-fdc, id ""
>              iobase = 1008 (0x3f0)
> @@ -1233,6 +1251,8 @@ sd0: [not inserted]
>  
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=1
> +QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
> +Use -device floppy,unit=0,drive=... instead.
>  
>            dev: isa-fdc, id ""
>              iobase = 1008 (0x3f0)
> @@ -1289,6 +1309,8 @@ sd0: [not inserted]
>  
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1
> +QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
> +Use -device floppy,unit=1,drive=... instead.
>  
>            dev: isa-fdc, id ""
>              iobase = 1008 (0x3f0)
> @@ -1345,6 +1367,8 @@ sd0: [not inserted]
>  
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=0
> +QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
> +Use -device floppy,unit=1,drive=... instead.
>  
>            dev: isa-fdc, id ""
>              iobase = 1008 (0x3f0)
> @@ -1441,9 +1465,13 @@ sd0: [not inserted]
>  
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveA=none0 -device floppy,drive=none1,unit=0
> +QEMU_PROG: warning: warning: property isa-fdc.driveA is deprecated
> +Use -device floppy,unit=0,drive=... instead.
>  QEMU_PROG: -device floppy,drive=none1,unit=0: Floppy unit 0 is in use
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global isa-fdc.driveB=none0 -device floppy,drive=none1,unit=1
> +QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
> +Use -device floppy,unit=1,drive=... instead.
>  QEMU_PROG: -device floppy,drive=none1,unit=1: Floppy unit 1 is in use
>  
>  Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global floppy.drive=none0 -device floppy,drive=none1,unit=0
> @@ -1512,6 +1540,8 @@ QEMU_PROG: -device floppy,drive=floppy0: Property 'floppy.drive' can't find valu
>  === Too many floppy drives ===
>  
>  Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -drive if=none,file=TEST_DIR/t.qcow2.3 -global isa-fdc.driveB=none0 -device floppy,drive=none1
> +QEMU_PROG: warning: warning: property isa-fdc.driveB is deprecated
> +Use -device floppy,unit=1,drive=... instead.
>  QEMU_PROG: -device floppy,drive=none1: Can't create floppy unit 2, bus supports only 2 units
>  
>  
> 

-- 
—js


