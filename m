Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A3C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5588420717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WddMWPff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5588420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfOa-0004gh-Fg
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:30:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJfNt-0004IW-Dl
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJfNs-0000ww-2U
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:29:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hJfNr-0000wA-Qr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:29:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id e5so19546006otk.12
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ViowtsQHEgKW7DCG0w4d8WLNkVhkI98vgMWHcb8V/qs=;
	b=WddMWPffN7wsLIFZdUdrLYr6P+lZtkTYo/tGKmOst1mozCIEKXUFHd+7QpqFX0Ojkk
	iBH0fLEeJhNbqfWHDUv9cvang61pFFDEZnEwtMYGpVwh2qpMbo8qpiMwagHltYXIT4kl
	lcyIiPIbdRvop0vIkgxtguFqLGIyUISINs7AmoeOhrm+tFBk6G4AJMoyjnM6VSLDFo+E
	XI37QOKObN/E+1fjRjElHU9ZcUOcedlCZ7GhD3ao6mt9Dvk7mjbsNmNc2Fsn8U8oVDMv
	Aw4bt6FTPTgyEADYHBV12nGoFbcJSo9QEaZJ/jst4TbWduXDqjzH8mfrhznokI9GgepE
	Np0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ViowtsQHEgKW7DCG0w4d8WLNkVhkI98vgMWHcb8V/qs=;
	b=BWdw/NUiKpWlbCc1YH0B0bnT+p1Ydep2sFanhC/L76Gzlq33eR5SmTTqU1H/9rY2gd
	5ReX8RMle4agFQWRfy8Da9qDMU3BxJwofIcZ1Fa9d9wBL1P8gjJHi+t6zhozObYCiK9b
	0q63VLqxAxBOQyHdDBwvDwj9926GSN327w4wN0APKnYucaGxuAfdyw2/IPPtXAVUvyIL
	SuTB3WczOVASkXlKve3G948HwXsm7mH1H/3zNeMMmuqTbFiQ8JT/FXPkVjs71PPMKxh1
	g8o3E87bHfoL2tTlFPLlMi+cqEg3pMYJpihTYO9PJqpNr3C3xHH+lz0hzR0gzar+1Vav
	GJLQ==
X-Gm-Message-State: APjAAAXjTYtEVj4h1paVzj9C22ZuxSz4Yh/khpXBTSdMjf5DJWG0Yy+X
	MqLPMulfSbjEWKX7ApGjGRhZcPhNRR6kxq9EXBk=
X-Google-Smtp-Source: APXvYqy19z5lbzcSn6f73J+suuJprn9LC0DZZK93YqhsdSroFKVUAG6FPhQUY8iLUeNAKqmC4a8BQgGEcJSovMrfqrE=
X-Received: by 2002:a05:6830:2148:: with SMTP id
	r8mr11257527otd.25.1556202594969; 
	Thu, 25 Apr 2019 07:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190424140643.62457-1-liq3ea@163.com>
	<2b623811-1be2-159c-0fa6-c548aa9eea82@redhat.com>
In-Reply-To: <2b623811-1be2-159c-0fa6-c548aa9eea82@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 25 Apr 2019 22:29:18 +0800
Message-ID:
 <CAKXe6SLXrthYFrQGVQNT4hK1-22wrteMNyygZgx_j=jtDfYC6g@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two
 test cases
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
Cc: lvivier@redhat.com, Laszlo Ersek <lersek@redhat.com>,
	Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425142918.zbY4dzwCXSaeqde3PpGDVuLuAyuo2jJ1sNxvDLajW1A@z>

Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8825=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:57=E5=86=99=E9=81=93=EF=BC=9A

> On 24/04/2019 16.06, Li Qiang wrote:
> > In the disscuss of adding reboot timeout test case:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html
> >
> > Philippe suggested we should uses the only related option for one
> > specific test. However currently we uses one QTestState for all the
> > test cases. In order to achieve Philippe's idea, I split the test case
> > for its own QTestState. As this patchset has changed a lot, I don't bum=
p
> > the version.
> >
> > Change since v1:
> > Add a patch to store the reboot_timeout as little endian
> > Fix the endian issue per Thomas's review
>
> The test still aborts on a big endian host:
>
> $ QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 tests/fw_cfg-test
> /x86_64/fw_cfg/signature: OK
> /x86_64/fw_cfg/id: OK
> /x86_64/fw_cfg/uuid: OK
> /x86_64/fw_cfg/ram_size: OK
> /x86_64/fw_cfg/nographic: OK
> /x86_64/fw_cfg/nb_cpus: OK
> /x86_64/fw_cfg/max_cpus: OK
> /x86_64/fw_cfg/numa: OK
> /x86_64/fw_cfg/boot_menu: OK
> /x86_64/fw_cfg/reboot_timeout: **
>
> ERROR:/home/thuth/devel/qemu/tests/fw_cfg-test.c:190:test_fw_cfg_reboot_t=
imeout:
> assertion failed (reboot_timeout =3D=3D 15): (251658240 =3D=3D 15)
> Aborted
>
> 251658240 is 0x0F000000, i.e. a byte-swapped 0xf =3D 15 ... i.e. you stil=
l
> got an endianess issue somewhere in the code.
>


Hmmmm,

I have thought a long time, still can't point where is wrong.

Let's from the result:
0x0f000000 in the big endian laid as this:
low ---> high
0x0f 00 00 00

As I have swapped before the compare so it is read as this:
low ---> high
00 00 00 0x0f

However from the store side:
the 15 in big endian is:
low ---> high
00 00 00 0x0f

But Before I store it, I convert it to little endian, so following should
be stored:
low ---> high
0x0f 00 00 00

Do you apply the patch 3 and recompile the qemu binary?
If it is, I may need your help as I have no big endian host device.

You can debug and  inspect the memory layout and point out where is wrong.

Thanks,
Li Qiang







>
>  Thomas
>
