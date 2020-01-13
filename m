Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992C5C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6643821744
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjVIrQME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6643821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2la-0004hO-9b
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ir2k1-0002am-Gu
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ir2jz-0006A0-Gc
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:39:01 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ir2jz-00067v-8j
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:38:59 -0500
Received: by mail-wr1-x441.google.com with SMTP id z7so9245375wrl.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 08:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZOpbB7KHWK4lUmvITz7ihBhSwvx9tQRl+jmLYdtNQoE=;
 b=YjVIrQMEJVpKNyLZnYn5A9sgGSGk0QSMlpt4KTgpKTfPBpzuyiUw3OOMWB6Vd8Jh/T
 LZdmfH1wZImakuMknzUyJQtho9SarDYCwCNGuMN5e8f4vN4PNaOp78hybNxhfUhFRd5E
 F2Ak6zYv20TlSyw4mR0WSKBrYynbwx0y6RBdUX558pgZkL4krWSwShUiXyBL0YsuSsuN
 4dSxHFutGNvQ5Dy+0i5JW8DzTMSPW8VOIrftxdrQyKd5bDAYK56yuN4avSBWm1ub+JoD
 BlWbq3XHhxUjZC/DlbGkq4yKB6Tm9GBE8OooOf4UJEADTAieI4c24q92lgQTSqE7RPw7
 lifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZOpbB7KHWK4lUmvITz7ihBhSwvx9tQRl+jmLYdtNQoE=;
 b=bx+450mZRcQ5+QvptkJN0OxFL6Ffa7pfpx0KgtVGByU6fujufWVmMhzA8ejrUpyoMU
 yJc07s2U8FLAZilsI8Laiwah3NcJQ2VYB98RdwgF0nIztG/YUdNbQ9wljsDMfGmG+arD
 0dCzL1hnrjAV/sZd2tRNtnXIK+0W7s/8vuVS/x6F6GJPDZV7hHocJMDFKD/BMiz/8z22
 jIA1/u52Mu07+1DCe4lr+RhM1+tuQ5QknXVAXb+betzaGFd7K+G7DHX+vK6Fownji4UC
 3BGHRp2dH2GkKBhlRkzzYWg8+Nfwf1qO1dqGvWgIU+fIogcD2XhwMTuaft/6FK5f3TCh
 8GzQ==
X-Gm-Message-State: APjAAAVLEAln3jNT6uAZxCfUON91EEYC7Tg2Fn81cOdVubZSNNp7BVnP
 EUrhO41h+uaomkj6Jz8OKrU=
X-Google-Smtp-Source: APXvYqyxVcC4dYq22J4hZt7KSsvpSgQhtW1kRy5oIEvEymJQRXX8KAROzpXEy2Q88XT8V2cYZMPJ9g==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr19885731wru.220.1578933537866; 
 Mon, 13 Jan 2020 08:38:57 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q15sm15776631wrr.11.2020.01.13.08.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 08:38:56 -0800 (PST)
Date: Mon, 13 Jan 2020 16:38:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eryu Guan <eguan@linux.alibaba.com>
Subject: Re: [BUG qemu 4.0] segfault when unplugging virtio-blk-pci device
Message-ID: <20200113163855.GC103384@stefanha-x1.localdomain>
References: <20191231103434.GA41863@e18g06458.et15sqa>
 <20191231115136.7b967604@Igors-MacBook-Pro>
 <20200102020850.GB41863@e18g06458.et15sqa>
 <20200107130649.GH41863@e18g06458.et15sqa>
 <CAMDeoFXdbJB_nn4MR4uZYTEE7N2BT05-Ucqnm9Hkj7=pMqOWwQ@mail.gmail.com>
 <20200109045806.GB79586@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <20200109045806.GB79586@e18g06458.et15sqa>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2020 at 12:58:06PM +0800, Eryu Guan wrote:
> On Tue, Jan 07, 2020 at 03:01:01PM +0100, Julia Suvorova wrote:
> > On Tue, Jan 7, 2020 at 2:06 PM Eryu Guan <eguan@linux.alibaba.com> wrot=
e:
> > >
> > > On Thu, Jan 02, 2020 at 10:08:50AM +0800, Eryu Guan wrote:
> > > > On Tue, Dec 31, 2019 at 11:51:35AM +0100, Igor Mammedov wrote:
> > > > > On Tue, 31 Dec 2019 18:34:34 +0800
> > > > > Eryu Guan <eguan@linux.alibaba.com> wrote:
> > > > >
> > > > > > Hi,
> > > > > >
> > > > > > I'm using qemu 4.0 and hit segfault when tearing down kata sand=
box, I
> > > > > > think it's because io completion hits use-after-free when devic=
e is
> > > > > > already gone. Is this a known bug that has been fixed? (I went =
through
> > > > > > the git log but didn't find anything obvious).
> > > > > >
> > > > > > gdb backtrace is:
> > > > > >
> > > > > > Core was generated by `/usr/local/libexec/qemu-kvm -name sandbo=
x-5b8df8c6c6901c3c0a9b02879be10fe8d69d6'.
> > > > > > Program terminated with signal 11, Segmentation fault.
> > > > > > #0 object_get_class (obj=3Dobj@entry=3D0x0) at /usr/src/debug/q=
emu-4.0/qom/object.c:903
> > > > > > 903        return obj->class;
> > > > > > (gdb) bt
> > > > > > #0  object_get_class (obj=3Dobj@entry=3D0x0) at /usr/src/debug/=
qemu-4.0/qom/object.c:903
> > > > > > #1  0x0000558a2c009e9b in virtio_notify_vector (vdev=3D0x558a2e=
7751d0,
> > > > > >     vector=3D<optimized out>) at /usr/src/debug/qemu-4.0/hw/vir=
tio/virtio.c:1118
> > > > > > #2  0x0000558a2bfdcb1e in virtio_blk_discard_write_zeroes_compl=
ete (
> > > > > >     opaque=3D0x558a2f2fd420, ret=3D0)
> > > > > >     at /usr/src/debug/qemu-4.0/hw/block/virtio-blk.c:186
> > > > > > #3  0x0000558a2c261c7e in blk_aio_complete (acb=3D0x558a2eed742=
0)
> > > > > >     at /usr/src/debug/qemu-4.0/block/block-backend.c:1305
> > > > > > #4  0x0000558a2c3031db in coroutine_trampoline (i0=3D<optimized=
 out>,
> > > > > >     i1=3D<optimized out>) at /usr/src/debug/qemu-4.0/util/corou=
tine-ucontext.c:116
> > > > > > #5  0x00007f45b2f8b080 in ?? () from /lib64/libc.so.6
> > > > > > #6  0x00007fff9ed75780 in ?? ()
> > > > > > #7  0x0000000000000000 in ?? ()
> > > > > >
> > > > > > It seems like qemu was completing a discard/write_zero request,=
 but
> > > > > > parent BusState was already freed & set to NULL.
> > > > > >
> > > > > > Do we need to drain all pending request before unrealizing virt=
io-blk
> > > > > > device? Like the following patch proposed?
> > > > > >
> > > > > > https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02945.=
html
> > > > > >
> > > > > > If more info is needed, please let me know.
> > > > >
> > > > > may be this will help: https://patchwork.kernel.org/patch/1121304=
7/
> > > >
> > > > Yeah, this looks promising! I'll try it out (though it's a one-time
> > > > crash for me). Thanks!
> > >
> > > After applying this patch, I don't see the original segfaut and
> > > backtrace, but I see this crash
> > >
> > > [Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > > Core was generated by `/usr/local/libexec/qemu-kvm -name sandbox-a2f3=
4a11a7e1449496503bbc4050ae040c0d3'.
> > > Program terminated with signal 11, Segmentation fault.
> > > #0  0x0000561216a57609 in virtio_pci_notify_write (opaque=3D0x5612184=
747e0, addr=3D0, val=3D<optimized out>, size=3D<optimized out>) at /usr/src=
/debug/qemu-4.0/hw/virtio/virtio-pci.c:1324
> > > 1324        VirtIOPCIProxy *proxy =3D VIRTIO_PCI(DEVICE(vdev)->parent=
_bus->parent);
> > > Missing separate debuginfos, use: debuginfo-install glib2-2.42.2-5.1.=
alios7.x86_64 glibc-2.17-260.alios7.x86_64 libgcc-4.8.5-28.alios7.1.x86_64 =
libseccomp-2.3.1-3.alios7.x86_64 libstdc++-4.8.5-28.alios7.1.x86_64 numactl=
-libs-2.0.9-5.1.alios7.x86_64 pixman-0.32.6-3.1.alios7.x86_64 zlib-1.2.7-16=
=2E2.alios7.x86_64
> > > (gdb) bt
> > > #0  0x0000561216a57609 in virtio_pci_notify_write (opaque=3D0x5612184=
747e0, addr=3D0, val=3D<optimized out>, size=3D<optimized out>) at /usr/src=
/debug/qemu-4.0/hw/virtio/virtio-pci.c:1324
> > > #1  0x0000561216835b22 in memory_region_write_accessor (mr=3D<optimiz=
ed out>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized=
 out>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at /us=
r/src/debug/qemu-4.0/memory.c:502
> > > #2  0x0000561216833c5d in access_with_adjusted_size (addr=3Daddr@entr=
y=3D0, value=3Dvalue@entry=3D0x7fcdeab1b8a8, size=3Dsize@entry=3D2, access_=
size_min=3D<optimized out>, access_size_max=3D<optimized out>, access_fn=3D=
0x561216835ac0 <memory_region_write_accessor>, mr=3D0x56121846d340, attrs=
=3D...)
> > >     at /usr/src/debug/qemu-4.0/memory.c:568
> > > #3  0x0000561216837c66 in memory_region_dispatch_write (mr=3Dmr@entry=
=3D0x56121846d340, addr=3D0, data=3D<optimized out>, size=3D2, attrs=3Dattr=
s@entry=3D...) at /usr/src/debug/qemu-4.0/memory.c:1503
> > > #4  0x00005612167e036f in flatview_write_continue (fv=3Dfv@entry=3D0x=
56121852edd0, addr=3Daddr@entry=3D841813602304, attrs=3D..., buf=3Dbuf@entr=
y=3D0x7fce7dd97028 <Address 0x7fce7dd97028 out of bounds>, len=3Dlen@entry=
=3D2, addr1=3D<optimized out>, l=3D<optimized out>, mr=3D0x56121846d340)
> > >     at /usr/src/debug/qemu-4.0/exec.c:3279
> > > #5  0x00005612167e0506 in flatview_write (fv=3D0x56121852edd0, addr=
=3D841813602304, attrs=3D..., buf=3D0x7fce7dd97028 <Address 0x7fce7dd97028 =
out of bounds>, len=3D2) at /usr/src/debug/qemu-4.0/exec.c:3318
> > > #6  0x00005612167e4a1b in address_space_write (as=3D<optimized out>, =
addr=3D<optimized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimize=
d out>) at /usr/src/debug/qemu-4.0/exec.c:3408
> > > #7  0x00005612167e4aa5 in address_space_rw (as=3D<optimized out>, add=
r=3D<optimized out>, attrs=3D..., attrs@entry=3D..., buf=3Dbuf@entry=3D0x7f=
ce7dd97028 <Address 0x7fce7dd97028 out of bounds>, len=3D<optimized out>, i=
s_write=3D<optimized out>) at /usr/src/debug/qemu-4.0/exec.c:3419
> > > #8  0x0000561216849da1 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x56121849a=
a00) at /usr/src/debug/qemu-4.0/accel/kvm/kvm-all.c:2034
> > > #9  0x000056121682255e in qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0=
x56121849aa00) at /usr/src/debug/qemu-4.0/cpus.c:1281
> > > #10 0x0000561216b794d6 in qemu_thread_start (args=3D<optimized out>) =
at /usr/src/debug/qemu-4.0/util/qemu-thread-posix.c:502
> > > #11 0x00007fce7bef6e25 in start_thread () from /lib64/libpthread.so.0
> > > #12 0x00007fce7bc1ef1d in clone () from /lib64/libc.so.6
> > >
> > > And I searched and found
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1706759 , which has the=
 same
> > > backtrace as above, and it seems commit 7bfde688fb1b ("virtio-blk: Add
> > > blk_drain() to virtio_blk_device_unrealize()") is to fix this particu=
lar
> > > bug.
> > >
> > > But I can still hit the bug even after applying the commit. Do I miss
> > > anything?
> >=20
> > Hi Eryu,
> > This backtrace seems to be caused by this bug (there were two bugs in
> > 1706759): https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
> > Although the solution hasn't been tested on virtio-blk yet, you may
> > want to apply this patch:
> >     https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg05197.h=
tml
> > Let me know if this works.
>=20
> Unfortunately, I still see the same segfault & backtrace after applying
> commit 421afd2fe8dd ("virtio: reset region cache when on queue
> deletion")
>=20
> Anything I can help to debug?

Please post the QEMU command-line and the QMP commands use to remove the
device.

The backtrace shows a vcpu thread submitting a request.  The device
seems to be partially destroyed.  That's surprising because the monitor
and the vcpu thread should use the QEMU global mutex to avoid race
conditions.  Maybe seeing the QMP commands will make it clearer...

Stefan

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4cnR8ACgkQnKSrs4Gr
c8jWdggAwvncG5obr7vhGP2ssI852FvGJirP+Xq8Rm3rLLknFqW++pf1h1o7itnv
zp3XdfGo8odjG+OyMyWBby9CNeiU2xz8cyC87efipqYSy1niWsmK8rf2/AhFe0Xs
HFEj9qzMNAt2L+2q5nrpTMA6YxKhAVBpGJ0i3v141UHe2EyKnJuWnsHuRWMH9e4D
/ETdf/9ulSUtHRxPbs3BEIChzx0rsPYW3QkBoyx4qF9ppLfWDIV4aXjA+UicUCfW
Ee9I74rNwpvXvitpXH8pNLK95rmt1F0AvyZEmk0qRD08oxNz3orhu4lfQGSbDC8h
G1XHJWmQHUcATbnhh5oTQvUHfSQ+gg==
=UvC5
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--

