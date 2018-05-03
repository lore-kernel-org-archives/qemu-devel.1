Received: from eggs.gnu.org ([2001:4830:134:3::10]:54841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fEKDN-0001Fm-8g
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fEKDJ-0000Yi-28
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:48:29 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:39267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fEKDI-0000Xv-RY
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:48:24 -0400
Received: by mail-wm0-x22c.google.com with SMTP id f8-v6so896746wmc.4
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 12:48:24 -0700 (PDT)
References: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
Date: Thu, 03 May 2018 20:48:22 +0100
Message-ID: <87zi1g8qrd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/3] target/arm: Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, khaled.jmal@lauterbach.com


Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:

> The previous version:
> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D33714

I was trying to do some testing but I was finding it very hard to do at
gdb kept throwing up errors like:

(gdb) x/10i $pc
=3D> 0xffffff8008097760 <check_and_switch_context>:       Cannot access mem=
ory at address 0xffffff8008097760
Detaching from program: /home/alex/lsrc/qemu/kernel-v8-plain.build/vmlinux,=
 Remote target
Ending remote debugging.

However this seems to be the same on master as well so I wonder there is
a regression somewhere.

What was the last QEMU master commit you've tested these patches on?
I'll do some more digging tomorrow.

--
Alex Benn=C3=A9e
