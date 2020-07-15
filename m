Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DB2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE07B206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE07B206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvf9J-0007Xa-6X
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 07:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jvf8Y-00077w-C2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:59:42 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:62128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jvf8T-0008P6-Gd
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:59:41 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9EF5F74637E;
 Wed, 15 Jul 2020 12:59:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7020874633D; Wed, 15 Jul 2020 12:59:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6EB7A746335;
 Wed, 15 Jul 2020 12:59:22 +0200 (CEST)
Date: Wed, 15 Jul 2020 12:59:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: InfoLibre <1887641@bugs.launchpad.net>
Subject: Re: [Bug 1887641] [NEW] PCI bus not available for hda
In-Reply-To: <159480389351.19763.4894026633511253778.malonedeb@chaenomeles.canonical.com>
Message-ID: <alpine.BSF.2.22.395.2007151255240.29808@zero.eik.bme.hu>
References: <159480389351.19763.4894026633511253778.malonedeb@chaenomeles.canonical.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020, InfoLibre wrote:
> Public bug reported:
>
> I'm trying to boot Mac OS 9.2.2 image in order to install it on a qcow
> disk image. I'm using Linux Mint MATE 20 and QEMU emulator version 4.2.0
> (Debian 1:4.2-3ubuntu6.3). When I boot, I've got this error message and
> boot fails :
>
> $ /usr/bin/qemu-system-ppc -monitor stdio -soundhw hda -k fr -machine 
> accel=tcg -m 512 -cdrom 
> /home/david/Bureau/debian-10.0.0-powerpc-NETINST-1.iso -drive 
> file="/home/david/.aqemu/iMacG3_hard_disk_HDA.img",if=ide,index=0 
> -virtfs 
> local,id=shared_folder_dev_0,path=/home/david/Bureau,security_model=none,mount_tag=shared0 
> -boot order=dc,menu=on -net nic,macaddr=00:a2:6d:80:10:8f,model=rtl8139 
> -net user -net user,smb=/home/david/Bureau -rtc base=localtime -name 
> "Debian + LXDE sur iMac G3" -M mac99
> QEMU 4.2.0 monitor - type 'help' for more information
> (qemu) qemu-system-ppc: PCI bus not available for hda

You have several problems in your command line. For one you have -cdrom 
debian-10.0.0-powerpc-NETINST-1.iso insead of MacOS-9.2.2.iso but your 
problem is the -soundhw hda option. Just remove this as it does not make 
sense to add Intel HDA audio to a Macintosh and it won't work. Sound is 
not currently supported in QEMU for MacOS guest yet, if you want 
experimental build with sound support for running MacOS see forum at 
emaculation.com.

