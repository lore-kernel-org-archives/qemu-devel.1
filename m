Received: from eggs.gnu.org ([2001:4830:134:3::10]:57074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLTV-0006OO-Gz
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLTU-0004LS-II
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:18:09 -0400
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:35113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLTU-0004L6-D6
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:18:08 -0400
Received: by mail-it0-x230.google.com with SMTP id v202so14438216itb.0
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 21:18:08 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CC588DAB-E108-4D59-867D-B0BCC98CA6A3@icloud.com>
References: <CC588DAB-E108-4D59-867D-B0BCC98CA6A3@icloud.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Jun 2017 01:18:07 -0300
Message-ID: <CAAdtpL54iDEs1aS-j+rJer2sS=E1OPC=vf1X5jwzaQkkr8bwwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] glue(glue(ld, USUFFIX), _p)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Theodore Dubois <tblodt@icloud.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Theodore,

> In include/exec/cpu_ldst_useronly_template.h, there=E2=80=99s references =
to glue(glue(ld, USUFFIX), _p), which would expand to a call to a function =
looking something like uint32_t lduw_p(void *) (for example). Where is this=
 function defined?

You might be looking for the glue address_space_lduw_internal() at
line 251 of memory_ldst.inc.c:

https://github.com/qemu/qemu/blob/master/memory_ldst.inc.c#L251

Regards,

Phil.
