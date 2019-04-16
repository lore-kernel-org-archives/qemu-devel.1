Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FA5C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFD020675
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/iWRhFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFD020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33687 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGKHW-0001Wl-KR
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 05:21:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hGKGl-0001Bp-5e
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hGKGk-0001dB-2s
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:20:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hGKGj-0001c0-I7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:20:46 -0400
Received: by mail-wm1-x343.google.com with SMTP id z6so1877102wmi.0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=YSx59gGCm/mHvdL8LzqkCxkpNVaZRBfVUcOOK6wQ+F8=;
	b=u/iWRhFFBTl5tU7x0f/PbExbFm49SqlamrrF74/R4piJDpX5T3bgK6qWdlNvVKZsbZ
	D+LT5yo9c9+k32hqnUvZz++bw9tbvgywdIRiyojpNDHwQD6izxFoVkdzicCnxfEEM5r2
	F+Xh0ju6OXAJQhLeRo9NJQncTzBL4hWU5BgxS/8JTFhjm16zD4J1+8Fsbe3+xaoUlMPU
	lCjB7bTxeWWo5+CdIRzMuQCuqmNOsb/kxxC2NnudyEyDOftQKXR5/E57j6d/3c0cU9J+
	8UJeouB2iY3PHaSGmojF5aJEHYhs8/b/Rxp9StNPZc9388Rp+7fVE2MLziDQ5+3G+hY2
	2BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=YSx59gGCm/mHvdL8LzqkCxkpNVaZRBfVUcOOK6wQ+F8=;
	b=B/vofeNKknWHZCra4jW+V4OlDei1x0CLG2mSP2YBhllxP9usSL/9MBTMJJvNoh3J5K
	7DR8E2uvWpy+RPDTVELY0buLljcz2S66gmSWgHIz4dL6tmgXYC4Ir30QJMvD9O4w7ful
	/bYqjyCOz13lYqL6dnJHeOegfeWh8IRg0mQ28yF94/yCU1lCyGX8RSx+vsqiDtR1izTp
	3OqdUxA7uHXkY0mhGnCRqC7szA2qrT23yAmmd1YdRP7Ln6Va6067Im7+d1E7yKax3pq6
	It+pu6KdgBKS5bIpECTZg+FeGznhZP4fg1CtScUsxOEUtTgTACiCPcSrJrGBa/Wx115Y
	c2Ug==
X-Gm-Message-State: APjAAAWv+xp3BFoj6VKSweXJHfsNMRSkRXKWJ9mFr67McfjNGnwnLg6l
	uw3uidCdNYi12u8Uvhdvdv8=
X-Google-Smtp-Source: APXvYqy4BO3tfV+FJ3rF8IwWR+bfcweGh+VSUpG6o7/5pJ2/OS8BIKGniHWaGuZd05AAwSC17wG69Q==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr27308623wme.72.1555406444078;
	Tue, 16 Apr 2019 02:20:44 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	v16sm106703491wro.48.2019.04.16.02.20.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 16 Apr 2019 02:20:43 -0700 (PDT)
Date: Tue, 16 Apr 2019 10:20:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <20190416092042.GB32709@stefanha-x1.localdomain>
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Wei Li <wei.d.li@oracle.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416092042.0LIIEhpDrukkHdY3VAL-Qd-GT4nGcymJiDxugT5yaCQ@z>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 07:23:38AM +0800, Dongli Zhang wrote:
>=20
>=20
> On 4/16/19 1:34 AM, Wei Li wrote:
> > Hi @Paolo Bonzini & @Stefan Hajnoczi,
> >=20
> > Would you please help confirm whether @Paolo Bonzini's multiqueue featu=
re change will benefit virtio-scsi or not? Thanks!
> >=20
> > @Stefan Hajnoczi,
> > I also spent some time on exploring the virtio-scsi multi-queue feature=
s via num_queues parameter as below, here are what we found:
> >=20
> > 1. Increase number of Queues from one to the same number as CPU will ge=
t better IOPS increase.
> > 2. Increase number of Queues to the number (e.g. 8) larger than the num=
ber of vCPU (e.g. 2) can get even better IOPS increase.
>=20
> As mentioned in below link, when the number of hw queues is larger than
> nr_cpu_ids, the blk-mq layer would limit and only use at most nr_cpu_ids =
queues
> (e.g., /sys/block/sda/mq/).
>=20
> That is, when the num_queus=3D4 while vcpus is 2, there should be only 2 =
queues
> available /sys/block/sda/mq/
>=20
> https://lore.kernel.org/lkml/1553682995-5682-1-git-send-email-dongli.zhan=
g@oracle.com/
>=20
> I am just curious how increasing the num_queues from 2 to 4 would double =
the
> iops, while there are only 2 vcpus available...

I don't know the answer.  It's especially hard to guess without seeing
the benchmark (fio?) configuration and QEMU command-line.

Common things to look at are:

1. Compare "iostat -dx 1" inside the guest and host.  Are the I/O
   patterns comparable?  blktrace(8) can give you even more detail on
   the exact I/O patterns.  If the guest and host have different I/O
   patterns (blocksize, IOPS, queue depth) then request merging or
   I/O scheduler effects could be responsible for the difference.

2. kvm_stat or perf record -a -e kvm:\* counters for vmexits and
   interrupt injections.  If these counters vary greatly between queue
   sizes, then that is usually a clue.  It's possible to get higher
   performance by spending more CPU cycles although your system doesn't
   have many CPUs available, so I'm not sure if this is the case.

3. Power management and polling (kvm.ko halt_poll_ns, tuned profiles,
   and QEMU iothread poll-max-ns).  It's expensive to wake a CPU when it
   goes into a low power mode due to idle.  There are several features
   that can keep the CPU awake or even poll so that request latency is
   reduced.  The reason why the number of queues may matter is that
   kicking multiple queues may keep the CPU awake more than batching
   multiple requests onto a small number of queues.

Stefan

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctZ5qAAoJEJykq7OBq3PI3m4IAJm5zNOKfl1Ucmhj1in4Hz/t
KTJJbVermP7Ctx5cYf7q5mKo8yh+GYxtbU9ZsA4feXg6iZh7pMLipeaTZMD6H6am
lAosO8CR9PGstjZNYuBkHVZfR+f/Io2Ghws0X/7fAJMP+oMvVctGODUYuKFJTlqb
QJb1qSi/kJg2UwKHffw+RjitEC9VOmz03kytZ6QJNVpRBO0plbFk8wAo/gkS6nSH
w8zvGZIk89wK12ZjvOSacHS2nOrHaUsc3EqkOWX59Vlpu+hELX4DXzXM+Jf1h9hb
XYNFUIrZe3FX9GLG99w0Rul9ZczsR25x1Bpb7BDInV2iH8tETysr740gwMgrLkQ=
=KRy6
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--

