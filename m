Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F703C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 04:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1056D207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 04:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="wQIHe8xC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1056D207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbGdS-0001lt-2v
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 00:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jbGcU-0000tl-LU
 for qemu-devel@nongnu.org; Wed, 20 May 2020 00:46:18 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jbGcT-0004lA-37
 for qemu-devel@nongnu.org; Wed, 20 May 2020 00:46:18 -0400
Received: by mail-qt1-x842.google.com with SMTP id n22so1571940qtv.12
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 21:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Zf7wnHGkJRcNplEvQx4ImRvBuF07SVlXLZq7AJ/XlYM=;
 b=wQIHe8xCKhtW/3f9guI6eF2iHjE2HAhMyzvLFQJHGJyZ+LEiwv5igiICZU88plINDh
 RZEFWQZRF+IJTje8aN+1ewmMnWlax3jjrv/vv5e1aWywd+diRqDQOw0SclFM6lEfIbZ4
 8Z72i7i5XtQVLvjS1dvbad8P6Xx23y6cpcKA+l/RoNMXV6H+ZcHUsP51nAoX3NiyUV0+
 y7jn0jT4MpY1d5bm71aWUCKU924kzZUZ2c99kNZQBa1EiPoQf7Oes+S+vm6vMAnPIPCx
 BedIHyYeCd7fW6+296D+o5KRMgqUw9M1cMgtxf0flnJQsCynZS0aeRQSMVuVIWK3QCHM
 hYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Zf7wnHGkJRcNplEvQx4ImRvBuF07SVlXLZq7AJ/XlYM=;
 b=bubnKwsFXmPQmB/Wev7u7eNhUx84uMwX56B/pSjBDVsm/eGouDq1SwBxPcnDs6ZTEi
 VjG9DIDgTRyDaiybUzta1cCYBlL1mqL1Ep5nr3S9IjSmn8nLFOuzpgIkkJxV1spw111m
 wib6qBrPJvYStOyFXnwm9CpobtaR+Arota/Y5djQQKVZVLVlekItbtw+E/3KjrCMn0io
 d3/dHnmsYcRU1szBq6qfu7Jok3U4eRfzmO5uqm94MeHR33Hwd52ITfNqVIMTI6SUS5cm
 CrXvr9w7Lu7S+uGi4PIYC8t9DTYiVNsKI/lpZgtILiFrOfF+o8Q773fqBU3sv4FvMYeD
 DDew==
X-Gm-Message-State: AOAM5317EUDYdtp4Njj89ofu9T379S/taRbXDU61R/4U2G8DgnUPrVop
 Ootlg3Wc4CxB0Hvzf6eosl6xTQ==
X-Google-Smtp-Source: ABdhPJyOaMdJ51ftLQriiV4bpvQluWUE9PVOwsrOgTiTqL5gymrpfnO67Uxs0CAXNQyq4BI+cSnnIg==
X-Received: by 2002:ac8:36a3:: with SMTP id a32mr3589882qtc.196.1589949974551; 
 Tue, 19 May 2020 21:46:14 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id i59sm1443798qtb.58.2020.05.19.21.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 21:46:13 -0700 (PDT)
Date: Wed, 20 May 2020 00:46:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v8 74/74] cputlb: queue async flush jobs without the BQL
Message-ID: <20200520044613.GA359481@sff>
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-75-robert.foley@linaro.org>
 <87imh1f79b.fsf@linaro.org>
 <CAEyhzFt1=xDMN5KdQvVx8QyS5n35THa2vY9D3rV8S9emyTYpSw@mail.gmail.com>
 <CAEyhzFuiDWYvu3FZNYy5M0FQ91Cs=-4=kV80xQZHEWX+ejhyTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEyhzFuiDWYvu3FZNYy5M0FQ91Cs=-4=kV80xQZHEWX+ejhyTw@mail.gmail.com>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::842;
 envelope-from=cota@braap.org; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 09:46:36 -0400, Robert Foley wrote:
> We re-ran the numbers with the latest re-based series.
> 
> We used an aarch64 ubuntu VM image with a host CPU:
> Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz, 2 CPUs, 10 cores/CPU,
> 20 Threads/CPU.  40 cores total.
> 
> For the bare hardware and kvm tests (first chart) the host CPU was:
> HiSilicon 1620 CPU 2600 Mhz,  2 CPUs, 64 Cores per CPU, 128 CPUs total.
> 
> First, we ran a test of building the kernel in the VM.
> We did not see any major improvements nor major regressions.
> We show the results of the Speedup of building the kernel
> on bare hardware compared with kvm and QEMU (both the baseline and cpu locks).
> 
> 
>                    Speedup vs a single thread for kernel build
> 
>   40 +----------------------------------------------------------------------+
>      |         +         +         +          +         +         +  **     |
>      |                                                bare hardwar********* |
>      |                                                          kvm ####### |
>   35 |-+                                                   baseline $$$$$$$-|
>      |                                                    *cpu lock %%%%%%% |
>      |                                                 ***                  |
>      |                                               **                     |
>   30 |-+                                          ***                     +-|
>      |                                         ***                          |
>      |                                      ***                             |
>      |                                    **                                |
>   25 |-+                               ***                                +-|
>      |                              ***                                     |
>      |                            **                                        |
>      |                          **                                          |
>   20 |-+                      **                                          +-|
>      |                      **                                #########     |
>      |                    **                  ################              |
>      |                  **          ##########                              |
>      |                **         ###                                        |
>   15 |-+             *       ####                                         +-|
>      |             **     ###                                               |
>      |            *    ###                                                  |
>      |           *  ###                                                     |
>   10 |-+       **###                                                      +-|
>      |        *##                                                           |
>      |       ##  $$$$$$$$$$$$$$$$                                           |
>      |     #$$$$$%%%%%%%%%%%%%%%%%%%%                                       |
>    5 |-+  $%%%%%%                    %%%$%$%$%$%$%$%$%$%$%$%$%$%$%$%$%    +-|
>      |   %%                                                           %     |
>      | %%                                                                   |
>      |%        +         +         +          +         +         +         |
>    0 +----------------------------------------------------------------------+
>      0         10        20        30         40        50        60        70
>                                    Guest vCPUs
> 
> 
> After seeing these results and the scaling limits inherent in the build itself,
> we decided to run a test which might show the scaling improvements clearer.

Thanks for doing these tests. I know from experience that benchmarking
is hard and incredibly time consuming, so please do not be discouraged by
my comments below.

A couple of points:

1. I am not familiar with aarch64 KVM but I'd expect it to scale almost
like the native run. Are you assigning enough RAM to the guest? Also,
it can help to run the kernel build in a ramfs in the guest.

2. The build itself does not seem to impose a scaling limit, since
it scales very well when run natively (per-thread I presume aarch64 TCG is
still slower than native, even if TCG is run on a faster x86 machine).
The limit here is probably aarch64 TCG. In particular, last time I
checked aarch64 TCG has room for improvement scalability-wise handling
interrupts and some TLB operations; this is likely to explain why we
see no benefit with per-CPU locks, i.e. the bottleneck is elsewhere.
This can be confirmed with the sync profiler.

IIRC I originally used ppc64 for this test because ppc64 TCG does not
have any other big bottlenecks scalability-wise. I just checked but
unfortunately I can't find the ppc64 image I used :( What I can offer
is the script I used to run these benchmarks; see the appended.

Thanks,
		Emilio

---
#!/bin/bash

set -eu

# path to host files
MYHOME=/local/home/cota/src

# guest image
QEMU_INST_PATH=$MYHOME/qemu-inst
IMG=$MYHOME/qemu/img/ppc64/ubuntu.qcow2

ARCH=ppc64
COMMON_ARGS="-M pseries -nodefaults \
		-hda $IMG -nographic -serial stdio \
		-net nic -net user,hostfwd=tcp::2222-:22 \
		-m 48G"

# path to this script's directory, where .txt output will be copied
# from the guest.
QELT=$MYHOME/qelt
HOST_PATH=$QELT/fig/kcomp

# The guest must be able to SSH to the HOST without entering a password.
# The way I set this up is to have a passwordless SSH key in the guest's
# root user, and then copy that key's public key to the host.
# I used the root user because the guest runs on bootup (as root) a
# script that scp's run-guest.sh (see below) from the host, then executes it.
# This is done via a tiny script in the guest invoked from systemd once
# boot-up has completed.
HOST=foo@bar.edu

# This is a script in the host to use an appropriate cpumask to
# use cores in the same socket if possible.
# See https://github.com/cota/cputopology-perl
CPUTOPO=$MYHOME/cputopology-perl

# For each run we create this file that then the guest will SCP
# and execute. It is a quick and dirty way of passing arguments to the guest.
create_file () {
    TAG=$1
    CORES=$2
    NAME=$ARCH.$TAG-$CORES.txt

    echo '#!/bin/bash' > run-guest.sh
    echo 'cp -r /home/cota/linux-4.18-rc7 /tmp2/linux' >> run-guest.sh
    echo "cd /tmp2/linux" >> run-guest.sh
    echo "{ time make -j $CORES vmlinux >/dev/null; } 2>>/home/cota/$NAME" >> run-guest.sh
    # Output with execution time is then scp'ed to the host.
    echo "ssh $HOST 'cat >> $HOST_PATH/$NAME' < /home/cota/$NAME" >> run-guest.sh
    echo "poweroff" >> run-guest.sh
}

# Change here THREADS and also the TAGS that point to different QEMU installations.
for THREADS in 64 32 16; do
    for TAG in cpu-exclusive-work cputlb-no-bql per-cpu-lock cpu-has-work baseline; do
	QEMU=$QEMU_INST_PATH/$TAG/bin/qemu-system-$ARCH
	CPUMASK=$($CPUTOPO/list.pl --policy=compact-smt $THREADS)

	create_file $TAG $THREADS
	time taskset -c $CPUMASK $QEMU $COMMON_ARGS -smp $THREADS
    done
done

