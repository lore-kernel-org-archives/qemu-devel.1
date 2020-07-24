Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F96C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B982065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmP41YJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B982065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jywtd-0001gD-6z
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 08:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jywsu-0001G1-6I
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:33:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34263
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jywsr-00020k-Rr
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595593985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UqDQvr5+xg+tOnPmUruQABTNJh9yKBRKzyzQuNMtHcY=;
 b=XmP41YJLhe02p5FQE9HIw7ALnoe/u2urkCkEffPXxUQEOJwV4qHiKCgH4xXBWnhQ95Zn5+
 nwG/4JsQPpbL1LmEkA6EJSqQg5jWyIG2MUKdINoR+NTXZmqqI6qhg02hwDDdfukIHzwWBX
 xdCrbFINRCrjvGefk5a33+YVafP0CqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-AtOnEHHyOWq7djeDv8pjMg-1; Fri, 24 Jul 2020 08:32:58 -0400
X-MC-Unique: AtOnEHHyOWq7djeDv8pjMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1079D18C63C0;
 Fri, 24 Jul 2020 12:32:57 +0000 (UTC)
Received: from localhost (ovpn-114-111.ams2.redhat.com [10.36.114.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B6AC8BEF7;
 Fri, 24 Jul 2020 12:32:55 +0000 (UTC)
Date: Fri, 24 Jul 2020 13:32:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Subject: Re: Testing the virtio-vhost-user QEMU patch
Message-ID: <20200724123254.GB333683@stefanha-x1.localdomain>
References: <87h7u1s5k1.fsf@alyssa.is>
 <20200721083048.GB144170@stefanha-x1.localdomain>
 <87eep1yihf.fsf@alyssa.is> <87o8o5dvru.fsf@alyssa.is>
MIME-Version: 1.0
In-Reply-To: <87o8o5dvru.fsf@alyssa.is>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Nikos Dragazis <ndragazis@arrikto.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 10:58:45AM +0000, Alyssa Ross wrote:
> Alyssa Ross <hi@alyssa.is> writes:
>=20
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> >
> >> On Tue, Jul 21, 2020 at 07:14:38AM +0000, Alyssa Ross wrote:
> >>> Hi -- I hope it's okay me reaching out like this.
> >>>=20
> >>> I've been trying to test out the virtio-vhost-user implementation tha=
t's
> >>> been posted to this list a couple of times, but have been unable to g=
et
> >>> it to boot a kernel following the steps listed either on
> >>> <https://wiki.qemu.org/Features/VirtioVhostUser> or
> >>> <https://ndragazis.github.io/dpdk-vhost-vvu-demo.html>.
> >>>=20
> >>> Specifically, the kernel appears to be unable to write to the
> >>> virtio-vhost-user device's PCI registers.  I've included the full pan=
ic
> >>> output from the kernel at the end of this message.  The panic is
> >>> reproducible with two different kernels I tried (with different confi=
gs
> >>> and versions).  I tried both versions of the virtio-vhost-user I was
> >>> able to find[1][2], and both exhibited the same behaviour.
> >>>=20
> >>> Is this a known issue?  Am I doing something wrong?
> >>
> >> Hi,
> >> Unfortunately I'm not sure what the issue is. This is an early
> >> virtio-pci register access before a driver for any specific device typ=
e
> >> (net, blk, vhost-user, etc) comes into play.
> >
> > Small update here: I tried on another computer, and it worked.  Made
> > sure that it was exactly the same QEMU binary, command line, and VM
> > disk/initrd/kernel, so I think I can fairly confidently say the panic
> > depends on what hardware QEMU is running on.  I set -cpu value to the
> > same on both as well (SandyBridge).
> >
> > I also discovered that it works on my primary computer (the one it
> > panicked on before) with KVM disabled.
> >
> > Note that I've only got so far as finding that it boots on the other
> > machine -- I haven't verified yet that it actually works.
> >
> > Bad host CPU:  Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
> > Good host CPU: AMD EPYC 7401P 24-Core Processor
> >
> > May I ask what host CPUs other people have tested this on?  Having more
> > data would probably be useful.  Could it be an AMD vs. Intel thing?
>=20
> I think I've figured it out!
>=20
> Sandy Bridge and Ivy Bridge hosts encounter this panic because the
> "additional resources" bar size is too big, at 1 << 36.  If I change
> this to 1 << 35, no more kernel panic.
>=20
> Skylake and later are fine with 1 << 36.  In between Ivy Bridge and
> Skylake were Haswell and Broadwell, but I couldn't find anybody who was
> able to help me test on either of those, so I don't know what they do.
>=20
> Perhaps related, the hosts that produce panics all seem to have a
> physical address size of 36 bits, while the hosts that work have larger
> physical address sizes, as reported by lscpu.

I have run it successfully on Broadwell but never tried 64GB or larger
shared memory resources.

Stefan

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8a1PYACgkQnKSrs4Gr
c8jRkgf+K8IIc+z3czepDltKJvBrcM55i/55bI1/+Mds4F2PoTM68Fo1Inl00QgP
ps76DlSgvgzGhI43w9R9gCU0cESTF6iDbIlOzV0WS8ppO4PuAkbzkFMrYVXhSEMg
MPuJzrbCWuZtWxKFQ6lyltCy/csfzYwMMHdTAgl7rtG1IyQKOb/ZEPCdw82+MTP0
m97FnPTedBszYOIAvMw/e3p/nsMKtKvLWcVtO0BsMHaEKV+RnQsHM7Dg+JI/g8UJ
HJMUhgtJCG+7NV4BJzD7tTPHCIE5LcC1I9HvI8o0HV4hCg8co/5d+6huwTZAPyiM
hMF/ixOQYnGIJHGJ+VSCrl5uxKageQ==
=RgCj
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--


