Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2FBC2D0F8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CEC20731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 21:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="mAza9aOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CEC20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYcnU-0007Ur-Ju
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 17:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jYcmQ-0006fN-BZ; Tue, 12 May 2020 17:49:38 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:55772 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jYcmP-0005X5-47; Tue, 12 May 2020 17:49:37 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 82C5641291;
 Tue, 12 May 2020 21:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1589320170; x=1591134571; bh=14sBeVGLUfQ6Kq71xw8hTO
 dV0zWmxwoF6fx6XUUjyRY=; b=mAza9aOJMiKQ8gnzHRq6C1wCRikhwmtYcV7xRM
 XoKZSWUTD4y1+msh5pEKGWsFkJvtUPHKB33mmkJZJa4z29V6QDQRNIkwaFC+n0JT
 SzN0ey8lvPE7AqyVdPEqL13o5s138ox8GV6v7rdpIpQ4pOZVFy0tDwEKxd77795H
 dqOt4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i2LZIXTbqgB3; Wed, 13 May 2020 00:49:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 9581641275;
 Wed, 13 May 2020 00:49:29 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 13
 May 2020 00:49:31 +0300
Date: Wed, 13 May 2020 00:49:30 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: QEMU + HVF Fails to start OVMF.fd (hang before displaying logo)
Message-ID: <20200512214930.GE98158@SPB-NB-133.local>
References: <1E2B87BF-BC9F-4A4A-962B-DC70B1232B37@cea.fr>
 <6878b688-dd72-c4e4-bdbc-38d6af10f257@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6878b688-dd72-c4e4-bdbc-38d6af10f257@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 17:49:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: LAHAYE Olivier <olivier.lahaye@cea.fr>, qemu-devel <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 12:38:26PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Olivier,
> 
> Cc'ing the HVF maintainers.
> 
> On 5/11/20 12:26 PM, LAHAYE Olivier wrote:
> > Hi,
> > 
> > I’m facing a similar problem to this one, but I’m unable to find any
> > solution via google.
> > 
> > https://www.mail-archive.com/qemu-discuss@nongnu.org/msg04372.html
> > 
> > I’m trying to run an EFI BIOS using qemu.
> > 
> >   * It works fine without acceleration
> >   * It hangs (display not initialized) when using -accel hvf
> > 
> > I’ve tested many OVMF.fd files from internet including the official one
> > of course whith no differences. (always work with no acceleration and
> > always fail with HVF acceleration).
> > 
> >   * OS: MacOS 10.14.6
> >   * QEMU 5.0.0 monitor - type 'help' for more information
> >   * (qemu) qemu-system-x86_64: warning: host doesn't support requested
> >     feature: CPUID.80000001H:ECX.svm [bit 2]
> >   * info roms
> >   * fw=genroms/kvmvapic.bin size=0x002400 name="kvmvapic.bin"
> >   * addr=00000000fff00000 size=0x100000 mem=rom
> >     name="/Users/ol222822/data/OVMF.fd"
> >   * /rom@etc/acpi/tables size=0x200000 name="etc/acpi/tables"
> >   * /rom@etc/table-loader size=0x001000 name="etc/table-loader"
> >   * /rom@etc/acpi/rsdp size=0x000014 name="etc/acpi/rsdp"
> > 
> > Is it a known issue?
> > 
> > Is there something I’m missing?
> > 
> > I’m running qemu in the following way:
> > 
> > qemu-system-x86_64 -machine q35 -bios ~/data/OVMF.fd -monitor stdio
> > 
> > If I add -accel hvf, it’ll hang before tiano core logo.
> > 
> > Best regards,
> > 
> > -- 
> > 
> > Olivier LAHAYE
> > 
> 

I tried to use OVMF shipped with qemu couple months ago and it worked,
but the latest UEFI from the master branch fails to boot either with hvf
or without it if built on macOS and the patch addresses the issue:

https://edk2.groups.io/g/devel/message/59372

I'm able to use UEFI shell on hvf accel if the patch is applied, and I
tried to boot FreeBSD iso with UEFI, it also works on the master branch
of qemu:

$QEMU_CMD -M q35,accel=hvf -m 512 -drive if=pflash,format=raw,readonly,file=Build/OvmfX64/DEBUG_XCODE5/FV/OVMF_CODE.fd -drive if=pflash,format=raw,file=Build/OvmfX64/DEBUG_XCODE5/FV/OVMF_VARS.fd -chardev file,path=debugcon.log,id=debugcon -device isa-debugcon,iobase=0x402,chardev=debugcon -net none -cdrom ~/Downloads/FreeBSD-12.0-RELEASE-amd64-bootonly.iso

I'm not sure about the logo though, I've never seen it.

Regards,
Roman

