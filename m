Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27142C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE4420748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vs7XItri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE4420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbm1a-00052W-66
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jbm0i-0003sL-UV
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:17:24 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jbm0h-0005O5-6A
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:17:24 -0400
Received: by mail-lf1-x144.google.com with SMTP id h188so4551284lfd.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R9gWcy5lFPxmq9Vk1uyXUnzN6teT8VSFX6pawSbm37A=;
 b=Vs7XItrisBD9FWw6nV0u+5CPyc+IzP/0MgOCvry8oBbCJAj5rqhL8SGyZYSxCWILs2
 Tv+J0ITpxFamkc5xbW+M5lLx7Xte+F2wOsNkShCnMiM2Db+pM7ycNElnozFrQYXfYW0r
 wRjPeT8OhDH7zOVVw/M5lMLxO9jE2lAwB7GFk3WzlKDNfJrHccpiEqSCSwtl7+PKRZHF
 B9Qvk9i/59V6WETM3xvtBgV26ZdKdbB2L6vPWnrjiEQvVOldEPRwRY3M/+k2McT4oer2
 nmkEFnnaCSnmbJaNmLs1/vVDnvw1li3af9dGtanKJp0veCH/kGYpHDNmXiuH6dWyxj3L
 KYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R9gWcy5lFPxmq9Vk1uyXUnzN6teT8VSFX6pawSbm37A=;
 b=ZqfpqIUVUxrwABGzyUl1zcRoMexQmnPr7GRDBblc1JSwvga3Qk4hxhPzZVO7E138Ft
 py7fn8Ij1Q6Qm6H8Axt3+e9AfnXbwV8Ax/xDZWIgoqX5zMcUBnUjIB9LyplYu0o4fVXF
 T8Os67aF1SOQ8m3ZppNzZsNmgCw2TE/nHRcwGVjf46mXHEQ2KQOkjT6pEV0HJYLy0q21
 oMB6911oHsgHftIPsNPLAvBQGs3/6bHdaqWyGbtDqJGo9O1MF06kBAgCFKwnzNs0OycV
 pakJQDsF9itSMjpwhvoCEWy3SnwVzicYbvDiIyRs3i39q/0QqHFO2fSNLpFbcueeD9s7
 15+A==
X-Gm-Message-State: AOAM531zHKAN8p1L9r2WB0P18ItnWByMIgZbX5yRkKmfD3zcWqQU0LD3
 9pqTpsKVUexIGYT3KKP2jCtNO6rbYjZBh5AEnb5/SQ==
X-Google-Smtp-Source: ABdhPJzYB8NZcb2gxdZky8Awl6nJ990at3Zwnqtk806wL4STL/DkfYvoUnkVYmePt1USmx2mqCTAgBW+4oqWpAwWFpY=
X-Received: by 2002:a19:550e:: with SMTP id n14mr5256137lfe.81.1590070640437; 
 Thu, 21 May 2020 07:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-75-robert.foley@linaro.org> <87imh1f79b.fsf@linaro.org>
 <CAEyhzFt1=xDMN5KdQvVx8QyS5n35THa2vY9D3rV8S9emyTYpSw@mail.gmail.com>
 <CAEyhzFuiDWYvu3FZNYy5M0FQ91Cs=-4=kV80xQZHEWX+ejhyTw@mail.gmail.com>
 <20200520044613.GA359481@sff>
 <CAEyhzFuraifsPTBrM2g+KQVWvD09Q3fwdh=fCo+a9YOTRBAMeg@mail.gmail.com>
In-Reply-To: <CAEyhzFuraifsPTBrM2g+KQVWvD09Q3fwdh=fCo+a9YOTRBAMeg@mail.gmail.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 21 May 2020 10:17:13 -0400
Message-ID: <CAEyhzFs4XdUR1RAF7m-BXVDvz1F05SM8fPOZ0xujZcZ0Fxat=A@mail.gmail.com>
Subject: Re: [PATCH v8 74/74] cputlb: queue async flush jobs without the BQL
To: "Emilio G. Cota" <cota@braap.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We re-ran the numbers for a ppc64 VM, using the additional configuration
details.
This seems to show the scalability gains much clearer.

                   Speedup vs a single thread for kernel build

  7 +-----------------------------------------------------------------------+
    |         +          +         +         +         +          +         |
    |                                    ###########       baseline ******* |
    |                               #####           ####   cpu lock ####### |
    |                             ##                    ####                |
  6 |-+                         ##                          ##            +-|
    |                         ##                              ####          |
    |                       ##                                    ###       |
    |                     ##        *****                            #      |
    |                   ##      ****     ***                          #     |
    |                 ##     ***            *                               |
  5 |-+             ##    ***                ****                         +-|
    |              #  ****                       **                         |
    |             # **                             **                       |
    |             #*                                 **                     |
    |          #*                                          **               |
    |         #*                                             *              |
    |         #                                               ******        |
    |        #                                                      **      |
    |       #                                                         *     |
  3 |-+     #                                                             +-|
    |      #                                                                |
    |      #                                                                |
    |     #                                                                 |
    |     #                                                                 |
  2 |-+  #                                                                +-|
    |    #                                                                  |
    |   #                                                                   |
    |   #                                                                   |
    |  #                                                                    |
    |  #      +          +         +         +         +          +         |
  1 +-----------------------------------------------------------------------+
    0         5          10        15        20        25         30        35
                                   Guest vCPUs

https://drive.google.com/file/d/1ASg5XyP9hNfN9VysXC3qe5s9QSJlwFAt/view?usp=sharing

Thanks & Regards,
-Rob

On Wed, 20 May 2020 at 11:01, Robert Foley <robert.foley@linaro.org> wrote:
>
> On Wed, 20 May 2020 at 00:46, Emilio G. Cota <cota@braap.org> wrote:
> >
> > On Mon, May 18, 2020 at 09:46:36 -0400, Robert Foley wrote:
> >
> > Thanks for doing these tests. I know from experience that benchmarking
> > is hard and incredibly time consuming, so please do not be discouraged by
> > my comments below.
> >
>
> Hi,
> Thanks for all the comments, and for including the script!
> These are all very helpful.
>
> We will work to replicate these results using a PPC VM,
> and will re-post them here.
>
> Thanks & Regards,
> -Rob
>
> > A couple of points:
> >
> > 1. I am not familiar with aarch64 KVM but I'd expect it to scale almost
> > like the native run. Are you assigning enough RAM to the guest? Also,
> > it can help to run the kernel build in a ramfs in the guest.
>
> > 2. The build itself does not seem to impose a scaling limit, since
> > it scales very well when run natively (per-thread I presume aarch64 TCG is
> > still slower than native, even if TCG is run on a faster x86 machine).
> > The limit here is probably aarch64 TCG. In particular, last time I
> > checked aarch64 TCG has room for improvement scalability-wise handling
> > interrupts and some TLB operations; this is likely to explain why we
> > see no benefit with per-CPU locks, i.e. the bottleneck is elsewhere.
> > This can be confirmed with the sync profiler.
> >
> > IIRC I originally used ppc64 for this test because ppc64 TCG does not
> > have any other big bottlenecks scalability-wise. I just checked but
> > unfortunately I can't find the ppc64 image I used :( What I can offer
> > is the script I used to run these benchmarks; see the appended.
> >
> > Thanks,
> >                 Emilio
> >
> > ---
> > #!/bin/bash
> >
> > set -eu
> >
> > # path to host files
> > MYHOME=/local/home/cota/src
> >
> > # guest image
> > QEMU_INST_PATH=$MYHOME/qemu-inst
> > IMG=$MYHOME/qemu/img/ppc64/ubuntu.qcow2
> >
> > ARCH=ppc64
> > COMMON_ARGS="-M pseries -nodefaults \
> >                 -hda $IMG -nographic -serial stdio \
> >                 -net nic -net user,hostfwd=tcp::2222-:22 \
> >                 -m 48G"
> >
> > # path to this script's directory, where .txt output will be copied
> > # from the guest.
> > QELT=$MYHOME/qelt
> > HOST_PATH=$QELT/fig/kcomp
> >
> > # The guest must be able to SSH to the HOST without entering a password.
> > # The way I set this up is to have a passwordless SSH key in the guest's
> > # root user, and then copy that key's public key to the host.
> > # I used the root user because the guest runs on bootup (as root) a
> > # script that scp's run-guest.sh (see below) from the host, then executes it.
> > # This is done via a tiny script in the guest invoked from systemd once
> > # boot-up has completed.
> > HOST=foo@bar.edu
> >
> > # This is a script in the host to use an appropriate cpumask to
> > # use cores in the same socket if possible.
> > # See https://github.com/cota/cputopology-perl
> > CPUTOPO=$MYHOME/cputopology-perl
> >
> > # For each run we create this file that then the guest will SCP
> > # and execute. It is a quick and dirty way of passing arguments to the guest.
> > create_file () {
> >     TAG=$1
> >     CORES=$2
> >     NAME=$ARCH.$TAG-$CORES.txt
> >
> >     echo '#!/bin/bash' > run-guest.sh
> >     echo 'cp -r /home/cota/linux-4.18-rc7 /tmp2/linux' >> run-guest.sh
> >     echo "cd /tmp2/linux" >> run-guest.sh
> >     echo "{ time make -j $CORES vmlinux >/dev/null; } 2>>/home/cota/$NAME" >> run-guest.sh
> >     # Output with execution time is then scp'ed to the host.
> >     echo "ssh $HOST 'cat >> $HOST_PATH/$NAME' < /home/cota/$NAME" >> run-guest.sh
> >     echo "poweroff" >> run-guest.sh
> > }
> >
> > # Change here THREADS and also the TAGS that point to different QEMU installations.
> > for THREADS in 64 32 16; do
> >     for TAG in cpu-exclusive-work cputlb-no-bql per-cpu-lock cpu-has-work baseline; do
> >         QEMU=$QEMU_INST_PATH/$TAG/bin/qemu-system-$ARCH
> >         CPUMASK=$($CPUTOPO/list.pl --policy=compact-smt $THREADS)
> >
> >         create_file $TAG $THREADS
> >         time taskset -c $CPUMASK $QEMU $COMMON_ARGS -smp $THREADS
> >     done
> > done

