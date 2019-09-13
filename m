Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3625DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D563206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D563206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8kmd-0002qr-4h
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 08:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i8klQ-0002EM-Fv
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i8klO-0002m9-0z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:33:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1i8klN-0002lo-Rv; Fri, 13 Sep 2019 08:33:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB8273CA16;
 Fri, 13 Sep 2019 12:33:19 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-100.rdu2.redhat.com
 [10.10.120.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6D8D5D9C3;
 Fri, 13 Sep 2019 12:33:18 +0000 (UTC)
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20190912231202.12327-1-mdroth@linux.vnet.ibm.com>
 <20190912231202.12327-3-mdroth@linux.vnet.ibm.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <beecc252-41af-ba15-651a-adfb2ebbd4a3@redhat.com>
Date: Fri, 13 Sep 2019 14:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190912231202.12327-3-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 13 Sep 2019 12:33:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] roms/Makefile.edk2: don't pull in
 submodules when building from tarball
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
Cc: qemu-stable@nongnu.org, brogers@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/13/19 01:12, Michael Roth wrote:
> Currently the `make efi` target pulls submodules nested under the
> roms/edk2 submodule as dependencies. However, when we attempt to build
> from a tarball this fails since we are no longer in a git tree.
> 
> A preceding patch will pre-populate these submodules in the tarball,
> so assume this build dependency is only needed when building from a
> git tree.
> 
> Reported-by: Bruce Rogers <brogers@suse.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Bruce Rogers <brogers@suse.com>
> Cc: qemu-stable@nongnu.org # v4.1.0
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  roms/Makefile.edk2 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
> index c2f2ff59d5..33a074d3a4 100644
> --- a/roms/Makefile.edk2
> +++ b/roms/Makefile.edk2
> @@ -46,8 +46,13 @@ all: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashdev).fd.bz2) \
>  # files.
>  .INTERMEDIATE: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashdev).fd)
>  
> +# Fetch edk2 submodule's submodules. If it is not in a git tree, assume
> +# we're building from a tarball and that they've already been fetched by
> +# make-release/tarball scripts.
>  submodules:
> -	cd edk2 && git submodule update --init --force
> +	if test -d edk2/.git; then \
> +		cd edk2 && git submodule update --init --force; \
> +	fi
>  
>  # See notes on the ".NOTPARALLEL" target and the "+" indicator in
>  # "tests/uefi-test-tools/Makefile".
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thank you,
Laszlo

