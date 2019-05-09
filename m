Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05B0C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DDB2175B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DDB2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlVq-0001yy-Nn
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:03:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hOlSo-00007c-Fx
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:00:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hOlSm-0004Ly-MH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:00:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1hOlSm-0004K2-Du
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:00:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B05B30917F0;
	Thu,  9 May 2019 16:00:01 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-80.ams2.redhat.com [10.36.116.80])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ECFEE1001DFE;
	Thu,  9 May 2019 16:00:00 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
	id 0D41D3E00DF; Thu,  9 May 2019 17:59:59 +0200 (CEST)
Date: Thu, 9 May 2019 17:59:58 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190509155958.GR4675@paraplu>
References: <20190503154613.4192-1-kchamart@redhat.com>
	<20190509135320.GE17133@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509135320.GE17133@stefanha-x1.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 09 May 2019 16:00:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] VirtIO-RNG: Update default entropy source
 to `/dev/urandom`
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
Cc: armbru@redhat.com, amit@kernel.org, qemu-devel@nongnu.org,
	rjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 02:53:20PM +0100, Stefan Hajnoczi wrote:
> On Fri, May 03, 2019 at 05:46:12PM +0200, Kashyap Chamarthy wrote:
> > When QEMU exposes a VirtIO-RNG device to the guest, that device needs=
 a
> > source of entropy, and that source needs to be "non-blocking", like
> > `/dev/urandom`.  However, currently QEMU defaults to the problematic
> > `/dev/random`, which is "blocking" (as in, it waits until sufficient
> > entropy is available).
> >=20
> > So change the entropy source to the recommended `/dev/urandom`.
>=20
> Why is /dev/urandom "recommended"?

Allow me to quote three expert sources.

(1) Let's start with Ted Ts'o, who is the author of the /dev/random.
    So it's as authoritative as it gets.  Ted Ts'o writes[*]:

    [quote]
      My recommendation is to just seed virtio-rng from /dev/urandom.
      Here's why.  /dev/urandom provides a cryptographic random number
      generator, and assuming it is adequately initialized, that should b=
e
      *fine* for pretty much all practical purposes.  And on the sort of
      systems you would be using as a Host, there are enough hardware
      devices that /dev/urandom will be initialized very quickly --- in
      practice, well before any VM's will be started.
     =20
      Furthermore, all modern x86 systems have RDRAND by now, and on thos=
e
      systems, the host kernel will mix RDRAND output with CRNG before
      sending the random numbers out via getrandom(2) or /dev/urandom.
     =20
      From a guest perspective, you have to trust the Host system anyway.
      The host as the ability to read or modify arbitrary guest memory,
      including that used by the kernel.  The host can mess with the gues=
t
      kernel before it's booted, or change the contents of the emulated h=
ard
      drive.  So trusting that the host CPU has implemented RDRAND correc=
tly
      isn't a stretch.  So even if the customer running the VM is a
      tin-foil-hatter who believes the NSA may have backdoored RDRAND and
      not have it be discovered or leaked out, in most cases, they aren't
      the sort of people who would want to use a cloud infrastructure.
      They're much more likely to want to use hardware which always stays
      under their personal control.
     =20
      And even if you *do* believe the NSA has somehow managed to sneak a
      backdoor into Intel CPU designs without it become public, that stil=
l
      means that you have to break the CRNG.  And practically speaking,
      assuming it's been initialized correctly, if you can break the CRNG=
,
      we've got much bigger problems, since that implies you can't trust =
the
      basic crypto primitives we use to secure our entire internet.=20
    [/quote]

(2) The man pages of `random(4) and `urandom(4)`:

    Both the man pages say the following about the blocking nature of
    '/dev/random':

       "The /dev/random device is a legacy interface which dates back to
       a time where the cryptographic primitives used in the
       implementation of /dev/urandom were not widely trusted.  It will
       return random bytes only within the estimated number of bits of
       fresh noise in the entropy pool, blocking if necessary.
       /dev/random is suitable for applications  that  need high quality
       randomness, and can afford indeterminate delays."

    And their the "Usage" section:

       "The  /dev/random interface is considered a legacy interface, and
       /dev/urandom is preferred and sufficient in all use cases, with
       the exception of applications which require randomness during
       early boot time; for these applications, getrandom(2) must be
       used instead, because it will block until the entropy pool is
       initialized.

       "If a seed file is saved across reboots as recommended below (all
       major Linux distributions have done this since 2000 at least),
       the output  is  cryptographically  secure  against attackers
       without local root access as soon as it is reloaded in the boot
       sequence, and perfectly adequate for network encryption session
       keys.  Since reads from /dev/random may block, users will usually
       want to open it in nonblocking mode (or perform a read with
       timeout), and provide some sort of user notification if the
       desired entropy is  not  immedi=E2=80=90 ately available."

(3) And this widely-referred document (by Thomas H=C3=BChn, who describes
    himself as "interested in ... Cryptography, standing on the
    sidelines"):

      "Myths about /dev/urandom"
      https://www.2uo.de/myths-about-urandom/

    I'm not going to quote the relevant parts, but the document is
    competently written, and is well worth reading.

> I understand the requirement for instant random numbers, but what
> about the concerns about quality? =20

I'm not a Crypto or RNG expert, but what precise "concerns" are these?
From my reading on this topic over the past several months, there are
some "sticky myths" in this area that Crypto / RNG experts have been
trying to debunk.  Refer to the earlier mentioned sources.

> Have you decided that the consumers of these random numbers are safe
> with /dev/urandom?

I didn't unilaterally decide it, but am relying on the expert sources
that I mentioned earlier.

In all likelihood you know this, but just as a refresher, there are
_two_ cases to distinguish w.r.t random numbers in QEMU:

  (a) When QEMU needs a random number, the entropy source it chooses.
      IIUC, here QEMU defers to GnuTLS, which uses getrandom(2), which
      in turn uses '/dev/urandom' as its entropy source; if getrandom(2)
      isn't available, GnuTLS uses `/dev/urandom` anyway.
 =20
  (b) When QEMU exposes a VirtIO-RNG device to the guest, the entropy
  source of that device.

This patch is changing the default of case (b).

> > Related discussion in these[1][2] past threads.
> >=20
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335=
.html
> >     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> > [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724=
.html
> >     -- "[RFC] Virtio RNG: Consider changing the default entropy sourc=
e to
> >        /dev/urandom"
>=20
> Please include actual justification in the commit description instead o=
f
> linking to email threads that need to be read and interpreted.

Sure, will do.  I normally bear that in mind, but missed to do it here.
I'll send a v2 by quoting the relevant parts from the
random(4)|urandom(4) man pages.

[*] http://lists.katacontainers.io/pipermail/kata-dev/2018-September/0004=
59.html
    [kata-dev] /dev/urandom or /dev/random


--=20
/kashyap

