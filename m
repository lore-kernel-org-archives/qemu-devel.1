Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FB4C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAA324655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6MpP7t+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAA324655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOuI-0002Ya-Ur
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 11:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irOrp-0007v2-JD
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irOrm-00060A-0f
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:16:33 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1irOrl-0005yZ-Mi
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:16:29 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so12757875wro.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 08:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mrWoJeDyXlC7Qt9+Gorw16dHbk1+q/otcI6iaisleGY=;
 b=R6MpP7t+KEbElU11BzAc3Ipbl9EmHK2q8SvnolexvhMoQy5wDPzKoSI1P49bYZiAwV
 vJnbcUweg5QfHYX8UjPvurQBxbyCg8R/fDXz90eaZ1tUL1a+a7cDja83SB6njHVIq6A0
 nKMpmGdg5ssRf+gJ+rTpowtYYA1ai1bzt2mrXkfl23eNsepzDpt/JUZlX4DE9tzq24Fq
 MgTKPds0Bh9i+IkUbCaT4GTcsldJTS9rvQT9sryeK/7u0tFJfFELHxDAZHWgMopBKrgn
 6R1Ex1iaLL1Rx2iubXCJKj973yE3CUOIFsFH+EZQRp6UIECf2LQr6N6bzGofGuGWcUOK
 hUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mrWoJeDyXlC7Qt9+Gorw16dHbk1+q/otcI6iaisleGY=;
 b=fClwoxLJek5mgseB9KgvbkMlpyEmO8Jx+6qlRrFvTPt1t2aykHFHTG11NrTCYNvLYG
 hINJmD1tH2tXMlRjRINuqHMoKQGtmj5w2jyW91QXyPq02Klr5muYFDtjjViSA4sJOD5k
 E0IN6ZKwCvuPiPoiY9B//L0rS+EBBNx4B6+UqqGSDBsF9M5ilFkZZZzDX+ZV4JBckoqO
 k19Mc09qY3ZqW8dKhR3FchDyzFwelKkvcbwNbyEilc/motAI9Guo++2RnQyb0y52AcUd
 Jube5BCxoIs0U6hfn2QhkTWvMWHK+PTOJfRXgimgV/5cdc9waS1K4qOqrKCDW9QoHBxy
 D8iA==
X-Gm-Message-State: APjAAAWXbkrBbnz2REvp5e3i7b5LQ6NvhvywSqXA8m9VXDY31GcOyrbK
 FXLghVZ7ZSKb+tjmdh+Dnjs=
X-Google-Smtp-Source: APXvYqxnm7a5ckwCrOXT2KHNRo2B33aFbPS29MaVFsweG71jJFZBr6trzythAXRrn2g6zba/DdRLEw==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr8613302wrn.245.1579018588270; 
 Tue, 14 Jan 2020 08:16:28 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o4sm20008058wrw.97.2020.01.14.08.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 08:16:26 -0800 (PST)
Date: Tue, 14 Jan 2020 16:16:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eryu Guan <eguan@linux.alibaba.com>
Subject: Re: [BUG qemu 4.0] segfault when unplugging virtio-blk-pci device
Message-ID: <20200114161624.GC132666@stefanha-x1.localdomain>
References: <20191231103434.GA41863@e18g06458.et15sqa>
 <20191231115136.7b967604@Igors-MacBook-Pro>
 <20200102020850.GB41863@e18g06458.et15sqa>
 <20200107130649.GH41863@e18g06458.et15sqa>
 <CAMDeoFXdbJB_nn4MR4uZYTEE7N2BT05-Ucqnm9Hkj7=pMqOWwQ@mail.gmail.com>
 <20200109045806.GB79586@e18g06458.et15sqa>
 <20200113163855.GC103384@stefanha-x1.localdomain>
 <20200114025058.GA47669@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <20200114025058.GA47669@e18g06458.et15sqa>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 10:50:58AM +0800, Eryu Guan wrote:
> On Mon, Jan 13, 2020 at 04:38:55PM +0000, Stefan Hajnoczi wrote:
> > On Thu, Jan 09, 2020 at 12:58:06PM +0800, Eryu Guan wrote:
> > > On Tue, Jan 07, 2020 at 03:01:01PM +0100, Julia Suvorova wrote:
> > > > On Tue, Jan 7, 2020 at 2:06 PM Eryu Guan <eguan@linux.alibaba.com> =
wrote:
> > > > >
> > > > > On Thu, Jan 02, 2020 at 10:08:50AM +0800, Eryu Guan wrote:
> > > > > > On Tue, Dec 31, 2019 at 11:51:35AM +0100, Igor Mammedov wrote:
> > > > > > > On Tue, 31 Dec 2019 18:34:34 +0800
> > > > > > > Eryu Guan <eguan@linux.alibaba.com> wrote:
> > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > I'm using qemu 4.0 and hit segfault when tearing down kata =
sandbox, I
> > > > > > > > think it's because io completion hits use-after-free when d=
evice is
> > > > > > > > already gone. Is this a known bug that has been fixed? (I w=
ent through
> > > > > > > > the git log but didn't find anything obvious).
> > > > > > > >
> > > > > > > > gdb backtrace is:
> > > > > > > >
> > > > > > > > Core was generated by `/usr/local/libexec/qemu-kvm -name sa=
ndbox-5b8df8c6c6901c3c0a9b02879be10fe8d69d6'.
> > > > > > > > Program terminated with signal 11, Segmentation fault.
> > > > > > > > #0 object_get_class (obj=3Dobj@entry=3D0x0) at /usr/src/deb=
ug/qemu-4.0/qom/object.c:903
> > > > > > > > 903        return obj->class;
> > > > > > > > (gdb) bt
> > > > > > > > #0  object_get_class (obj=3Dobj@entry=3D0x0) at /usr/src/de=
bug/qemu-4.0/qom/object.c:903
> > > > > > > > #1  0x0000558a2c009e9b in virtio_notify_vector (vdev=3D0x55=
8a2e7751d0,
> > > > > > > >     vector=3D<optimized out>) at /usr/src/debug/qemu-4.0/hw=
/virtio/virtio.c:1118
> > > > > > > > #2  0x0000558a2bfdcb1e in virtio_blk_discard_write_zeroes_c=
omplete (
> > > > > > > >     opaque=3D0x558a2f2fd420, ret=3D0)
> > > > > > > >     at /usr/src/debug/qemu-4.0/hw/block/virtio-blk.c:186
> > > > > > > > #3  0x0000558a2c261c7e in blk_aio_complete (acb=3D0x558a2ee=
d7420)
> > > > > > > >     at /usr/src/debug/qemu-4.0/block/block-backend.c:1305
> > > > > > > > #4  0x0000558a2c3031db in coroutine_trampoline (i0=3D<optim=
ized out>,
> > > > > > > >     i1=3D<optimized out>) at /usr/src/debug/qemu-4.0/util/c=
oroutine-ucontext.c:116
> > > > > > > > #5  0x00007f45b2f8b080 in ?? () from /lib64/libc.so.6
> > > > > > > > #6  0x00007fff9ed75780 in ?? ()
> > > > > > > > #7  0x0000000000000000 in ?? ()
> > > > > > > >
> > > > > > > > It seems like qemu was completing a discard/write_zero requ=
est, but
> > > > > > > > parent BusState was already freed & set to NULL.
> > > > > > > >
> > > > > > > > Do we need to drain all pending request before unrealizing =
virtio-blk
> > > > > > > > device? Like the following patch proposed?
> > > > > > > >
> > > > > > > > https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02=
945.html
> > > > > > > >
> > > > > > > > If more info is needed, please let me know.
> > > > > > >
> > > > > > > may be this will help: https://patchwork.kernel.org/patch/112=
13047/
> > > > > >
> > > > > > Yeah, this looks promising! I'll try it out (though it's a one-=
time
> > > > > > crash for me). Thanks!
> > > > >
> > > > > After applying this patch, I don't see the original segfaut and
> > > > > backtrace, but I see this crash
> > > > >
> > > > > [Thread debugging using libthread_db enabled]
> > > > > Using host libthread_db library "/lib64/libthread_db.so.1".
> > > > > Core was generated by `/usr/local/libexec/qemu-kvm -name sandbox-=
a2f34a11a7e1449496503bbc4050ae040c0d3'.
> > > > > Program terminated with signal 11, Segmentation fault.
> > > > > #0  0x0000561216a57609 in virtio_pci_notify_write (opaque=3D0x561=
2184747e0, addr=3D0, val=3D<optimized out>, size=3D<optimized out>) at /usr=
/src/debug/qemu-4.0/hw/virtio/virtio-pci.c:1324
> > > > > 1324        VirtIOPCIProxy *proxy =3D VIRTIO_PCI(DEVICE(vdev)->pa=
rent_bus->parent);
> > > > > Missing separate debuginfos, use: debuginfo-install glib2-2.42.2-=
5.1.alios7.x86_64 glibc-2.17-260.alios7.x86_64 libgcc-4.8.5-28.alios7.1.x86=
_64 libseccomp-2.3.1-3.alios7.x86_64 libstdc++-4.8.5-28.alios7.1.x86_64 num=
actl-libs-2.0.9-5.1.alios7.x86_64 pixman-0.32.6-3.1.alios7.x86_64 zlib-1.2.=
7-16.2.alios7.x86_64
> > > > > (gdb) bt
> > > > > #0  0x0000561216a57609 in virtio_pci_notify_write (opaque=3D0x561=
2184747e0, addr=3D0, val=3D<optimized out>, size=3D<optimized out>) at /usr=
/src/debug/qemu-4.0/hw/virtio/virtio-pci.c:1324
> > > > > #1  0x0000561216835b22 in memory_region_write_accessor (mr=3D<opt=
imized out>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optim=
ized out>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at=
 /usr/src/debug/qemu-4.0/memory.c:502
> > > > > #2  0x0000561216833c5d in access_with_adjusted_size (addr=3Daddr@=
entry=3D0, value=3Dvalue@entry=3D0x7fcdeab1b8a8, size=3Dsize@entry=3D2, acc=
ess_size_min=3D<optimized out>, access_size_max=3D<optimized out>, access_f=
n=3D0x561216835ac0 <memory_region_write_accessor>, mr=3D0x56121846d340, att=
rs=3D...)
> > > > >     at /usr/src/debug/qemu-4.0/memory.c:568
> > > > > #3  0x0000561216837c66 in memory_region_dispatch_write (mr=3Dmr@e=
ntry=3D0x56121846d340, addr=3D0, data=3D<optimized out>, size=3D2, attrs=3D=
attrs@entry=3D...) at /usr/src/debug/qemu-4.0/memory.c:1503
> > > > > #4  0x00005612167e036f in flatview_write_continue (fv=3Dfv@entry=
=3D0x56121852edd0, addr=3Daddr@entry=3D841813602304, attrs=3D..., buf=3Dbuf=
@entry=3D0x7fce7dd97028 <Address 0x7fce7dd97028 out of bounds>, len=3Dlen@e=
ntry=3D2, addr1=3D<optimized out>, l=3D<optimized out>, mr=3D0x56121846d340)
> > > > >     at /usr/src/debug/qemu-4.0/exec.c:3279
> > > > > #5  0x00005612167e0506 in flatview_write (fv=3D0x56121852edd0, ad=
dr=3D841813602304, attrs=3D..., buf=3D0x7fce7dd97028 <Address 0x7fce7dd9702=
8 out of bounds>, len=3D2) at /usr/src/debug/qemu-4.0/exec.c:3318
> > > > > #6  0x00005612167e4a1b in address_space_write (as=3D<optimized ou=
t>, addr=3D<optimized out>, attrs=3D..., buf=3D<optimized out>, len=3D<opti=
mized out>) at /usr/src/debug/qemu-4.0/exec.c:3408
> > > > > #7  0x00005612167e4aa5 in address_space_rw (as=3D<optimized out>,=
 addr=3D<optimized out>, attrs=3D..., attrs@entry=3D..., buf=3Dbuf@entry=3D=
0x7fce7dd97028 <Address 0x7fce7dd97028 out of bounds>, len=3D<optimized out=
>, is_write=3D<optimized out>) at /usr/src/debug/qemu-4.0/exec.c:3419
> > > > > #8  0x0000561216849da1 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x56121=
849aa00) at /usr/src/debug/qemu-4.0/accel/kvm/kvm-all.c:2034
> > > > > #9  0x000056121682255e in qemu_kvm_cpu_thread_fn (arg=3Darg@entry=
=3D0x56121849aa00) at /usr/src/debug/qemu-4.0/cpus.c:1281
> > > > > #10 0x0000561216b794d6 in qemu_thread_start (args=3D<optimized ou=
t>) at /usr/src/debug/qemu-4.0/util/qemu-thread-posix.c:502
> > > > > #11 0x00007fce7bef6e25 in start_thread () from /lib64/libpthread.=
so.0
> > > > > #12 0x00007fce7bc1ef1d in clone () from /lib64/libc.so.6
> > > > >
> > > > > And I searched and found
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1706759 , which has=
 the same
> > > > > backtrace as above, and it seems commit 7bfde688fb1b ("virtio-blk=
: Add
> > > > > blk_drain() to virtio_blk_device_unrealize()") is to fix this par=
ticular
> > > > > bug.
> > > > >
> > > > > But I can still hit the bug even after applying the commit. Do I =
miss
> > > > > anything?
> > > >=20
> > > > Hi Eryu,
> > > > This backtrace seems to be caused by this bug (there were two bugs =
in
> > > > 1706759): https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
> > > > Although the solution hasn't been tested on virtio-blk yet, you may
> > > > want to apply this patch:
> > > >     https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg051=
97.html
> > > > Let me know if this works.
> > >=20
> > > Unfortunately, I still see the same segfault & backtrace after applyi=
ng
> > > commit 421afd2fe8dd ("virtio: reset region cache when on queue
> > > deletion")
> > >=20
> > > Anything I can help to debug?
> >=20
> > Please post the QEMU command-line and the QMP commands use to remove the
> > device.
>=20
> It's a normal kata instance using virtio-fs as rootfs.
>=20
> /usr/local/libexec/qemu-kvm -name sandbox-a670786fcb1758d2348eb120939d90f=
facf9f049f10b337284ad49bbcd60936d \
>  -uuid e03f6b6b-b80b-40c0-8d5b-0cbfed1305d2 -machine q35,accel=3Dkvm,kern=
el_irqchip,nvdimm,nosmm,nosmbus,nosata,nopit \
>  -cpu host -qmp unix:/run/vc/vm/a670786fcb1758d2348eb120939d90ffacf9f049f=
10b337284ad49bbcd60936d/qmp.sock,server,nowait \
>  -qmp unix:/run/vc/vm/debug-a670786fcb1758d2348eb120939d90ffacf9f049f10b3=
37284ad49bbcd60936d/qmp.sock,server,nowait \
>  -m 2048M,slots=3D10,maxmem=3D773893M -device pci-bridge,bus=3Dpcie.0,id=
=3Dpci-bridge-0,chassis_nr=3D1,shpc=3Don,addr=3D2,romfile=3D \
>  -device virtio-serial-pci,disable-modern=3Dfalse,id=3Dserial0,romfile=3D=
 -device virtconsole,chardev=3Dcharconsole0,id=3Dconsole0 \
>  -chardev socket,id=3Dcharconsole0,path=3D/run/vc/vm/a670786fcb1758d2348e=
b120939d90ffacf9f049f10b337284ad49bbcd60936d/console.sock,server,nowait \
>  -device virtserialport,chardev=3Dmetricagent,id=3Dchannel10,name=3Dmetri=
c.agent.channel.10 \
>  -chardev socket,id=3Dmetricagent,path=3D/run/vc/vm/a670786fcb1758d2348eb=
120939d90ffacf9f049f10b337284ad49bbcd60936d/metric.agent.channel.sock,serve=
r,nowait \
>  -device nvdimm,id=3Dnv0,memdev=3Dmem0 -object memory-backend-file,id=3Dm=
em0,mem-path=3D/usr/local/share/containers-image-1.9.0.img,size=3D268435456=
 \
>  -object rng-random,id=3Drng0,filename=3D/dev/urandom -device virtio-rng,=
rng=3Drng0,romfile=3D \
>  -device virtserialport,chardev=3Dcharch0,id=3Dchannel0,name=3Dagent.chan=
nel.0 \
>  -chardev socket,id=3Dcharch0,path=3D/run/vc/vm/a670786fcb1758d2348eb1209=
39d90ffacf9f049f10b337284ad49bbcd60936d/kata.sock,server,nowait \
>  -chardev socket,id=3Dchar-6fca044b801a78a1,path=3D/run/vc/vm/a670786fcb1=
758d2348eb120939d90ffacf9f049f10b337284ad49bbcd60936d/vhost-fs.sock \
>  -device vhost-user-fs-pci,chardev=3Dchar-6fca044b801a78a1,tag=3DkataShar=
ed,cache-size=3D8192M -netdev tap,id=3Dnetwork-0,vhost=3Don,vhostfds=3D3,fd=
s=3D4 \
>  -device driver=3Dvirtio-net-pci,netdev=3Dnetwork-0,mac=3D76:57:f1:ab:51:=
5c,disable-modern=3Dfalse,mq=3Don,vectors=3D4,romfile=3D \
>  -global kvm-pit.lost_tick_policy=3Ddiscard -vga none -no-user-config -no=
defaults -nographic -daemonize \
>  -object memory-backend-file,id=3Ddimm1,size=3D2048M,mem-path=3D/dev/shm,=
share=3Don -numa node,memdev=3Ddimm1 -kernel /usr/local/share/kernel \
>  -append tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=3D1 i8042.d=
irect=3D1 i8042.dumbkbd=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 noreplace-smp r=
eboot=3Dk console=3Dhvc0 console=3Dhvc1 iommu=3Doff cryptomgr.notests net.i=
fnames=3D0 pci=3Dlastbus=3D0 root=3D/dev/pmem0p1 rootflags=3Ddax,data=3Dord=
ered,errors=3Dremount-ro ro rootfstype=3Dext4 quiet systemd.show_status=3Df=
alse panic=3D1 nr_cpus=3D96 agent.use_vsock=3Dfalse init=3D/usr/lib/systemd=
/systemd systemd.unit=3Dkata-containers.target systemd.mask=3Dsystemd-netwo=
rkd.service systemd.mask=3Dsystemd-networkd.socket \
>  -pidfile /run/vc/vm/a670786fcb1758d2348eb120939d90ffacf9f049f10b337284ad=
49bbcd60936d/pid \
>  -smp 1,cores=3D1,threads=3D1,sockets=3D96,maxcpus=3D96
>=20
> QMP command to delete device (the device id is just an example, not the
> one caused the crash):
>=20
> "{\"arguments\":{\"id\":\"virtio-drive-5967abfb917c8da6\"},\"execute\":\"=
device_del\"}"
>=20
> which has been hot plugged by:
> "{\"arguments\":{\"cache\":{\"direct\":true,\"no-flush\":false},\"driver\=
":\"raw\",\"file\":{\"driver\":\"file\",\"filename\":\"/dev/dm-18\"},\"node=
-name\":\"drive-5967abfb917c8da6\"},\"execute\":\"blockdev-add\"}"
> "{\"return\": {}}"
> "{\"arguments\":{\"addr\":\"01\",\"bus\":\"pci-bridge-0\",\"drive\":\"dri=
ve-5967abfb917c8da6\",\"driver\":\"virtio-blk-pci\",\"id\":\"virtio-drive-5=
967abfb917c8da6\",\"romfile\":\"\",\"share-rw\":\"on\"},\"execute\":\"devic=
e_add\"}"
> "{\"return\": {}}"

Thanks.  I wasn't able to reproduce this crash with qemu.git/master.

One thing that is strange about the latest backtrace you posted: QEMU is
dispatching the memory access instead of using the ioeventfd code that
that virtio-blk-pci normally takes when a virtqueue is notified.  I
guess this means ioeventfd has already been disabled due to the hot
unplug.

Could you try with machine type "i440fx" instead of "q35"?  I wonder if
pci-bridge/shpc is part of the problem.

Stefan

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4d6VgACgkQnKSrs4Gr
c8gXJQgAwz1Gi6P65YwikBEAZQY+EvYQnXGacBAdpunIjwhrypEvL4OJs/N3mwuH
DB/CxnL/k0L6AEk/6F7g8qn666ekYw3TIViZTsiej2G9tNTw7ENGiTrmAovl12VF
z+8XTrHdCT9nkQ3PetQCh8/aboZFMz4aIouLUVQy0YuSK+cqQ1S2vUmtSIVSDVEE
GB9Ryx0fP46ib5xkGdqvD7/MVt0+5Et4m50FkvscjRdP+ZsZbm60Ihk2oP/Ql0X+
PJdDt3fu4e81BrSrCDA0ed3vu3eN+KT5tO+CJorsbNTkQoNx4y29oA5GGpucIeH8
0iayaoTLG9+eACVBSCofV+5risG5iw==
=Kfh7
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

