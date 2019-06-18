Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85668C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5294A20673
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHGt9Qbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5294A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60217 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHZi-0001hm-I6
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ryanpboyce12@gmail.com>) id 1hdHG5-0000Y1-8A
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ryanpboyce12@gmail.com>) id 1hdHG2-00012a-EI
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:46:57 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e]:42343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ryanpboyce12@gmail.com>)
 id 1hdHFx-0000nc-FL
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:46:52 -0400
Received: by mail-qt1-x82e.google.com with SMTP id s15so16132733qtk.9
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ozhGyiX5GGyANNqdzEPXuP/b6YXYV5RnVLKgP0S/yWg=;
 b=aHGt9QbrUjng0GxdCm8vY+mOp216t8xXO491NTkL66B6n+jIWZWs61bbIzLt1+bu/d
 5aYfi0TEvzwebsWQizAiArYIIZ2UZMFx+h92kFS4J2UszdO73it+m2habHa/arD6l9qn
 Kcx+62WUtBnaHx7MtrY8dz8O399A1V+tJ9dTyzxVgPqNFBr/VDiqfTaugXX9jHn7FwVf
 1DhLZgG7i7ARqbW+xsMyNKPCAa0tqpImdpSHsz/a6ePDIOhTjfIjTNVNIycjCKkZ9QQS
 JFLULErBqI3AGjZd1vqKA/MluOAANtP4gbn7NjoBc3clzAR0xR/CoWDbIx1g9/HyQ1Tb
 eKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ozhGyiX5GGyANNqdzEPXuP/b6YXYV5RnVLKgP0S/yWg=;
 b=VuaewbLc4c+uE0BS0IERZzfnfzqAPGXC06S/MDPW6o9iPNo49l3B/7UoMC2d2jQqWE
 c2KoBpf9p5ySqOwWAUoYChnwts+IwhcH8moerEcdgyuth5bVl1Uqa3QtCcOQNOibeoyB
 M3A7K6NOri+j+XsRYyM97Fjgsg9kn4YrZNX7Vhfjk48hTp9+X9lBxbjY+aANZiCaPZI/
 nu0Pq+lGRnNOetTnNfAn2JLQtB1DkCLe5sTJp56k8dE2Nu70OVtvrXuMXNsxBqcNqeYo
 ccE17dSw/xJ2440bwf6LDtWmrtq9gHjDr29qTgBIRWIPWt2nagFy96kyzBd3k0H8DVeT
 z4WQ==
X-Gm-Message-State: APjAAAVMB+MHNzZK6hho5CpxyfIUU1sufyBCy4V3NDdpmsNDa8fwJRfb
 Ysi/6+FI1nTzzPdzO7EtBpCsMads+0WbPmUbk/A=
X-Google-Smtp-Source: APXvYqyO4lIz7JXC8g/qmOSp6OH/Rj2Jlq4uWlvqHiiwm+3EHKzFpKWvw9regHCvyYWztWhdWkuuqgqfjfAQ50iMwBc=
X-Received: by 2002:a0c:9e5b:: with SMTP id z27mr27211026qve.67.1560876398417; 
 Tue, 18 Jun 2019 09:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOJt3afDmLtb1328ZWRvbO=SYgqtGZYX-aApTMoDPffiErygGg@mail.gmail.com>
 <CAHDbmO2cxxAv2Fqotfw8S8DBh7J+9oa67N8K_Ps_25vRbtpe3Q@mail.gmail.com>
 <CAOJt3ad2HbohoBRv8Ey9fknBRGeiN1SJ7wAk9gX+Vpf4pig_KA@mail.gmail.com>
In-Reply-To: <CAOJt3ad2HbohoBRv8Ey9fknBRGeiN1SJ7wAk9gX+Vpf4pig_KA@mail.gmail.com>
From: Ryan Boyce <ryanpboyce12@gmail.com>
Date: Tue, 18 Jun 2019 12:46:27 -0400
Message-ID: <CAOJt3acuu-eLwnKFUpEQ9V0JqqQs8=dyRUKJVRHKSDzbdGVGpA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] qemu processes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex,

I have another KVM/qemu related CPU question. I am hoping you will be so
kind as to answer again. I have a Dell Poweredge T430 server running a
single Intel Xeon E5-2603 v3 CPU with 6 cores. I have 6 VMs running CentOS
7 via KVM. I am noticing some terrible host CPU performance when a VM runs
a simple process such as a recursive search on its file system. I see VM
CPU acting normally but the host CPU skyrockets to well over 100%. I have a
few ideas as to why this is but am hoping you might be able to point me in
the right direction. Thank you so much for your help!

Ryan

On Wed, Jun 12, 2019 at 12:50 PM Ryan Boyce <ryanpboyce12@gmail.com> wrote:

> Thank you my friend!
>
> On Wed, Jun 12, 2019 at 12:48 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
>
> wrote:
>
>> You've actually contacted the development list but I can answer the
>> question.
>>
>> QEMU is multi-threaded so there will be a thread per KVM based vCPU
>> (and also for TCG based vCPUs where MTTCG is enabled). There will also
>> be a number of additional threads created including at least one for
>> the main monitor thread and potentially additional threads for
>> servicing IO requests. So expect to see $SMP + 1 + n threads for each
>> QEMU instance.
>>
>> On Wed, 12 Jun 2019 at 16:32, Ryan Boyce <ryanpboyce12@gmail.com> wrote:
>> >
>> > Hi Stefan,
>> >
>> > I am a big fan of your blog! In relation to your blog post,
>> >
>> http://blog.vmsplice.net/2011/03/qemu-internals-big-picture-overview.htm=
l
>> ,
>> > I have a question I am really hoping you can answer:
>> >
>> > When I start a VM, I see that the qemu-kvm processes start and run as
>> > "qemu-kvm..... -name "something1"...."
>> > My issue, though, is I see multiple processes running as "qemu-kvm....=
.
>> > -name "something1"...." and each of these processes has memory/cpu/dis=
k
>> > mapped to it.
>> > Does qemu-kvm run VMs on a one-to-one VM-to-host process basis? Or doe=
s
>> > each virtual cpu on the guest get its own process on the host?
>> > For example, If I have a VM that has 4 virtual cpus, will I see 4
>> processes
>> > (PIDs) on the host or should I see just see one for the VM itself.
>> >
>> > Any help you can give would be GREATLY appreciated. Thank you!
>> >
>> > Ryan
>>
>>
>>
>> --
>> Alex Benn=C3=A9e
>> KVM/QEMU Hacker for Linaro
>>
>
