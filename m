Received: from eggs.gnu.org ([2001:4830:134:3::10]:50597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnN4d-0004IP-Pj
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnN4Z-0000cP-Bk
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:19:31 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnN4Z-0000aa-4l
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 06:19:27 -0400
Received: by mail-wm0-x230.google.com with SMTP id t189so35969541wmt.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 03:19:25 -0700 (PDT)
References: <928382347.7043935.1489394441716.ref@mail.yahoo.com>
	<928382347.7043935.1489394441716@mail.yahoo.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <928382347.7043935.1489394441716@mail.yahoo.com>
Date: Mon, 13 Mar 2017 10:19:38 +0000
Message-ID: <87bmt5qy11.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] how to enable trace
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

> i used simple trace back end to trace guest code running in qemu but when i tried to recompile and disable this trace i have always this problem
> undefined reference to `trace_record_write_u64'
> thanks for your help

It's always worth doing a make clean if you change you configure
options.

What was your configure command and what exactly did the compiler say?


--
Alex Bennée
