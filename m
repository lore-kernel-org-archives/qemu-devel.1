Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0620C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 05:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C697235FD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 05:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5Pb9H6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C697235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLJdm-0005Mu-1L
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 01:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLJcw-0004wu-6l
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 01:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLJcu-0002Xz-Hl
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 01:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600924623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QrjOAfZIB/7FHm8Jh5OnAfU2VOCQAJ06hlsyhhLZzxY=;
 b=Y5Pb9H6qmJHikoCLZ4tQAtY//dWKdddA5uN49NPtJOPE4D2HckPjG+Vn6E6i8SZNXcEh4B
 p9pffp3b7w2DIA2zupSgmvimpGCNQ1MIGL9CTJKUIbN5ApnZQl2xaLuHA4Ao5VZ9NsqipB
 mtvGkXy8DELKHfocaCvaIbIEXVF0yK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-ofJrLAmkN3-LOvU4OZ82Iw-1; Thu, 24 Sep 2020 01:17:01 -0400
X-MC-Unique: ofJrLAmkN3-LOvU4OZ82Iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 592151868426;
 Thu, 24 Sep 2020 05:16:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0848126357;
 Thu, 24 Sep 2020 05:16:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F0E0416E0A; Thu, 24 Sep 2020 07:16:54 +0200 (CEST)
Date: Thu, 24 Sep 2020 07:16:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sai Pavan Boddu <saipava@xilinx.com>
Subject: Re: [PATCH v8 3/7] usb/hcd-xhci: Split pci wrapper for xhci base model
Message-ID: <20200924051654.phuk3bmqjz3v3lxu@sirius.home.kraxel.org>
References: <1600780837-8231-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600780837-8231-4-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200923101428.zilaxig5yi5u45rn@sirius.home.kraxel.org>
 <BY5PR02MB67721C6F6152DBA2AD4E3663CA380@BY5PR02MB6772.namprd02.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB67721C6F6152DBA2AD4E3663CA380@BY5PR02MB6772.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?'Marc-Andr=C3=A9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?utf-8?Q?Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Can you also provide any steps to test vmstate migration ?

Helper script below, run it with something like:

$script -m 4G -vga std \
  -cdrom Fedora-Workstation-Live-x86_64-32-1.6.iso \
  -device qemu-xhci -device usb-tablet

============================ cut here ==============================
#!/bin/bash

# most recent release
src="/usr/local/bin/qemu-system-x86_64" 

# master branch / devel branch
dst="/home/kraxel/projects/qemu/build/default/x86_64-softmmu/qemu-system-x86_64"

# time to wait before migration
sec=60

# vmstate storage
tmp="$(mktemp ${TMPDIR-/var/tmp}/vmstate-XXXXXXXXXXXXXX)"
trap "rm -f $tmp" EXIT

# figure machine type to use
machine=$($src -M help | awk '/default/ { print $1 }')
machine="${machine},vmport=off"
machine="${machine},accel=kvm"

########################################################################

echo "#"
echo "# vmsave (after $sec seconds)"
echo "#"
(
    sleep $sec
    echo "migrate_set_speed 100M"
    echo "migrate exec:cat>$tmp"
    echo "quit"
) |\
$src -nodefaults \
    -monitor stdio \
    -M $machine \
    "$@"

echo "#"
echo "# vmload"
echo "#"
$dst -nodefaults \
    -monitor stdio \
    -incoming "exec:cat $tmp" \
    -M $machine \
    "$@"


