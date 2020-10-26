Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E879C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FDD22242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC+ECTPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FDD22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5CC-0002CP-VT
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kX59W-0008Mb-2e
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kX59P-0007jX-BN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603728913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1f1yRNOe4AqM+qRSV+R+S11BduQ57G+MRKbIBFv9drs=;
 b=YC+ECTPqmFlWfykUU4VEGH+r1dyCsYDMdEFAWHRSk5mQQQGMdHNblUtwbbwxSL/AULhafo
 35JczCqjDFvQMAuKI5wMvWTE5IbboKMx83gjipkd/BAgZZJFgkOu05GaaWxj2j9oVMZmm9
 FEB9InxZFnDPPcZ9BoKIiw9gr2zyCEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-Eqe9gS-FPUmHzP_bR39hBw-1; Mon, 26 Oct 2020 12:15:09 -0400
X-MC-Unique: Eqe9gS-FPUmHzP_bR39hBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11E008049D8;
 Mon, 26 Oct 2020 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 432615B4C1;
 Mon, 26 Oct 2020 16:14:52 +0000 (UTC)
Date: Mon, 26 Oct 2020 12:14:50 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Should we keep using Avocado for functional testing? (was: Re:
 [PULL 22/23] hw/sd: Fix incorrect populated function switch status data
 structure)
Message-ID: <20201026161450.GA2201333@localhost.localdomain>
References: <20200821172916.1260954-1-f4bug@amsat.org>
 <20200821172916.1260954-23-f4bug@amsat.org>
 <e378932a-1de3-83c1-834f-ae6526604cb7@amsat.org>
 <CAEUhbmVFZ8aWdv48D8acdfFRp6WMYL6n=ENeo4hBZfmqE9TrDA@mail.gmail.com>
 <a0ac3805-ec48-2a0e-6511-b142bfc6f214@amsat.org>
 <CAEUhbmVLFJWND=KHexD12mrCMJSO3mcE6k7_tRE+v8pNZjhN_A@mail.gmail.com>
 <CAPan3Wqx-psi6zgz3NyM1Hu_PHaGq4Nn3_RJf_zueqwXFNKuWg@mail.gmail.com>
 <CAEUhbmXGbNNXkJYt8-sX_+nT_ReXoyerYaf+KROxx55-89wbHA@mail.gmail.com>
 <db561779-005b-c358-3e72-e1169ef49faf@amsat.org>
 <26e41113-e124-63f7-64c5-2d42011c5cfb@redhat.com>
MIME-Version: 1.0
In-Reply-To: <26e41113-e124-63f7-64c5-2d42011c5cfb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 11:34:29AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 10/23/20 11:23 AM, Philippe Mathieu-Daud=E9 wrote:
>=20
> Back to the cache problem, I started to ask 2 years ago,
> https://www.mail-archive.com/avocado-devel@redhat.com/msg00860.html
> note this is the exact situation we are having:
>

Hi Phil,

I think the issue on this thread was more on the server mirror side,
than on the *cache* side of things, right?  Still, it's an open issue
that needs to be discussed indeed.

> >> - What will happens if I add tests downloading running on their
> >> compiled u-boot
> >> (https://downloads.gumstix.com/images/angstrom/developer/2012-01-22-17=
50/u-boot.bin)
> >> and the company decides to remove this old directory?
> >> Since sometimes old open-source software are hard to rebuild with
> >> recent compilers, should we consider to use a public storage to keep
> >> open-source (signed) blobs we can use for integration testing?
> >
> > For Avocado-VT, there are the JeOS images[1], which we keep on a test
> > "assets" directory.  We have a lot of storage/bandwidth availability,
> > so it can be used for other assets proven to be necessary for tests.
> >
> > As long as distribution rights and licensing are not issues, we can
> > definitely use the same server for kernels, u-boot images and what
> > not.
> >
> > [1] - https://avocado-project.org/data/assets/
>=20
>=20
> We discussed about this again last year at the KVM forum. Various
> RFE have been filled:
> https://www.mail-archive.com/avocado-devel@redhat.com/msg01183.html
>

I understand it has been a year, which is a lot of time specially when
it comes to an urgent need such as more and better testing and CI.
But some things can be patched quickly, while others need further
structural work.  More on that later...

>=20
> What we need is a QEMU community file server similar to the asset
> one used by the Avocado community. The problem is who is going to
> pay and sysadmin it. IIRC Gerd suggested to use GitLab Page, but
> the artifact file size is limited to a maximum of 1GiB:
> https://docs.gitlab.com/ee/user/gitlab_com/#gitlab-pages
> Alternative is to use a git-lfs server:
> https://docs.gitlab.com/ee/topics/git/lfs/#hosting-lfs-objects-externally
> This is now a project management problem.
>=20
> Next week is the KVM forum 2020 and there might be a BoF session
> to talk about that:
> https://kvmforum2020.sched.com/overview/type/Birds+of+a+Feather+Sessions+=
(BoF)
>=20
>=20
> Now that the QEMU community started to use gitlab-ci more and more
> I received complains that Avocado is not practical (hard to
> understand how to reproduce command line to debug, options to use
> not clear, timeouts not clear, why download all artifacts to run
> a single test, various issues regarding caching, cache filled /home
> filesystem) so I have been asked to look at Avocado alternatives,
> because we want contributors run more tests and CI, not them be
> scared by it.

What I can say is that the Avocado developers have been working
on a major overhaul to address those issues.  I'm not sure this
is the place/time to go over each of those items, but there may be
some confusion going on some of those issues.  For instance, your
point about "why download all artifacts to run a single test".
It shouldn't, and it doesn't:

  $ du -hcs ~/avocado/data/cache/
  4.0K    /home/cleber/avocado/data/cache/
  4.0K    total

  $ ./tests/venv/bin/avocado run tests/acceptance/boot_linux_console.py:Boo=
tLinuxConsole.test_x86_64_pc=20
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConso=
le.test_x86_64_pc
  JOB ID     : a3c08d7a0acc613c207b27e4b291a0010965af2d
  JOB LOG    : /home/cleber/avocado/job-results/job-2020-10-26T11.50-a3c08d=
7/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_6=
4_pc: PASS (2.04 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 3.22 s

  $ du -hcs ~/avocado/data/cache/
  8.3M    /home/cleber/avocado/data/cache/
  8.3M    total

About Avocado being hard to understand, I'm a bit saddened by that,
because the team spent a lot of effort in:

 * Restructuring / rewriting / reviewing the documention
 * Normalizing the command line options
 * Deprecating and removing a lot of non-relevant functionality

I've probably said the same thing in a few different channels and
contexts, but for the last ~9 months, the Avocado project had been
working on a new architecture that was highly influenced by the
limitations we found while using Avocado in QEMU.  Version 82.0 was
the result of that work, and it'd be very bad timing if, instead of
integrating this "new Avocado", QEMU would start "from scratch" again.

I've been looking for an opportunity to present what this "new
Avocado" is.  Maybe this or another BoF would be a good place?

> I haven't looked at alternatives yet, from the various features
> we could have use, the biggest one is the ability to interact with
> the serial console. And that feature is duplicated with the VM
> testing class: tests/vm/basevm.py.
> The SSH session used in linux_ssh_mips_malta.py is similar to the
> one from basevm.py too (see 'make vm-boot-ssh-%').
> Some tests are not 'acceptance' but simple qtest written in Python,
> such cpu_queries.py / pc_cpu_hotplug_props.py / migration.py /
> pc_cpu_hotplug_props.py / x86_cpu_model_versions.py.
>=20
> The classes I find practical are downloading artifact, uncompressing
> or extracting archive, and eventually the cloudinit one. But we can proba=
bly
> use them directly.
>

I understand this is your PoV with regards to how much value you
believe exists in those particular utility modules.  The challenge is
how to combine other people's PoV with regards to the same matter, and
manage them accordingly as a group.  One example is how Pavel Dovgaluk
may find the "gdb" utility module important.

Now consider that Red Hat is vested to have some of the functional /
integration tests that run downstream (and which are based on
Avocado+Avocado-VT) migrated upstreamed.  Then, all of a sudden, a
much larger group of "practical classes" arise.

Finally, these are, as you mentioned in another thread, utility
libraries (such as python/qemu) are commonly needed in other projects
(specially those related to QEMU).  I understand that suggesting to
have more code infrastructure code living in the QEMU would actually
make it harder to solve similar problems once.

>=20
> Lot of material to discuss :)
>

Absolutely!

Best,
- Cleber.

> Regards,
>=20
> Phil.
>=20

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+W9fcACgkQZX6NM6Xy
CfPqQg/+OCmyYSNFmzKNjnZJslhlLQOd86pkf59vB+EW23qrl0VIwfXy/mAYPYhb
B7vTb7BVFYX2ovUe3/IVZKgR5m+LtwAdNxfePzGOc4xhQAHGhItrOEGmTxKYIk3S
DSirFQJHvUa4s6i3pR4IxRZ6sUsfN6Upc9lIxHH3+0SXyUrQQadD+vteWSqB0E7P
7OEv0VJD0Ltq0hB/zdn+R2gdMOLin2uXbOuY9kgus98UbXYG4YmvYG24o548AwKZ
wZH4yABWjnI3br/CWVoi03/fBMsgOfydjBlQOXh9T6SdWxSqqk5F01H4LGxLXLhd
1bbkPFo42t4bTR6XFkjN4Jl2whGr3t+YdQQSuokes3AbWv77Iz7R9AJKAbRegulp
8Dk6DdZSCcmfpKIYKqd8MlnJVd6eRa6p7TmdMg5a2dxCm1mwLStTIWSAiO48w1pU
hAiafmk8GX4pVbbZntA2hsumdWkc4LC8lFalLxf/ka0xJqUmLg0uHghcAtWqOnSk
FB77NqCKiYdb/t2ckT6cMUvmScFrZ6ULOSe36nnTHjHt3lzr5QfZu6qjhKca7tGb
MsT+CIB8t1nvP6rG+34L3m9C3vvVlDjzntg9PN48kQ3gHROyG9gmiUWH75zowZKh
Ooh7n+Uk2lPPy4sctZHLzArCuDrT3H3vGwDiAFMSN2c4U3o4C+U=
=MG90
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--


