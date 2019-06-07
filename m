Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A8DC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6005C208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6005C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDuh-00063g-N7
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47518)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hZCbn-00088V-3f
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hZCbl-0007h0-1C
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:00:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hZCbk-0006wR-JG
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:00:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so1697219wrm.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 04:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=KwGZfAwrZC3rDiUbX5X5riVLKxirW1SMy7bDId1QOzc=;
 b=c7Y/yjU0tCx/QoJYiojaOUKGBEfsiXaEIydF38zSuF++KX8U4AvMyqDfu7cuaE6rZi
 exrszHwQskEl7HfqF3N9R+ZojjYeloSj+zdKgng/jjDz95YQlnlamHaCrP0Eqa6y0v7Y
 3Fj2+QQ0VqgXfUFrd8t++j83t7canfdSYrQY3MM/IjF9SlEeA9YlWPzBdwZqtBYtSnW4
 cOmZ7T6G5rKQ9Mcnk/DrTJSbvhqZxMvl8ZTXGWk6FcKYZ/uqJBASdf6KYul7jwcV2GkA
 OwMVuqexsJW9hLe3aHJvIRL53acziFlZVziPM2KBhXY6mMx6sfEjt5Re9DcpelHv4T7Z
 xmow==
X-Gm-Message-State: APjAAAUaNCx/VTUlmjUQ7zjDH+80p3aqAIc7KmG+lUOIgmeJAZoO+se2
 xNf4BGAFZ17e4+Nbvwt0z7tpaw==
X-Google-Smtp-Source: APXvYqxd+mOZhbQxooKv3rv2/zkxVJwLtN2mSOeUzRSdcjD3D8etxIUyd9kAwUTefEFXN3CxmZb9bA==
X-Received: by 2002:adf:b689:: with SMTP id j9mr11977714wre.76.1559905214454; 
 Fri, 07 Jun 2019 04:00:14 -0700 (PDT)
Received: from dritchie.redhat.com (143.red-81-44-182.dynamicip.rima-tde.net.
 [81.44.182.143])
 by smtp.gmail.com with ESMTPSA id v11sm1192390wmh.28.2019.06.07.04.00.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 04:00:12 -0700 (PDT)
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
In-reply-to: <20190603123823.32661-1-mehta.aaru20@gmail.com>
Date: Fri, 07 Jun 2019 12:59:54 +0200
Message-ID: <878sudu0d1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v4 0/9] Add support for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Aarushi Mehta <mehta.aaru20@gmail.com> writes:

> This patch series adds support for the newly developed io_uring Linux AIO
> interface. Linux io_uring is faster than Linux's AIO asynchronous I/O code,
> offers efficient buffered asynchronous I/O support, the ability to do I/O
> without performing a system call via polled I/O, and other efficiency enhancements.
>
> Testing it requires a host kernel (5.1+) and the liburing library.
> Use the option -drive aio=io_uring to enable it.
>
> v4:
> - Add error handling
> - Add trace events
> - Remove aio submission based code
>
> v3:
> - Fix major errors in io_uring (sorry)
> - Option now enumerates for CONFIG_LINUX_IO_URING
> - pkg config support added
>
> Aarushi Mehta (9):
>   configure: permit use of io_uring
>   qapi/block-core: add option for io_uring
>   block/block: add BDRV flag for io_uring
>   block/io_uring: implements interfaces for io_uring
>   stubs: add stubs for io_uring interface
>   util/async: add aio interfaces for io_uring
>   blockdev: accept io_uring as option
>   block/file-posix.c: extend to use io_uring
>   block: add trace events for io_uring
>
>  MAINTAINERS             |   8 +
>  block/Makefile.objs     |   3 +
>  block/file-posix.c      |  85 +++++++++--
>  block/io_uring.c        | 325 ++++++++++++++++++++++++++++++++++++++++
>  block/trace-events      |   8 +
>  blockdev.c              |   4 +-
>  configure               |  27 ++++
>  include/block/aio.h     |  16 +-
>  include/block/block.h   |   1 +
>  include/block/raw-aio.h |  12 ++
>  qapi/block-core.json    |   4 +-
>  stubs/Makefile.objs     |   1 +
>  stubs/io_uring.c        |  32 ++++
>  util/async.c            |  36 +++++
>  14 files changed, 543 insertions(+), 19 deletions(-)
>  create mode 100644 block/io_uring.c
>  create mode 100644 stubs/io_uring.c

Hi Aarushi,

I gave this version of the patchset a try, and found that IO hangs when
the device is assigned to an IOThread. Sometimes is able to serve a few
requests getting through the Guest OS boot process, to hang the moment
you try generate some IO on the device, while others it hangs when Linux
tries to read the partitions from the device.

I'm starting QEMU this way:

./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -name rhel80,debug-threads=on -m 2g -smp 4 -object iothread,id=iothread0 -blockdev node-name=rhel80,driver=qcow2,file.driver=file,file.filename=/home/VirtualMachines/rhel80.qcow2 -device virtio-blk,drive=rhel80 -serial tcp::6667,server,nowait -qmp tcp::6668,server,nowait -nographic -net user,hostfwd=tcp::6666-:22 -net nic,model=virtio -device virtio-rng -drive file=/dev/nullb0,format=raw,cache=none,aio=io_uring,if=none,id=test -device virtio-blk,drive=test,iothread=iothread0

Could you please take a look at this issue?

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAlz6Q6oACgkQ9GknjS8M
AjVc2A/+NFvOVizXNmA/Vh0dPNHR7gAj0r3ft5SMxqvjk3jGasRTQjvsWAvW50x9
m2hHtYNrdp7YAk9NU+83AIP5+wgWPpJV1jXq3kGAP7LXxKEbCK4o+88TB7jtxZFE
IfG1WU+2o5ivbrPdwHobUyRLzO4n2+l/7ejzpy3oZuYyuLHYD0cK1tscRIzugb8v
xgzqawL7OoU96yopINk6IdHnuqw7UQPCyyWJ8t4PHKNirxiGyLfRdJK7f6UMtWZS
0Ibw9b3OPvvVJnoVFuGINvSZ6W4SfCcgnTWs9ccpLxIc6srRxUp6qTCUINpLWpAj
/oWwBdR7hh8vdmvn0a9KkWyKIzmUQMjkoKejgF2KEwXYOybiVmbY7KI5amk/qgBf
2ixrI2ksSEqe2MlbCyfQtKejdROqr48cak24x0Rk5lYpLaIcUtQ5ykZlXY3xVOUs
f3WJHPDj9vmZFd4hZ42LsH5GtI8PDuedWvwlLK+D7xHB+DLz7pMRjlepV9ZFOObd
aHBmCAOtjPv+f6i/KzypXOcMeDl1VTe8rtHlhWZ/s84DGVqhzqnqtjhXryCpPBfo
ilYd2fOpJsvKKHXrlKkMgT5fV7wPVBkiIJ2sFkhMzQ3CDfYQwUu2EKLc8dnV7/rG
UCGx0/+OgwV4frhIln2STEz7K6PoingPnTvtlVJhSBpShIJfdsA=
=/peO
-----END PGP SIGNATURE-----
--=-=-=--

