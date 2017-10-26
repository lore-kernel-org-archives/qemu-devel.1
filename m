Received: from eggs.gnu.org ([2001:4830:134:3::10]:33969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iEe-00021k-JO
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iEb-00023D-Td
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:30:12 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:46518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7iEb-000225-PC
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:30:09 -0400
Received: by mail-qk0-x234.google.com with SMTP id k123so4235511qke.3
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 06:30:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
	<CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
	<CAFEAcA9XdoV0YVw+q7op_vafe9X0JTiQdYmGcmPgqRR3qhUYrQ@mail.gmail.com>
	<20171026070608.GC5847@redhat.com>
	<CAFEAcA8f7jJsM3=4bZG8fE_kTm6jueC-rF6ga0mdUvzMDSpLwQ@mail.gmail.com>
	<20171026100645.GA24581@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8774f2a0-274f-b358-c316-d3484f15b2cb@amsat.org>
Date: Thu, 26 Oct 2017 10:29:59 -0300
MIME-Version: 1.0
In-Reply-To: <20171026100645.GA24581@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10/26/2017 07:06 AM, Daniel P. Berrange wrote:
> Do we really expect make/configure todo the right thing when going
> backwards in time ?

"Yes"? Ideally at least :)

> I've always assumed that if you go back in time
> when you need to do a 'git clean -f -x d' and re-run configure from> scratch.
I certainly don't do that and would rather not have to think about it.

I also don't think about calling it when bisecting, however looking at
the man page, this is somehow suggested in the example:

·   Automatically bisect with temporary modifications (hot-fix):
[...]
        # undo the tweak to allow clean flipping to the next commit
        git reset --hard

This could be a warning displayed via a post-checkout hook, for this
particular merge hash, or if you go way too back in time...

> Certainly in the past various makefile changes in QEMU would> break, or silently not correctly recompile stuff when going backwards
> in time.

Travis is already taking too long, but we could add a such test
(merge/build/checkout backward/configure/quick build), not sure if we
gain much.
