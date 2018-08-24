Received: from eggs.gnu.org ([2001:4830:134:3::10]:36504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDTN-0003wf-Ru
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftDTN-0001Pp-7w
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:54:01 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftDTM-0001P8-RF
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:54:01 -0400
Received: by mail-oi0-x241.google.com with SMTP id 8-v6so15821157oip.0
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 07:54:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180824144840.GV3430@redhat.com>
References: <20180824012126.22721-1-famz@redhat.com>
	<8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
	<20180824144341.GU3430@redhat.com>
	<CAFEAcA-r4CrL91gk0JhD4_iEZEOR=02Aa+noo3H3sed==P+6WQ@mail.gmail.com>
	<20180824144840.GV3430@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 15:53:39 +0100
Message-ID: <CAFEAcA8+Axs2xGCJkuFr6SG2Xz9zYf_FZxFK_bP0xk=C32CxTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 24 August 2018 at 15:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
> On Fri, Aug 24, 2018 at 03:46:31PM +0100, Peter Maydell wrote:
>> Is emulated TLS a sufficiently complete/performant TLS
>> implementation for our purposes?
>>
>> (I think it would be better if OpenBSD just implemented real TLS
>> like every other host OS we support.)
>
> My reading of the situation is that OpenBSD *does* support real TLS,
> but our configure script failed to detect that it supported it,
> due to missing "-pthread" arg.

Real TLS doesn't require that you have to call out to
pthread_* functions or link against a library to get it.
It's directly implemented by the C compiler/linker/runtime.

thanks
-- PMM
