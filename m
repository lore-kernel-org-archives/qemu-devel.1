Received: from eggs.gnu.org ([2001:4830:134:3::10]:45833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ceJMs-0001eY-7m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ceJMn-0001vT-Qf
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:32:54 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ceJMn-0001uH-Hx
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:32:49 -0500
Received: by mail-wm0-x232.google.com with SMTP id r141so11599149wmg.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 02:32:49 -0800 (PST)
References: <2004926324.426001.1487236519745.ref@mail.yahoo.com>
	<2004926324.426001.1487236519745@mail.yahoo.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <2004926324.426001.1487236519745@mail.yahoo.com>
Date: Thu, 16 Feb 2017 10:32:47 +0000
Message-ID: <878tp6v31s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] about translation block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: oussema ben khedher <oussemakeder@yahoo.fr>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


oussema ben khedher <oussemakeder@yahoo.fr> writes:

> hi
> im using qemu and i run in it a sample application of addition.c that
> do a+b=cin order to implement a trace for the code execution od
> addition.c i want to get adresses of transaltion block

If you run your application with -d in_asm,op,op_opt,out_asm you'll see
all the various stages that translate the input code into the eventual
translated code.

> thank you for the help


--
Alex Bennée
