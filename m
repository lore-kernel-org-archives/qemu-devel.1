Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE81C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5FD20752
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 14:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="JSapOhS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5FD20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDr3v-0007ME-3E
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 10:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jDobw-0000aC-K7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jDobv-0001Sm-EL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:12:48 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:46008 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jDobv-0000mo-0C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:12:47 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 806794127E;
 Mon, 16 Mar 2020 12:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1584360762; x=1586175163; bh=ytQFbSVDdP48Au5ur48MS0
 UN/nseZ5yDdS03nrHjTCg=; b=JSapOhS87rPGpYmKWv5pZLLPaLy/FbrzutsTR9
 VIC8WbiC4Tx5CEFvASiBBzi0VBju+/8O6aveQHkRACjp3+q3TmPLADWPiYjo2P2L
 DrrJPHOd3wc6SU/KntWZxzMDGYSmNlgoS0n5YeHO8H6CmCxyaahwjKoUVC5onMwa
 GpRYM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ThpQGHoV46T; Mon, 16 Mar 2020 15:12:42 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 1B36B41259;
 Mon, 16 Mar 2020 15:12:41 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 16
 Mar 2020 15:12:41 +0300
Date: Mon, 16 Mar 2020 15:12:41 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 04/11] MAINTAINERS: Add an entry for the HVF accelerator
Message-ID: <20200316121241.GA4312@SPB-NB-133.local>
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20200316120049.11225-5-philmd@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 89.207.88.252
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 "Reviewed-by : Nikita Leshenko" <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

I can take the ownership if nobody wants it. At the moment I'm working
on APIC for HVF to get kvm-unit-tests fixed.

Next items on the list (in no particular order):
* MMX emulation
* SSE emulation
* qxl display
* gdb stub
* virtio-gpu/virgil running on metal
* VFIO-PCI based on macOS user-space DriverKit framework

Best regards,
Roman

On Mon, Mar 16, 2020 at 01:00:42PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> Cc: Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Cc: Patrick Colp <patrick.colp@oracle.com>
> Cc: Cameron Esfahani <dirty@apple.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Heiher <r@hev.cc>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ec42a18f7..bcf40afb85 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -420,6 +420,12 @@ F: accel/stubs/hax-stub.c
>  F: target/i386/hax-all.c
>  F: include/sysemu/hax.h
> =20
> +HVF Accelerator
> +S: Orphan
> +F: accel/stubs/hvf-stub.c
> +F: target/i386/hvf/hvf.c
> +F: include/sysemu/hvf.h
> +
>  WHPX CPUs
>  M: Sunil Muthuswamy <sunilmut@microsoft.com>
>  S: Supported
> --=20
> 2.21.1
>=20

