Received: from eggs.gnu.org ([2001:4830:134:3::10]:38743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvKNc-0006JX-Ba
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvKNb-0000bX-Fi
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:36:16 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:44867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvKNb-0000b7-8o
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:36:15 -0400
Received: by mail-wr0-x236.google.com with SMTP id v109so497434wrc.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 02:36:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922075401.GA2933@vader>
References: <20170920083647.14599-1-famz@redhat.com>
	<df117864-4533-9527-d051-62a126e60794@siemens.com>
	<20170922075401.GA2933@vader>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 10:35:53 +0100
Message-ID: <CAFEAcA9QCAYodtsA=Tp_E9cp1sNm2oTQsNHvoudc3LnCm0FFHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] seccomp: Don't include libseccomp from
 QEMU header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 22 September 2017 at 08:54, Eduardo Otubo <otubo@redhat.com> wrote:
> On Fri, Sep 22, 2017 at 09:09:27AM +0200, Jan Kiszka wrote:
>> On 2017-09-20 10:36, Fam Zheng wrote:
>> > The only prototype doesn't need anything from the lib header, and not
>> > including it here allows files that include this header, for example
>> > vl.c, to compile without the libseccomp cflags.
>> >
>> > The breakage is since c3883e1f93 for environments where `pkg-config
>> > --cflags libseccomp" is non-empty.
>> >
>> > Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
>> > Signed-off-by: Fam Zheng <famz@redhat.com>
>
> Acked-by: Eduardo Otubo <otubo@redhat.com>
>

Thanks. Applied to master as a buildfix.

-- PMM
