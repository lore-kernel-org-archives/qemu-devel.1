Received: from eggs.gnu.org ([2001:4830:134:3::10]:33785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMz5-0005UA-T3
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMz5-0006ph-6M
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:51:55 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:41087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMz4-0006n9-Ud
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:51:55 -0400
Received: by mail-yw1-xc44.google.com with SMTP id q129-v6so2041860ywg.8
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:51:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_M2L8y0pc+LsudV0Ec-EzD5S-_E-jZE7QuXof+af3KTQ@mail.gmail.com>
References: <20180904210036.7317-1-jcmvbkbc@gmail.com>
	<CAFEAcA-AyrFVYWkM+_aBQ8eXH-03UZfgiHrB37v=-iM+A=70DA@mail.gmail.com>
	<CAMo8Bf+3gws2Sa24xMfVsAQ_PaZVqKPbpqpySAAHrdkvnF-erw@mail.gmail.com>
	<CAFEAcA8M9+sZQehFQSUrrZYZ4e=CH6aDc890FfRwbMdQfUmEKA@mail.gmail.com>
	<CAMo8Bf+bV9wAX_ctyy2pftLnyb+_7ukiVkD5sEENX94=nQmMfw@mail.gmail.com>
	<CAFEAcA9LtXdP7MYEf4X3SkJjnpQaSDRNaFh3rYVcWeaUgKBoew@mail.gmail.com>
	<CAMo8BfL3J-oFqHds3=0nya-Cke1FstXWpkZosvBJsvZmHJc4bw@mail.gmail.com>
	<CAFEAcA_M2L8y0pc+LsudV0Ec-EzD5S-_E-jZE7QuXof+af3KTQ@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 4 Sep 2018 18:51:53 -0700
Message-ID: <CAMo8Bf+RKpZA0SP11gjYbCMmq_uBbL_7ELPQg_T9yjZKkZDYnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: do setrlimit selectively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Tue, Sep 4, 2018 at 6:40 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> I still think 32-on-64 is a red herring here. If ignoring
> client attempts to set the memory rlimits makes sense on
> 32-on-64 it makes sense for all configurations.

Ok, I don't have anything against ignoring guest setrlimit completely, so
if that variant has better chances for positive review I'll gladly send it.

-- 
Thanks.
-- Max
