Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29DAC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F39C2089F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU/mV8uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F39C2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfMs4-0005qI-PK
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hfMqT-0004MA-IH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hfMqS-0006Rd-4c
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:09:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hfMqR-0006QT-R3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:09:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id j19so13086883otq.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UVzbIZc4EBciOaQptpV3eLW93DDK64nenvgyquyswow=;
 b=eU/mV8uwD07eF+4EOK8mTJe8+pjo/fkiJCa0YHD+gN4ErxMqc2gZAxbzGTAIIULyUX
 5WZhDoEHjOUH4GM6G2ZDe9y10QQuknl1xYqMO5zg/JfZUa0lZrzxMRntPkrsBgGB1IRi
 0YZvbbu9YLI2G2YDnN7Buj3HxR73qfT9OLtY9Ftz31LZzYNpAXENzoZTtMCq/4RnxCXq
 khPCHU9dCmZ4FtL/i/gi7bB75Tde/0EjRB+Z0HmXsQ3lKZAWONIpd/lE0KbVBxTonhAT
 ijMMwnzRMV+zdqdkhrwcESXWyhj++Rg7xWDcHUfxxqYRAargtV2UpkU8QK963IblWAu9
 G3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UVzbIZc4EBciOaQptpV3eLW93DDK64nenvgyquyswow=;
 b=Rj0kFq8+/teickDIXPvtqNZFbDBU/jHG4eRwytlR4BA/TUAMszualfFZmacixRcEOf
 mewVWB0QS1LdWQStr335tuGer7pAjasPNbmZSLX0vJlLSajiGLK6SKkXiq+ZLNfxeOkm
 sfhwkjsAH5Apx6tLrdXIWqRN5O3MsZh+B0Eea85n6kOtzQDaiqIAaPF8diSZ35kqI11G
 6lhG4nwRUvdit8KnFCZ+bq809s6/I7rnnI9MfZAE4uSr7LKmkDTxi1PLHyrlcHQOJvnb
 /PIptgY64GF+g3NYN+eoz0u5YOLMmfmASAh7dvR38YLQ4g3Swvqe4DmRENpCqXbYsR96
 5VaA==
X-Gm-Message-State: APjAAAVmCGVdxu5Xmv83WQ7zv/jAiUWtJ/IV7xwqis/sRUhZ6hYPLBu5
 xXNrxSGHVwVNKenUwVjeY6aDFQHHwYZXDSV8XhI=
X-Google-Smtp-Source: APXvYqyG2g/7PpKoEs1Mw2Lr6IoVhg4tsORTAxDEd+wYhYbYoS6ooZxgUnOVrSwbrOp98qg7BLldGALRe92NHj+NQ7U=
X-Received: by 2002:a05:6830:14c:: with SMTP id
 j12mr10602909otp.181.1561374546220; 
 Mon, 24 Jun 2019 04:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190622002119.126834-1-liq3ea@163.com>
 <20190624094216.GI6279@xz-x1>
In-Reply-To: <20190624094216.GI6279@xz-x1>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 24 Jun 2019 19:08:30 +0800
Message-ID: <CAKXe6S+5Ad-WHYpX9E8EFv61ASxSQYL+RQoqnG6NVbysgtv4FQ@mail.gmail.com>
To: Peter Xu <peterx@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] ioapic: use irq number instead of
 vector in ioapic_eoi_broadcast
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8824=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:42=E5=86=99=E9=81=93=EF=BC=9A

> On Fri, Jun 21, 2019 at 05:21:19PM -0700, Li Qiang wrote:
> > When emulating irqchip in qemu, such as following command:
> >
> > x86_64-softmmu/qemu-system-x86_64 -m 1024 -smp 4 -hda /home/test/test.i=
mg
> > -machine kernel-irqchip=3Doff --enable-kvm -vnc :0 -device edu -monitor
> stdio
> >
> > We will get a crash with following asan output:
> >
> > (qemu) /home/test/qemu5/qemu/hw/intc/ioapic.c:266:27: runtime error:
> index 35 out of bounds for type 'int [24]'
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D113504=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addr=
ess
> 0x61b000003114 at pc 0x5579e3c7a80f bp 0x7fd004bf8c10 sp 0x7fd004bf8c00
> > WRITE of size 4 at 0x61b000003114 thread T4
> >     #0 0x5579e3c7a80e in ioapic_eoi_broadcast
> /home/test/qemu5/qemu/hw/intc/ioapic.c:266
> >     #1 0x5579e3c6f480 in apic_eoi
> /home/test/qemu5/qemu/hw/intc/apic.c:428
> >     #2 0x5579e3c720a7 in apic_mem_write
> /home/test/qemu5/qemu/hw/intc/apic.c:802
> >     #3 0x5579e3b1e31a in memory_region_write_accessor
> /home/test/qemu5/qemu/memory.c:503
> >     #4 0x5579e3b1e6a2 in access_with_adjusted_size
> /home/test/qemu5/qemu/memory.c:569
> >     #5 0x5579e3b28d77 in memory_region_dispatch_write
> /home/test/qemu5/qemu/memory.c:1497
> >     #6 0x5579e3a1b36b in flatview_write_continue
> /home/test/qemu5/qemu/exec.c:3323
> >     #7 0x5579e3a1b633 in flatview_write /home/test/qemu5/qemu/exec.c:33=
62
> >     #8 0x5579e3a1bcb1 in address_space_write
> /home/test/qemu5/qemu/exec.c:3452
> >     #9 0x5579e3a1bd03 in address_space_rw
> /home/test/qemu5/qemu/exec.c:3463
> >     #10 0x5579e3b8b979 in kvm_cpu_exec
> /home/test/qemu5/qemu/accel/kvm/kvm-all.c:2045
> >     #11 0x5579e3ae4499 in qemu_kvm_cpu_thread_fn
> /home/test/qemu5/qemu/cpus.c:1287
> >     #12 0x5579e4cbdb9f in qemu_thread_start util/qemu-thread-posix.c:50=
2
> >     #13 0x7fd0146376da in start_thread
> (/lib/x86_64-linux-gnu/libpthread.so.0+0x76da)
> >     #14 0x7fd01436088e in __clone
> (/lib/x86_64-linux-gnu/libc.so.6+0x12188e
> >
> > This is because in ioapic_eoi_broadcast function, we uses 'vector' to
> > index the 's->irq_eoi'. To fix this, we should uses the irq number.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>
Thanks Peter.



> Maybe also add:
>
> Fixes: 958a01dab8 ("ioapic: allow buggy guests mishandling ...")
>
> Should we better clear irq_eoi when the entries are updated in
> ioapic_mem_write()?
>
>
Do you mean the redirect table entry of ioapic update?
I think this is reasonable, I will prepare a separate patch with this one
as a patchset later.

Thanks,
Li Qiang



> Regards,
>
> --
> Peter Xu
>
