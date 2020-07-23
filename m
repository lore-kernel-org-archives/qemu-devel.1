Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09464C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F8C206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwZI+FXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F8C206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydx0-0006ci-IM
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jydwJ-0006Bz-0Y
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:19:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45357
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jydwH-0000p7-AA
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595521159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Te7HctBispwAjCY3IbPvsOHbaOTKTc8ujL/tgYMIIn0=;
 b=GwZI+FXmQLuLJYcSFd5p2QZrLgasuqtvlJ3qxHTfWBzIoPZt1EWI/ZlpP/oAs5+cIT+tL9
 bdBZ+keze0dGMVqPu0FaxdeqjAF4xgQ1vMxRjNsln9sMkiOkAfUJU+XkWbcZugwx9inH3a
 CiFBKt3klMIhuWY0gCH9p8b+yEvIRfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-MNzLyiqyOPyJLctr5Sir5w-1; Thu, 23 Jul 2020 12:19:14 -0400
X-MC-Unique: MNzLyiqyOPyJLctr5Sir5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBE958B8E2E;
 Thu, 23 Jul 2020 16:19:12 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-52.ams2.redhat.com
 [10.36.114.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1E75756A5;
 Thu, 23 Jul 2020 16:19:05 +0000 (UTC)
Subject: Re: Possible regression with VGA and resolutions in Windows 10?
To: Aaron Lauterer <a.lauterer@proxmox.com>, qemu-devel <qemu-devel@nongnu.org>
References: <24909a16-be74-7516-b5c5-08bdc743a553@proxmox.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <549596cf-225a-cec3-a8bc-8e87b365a1d7@redhat.com>
Date: Thu, 23 Jul 2020 18:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <24909a16-be74-7516-b5c5-08bdc743a553@proxmox.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/23/20 16:24, Aaron Lauterer wrote:
> Hi all,
> 
> I think we have a regression introduced in commit 0221d73ce6.
> 
> Once I start a Windows 10 VM (build 18363) with `-device VGA` I have
> only the following resolutions to choose from instead of the much longer
> list:
> 
> 1920x1080
> 1024x768
> 800x600
> 
> Linux guests work fine.
> 
> qemu-system-x86_64 \
>   -name windows-resolution-test \
>   -smp '2,sockets=1,cores=2,maxcpus=2' \
>   -nodefaults \
>   -cpu host,+kvm_pv_eoi,+kvm_pv_unhalt \
>   -m 3072 \
>   -device 'piix3-usb-uhci,id=uhci,bus=pci.0,addr=0x1.0x2' \
>   -device 'usb-tablet,id=tablet,bus=uhci.0,port=1' \
>   -device 'VGA,id=vga,vgamem_mb=32,bus=pci.0,addr=0x2' \
>   -device 'virtio-scsi-pci,id=scsihw0,bus=pci.0,addr=0x5' \
>   -drive
> 'file=/dev/zvol/rpool/data/vm-102-disk-0,if=none,id=drive-scsi0,discard=on,format=raw,cache=none,aio=native,detect-zeroes=unmap'
> \
>   -device
> 'scsi-hd,bus=scsihw0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,rotation_rate=1,bootindex=100'
> \
>   -machine pc,accel=kvm
> 
> 
> I have not yet gotten around to bisect the SeaBIOS repository to know
> exactly which commit there is causing it.
> 
> If this is better handled at the SeaBIOS mailing list, let me know.

I'm vaguely reminded of
<http://mid.mail-archive.com/20200625091709.8550-1-kraxel@redhat.com>,
but no promises.

Laszlo


