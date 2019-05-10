Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B3C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6D12175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1QIfPr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6D12175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOu5w-00038C-7w
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:13:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hOu54-0002hX-Ox
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hOu52-0001Un-BI
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:12:10 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hOu51-0001UH-Vz
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:12:08 -0400
Received: by mail-oi1-x244.google.com with SMTP id u199so3376454oie.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=EGuxRRu7B8lpqvtk+XV624WlTyzXWDItZRHnjrpiXMg=;
	b=R1QIfPr7bcsNnQrjnPToSJx7ADujyXSuFxEZ+e1PgnCXQ6a88koG/MskWYFREC4+ML
	twYcu2y46C7C0duv0vUObyL3LCkhFnZYG+jfJ7G3uMmn8fY0Z1+Fbl7fEsNuxehYUgwo
	Z4PDPwOZmjEc86XwxN5g3Pxh5goJHOl0bsP3Oaqtn6ndQqzbK2yEztR1HX9sIYtxi3JA
	vyscUEelI6U9gmfhfYQ+2GYxb6Z6UxPd5C+Ng1BTwLr97nrqMe5YlMjwrFoUF87McskH
	VLSjRGBRQpzzEmvwtsVdPoy0vRFhGlD66I9/OMg46weIy3qZyegvynT7ffXfLNQ8BkDV
	EMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EGuxRRu7B8lpqvtk+XV624WlTyzXWDItZRHnjrpiXMg=;
	b=c53BKbn0GHnXVDw/Vi6xK4Vi7CgZ+MR56U7HR0Zkek96lJrcWNPRJ9Aa91rmxreXIm
	zYyX6ouP0G8hpJ+v/z/kpE7gRmXXbnrgT/z7F5arSQ9kNc9lsuZH6s2lTRhuQC8P0/yI
	LiLCpU/WiwiuUtwxd0qFUHNN5sJSSsUCptKtiMwXrKwc+rPJU7RM+/TiZrSs/uMoQT07
	VzWQeyr8HuD0VokWDk/yRP8v1aZ4uo2ZUnE1F1BII+pX2NOMhzWElAGTH6VYp/l181Rm
	84aIg0XG93Z362iSBi41xxsIFW13hxOWbm0bXKmdJHKipBJnck1Uomyyz9oTfDyGHe+4
	3cng==
X-Gm-Message-State: APjAAAUfoOaaAPfhkCYoDglb83L/T29JDDzSXn2QSWDjWd5lv2rp6/qi
	196NaIUPraMzfY18yiv5R2MfyGSeU0NxjrXabiw=
X-Google-Smtp-Source: APXvYqxEUaqfL8cBgs2te+0PKl+WPXUpIByhKqV8Q+3XBXNO5uc3YR00RXnmWfqjITK4NiDYdWoHfiW7zM+iJMmX07k=
X-Received: by 2002:aca:fd45:: with SMTP id b66mr1740228oii.157.1557450726668; 
	Thu, 09 May 2019 18:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190509121820.16294-1-stefanha@redhat.com>
	<20190509121820.16294-2-stefanha@redhat.com>
In-Reply-To: <20190509121820.16294-2-stefanha@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 10 May 2019 09:11:30 +0800
Message-ID: <CAKXe6SL9SUhV-kpQj5rFtVZp+8x4ggWhbDSvg1Ee-xztym--=w@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 1/2] docs: add Secure Coding Practices
 to developer docs
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Qemu Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=889=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:20=E5=86=99=E9=81=93=EF=BC=9A

> At KVM Forum 2018 I gave a presentation on security in QEMU:
> https://www.youtube.com/watch?v=3DYAdRf_hwxU8 (video)
> https://vmsplice.net/~stefan/stefanha-kvm-forum-2018.pdf (slides)
>
> This patch adds a guide to secure coding practices.  This document
> covers things that developers should know about security in QEMU.  It is
> just a starting point that we can expand on later.  I hope it will be
> useful as a resource for new contributors and will save code reviewers
> from explaining the same concepts many times.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>




> ---
>  docs/devel/index.rst                   |   1 +
>  docs/devel/secure-coding-practices.rst | 106 +++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 docs/devel/secure-coding-practices.rst
>
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index ebbab636ce..2a4ddf40ad 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -20,3 +20,4 @@ Contents:
>     stable-process
>     testing
>     decodetree
> +   secure-coding-practices
> diff --git a/docs/devel/secure-coding-practices.rst
> b/docs/devel/secure-coding-practices.rst
> new file mode 100644
> index 0000000000..cbfc8af67e
> --- /dev/null
> +++ b/docs/devel/secure-coding-practices.rst
> @@ -0,0 +1,106 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Secure Coding Practices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This document covers topics that both developers and security researcher=
s
> must
> +be aware of so that they can develop safe code and audit existing code
> +properly.
> +
> +Reporting Security Bugs
> +-----------------------
> +For details on how to report security bugs or ask questions about
> potential
> +security bugs, see the `Security Process wiki page
> +<https://wiki.qemu.org/SecurityProcess>`_.
> +
> +General Secure C Coding Practices
> +---------------------------------
> +Most CVEs (security bugs) reported against QEMU are not specific to
> +virtualization or emulation.  They are simply C programming bugs.
> Therefore
> +it's critical to be aware of common classes of security bugs.
> +
> +There is a wide selection of resources available covering secure C
> coding.  For
> +example, the `CERT C Coding Standard
> +<https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standar=
d
> >`_
> +covers the most important classes of security bugs.
> +
> +Instead of describing them in detail here, only the names of the most
> important
> +classes of security bugs are mentioned:
> +
> +* Buffer overflows
> +* Use-after-free and double-free
> +* Integer overflows
> +* Format string vulnerabilities
> +
> +Some of these classes of bugs can be detected by analyzers.  Static
> analysis is
> +performed regularly by Coverity and the most obvious of these bugs are
> even
> +reported by compilers.  Dynamic analysis is possible with valgrind, tsan=
,
> and
> +asan.
> +
> +Input Validation
> +----------------
> +Inputs from the guest or external sources (e.g. network, files) cannot b=
e
> +trusted and may be invalid.  Inputs must be checked before using them in
> a way
> +that could crash the program, expose host memory to the guest, or
> otherwise be
> +exploitable by an attacker.
> +
> +The most sensitive attack surface is device emulation.  All hardware
> register
> +accesses and data read from guest memory must be validated.  A typical
> example
> +is a device that contains multiple units that are selectable by the gues=
t
> via
> +an index register::
> +
> +  typedef struct {
> +      ProcessingUnit unit[2];
> +      ...
> +  } MyDeviceState;
> +
> +  static void mydev_writel(void *opaque, uint32_t addr, uint32_t val)
> +  {
> +      MyDeviceState *mydev =3D opaque;
> +      ProcessingUnit *unit;
> +
> +      switch (addr) {
> +      case MYDEV_SELECT_UNIT:
> +          unit =3D &mydev->unit[val];   <-- this input wasn't validated!
> +          ...
> +      }
> +  }
> +
> +If ``val`` is not in range [0, 1] then an out-of-bounds memory access
> will take
> +place when ``unit`` is dereferenced.  The code must check that ``val`` i=
s
> 0 or
> +1 and handle the case where it is invalid.
> +
> +Unexpected Device Accesses
> +--------------------------
> +The guest may access device registers in unusual orders or at unexpected
> +moments.  Device emulation code must not assume that the guest follows t=
he
> +typical "theory of operation" presented in driver writer manuals.  The
> guest
> +may make nonsense accesses to device registers such as starting operatio=
ns
> +before the device has been fully initialized.
> +
> +A related issue is that device emulation code must be prepared for
> unexpected
> +device register accesses while asynchronous operations are in progress. =
 A
> +well-behaved guest might wait for a completion interrupt before accessin=
g
> +certain device registers.  Device emulation code must handle the case
> where the
> +guest overwrites registers or submits further requests before an ongoing
> +request completes.  Unexpected accesses must not cause memory corruption
> or
> +leaks in QEMU.
> +
> +Invalid device register accesses can be reported with
> +``qemu_log_mask(LOG_GUEST_ERROR, ...)``.  The ``-d guest_errors``
> command-line
> +option enables these log messages.
> +
> +Live Migration
> +--------------
> +Device state can be saved to disk image files and shared with other user=
s.
> +Live migration code must validate inputs when loading device state so an
> +attacker cannot gain control by crafting invalid device states.  Device
> state
> +is therefore considered untrusted even though it is typically generated
> by QEMU
> +itself.
> +
> +Guest Memory Access Races
> +-------------------------
> +Guests with multiple vCPUs may modify guest RAM while device emulation
> code is
> +running.  Device emulation code must copy in descriptors and other guest
> RAM
> +structures and only process the local copy.  This prevents
> +time-of-check-to-time-of-use (TOCTOU) race conditions that could cause
> QEMU to
> +crash when a vCPU thread modifies guest RAM while device emulation is
> +processing it.
> --
> 2.21.0
>
>
>
