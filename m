Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47218C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121AE20708
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAU6PeE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121AE20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnIjA-0001VJ-Au
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnIiP-00010R-IX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:26:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21484
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnIiM-00016H-JM
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592817965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=a9TmWcitpfhowxL2HDk8sG8+UEmxLvSZMw0fUfI8KDQ=;
 b=cAU6PeE6EG5BPJy+qj8pIIOQRIRtNWWK6N6IcJ5KOcQZ3CwAAUQoiCVZtCHam/8UwRsajQ
 seBLNyB2nxhQXwr/ojm/NQ7fvgqQMS+yBROaxfQOlUxK46sjlwG8RVP3CYlFOOaYy9DvKB
 nszqXyVTW/EK2BcPUsO/kyQFLdcKodI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-o48XHx8TMhao_eT7_plw_Q-1; Mon, 22 Jun 2020 05:25:57 -0400
X-MC-Unique: o48XHx8TMhao_eT7_plw_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F25D38005AD;
 Mon, 22 Jun 2020 09:25:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAC145C1BD;
 Mon, 22 Jun 2020 09:25:51 +0000 (UTC)
Subject: Re: make test failure for iotest 267 on qemu-system-sparc64
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>
References: <35510ff8-b301-a3a1-48a6-ae5864007c49@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d6a22c5f-2403-d6c4-da89-02e457ee0174@redhat.com>
Date: Mon, 22 Jun 2020 11:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <35510ff8-b301-a3a1-48a6-ae5864007c49@ilande.co.uk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/03/2020 10.48, Mark Cave-Ayland wrote:
> Hi all,
> 
> After a recent rebase I've started seeing iotest 267 after running "make check" on
> qemu-system-sparc64. The diff output looks similar to this:
> 
> --- /home/build/src/qemu/git/qemu/tests/qemu-iotests/267.out    2020-01-22
> 17:57:54.246650995 +0000
> +++ /home/build/src/qemu/git/qemu/tests/qemu-iotests/267.out.bad        2020-03-07
> 09:25:36.044451658 +0000
> @@ -41,13 +41,7 @@
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none -device
> virtio-blk,drive=none0
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) savevm snap0
> -(qemu) info snapshots
> -List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> -(qemu) loadvm snap0
> -(qemu) quit
> +(qemu) QEMU_PROG: -device virtio-blk,drive=none0: PCI: no slot/function available
> for virtio-blk-pci, all in use or reserved
> 
> The error message here is because the sun4u machine PCI root (default) bus contains
> only 2 PCI bridges and cannot have devices plugged into it directly. An example of
> how to use virtio-blk-pci on qemu-system-sparc64 is shown at
> https://wiki.qemu.org/Documentation/Platforms/SPARC#All_PCI_devices_are_attached_behind_one_of_the_simba_PCI_bridges.
> 
> It seems that all that is missing is a way to specify the bus= parameter for the
> virtio-blk-pci device for this test to work. Can anyone suggest a suitable way to do
> this?

 Hi!

Sorry for the late reply... but better late than never:

I think you likely don't want to change each and every current and
future iotest to contain a "bus=..." parameter - that's not reasonable.
So I see two possibilities to get "make check" working here again:

1) From a user point of view, it would be great if PCI devices could be
used on the sun4u machine also without specifying the "bus=..."
property. Is there a way to convince QEMU to plug PCI devices in a
different bus with free slots in case the root bus is already full? ...
I had a quick look at the sources, but unfortunately I failed to spot
the code that decides which PCI bus should be used in case no "bus=..."
property has been specified, so no clue whether this is feasible or not.

2) Simply change the _require_devices function in
tests/qemu-iotests/common.rc to filter out the virtio and pci devices on
sparc64. Something like this should do the job, I hope:

diff a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -788,6 +788,11 @@ _require_devices()
 {
     available=$($QEMU -M none -device help | \
                 grep ^name | sed -e 's/^name "//' -e 's/".*$//')
+    case "$QEMU_PROG" in
+        *qemu-system-sparc64)
+            available=$(grep -v -i -E 'pci|virtio' <<< $available)
+            ;;
+    esac
     for device
     do
         if ! echo "$available" | grep -q "$device" ; then

 HTH,
  Thomas


