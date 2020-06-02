Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10812067B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="zcnJ0Ar4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10812067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9it-0008F2-24
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chouteau@adacore.com>)
 id 1jg9iH-0007lk-0B
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:24:29 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f]:38346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chouteau@adacore.com>)
 id 1jg9iF-00080n-QM
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:24:28 -0400
Received: by mail-io1-xd2f.google.com with SMTP id d7so11489102ioq.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=hOC4euejTBaAmNdHY26JjKCLitchZSJaHBT2DxiVxGk=;
 b=zcnJ0Ar4hV5YD7Nnvejm+DxBxd5eo4bkmDJVCB6CmYdwKaM8ULRwL1mCxICjy0ANfY
 OkmOldSpKlmOo74ZAdCgrrU3lNHwiQWqSX25IFgN9xat0OLMvReqOyvJAe321mVVUZ1F
 ketg77jDzNSKXAoG+NxAp00TT4um0OwqUPOM2/DTwwodgy9Sl125gZOJAJbADBSLTim4
 NdaIjPZF1jzb8z+D6f3CzO9oOiM3rjZ/7q2ydZ+fJ+XkAi/1Kb2fD4yGZyhGyu5+tvfI
 CengtSM684EupuRunODnfa1g5RTFqSbzbsWcRtnczqOMZGFtKKb7+3UfRDnVIhdaEGRA
 T1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=hOC4euejTBaAmNdHY26JjKCLitchZSJaHBT2DxiVxGk=;
 b=bhmgPOngRUdDFKQs98soagadHT/MfQNFCeoI0V401Eqs8OgoRmnGQnQ+8bOYeUDKFD
 0HnQRoztg8IIKn7EtwLBOjDXn5iXfZGPjVotciH1BABdu+eUUg2zgKKjF+9/BKPFS7o6
 Y3Ym3bh/7ZpE1zF8JPHPUskldgsr7A/vD2uQE7yGm7V4IlKgOy8T38Do1ELgXCoRbO13
 mj5FIEg3JoqwthvC8Z8SG7koQnD0DlPuyTvA73T3+oflCDa8UxuTl89o//oPJ9FRkYqi
 yGlVAYs4FAT3gmnN8APEVOV0ObjH2v75+QrjpOZr69xRi3svQv4xFMYzm/q01510has3
 iQyQ==
X-Gm-Message-State: AOAM533qT02uGIyk42wbDq+MIIePA77kCIkapQ6EPDaLpkHgbwaFxz/r
 k9k74i0CPD0fCijJliR22ITbexCpMFeUsI2xkAbXsd6W3nX7hw==
X-Google-Smtp-Source: ABdhPJyMg71rFFFip5iq1NksE9lzWSYg0I5pnq+YWfUECvLvWVh4RC46iH6b9DirRVjqUapBMGuQSkOWn5EbQ4eXFt0=
X-Received: by 2002:a05:6602:2055:: with SMTP id
 z21mr217211iod.60.1591115065704; 
 Tue, 02 Jun 2020 09:24:25 -0700 (PDT)
MIME-Version: 1.0
From: Fabien Chouteau <chouteau@adacore.com>
Date: Tue, 2 Jun 2020 18:24:15 +0200
Message-ID: <CALQG_Wh7eMt9U3gWkZZGDq0RFvWfuSVoiNBRNnPS_cDVfUc30w@mail.gmail.com>
Subject: gdbstub.c CPU clusters not handled for ThreadInfo packets
To: qemu-devel@nongnu.org, Luc Michel <luc.michel@greensocs.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000049e00b05a71c58cc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=chouteau@adacore.com; helo=mail-io1-xd2f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000049e00b05a71c58cc
Content-Type: text/plain; charset="UTF-8"

Hi all,

(Luc, I am putting in copy because from the logs it looks like you
implemented the multiprocess support)

Using the sifive_u machine on qemu-system-riscv64 which has 2 clusters of 1
and 4 CPUs respectively, when I use the "info threads" command in GDB only
one thread is displayed.
This thread is the only CPU of the 1st cluster, the CPUs of cluster 2nd are
not listed at all.

Looking at the GDB remote packets (see below) we can see that indeed only
one thread is listed (mp01.01). It seems to me that the functions
handle_query_first_threads() and handle_query_threads() of gdbstub.c are
not handling the new multiprocess implementation. I would like to fix it
but I am lost between cpus, processes, threads, etc.

Does anyone have an idea how to fix this?

Regards,

(gdb) info threads
Sending packet: $qfThreadInfo#bb...Ack
Packet received: mp01.01
Sending packet: $qsThreadInfo#c8...Ack
Packet received: l
Sending packet: $qThreadExtraInfo,p1.1#85...Ack
Packet received:
7369666976652d6535312d72697363762d6370752068617274735b305d205b72756e6e696e675d
  Id   Target Id                                            Frame
* 1    Thread 1.1 (sifive-e51-riscv-cpu harts[0] [running])
0x0000000000001000 in ?? ()
(gdb)

--00000000000049e00b05a71c58cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,</div><div><br></div><div>(Luc, I am putting i=
n copy  because from the logs it looks like you implemented the multiproces=
s support)</div><div><br></div><div>Using the sifive_u machine on qemu-syst=
em-riscv64 which has 2 clusters of 1 and 4 CPUs respectively, when I use th=
e &quot;info threads&quot; command in GDB only one thread is displayed.</di=
v><div>This thread is the only CPU of the 1st cluster, the CPUs of cluster =
2nd are not listed at all.</div><div><br></div><div>Looking at the GDB remo=
te packets (see below) we can see that indeed only one thread is listed (mp=
01.01). It seems to me that the functions handle_query_first_threads() and =
handle_query_threads() of gdbstub.c are not handling the new multiprocess i=
mplementation. I would like to fix it but I am lost between cpus, processes=
, threads, etc.</div><div><br></div><div>Does anyone have an idea how to fi=
x this?<br></div><div><br></div><div>Regards,</div><div><br></div><div>(gdb=
) info threads <br>Sending packet: $qfThreadInfo#bb...Ack<br>Packet receive=
d: mp01.01<br>Sending packet: $qsThreadInfo#c8...Ack<br>Packet received: l<=
br>Sending packet: $qThreadExtraInfo,p1.1#85...Ack<br>Packet received: 7369=
666976652d6535312d72697363762d6370752068617274735b305d205b72756e6e696e675d<=
br>=C2=A0 Id =C2=A0 Target Id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Frame <br>* 1 =C2=A0 =C2=A0Thread 1.1 (si=
five-e51-riscv-cpu harts[0] [running]) 0x0000000000001000 in ?? ()<br>(gdb)=
 </div><div><br></div></div>

--00000000000049e00b05a71c58cc--

