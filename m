Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D6DC11D00
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 00:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CF7222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 00:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNa8KE7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CF7222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4vrI-0005Q5-6D
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 19:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1j4vqi-0004yE-KX
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 19:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1j4vqh-0004fC-EG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 19:07:20 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1j4vqh-0004eH-79
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 19:07:19 -0500
Received: by mail-pj1-x1043.google.com with SMTP id ep11so207406pjb.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 16:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=XUT5bw9wd39C2VeFFnZG6niMWFp+WGo1G3KIdVXv3F0=;
 b=tNa8KE7DVP+Y3rQnOF2sZHApQRe0CK59aCSFruKb45eTlGOBodtky8VH1KjgbGrd1l
 bl3vdn8lethD9EJUpB1IObjO/eiINUjR072plSSRchK03UW/M+JUos50qc9s8se4T6or
 HKc8QiEtyzRmdzIk4Ws5qMwJerDHAzWXJWgvuwJmitiirBrCcvUhGH40LXw4t9PQe08K
 0Oau/xuJ+Nwu6XKz7WZKkflAGUFfIDRV9gkdugeTrNdw6CwVuLv3YWr+hNSQCikDL6PW
 32LNEbQZMLECbvfc/hm61MnnSLGV7c2qJc7JweDjIAxftVJZosPDt0HzRHg7DXHKtTQB
 592Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XUT5bw9wd39C2VeFFnZG6niMWFp+WGo1G3KIdVXv3F0=;
 b=lkISCp9i+hj2axOJdoA/N99FhYWnD50YER8GPa3zXWewPf1gOA6PNXgtmYNnEXRsn9
 vAgwLA8dwiqlMGLTVsNzfflpEobEoa/OitkNkU2NCsUTrJzUt2+aZrEmc4JCrv00ARD8
 VDSslmnDiGmai66f9YAEsYAIGpbU/oOFVLlkVMgmO3+gyaLvCRhTlzQQQCJk1+dT9Cj4
 dM+R6ukC7G1jwVgxs7dcURWwcoJGGS9MlfAWtnmTP6lX9thOaLW9vlulznFXoeHrf9v1
 Ei1B8N43NIiujBUQMKYi5gppJHrnvVEvPGD4wPQe9DuuF530EXV1NiaDy2Y15CtQqH0Y
 1bzg==
X-Gm-Message-State: APjAAAX5r25JFUfwpUYGiD1Ag5FI7JHjAuM9fajISpcRyTr2HAM0/9OR
 Ci+Smsfvs84D3qkTt1MtzDI=
X-Google-Smtp-Source: APXvYqwqwf2RH+RVsX0zrNsUz72syvN2SIuLh/DTBibdHoHK2StfRZCLILL5B9/0k08S7NeGkWIxlg==
X-Received: by 2002:a17:90a:c388:: with SMTP id
 h8mr6310309pjt.83.1582243638065; 
 Thu, 20 Feb 2020 16:07:18 -0800 (PST)
Received: from mail.google.com ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id s125sm417427pgc.53.2020.02.20.16.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 16:07:17 -0800 (PST)
Date: Fri, 21 Feb 2020 08:07:11 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Luc Michel <luc.michel@greensocs.com>
Subject: Re: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
Message-ID: <20200221000711.om6gkf37qckcsdc7@mail.google.com>
References: <20200220155834.21905-1-changbin.du@gmail.com>
 <ddc8b36f-da30-faac-cab2-fad882841159@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddc8b36f-da30-faac-cab2-fad882841159@greensocs.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com,
 alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 20, 2020 at 10:24:37PM +0100, Luc Michel wrote:
> Hi,
> 
> On 2/20/20 4:58 PM, Changbin Du wrote:
> > Recently when debugging an arm32 system on qemu, I found sometimes the
> > single-step command (stepi) is not working. This can be reproduced by
> > below steps:
> >  1) start qemu-system-arm -s -S .. and wait for gdb connection.
> >  2) start gdb and connect to qemu. In my case, gdb gets a wrong value
> >     (0x60) for PC.
> >  3) After connected, type 'stepi' and expect it will stop at next ins.
> > 
> > But, it has never stopped. This because:
> >  1) We doesn't report ‘vContSupported’ feature to gdb explicitly and gdb
> >     think we do not support it. In this case, gdb use a software breakpoint
> >     to emulate single-step.
> >  2) Since gdb gets a wrong initial value of PC, then gdb inserts a
> >     breakpoint to wrong place (PC+4).
> > 
> > Since we do support ‘vContSupported’ query command, so let's tell gdb that
> > we support it.
> > 
> > Before this change, gdb send below 'Z0' packet to implement single-step:
> > gdb_handle_packet: Z0,4,4
> > 
> > After this change, gdb send "vCont;s.." which is expected:
> > gdb_handle_packet: vCont?
> > put_packet: vCont;c;C;s;S
> > gdb_handle_packet: vCont;s:p1.1;c:p1.-1
> I'm curious, I never experienced this behaviour from GDB. What GDB and
> QEMU versions are you using?
> 
For QEMU, it's built from mainline.
For GDB, I have tried 8.1 and latest 9.1.

> On my side (GDB 9.1), even without 'vContSupported+' in the 'qSupported'
> answer, GDB sends a 'vCont?' packet on the first stepi:
> 
> 0x00000000 in ?? ()
> (gdb) si
> Sending packet: $m0,4#fd...Ack
> Packet received: 00000000
> Sending packet: $vCont?#49...Ack
> Packet received: vCont;c;C;s;S
> Packet vCont (verbose-resume) is supported
> Sending packet: $vCont;s:p1.1;c:p1.-1#f7...Ack
> Packet received: T05thread:p01.01;
>
hmm, On my side, this is 100% reproducable on arm32, but aarch64 doesn't. I
think the GDB has different assumptions for different arch.

> Your second issue (wrong PC value) should be investigated though. Does
> it happen on QEMU vanilla? Do you have a way to reproduce this bug?
> 
This is also 100% reproducable for my tested elf guest. But so sorry that I
can't share it. Probablly I will check this issue some days later.

> Anyway after re-reading the GDB remote protocol documentation, I think
> your patch is right, the feature should be advertised.
> 
> However I think your commit message needs some modifications. This fix
> is not specific to ARM or TCG, but to the gdbstub itself. You also
> mention this bug you have with PC, which is not related to the bug you
> are fixing here. Could you rewrite it in a more generic way? You simply
> need to emphasis the effect of advertising the 'vContSupported+' feature
> on GDB.
> 
sure.

> Thanks.
> 
> -- 
> Luc

-- 
Cheers,
Changbin Du

