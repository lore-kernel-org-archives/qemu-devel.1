Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21A5C282DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EA62146F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EA62146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44435 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRkm-00041R-Rh
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:31:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hCRjk-0003di-Bl
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1hCRjf-0008Cd-15
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:30:38 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1hCRjS-0007dD-A0
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:30:29 -0400
Received: by mail-wm1-f48.google.com with SMTP id z24so7905316wmi.5
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version;
	bh=IGtJ9wa2Hg3mtjprACCwVbj5MDJo07fXpgAYCEdR8dg=;
	b=I7GzT/IcYbegThaUOIPHMr9tFy8QoNF+8Had1k414y6tP+fYyU5HxGeB0OWyTAZKne
	T6jdxitpluHteHQKsTdNuDXh01L0NDY+kozc4xPVyYrRNIYsyz81jY8Uv9Q5wTNt4twy
	+x5pIkzvry4HLUqJvUDDkEHvSIbAwHtXg3GM32KeRFtF0/9yCeVXgcEfJpwTTfX3E6K0
	1qJbfNHgd64yyUXHRqycaDoMK260UoUw+NKV+v5m1NcULoQxe96/U5wz24t/D7JEiYS1
	eYDliONX4QCTY+u1cSkWbdfBRJA46n0MDrQf8I7+gt6+6aXo4n2VpOnZKlz+Qg84BZTd
	WDfA==
X-Gm-Message-State: APjAAAWvRLL/u3v4XpQ+9Lt5hF3LDQZZwBcz8/fiFgO3klmlmbKBwYLU
	tJ3XIgeAK0g4yvjKvnqaOQkXMw==
X-Google-Smtp-Source: APXvYqwtk5FmCFG247S0kQoBk6kQQUMp/h+8C7kMj8DYPe5ZDymTEYrdQoyt1CRp7WyHOeI+qaXbyg==
X-Received: by 2002:a1c:2d91:: with SMTP id t139mr8549838wmt.102.1554481793001;
	Fri, 05 Apr 2019 09:29:53 -0700 (PDT)
Received: from dritchie.redhat.com ([80.30.223.174])
	by smtp.gmail.com with ESMTPSA id h9sm1789182wmb.5.2019.04.05.09.29.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 09:29:51 -0700 (PDT)
References: <20190326131822.GD15011@stefanha-x1.localdomain>
User-agent: mu4e 1.0; emacs 26.1
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
In-reply-to: <20190326131822.GD15011@stefanha-x1.localdomain>
Date: Fri, 05 Apr 2019 18:29:49 +0200
Message-ID: <878swomn42.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.48
Subject: Re: [Qemu-devel] QEMU event loop optimizations
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405162949.KDxqBUTuznaZPWlOM7sxudpk8ndTAToM6XJEIop-Tys@z>

--=-=-=
Content-Type: text/plain


Stefan Hajnoczi writes:

> Hi Sergio,
> Here are the forgotten event loop optimizations I mentioned:
>
>   https://github.com/stefanha/qemu/commits/event-loop-optimizations
>
> The goal was to eliminate or reorder syscalls so that useful work (like
> executing BHs) occurs as soon as possible after an event is detected.
>
> I remember that these optimizations only shave off a handful of
> microseconds, so they aren't a huge win.  They do become attractive on
> fast SSDs with <10us read/write latency.
>
> These optimizations are aggressive and there is a possibility of
> introducing regressions.
>
> If you have time to pick up this work, try benchmarking each commit
> individually so performance changes are attributed individually.
> There's no need to send them together in a single patch series, the
> changes are quite independent.

It took me a while to find a way to get meaningful numbers to evaluate
those optimizations. The problem is that here (Xeon E5-2640 v3 and EPYC
7351P) the cost of event_notifier_set() is just ~0.4us when the code
path is hot, and it's hard differentiating it from the noise.

To do so, I've used a patched kernel with a naive io_poll implementation
for virtio_blk [1], an also patched QEMU with poll-inflight [2] (just to
be sure we're polling) and ran the test on semi-isolated cores
(nohz_full + rcu_nocbs + systemd_isolation) with idle siblings. The
storage is simulated by null_blk with "completion_nsec=0 no_sched=1
irqmode=0".

# fio --time_based --runtime=30 --rw=randread --name=randread \
 --filename=/dev/vdb --direct=1 --ioengine=pvsync2 --iodepth=1 --hipri=1

| avg_lat (us) | master | qbsn* |
|   run1       | 11.32  | 10.96 |
|   run2       | 11.37  | 10.79 |
|   run3       | 11.42  | 10.67 |
|   run4       | 11.32  | 11.06 |
|   run5       | 11.42  | 11.19 |
|   run6       | 11.42  | 10.91 |
 * patched with aio: add optimized qemu_bh_schedule_nested() API

Even though there's still some variance in the numbers, the 0.4us
improvement can be clearly appreciated.

I haven't tested the other 3 patches, as their optimizations only have
effect when the event loop is not running in polling mode. Without
polling, we get an additional overhead of, at least, 10us, in addition
to a lot of noise, due to both direct costs (ppoll()...) and indirect
ones (re-scheduling and TLB/cache pollution), so I don't think we can
reliable benchmark them. Probably their impact won't be significant
either, due to the costs I've just mentioned.

Sergio.

[1] https://github.com/slp/linux/commit/d369b37db3e298933e8bb88c6eeacff07f39bc13
[2] https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg00447.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlyngn0ACgkQ9GknjS8M
AjX5ThAAhdU6dwvSXtqoXMYKjKLVAVCCVY13UNyuEtddfJuLwgn0ghk/KGRIlgum
ZWJmlimkWSFzypOL9XGoA5byMmh78uI6RsYLYtArBdFxeRHk9Ie1Xmjx5hRgz049
Now7hu7qlQv7Bv3hrC6FY0/Mx6uTdTKB0+hoXqRjGI2Sr4x8ZYCDgWdUnX5fJ3DL
4fUJcyX8Mt9HjaMCH2Y/NUElTVKHVNAH9CL1UuA6Gfaj0B5Ly0KUqb6NMB+fZeIk
P4JEkiMkiqM/0FV27R2Sm3C7JmqfwxplVCVZXUT1kPEtZBk4P7YK5MIpBxbLCMJ7
T2vwDNCTrnoK8/mQGictdVPq/S1e1m63I2LIbA8BAcDPhMazWNmS4ChOZGw0H32e
N9U6Qhp60idcjYDrG05Sg8pBohW4vw6AnN3n6shbIW1ao7DQjLD8VDNqN/ZdCSEm
7Oanv8EmrSRiDI29Kpj0y8KbDQVP8zYTYFwlLaQYYqfbiZsGER52CUGXzY77feeZ
kB7vsrjNz13a4hYS6mOcQkJJeku0bCChfNGXKkpQX5dMd8Ghs3NxSSCY79G1maUF
RtPuALcHBHKr16eeMycCDQIVji24s14MLe9eJzKQQkIoHnc9ThU48oj+YZ51HxoE
t++RwIpruCMLxJfuUi0ybXXpc9iOJFcY4LYKbnQ4nTZhj0Ctu7o=
=h9Wc
-----END PGP SIGNATURE-----
--=-=-=--

