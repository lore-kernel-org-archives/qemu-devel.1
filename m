Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCF8C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E8420857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E8420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDzzb-00005a-MD
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:17:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDzy8-0007Zz-2l
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hDzy6-0002RA-Oi
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:15:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hDzy6-0002Qx-It
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:15:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id a71so110354qkg.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 16:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=muw+hA8WcWgRUeb9AlPBU9GVnR0/q4cC4N42gEC3KrE=;
	b=b+gozwlik6ss5EoghAcXmJ3QxS09IgGrPGVK50KAwNPcwmeSaynY1cskJO/7gxIZbz
	zyzqGFFwIdNx0PW0jm5Xj1uw710nDJyj2xOEvAfd7X7w/D5QfVH0sV7lqiRz/toKfXpL
	FTSBuIw5E6+dQuNyZnOZMixa9uBSNEScUtpR7qJwFOeJF6FTwhCuNNdOEZcU0q6p7h6H
	h/BqfrFbC/vDMVVqDCClpStvYOnsG1YfdNcDBv59QFRILanttu0zT4B7i1+esA93u6JX
	RgiioXGLUoB1IwooJM1vaRibaxFKyoyJF1EOMCimL+vhxVJkmYH3UXkrC8rRHxTZJiYi
	F8Bw==
X-Gm-Message-State: APjAAAXAMz4wGhlxqVm/TGkWih5LmsK5WOCq04FKo3wCfELgmHZWdelN
	634qGbJQqgRzEDekWktQ6MKyow==
X-Google-Smtp-Source: APXvYqx3izzaVGNxb2YzhycdfhDNe6zkS8R4mn3zY+QvjcH7mgyivFOr2sIr81MKBERtT7U+SkLRkg==
X-Received: by 2002:a05:620a:1597:: with SMTP id
	d23mr29725558qkk.226.1554851753948; 
	Tue, 09 Apr 2019 16:15:53 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	46sm24383055qtz.87.2019.04.09.16.15.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 16:15:53 -0700 (PDT)
Date: Tue, 9 Apr 2019 19:15:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Message-ID: <20190409191500-mutt-send-email-mst@kernel.org>
References: <20190409230022.6462-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190409230022.6462-1-lersek@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 00/12] bundle edk2 platform
 firmware with QEMU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mprivozn@redhat.com,
	f4bug@amsat.org, philmd@redhat.com, kraxel@redhat.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409231549.zureyGyK2glGZgJLxLnO4WxqQjiYLVavtsNm6dTw48w@z>

On Wed, Apr 10, 2019 at 01:00:10AM +0200, Laszlo Ersek wrote:
> Repo:   https://github.com/lersek/qemu.git
> Branch: edk2_build_v4
> 
> Posting a v4 is necessary because patch #6 needs
> - manual conflict resolution against some commits between v4.0.0-rc2 and
>   v4.0.0-rc3,
> - and corresponding commit message updates.
> 
> These are noted in more detail on the patch itself:
> 
>   [PATCH for-4.1 v4 06/12]
>   roms/Makefile: replace the $(EDK2_EFIROM) target with "edk2-basetools"
> 
> Due to this update, I had to drop all previous feedback tags on this
> patch. I plan to send a pullreq as soon as 4.0 is released, so please
> re-review / retest the above patch (and *only* the above patch) soon.
> (The notes on the patch list the tags individually that I've now
> dropped.)

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I also think pull requests for that is a good idea.
Firmware is pretty independent of the rest of qemu.

> Version 3, that is:
> 
>   [Qemu-devel] [PATCH for-4.1 v3 00/12] bundle edk2 platform firmware with QEMU
> 
> was posted at:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06148.html
>   http://mid.mail-archive.com/20190321113408.19929-1-lersek@redhat.com
> 
> Thanks,
> Laszlo
> 
> Laszlo Ersek (12):
>   roms: lift "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"
>   roms/edk2-funcs.sh: require gcc-4.8+ for building i386 and x86_64
>   tests/uefi-test-tools/build.sh: work around TianoCore#1607
>   roms/edk2: advance to tag edk2-stable201903
>   roms/edk2-funcs.sh: add the qemu_edk2_get_thread_count() function
>   roms/Makefile: replace the $(EDK2_EFIROM) target with "edk2-basetools"
>   roms: build edk2 firmware binaries and variable store templates
>   pc-bios: add edk2 firmware binaries and variable store templates
>   pc-bios: document the edk2 firmware images; add firmware descriptors
>   tests: add missing dependency to build QTEST_QEMU_BINARY, round 2
>   Makefile: install the edk2 firmware images and their descriptors
>   MAINTAINERS: add the "EDK2 Firmware" subsystem
> 
>  .gitignore                                     |   1 +
>  MAINTAINERS                                    |  12 +
>  Makefile                                       |  29 ++-
>  configure                                      |   1 +
>  pc-bios/README                                 |  11 +
>  pc-bios/descriptors/50-edk2-i386-secure.json   |  34 +++
>  pc-bios/descriptors/50-edk2-x86_64-secure.json |  35 +++
>  pc-bios/descriptors/60-edk2-aarch64.json       |  31 +++
>  pc-bios/descriptors/60-edk2-arm.json           |  31 +++
>  pc-bios/descriptors/60-edk2-i386.json          |  33 +++
>  pc-bios/descriptors/60-edk2-x86_64.json        |  34 +++
>  pc-bios/edk2-aarch64-code.fd.bz2               | Bin 0 -> 1177603 bytes
>  pc-bios/edk2-arm-code.fd.bz2                   | Bin 0 -> 1173662 bytes
>  pc-bios/edk2-arm-vars.fd.bz2                   | Bin 0 -> 263 bytes
>  pc-bios/edk2-i386-code.fd.bz2                  | Bin 0 -> 1688659 bytes
>  pc-bios/edk2-i386-secure-code.fd.bz2           | Bin 0 -> 1881979 bytes
>  pc-bios/edk2-i386-vars.fd.bz2                  | Bin 0 -> 190 bytes
>  pc-bios/edk2-licenses.txt                      | 209 ++++++++++++++++
>  pc-bios/edk2-x86_64-code.fd.bz2                | Bin 0 -> 1669280 bytes
>  pc-bios/edk2-x86_64-secure-code.fd.bz2         | Bin 0 -> 1901210 bytes
>  roms/Makefile                                  |   9 +-
>  roms/Makefile.edk2                             | 148 ++++++++++++
>  roms/edk2                                      |   2 +-
>  roms/edk2-build.sh                             |  55 +++++
>  roms/edk2-funcs.sh                             | 253 ++++++++++++++++++++
>  tests/Makefile.include                         |   2 +-
>  tests/uefi-test-tools/build.sh                 | 100 +-------
>  27 files changed, 934 insertions(+), 96 deletions(-)
>  create mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
>  create mode 100644 pc-bios/descriptors/50-edk2-x86_64-secure.json
>  create mode 100644 pc-bios/descriptors/60-edk2-aarch64.json
>  create mode 100644 pc-bios/descriptors/60-edk2-arm.json
>  create mode 100644 pc-bios/descriptors/60-edk2-i386.json
>  create mode 100644 pc-bios/descriptors/60-edk2-x86_64.json
>  create mode 100644 pc-bios/edk2-aarch64-code.fd.bz2
>  create mode 100644 pc-bios/edk2-arm-code.fd.bz2
>  create mode 100644 pc-bios/edk2-arm-vars.fd.bz2
>  create mode 100644 pc-bios/edk2-i386-code.fd.bz2
>  create mode 100644 pc-bios/edk2-i386-secure-code.fd.bz2
>  create mode 100644 pc-bios/edk2-i386-vars.fd.bz2
>  create mode 100644 pc-bios/edk2-licenses.txt
>  create mode 100644 pc-bios/edk2-x86_64-code.fd.bz2
>  create mode 100644 pc-bios/edk2-x86_64-secure-code.fd.bz2
>  create mode 100644 roms/Makefile.edk2
>  create mode 100755 roms/edk2-build.sh
>  create mode 100644 roms/edk2-funcs.sh
> 
> -- 
> 2.19.1.3.g30247aa5d201

