Received: from eggs.gnu.org ([2001:4830:134:3::10]:59856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZxU1-0008O6-FF
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZxTw-0006b4-GE
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:31:21 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gZxTv-0006PL-VI
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:31:16 -0500
Received: by mail-wr1-x42b.google.com with SMTP id v13so1569316wrw.5
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 04:31:12 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	x81sm9699201wmg.17.2018.12.20.04.31.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 20 Dec 2018 04:31:09 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
	by zen.linaro.local (Postfix) with ESMTPS id 37EA73E059D
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 12:31:09 +0000 (GMT)
References: <76d14474.f850.167cb46b4d9.Coremail.13824125580@163.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <76d14474.f850.167cb46b4d9.Coremail.13824125580@163.com>
Date: Thu, 20 Dec 2018 12:31:09 +0000
Message-ID: <87d0pw9y7m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] did the qemu can emulate the whole system with the
 processor that without support the "virtulization and kvm"?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


tugouxp <13824125580@163.com> writes:

> hi folks:
>      did the qemu can emulate the whole system(such as ubuntu) with
>      the processor that without support the "virtulization and kvm"?

I don't quite follow your question. However if you are asking about the
cross-architecture emulation (usually called TCG) the features of the
processor depend on how complete the front-end is.

So you can for example boot an aarch64 system under emulation that can
itself run KVM guests (because we implement EL0/1/2/3). However you
the system can't currently use VHE extensions because the support for
that has yet to be added.

What is your use-case?

--
Alex Benn=C3=A9e
