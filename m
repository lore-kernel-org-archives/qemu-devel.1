Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86555C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D94B206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4rlt56r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D94B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVcT-0007ab-Ej
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1isVbP-00071K-FO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1isVbN-0002KC-Pp
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:40:11 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1isVbN-0002JO-HL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:40:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id d73so8253684wmd.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GG/2yOwLVaV+NUVQmSrEYPITPWV6B/NHd3Qy4LJRUb4=;
 b=f4rlt56rpuNi2WjjVN2ntDSRO9D5KwW2V7NgCDjFMaobrXfPV8acAqs2kgZHbvbsbr
 +w0iiCWHZl4uPz3c1j4FuAev5Ol69fVTlwhp+eVWRxGRgorTLcOeQ7pCp+u89sSid43z
 is0r+pAE5aZ9Mv8PXtpVUfvBFP/NgbBxVhk0+Sd85xX0FO2hnmv9at0Cg/M3b3snz6xO
 BhyMFuNqHhSXRFiYxDPN7tGRaSHbk2ddxJ/comcqE2Amk6yhtUtLTJdW5aBC6RduDMup
 QMUDVweq1jccCIBwQrargC8bfB9sPQJwiYLwuzYy8QXsqIYZhygh45nljP9IBe2Xy1Py
 RxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GG/2yOwLVaV+NUVQmSrEYPITPWV6B/NHd3Qy4LJRUb4=;
 b=sRcDhZR+tsMllAw8YES9jZlLUxQGP1OCMZzhf5tsCX5n35AgKj8Uu7hmKsDiekCdIx
 wEqTnpANzoi/4bdj9jREvh2aeIepJgIAuRp5Cmi70g8czaH9fLCam8p+xHPonENHFi9k
 FyZPSIs3KygVbYgWDuPtP/2prrXZLvqOjncFiuXuYvG+dhaR/NJqygVKMiK16i5YTEfB
 0WIvWpMrS0UWJ66fx8OBOFKau8osQiGnEs5McuP+PD6LZkINc++HbLqEvASCbgUWnIwa
 unzz3scEu8HB/vKV0rZjqJKImMSCB9ZPSlGs8/2xPV2B8p8jlLjxeSzvAhLMvAuHM8A4
 oqJA==
X-Gm-Message-State: APjAAAViqtJsMSt5VzbK3i1ieC3xng/nsfKEbg8qStoekhP9iIP6NSTw
 txFKxVeeHyFEBEMr202LlOb/hw==
X-Google-Smtp-Source: APXvYqxfI1+cs4atV0QYx3OYg2xVrwa6VxEd10jrDVnoNG6yUID15K1wOG+jhQtzVoryw7r6TOeqKw==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr5688217wmb.19.1579282808465; 
 Fri, 17 Jan 2020 09:40:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p17sm34860891wrx.20.2020.01.17.09.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 09:40:07 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 612491FF87;
 Fri, 17 Jan 2020 17:40:06 +0000 (GMT)
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <87o8v3lkq8.fsf@linaro.org> <000f01d5cc5f$cccb90b0$6662b210$@ru>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Subject: Re: [for-5.0 PATCH 00/11] Support for reverse debugging with GDB
In-reply-to: <000f01d5cc5f$cccb90b0$6662b210$@ru>
Date: Fri, 17 Jan 2020 17:40:06 +0000
Message-ID: <871rrykmmh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:
>>=20
>> > GDB remote protocol supports reverse debugging of the targets.
>> > It includes 'reverse step' and 'reverse continue' operations.
>> > The first one finds the previous step of the execution,
>> > and the second one is intended to stop at the last breakpoint that
>> > would happen when the program is executed normally.
>> >
>> > Reverse debugging is possible in the replay mode, when at least
>> > one snapshot was created at the record or replay phase.
>> > QEMU can use these snapshots for travelling back in time with GDB.
>> >
>> > Running the execution in replay mode allows using GDB reverse debugging
>> > commands:
>> >  - reverse-stepi (or rsi): Steps one instruction to the past.
>> >    QEMU loads on of the prior snapshots and proceeds to the desired
>> >    instruction forward. When that step is reaches, execution stops.
>> >  - reverse-continue (or rc): Runs execution "backwards".
>> >    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>> >    and replaying the execution. Then QEMU loads snapshots again and
>> >    replays to the latest breakpoint. When there are no breakpoints in
>> >    the examined section of the execution, QEMU finds one more snapshot
>> >    and tries again. After the first snapshot is processed, execution
>> >    stops at this snapshot.
>> >
>> > The set of patches include the following modifications:
>> >  - gdbstub update for reverse debugging support
>> >  - functions that automatically perform reverse step and reverse
>> >    continue operations
>> >  - hmp/qmp commands for manipulating the replay process
>> >  - improvement of the snapshotting for saving the execution step
>> >    in the snapshot parameters
>> >
>> > The patches are available in the repository:
>> > https://github.com/ispras/qemu/tree/rr-191223
>>=20
>> So I tried with your additional patch. Launching QEMU as:
>>=20
>>   ./aarch64-softmmu//qemu-system-aarch64 -monitor none \
>>      -display none -M virt -cpu max -display none \
>>      -semihosting-config enable=3Don \
>>      -kernel ./tests/tcg/aarch64-softmmu/memory \
>>      -icount shift=3D5,rr=3Dreplay,rrfile=3Drecord.bin \
>>      -s -S -d trace:gdbstub\*
>>=20
>> And gdb:
>>=20
>>   gdb tests/tcg/aarch64-softmmu/memory \
>>     -ex "target remote localhost:1234"
>>=20
>> I get the following log:
>>=20
>>   (gdb) x/3i $pc
>>   =3D> 0x400037b0 <__start>:        adr     x0, 0x40003000 <vector_table>
>>      0x400037b4 <__start+4>:      msr     vbar_el1, x0
>>      0x400037b8 <__start+8>:      adrp    x0, 0x40200000
>>   (gdb) p/x $x0
>>   $1 =3D 0x0
>>   (gdb) si
>>   92              msr     vbar_el1, x0
>>   (gdb) p/x $x0
>>   $2 =3D 0x40003000
>>   (gdb) rsi
>>   warning: Remote failure reply: E14
>>=20
>>   Program stopped.
>>   __start () at /home/alex.bennee/lsrc/qemu.git/tests/tcg/aarch64/system=
/boot.S:92
>>   92              msr     vbar_el1, x0
>>   (gdb) p/x $x0
>>   $3 =3D 0x40003000
>>=20
>> So it doesn't seem to be working.
>
> That's ok, you'll need at least one VM snapshot available to recover the =
initial VM state.
> Try changing the command lines in the following way:
>
> First, create empty.qcow2 which will be used for saving the snapshots.
> Then record with initial snapshot and attached empty.qcow2:
>
>    ./aarch64-softmmu//qemu-system-aarch64 -monitor none \
>       -display none -M virt -cpu max \
>       -kernel ./tests/tcg/aarch64-softmmu/memory \
>       -icount shift=3D5,rr=3Drecord,rrfile=3Drecord.bin,rrsnapshot=3Dinit=
 \
>       -drive file=3Dempty.qcow2

./aarch64-softmmu//qemu-system-aarch64 -monitor none -display none -M virt =
-cpu max -display none -semihosting-config enable=3Don -kernel ./tests/tcg/=
aarch64-softmmu/memory -icount shift=3D5,rr=3Drecord,rrfile=3Drecord.bin,rr=
snapshot=3Dinit -drive file=3Dempty.qcow2
qemu-system-aarch64: invalid accelerator kvm
qemu-system-aarch64: falling back to tcg
qemu-system-aarch64: The qcow format used by node '#block163' does not supp=
ort live migration
qemu-system-aarch64: Could not create snapshot for icount record

I don't know if this is down to the current state of the tree but I
haven't been able to get it working.

>
> After that you can replay the execution with the support of reverse debug=
ging:
>
>    ./aarch64-softmmu//qemu-system-aarch64 -monitor none \
>       -display none -M virt -cpu max \
>       -kernel ./tests/tcg/aarch64-softmmu/memory \
>       -icount shift=3D5,rr=3Dreplay,rrfile=3Drecord.bin,rrsnapshot=3Dinit=
 \
>       -drive file=3Dempty.qcow2
>
> I removed "-semihosting-config enable=3Don", because I'm not sure what is=
 it for.
> It may break the replay, because there is no implementation of
> semihosting input record/replay.

For this testcase semihosting in just a convenient output device (in
lieu of a serial device). We probably need to come up with a strategy on
how we handle all these devices otherwise we will end up with a random
selection of hardware combinations which work.

>
> Pavel Dovgalyuk


--=20
Alex Benn=C3=A9e

