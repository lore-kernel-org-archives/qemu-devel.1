Received: from eggs.gnu.org ([2001:4830:134:3::10]:45067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dE9K2-0000yt-1k
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dE9K0-0002ge-MQ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:06:05 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dE9K0-0002gZ-7j
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:06:04 -0400
Received: by mail-lf0-x243.google.com with SMTP id m18so224502lfj.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 00:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<20170526023213.18741-2-haozhong.zhang@intel.com>
	<CAJ+F1C+9o_vv4m7q47gPiaUjmQy7ag_J5ZKaHA9oagxZG2Q5Cg@mail.gmail.com>
	<20170526065132.ayapfebbft5lyigd@hz-desktop>
In-Reply-To: <20170526065132.ayapfebbft5lyigd@hz-desktop>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 May 2017 07:05:52 +0000
Message-ID: <CAJ+F1CLDp7O93TRh2XcGQXXM_ZESiku0jDkcgzYUWAkP01wG9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RESEND PATCH 2/2] hostmem-file: add an attribute
 'align' to set its alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Richard Henderson <rth@twiddle.net>

Hi

On Fri, May 26, 2017 at 10:51 AM Haozhong Zhang <haozhong.zhang@intel.com>
wrote:

> On 05/26/17 06:39 +0000, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, May 26, 2017 at 6:34 AM Haozhong Zhang <haozhong.zhang@intel.co=
m
> >
> > wrote:
> >
> > > file_ram_alloc() currently maps the backend file via mmap to a virtua=
l
> > > address aligned to the value returned by qemu_fd_getpagesize(). When =
a
> > > DAX device (e.g. /dev/dax0.0) is used as the backend file, its kernel
> > > mmap implementation may require an alignment larger than what
> > > qemu_fd_get_pagesize() returns (e.g. 2MB vs. 4KB), and mmap may fail.
> > >
> >
> > How is the accepted value queried? Any chance to configure it
> > automatically?
>
> Take /dev/dax0.0 for example. The value can be read from
> /sys/class/dax/dax0.0/device/dax_region/align.
>

Should this work be left to management layer, or could qemu figure it out
by itself (using udev?)


> [..]
> > > +static void
> > >  file_backend_class_init(ObjectClass *oc, void *data)
> > >  {
> > >      HostMemoryBackendClass *bc =3D MEMORY_BACKEND_CLASS(oc);
> > > @@ -116,6 +151,10 @@ file_backend_class_init(ObjectClass *oc, void
> *data)
> > >      object_class_property_add_str(oc, "mem-path",
> > >          get_mem_path, set_mem_path,
> > >          &error_abort);
> > > +    object_class_property_add(oc, "align", "int",
> > >
> >
> > It would make sense to make it "size" instead of "int"
> >
>
> will change in the next version
>

thanks
--=20
Marc-Andr=C3=A9 Lureau
