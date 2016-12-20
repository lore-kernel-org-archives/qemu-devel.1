Received: from eggs.gnu.org ([2001:4830:134:3::10]:36698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJN39-0001QI-Cp
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJN35-0008FD-Lw
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:13:59 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:35207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cJN35-0008Ez-HF
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:13:55 -0500
Received: by mail-it0-x241.google.com with SMTP id b123so14473514itb.2
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 08:13:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHDbmO0nFH6f9ZTjKbPuu2j5PZ_tSN8dV8WJqPpm=4mbPmM67g@mail.gmail.com>
References: <000301d259dc$f9d097c0$ed71c740$@ru>
	<000601d25a95$12b1b9f0$38152dd0$@ru>
	<20161220102126.GE5602@stefanha-x1.localdomain>
	<002501d25ab1$af024b00$0d06e100$@ru>
	<CAJSP0QXm9ssLC5C+gV_agkEW_fdUY=NWBMvHqMh55UhYTR276g@mail.gmail.com>
	<CAHDbmO0nFH6f9ZTjKbPuu2j5PZ_tSN8dV8WJqPpm=4mbPmM67g@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 20 Dec 2016 16:13:54 +0000
Message-ID: <CAJSP0QVM87_rg1z6XetNxtN-1xUTcAKmkRM9TN7yyNYpb0Os_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Maydell <peter.maydell@linaro.org>

Thanks for looking into this bug.

The QEMU 2.8 release will go ahead as planned today since this is an
existing race and there is a potential workaround (i.e. disabling
vapic on x86).

Stefan
