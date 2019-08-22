Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795AC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4398D2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPYHApi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4398D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0iOr-00042f-Dv
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0iNv-0003bb-6l
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0iNt-0001U7-VW
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:23:55 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:33123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0iNt-0001RT-OM
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:23:53 -0400
Received: by mail-oi1-x232.google.com with SMTP id l2so3753232oil.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gC0g7MU9xUUOoGCIqi0lwDybwUQVQ9QAsUHfnLHQtn4=;
 b=ZPYHApi9CQqOSWlUBLF2Ekky+RS8cNe06tu0YRNLf3QJdxEi6xlNXBSNH3zsPxIVjF
 c3MHXGzSkMCAORxjm2ZgX2Xw1y63YwC0qPvMUxk8WiPdsCQaPMusThbrkwqS1iiO14ki
 4yH3Q0gdZpHI43bcjTKuFlrw+pRHY+BJL+v7STLujKL/BGqrx81LO1kyklsW1ByinLaK
 zDurNHjHz6pQHzsENUvkC7AUYxkAdh45Z0dVSMGRKMQ0splFBkabqRyDqej2xEpcaABi
 dbSbF7OSPmFO6eXnJiITEXgOZXBsBUOz4v051jhAmXl9z+ewLtqFUdPOEnYYs3fa/Nhf
 V01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gC0g7MU9xUUOoGCIqi0lwDybwUQVQ9QAsUHfnLHQtn4=;
 b=kdLZfBlgSv145uSL5H4lpMAVk/TaTQ8RiC1iEFmcMpvOy8QBtPF8N2xkNsbRdZTgjg
 EcVmroMbxjO3lC3CPujAFpO9zvOjTBRce/4LjpWtC01qsVuca8w43Mr0Y5ODe4vLFpTw
 7AjaGe0kOem/Bgtcu3/W+lgjTWxaBar2jjkAOlypYlQYMKbr99lSwT3fWtlqwnXhYQ/S
 IixRQsmRSOPIyvPubjCsq/9y+7i2uiWW7DJWFYmqymoPE46QeOTYAp5uGVBBjlWa79ok
 oUQ6BUZA8b2isp+E4A8nOvusqZKD3hifeH9kZw6Mgqr7Ca7/vxaKwBnyHVD/L771qzbG
 592g==
X-Gm-Message-State: APjAAAXCPSszeimK5LJf7PQnBI4ATrgq1V3ghA4/8JUIv48E+w1G+FvJ
 Q+1sNEAv4EAiKx4j0+Ti0CbCLZGWf8Hu1fean8s=
X-Google-Smtp-Source: APXvYqzq7sAcfKu8FyTgN+G4yyCXXhNhwOfdQ3rd0+EfeaL4qTNTIgNjPDP2DF5+szGFCrNDlIxPX4dpy9ThXzKW+kc=
X-Received: by 2002:aca:fd92:: with SMTP id b140mr2702914oii.79.1566462230319; 
 Thu, 22 Aug 2019 01:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
In-Reply-To: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 22 Aug 2019 10:23:39 +0200
Message-ID: <CAL1e-=jUNzu19BBhFq0M_hjxi6BSgfmZUgQMygszTTonORVNmg@mail.gmail.com>
To: =?UTF-8?B?56uL?= <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 12:12 PM =E7=AB=8B <zhlb29@foxmail.com> wrote:

> I am working on a project that requires me to modify the ISA of the MIPS
> target.


L.,

How is it going?

Aleksandar



> I have been staring at the source code for about a week, but found it
> really difficult due to me being a young rookie and the sparse comments.
> Specifically, I need to extend MIPS, by adding some new instructions and
> new CPU registers to the current architecture, and that sounds really eas=
y.
> I think the place for me to look at should be at the directory
> ${qemu_root}/target/mips/. With a MIPS Instruction Set Manual Release 6
> handy, I have difficulty finding the source code where the ISA resides. I=
s
> it in op_helper.c? Or translate.c? Any guidance would be really
> appreciated. Thank you very much in advance.
>
>
> Cheers,
> L.
