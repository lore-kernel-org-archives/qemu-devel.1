Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129CBC04AA6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB7A2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxOyWFlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB7A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8Wy-0004ir-0e
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:49:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8VR-00046M-8g
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8VP-0007Z1-2M
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:47:49 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hL8VO-0007Xh-Rz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:47:47 -0400
Received: by mail-io1-xd42.google.com with SMTP id p23so9331411iol.13
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=kh1GH3B0EzKtYBFGz4QXQdS/+zp8dBhZU4dPio2wxWk=;
	b=PxOyWFlFcNnJiNxeLYZ9UM3D1o6X2YNuxvNeUK9k7VMstTsk8Arw8BQ9fQ7LSwGGrs
	fCLtMj4M8g8iO3p1P2QcdJV914zLxS2r62fdzCOkIiDTiyTMdAOlu8DOqw/dFzYvtb4J
	EZlPAFOMAMVJq+0HLmUy7WDFxzO42dBZTpK6K9ugYXk+2g84yoO0ermLxvIWTUND6T5E
	79mBzor6SQ2Q4pCqJ29m+67Rk6bmQvyLppKF0vJLoqxlkwZStVXnpzPrtEJrs2C3tNUi
	fAEbzxiuzmuUCqaW5gCqWGFo/f8khmvyfIz/oVVG/x+s6vc8z9KPNWPPilTuPumBc1u5
	aIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=kh1GH3B0EzKtYBFGz4QXQdS/+zp8dBhZU4dPio2wxWk=;
	b=nVa1NJeONakizksh9aWHmfvLkRE4R7fBV7miGH2cvflPVzDP4WQMxCF+6LNi+xVg7B
	mvoCKTPn2WW5f13oV85L5ZmQfOBLK6xmkmV7Q9RWApszMZ4P+eRlUdrMpIYcklWK+64C
	sJqvZ0YkItkiCVtIbs1KAJFG76jS64CyGs+Sv9C5VafdVtpLilCT3krwuw5opz4gwUK7
	WDrf/TmYZ9F+CVowaLF1vl/ruxlSV7iKljomHGrLaeS9dCSq8pEKY0CPhT03XMuM8ACK
	RytO39bJMZVs4bPSGt61xvZpPKsNawezMYasTE/JEX+d2ZCuXUqq3mRWg9VZOe+vSK3S
	zF7w==
X-Gm-Message-State: APjAAAVW7kI053LU1u5bRlyrwGiwlqIdysNtpzw9C9lvXrO5iXJZQotP
	bMPnJqh/P6gs7XFbYxb1DYE=
X-Google-Smtp-Source: APXvYqyyqZw+5EOzyBURxOoSNo1GFa5YWUHGP7pWWR35sMo66mZr3v+5cmJ3zNuRiLMQjovyBFvRjA==
X-Received: by 2002:a5d:8245:: with SMTP id n5mr11324292ioo.41.1556552865315; 
	Mon, 29 Apr 2019 08:47:45 -0700 (PDT)
Received: from localhost
	(CPE64777d5479c3-CM64777d5479c0.cpe.net.cable.rogers.com.
	[99.228.64.175])
	by smtp.gmail.com with ESMTPSA id p16sm707933ioh.6.2019.04.29.08.47.41
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 08:47:44 -0700 (PDT)
Date: Mon, 29 Apr 2019 11:47:33 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1826393 <1826393@bugs.launchpad.net>
Message-ID: <20190429154733.GA13640@stefanha-x1.localdomain>
References: <155619222209.13917.4120344041326080857.malonedeb@gac.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <155619222209.13917.4120344041326080857.malonedeb@gac.canonical.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [Bug 1826393] [NEW] QEMU 3.1.0 stuck waiting for
 800ms (5 times slower) in pre-bios phase
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
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429154733.wyBKZOGvKXgGzAOnOoqn1y7q1_oA206AT6iAtdpqDsE@z>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2019 at 11:37:02AM -0000, Waldemar Kozaczuk wrote:
> Public bug reported:
>=20
> Yesterday I have upgraded my laptop from Ubuntu 18.10 to 19.04 and that
> way got newer QEMU 3.1.0 along vs QEMU 2.12.0 before. I have noticed
> that everytime I start QEMU to run OSv, QEMU seems to hand noticably
> longer (~1 second) before showing SeaBIOS output. I have tried all kind
> of combinations to get rid of that pause and nothing helped.
>=20
> Here is my start command:
> time qemu-system-x86_64 -m 256M -smp 1 -nographic -nodefaults \
>  -device virtio-blk-pci,id=3Dblk0,bootindex=3D0,drive=3Dhd0,scsi=3Doff \
>  -drive file=3Dusr.img,if=3Dnone,id=3Dhd0,cache=3Dnone,aio=3Dthre\
>  -enable-kvm \
>  -cpu host,+x2apic -chardev stdio,mux=3Don,id=3Dstdio,signal=3Doff \
>  -mon chardev=3Dstdio,mode=3Dreadline -device isa-serial,chardev=3Dstdio
>=20
> It looks like qemu process starts, waits almost a second for something
> and then print SeaBIOS splashscreen and continues boot:
>=20
> --> waits here
> SeaBIOS (version 1.12.0-1)
> Booting from Hard Disk..OSv v0.53.0-6-gc8395118
> 	disk read (real mode): 27.25ms, (+27.25ms)
> 	uncompress lzloader.elf: 46.22ms, (+18.97ms)
> 	TLS initialization: 46.79ms, (+0.57ms)
> 	.init functions: 47.82ms, (+1.03ms)
> 	SMP launched: 48.08ms, (+0.26ms)
> 	VFS initialized: 49.25ms, (+1.17ms)
> 	Network initialized: 49.48ms, (+0.24ms)
> 	pvpanic done: 49.57ms, (+0.08ms)
> 	pci enumerated: 52.42ms, (+2.85ms)
> 	drivers probe: 52.42ms, (+0.00ms)
> 	drivers loaded: 55.33ms, (+2.90ms)
> 	ROFS mounted: 56.37ms, (+1.04ms)
> 	Total time: 56.37ms, (+0.00ms)
> Found optarg
> dev  etc  hello  libenviron.so	libvdso.so  proc  tmp  tools  usr
>=20
> real	0m0.935s
> user	0m0.426s
> sys	0m0.490s
>=20
> With version 2.12.0 I used to see real below 200ms. So it seems qemu
> slowed down 5 times.
>=20
> I ran strace -tt against it and I have noticed a pause here:
> ...
> 07:31:41.848579 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
> 07:31:41.848604 futex(0x55c4a2ff6308, FUTEX_WAIT_PRIVATE, 0, NULL) =3D 0
> 07:31:41.848649 ioctl(10, KVM_SET_PIT2, 0x7ffdd272d1f0) =3D 0
> 07:31:41.848674 ioctl(9, KVM_CHECK_EXTENSION, KVM_CAP_KVMCLOCK_CTRL) =3D 1
> 07:31:41.848699 ioctl(10, KVM_SET_CLOCK, 0x7ffdd272d230) =3D 0
> 07:31:41.848724 futex(0x55c4a49a9a9c, FUTEX_WAKE_PRIVATE, 2147483647) =3D=
 1
> 07:31:41.848747 getpid()                =3D 5162
> 07:31:41.848769 tgkill(5162, 5166, SIGUSR1) =3D 0
> 07:31:41.848791 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
> 07:31:41.848814 futex(0x55c4a49a9a98, FUTEX_WAKE_PRIVATE, 2147483647) =3D=
 1
> 07:31:41.848837 getpid()                =3D 5162
> 07:31:41.848858 tgkill(5162, 5166, SIGUSR1) =3D 0
> 07:31:41.848889 write(8, "\1\0\0\0\0\0\0\0", 8) =3D 8
> 07:31:41.848919 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
> 07:31:41.848943 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLI=
N}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN},=20
> {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D0}, NULL, 8) =3D 1 =
([{fd=3D8, revents=3DPOLLIN}], left {tv_sec=3D0, tv_nsec=3D0
> })
> 07:31:41.849003 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D -1=
 EAGAIN (Resource temporarily unavailable)
> 07:31:41.849031 read(8, "\5\0\0\0\0\0\0\0", 16) =3D 8
> 07:31:41.849064 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
> 07:31:41.849086 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLI=
N}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN},=20
> {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D984624000}, NULL, 8=
) =3D 1 ([{fd=3D7, revents=3DPOLLIN}], left {tv_sec=3D0, t
> v_nsec=3D190532609})
>=20
> --> waits for almost 800ms
>=20
> 07:31:42.643272 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D 0
> 07:31:42.643522 read(7, "\1\0\0\0\0\0\0\0", 512) =3D 8
> 07:31:42.643625 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
> 07:31:42.643646 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLI=
N}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN},=20
> {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D190066000}, NULL, 8=
) =3D 2 ([{fd=3D4, revents=3DPOLLIN}, {fd=3D8, revents=3DPOL
> LIN}], left {tv_sec=3D0, tv_nsec=3D189909632})
> 07:31:42.643836 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D -1=
 EAGAIN (Resource temporarily unavailable)
> 07:31:42.643859 read(8, "\2\0\0\0\0\0\0\0", 16) =3D 8
> 07:31:42.643880 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
>=20
> ...
>=20
> when I run same command using qemu 3.0.5 that I still happen to have on
> the same machine that I built directly from source I see total boot time
> at around 200ms. It seems like a regression.

Please try building QEMU 4.0.0 from source:

  https://download.qemu.org/qemu-4.0.0.tar.xz

> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1826393
>=20
> Title:
>   QEMU 3.1.0 stuck waiting for 800ms (5 times slower) in pre-bios phase
>=20
> Status in QEMU:
>   New
>=20
> Bug description:
>   Yesterday I have upgraded my laptop from Ubuntu 18.10 to 19.04 and
>   that way got newer QEMU 3.1.0 along vs QEMU 2.12.0 before. I have
>   noticed that everytime I start QEMU to run OSv, QEMU seems to hand
>   noticably longer (~1 second) before showing SeaBIOS output. I have
>   tried all kind of combinations to get rid of that pause and nothing
>   helped.
>=20
>   Here is my start command:
>   time qemu-system-x86_64 -m 256M -smp 1 -nographic -nodefaults \
>    -device virtio-blk-pci,id=3Dblk0,bootindex=3D0,drive=3Dhd0,scsi=3Doff \
>    -drive file=3Dusr.img,if=3Dnone,id=3Dhd0,cache=3Dnone,aio=3Dthre\
>    -enable-kvm \
>    -cpu host,+x2apic -chardev stdio,mux=3Don,id=3Dstdio,signal=3Doff \
>    -mon chardev=3Dstdio,mode=3Dreadline -device isa-serial,chardev=3Dstdio
>=20
>   It looks like qemu process starts, waits almost a second for something
>   and then print SeaBIOS splashscreen and continues boot:
>=20
>   --> waits here
>   SeaBIOS (version 1.12.0-1)
>   Booting from Hard Disk..OSv v0.53.0-6-gc8395118
>   	disk read (real mode): 27.25ms, (+27.25ms)
>   	uncompress lzloader.elf: 46.22ms, (+18.97ms)
>   	TLS initialization: 46.79ms, (+0.57ms)
>   	.init functions: 47.82ms, (+1.03ms)
>   	SMP launched: 48.08ms, (+0.26ms)
>   	VFS initialized: 49.25ms, (+1.17ms)
>   	Network initialized: 49.48ms, (+0.24ms)
>   	pvpanic done: 49.57ms, (+0.08ms)
>   	pci enumerated: 52.42ms, (+2.85ms)
>   	drivers probe: 52.42ms, (+0.00ms)
>   	drivers loaded: 55.33ms, (+2.90ms)
>   	ROFS mounted: 56.37ms, (+1.04ms)
>   	Total time: 56.37ms, (+0.00ms)
>   Found optarg
>   dev  etc  hello  libenviron.so	libvdso.so  proc  tmp  tools  usr
>=20
>   real	0m0.935s
>   user	0m0.426s
>   sys	0m0.490s
>=20
>   With version 2.12.0 I used to see real below 200ms. So it seems qemu
>   slowed down 5 times.
>=20
>   I ran strace -tt against it and I have noticed a pause here:
>   ...
>   07:31:41.848579 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
>   07:31:41.848604 futex(0x55c4a2ff6308, FUTEX_WAIT_PRIVATE, 0, NULL) =3D 0
>   07:31:41.848649 ioctl(10, KVM_SET_PIT2, 0x7ffdd272d1f0) =3D 0
>   07:31:41.848674 ioctl(9, KVM_CHECK_EXTENSION, KVM_CAP_KVMCLOCK_CTRL) =
=3D 1
>   07:31:41.848699 ioctl(10, KVM_SET_CLOCK, 0x7ffdd272d230) =3D 0
>   07:31:41.848724 futex(0x55c4a49a9a9c, FUTEX_WAKE_PRIVATE, 2147483647) =
=3D 1
>   07:31:41.848747 getpid()                =3D 5162
>   07:31:41.848769 tgkill(5162, 5166, SIGUSR1) =3D 0
>   07:31:41.848791 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
>   07:31:41.848814 futex(0x55c4a49a9a98, FUTEX_WAKE_PRIVATE, 2147483647) =
=3D 1
>   07:31:41.848837 getpid()                =3D 5162
>   07:31:41.848858 tgkill(5162, 5166, SIGUSR1) =3D 0
>   07:31:41.848889 write(8, "\1\0\0\0\0\0\0\0", 8) =3D 8
>   07:31:41.848919 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
>   07:31:41.848943 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOL=
LIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN},=20
>   {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D0}, NULL, 8) =3D =
1 ([{fd=3D8, revents=3DPOLLIN}], left {tv_sec=3D0, tv_nsec=3D0
>   })
>   07:31:41.849003 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D =
-1 EAGAIN (Resource temporarily unavailable)
>   07:31:41.849031 read(8, "\5\0\0\0\0\0\0\0", 16) =3D 8
>   07:31:41.849064 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
>   07:31:41.849086 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOL=
LIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN},=20
>   {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D984624000}, NULL,=
 8) =3D 1 ([{fd=3D7, revents=3DPOLLIN}], left {tv_sec=3D0, t
>   v_nsec=3D190532609})
>=20
>   --> waits for almost 800ms
>=20
>   07:31:42.643272 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D 0
>   07:31:42.643522 read(7, "\1\0\0\0\0\0\0\0", 512) =3D 8
>   07:31:42.643625 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
>   07:31:42.643646 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOL=
LIN}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN},=20
>   {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D190066000}, NULL,=
 8) =3D 2 ([{fd=3D4, revents=3DPOLLIN}, {fd=3D8, revents=3DPOL
>   LIN}], left {tv_sec=3D0, tv_nsec=3D189909632})
>   07:31:42.643836 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D =
-1 EAGAIN (Resource temporarily unavailable)
>   07:31:42.643859 read(8, "\2\0\0\0\0\0\0\0", 16) =3D 8
>   07:31:42.643880 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
>=20
>   ...
>=20
>   when I run same command using qemu 3.0.5 that I still happen to have
>   on the same machine that I built directly from source I see total boot
>   time at around 200ms. It seems like a regression.
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1826393/+subscriptions
>=20

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxxyVAAoJEJykq7OBq3PIWtEH/jdtBbX8fxYUJUmIwD5FBbrS
QS2byotiO9Qbu6lUaX83zecoZBy2GLgbeNHECEp64VmSZcWuqKJTksDzBK8GDWta
8o56j/+qlj6/x6D+SWxAIe+5drwnhcJkZNTzJFFTX1Kw7lnpB9eQD+ChpSsiNHGF
5Zduhwuy/VX+FBQbURe5IZc2ULmT+mhqfHKeSpWfhE+o0yzKuR4mFnOOU3H5Ezk9
Qc+QwvboJDI7i7DD3TuJ5izB/I4ggGZcyhpjj4YMU9omrtOpnWrHFOdMnuZUNQ+6
PGEUXhFS3s7QOR74r8teyjmbT/kHTGyyHgg86Ybt16fUr406NIsJwS536XsUlH4=
=9Qsf
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

