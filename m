Received: from eggs.gnu.org ([2001:4830:134:3::10]:49802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiypg-0006zE-Il
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiypf-0004xn-M3
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:14:44 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fiypf-0004xf-8t
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:14:43 -0400
Received: by mail-oi0-x242.google.com with SMTP id w126-v6so7905724oie.7
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 02:14:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621122638.12113-1-f4bug@amsat.org>
References: <20180621122638.12113-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jul 2018 10:14:22 +0100
Message-ID: <CAFEAcA9=SFQvQfu-9E9Qi+XrB-1uXxutWQ29pjRf=vxJH_h-7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] travis: Test out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 21 June 2018 at 13:26, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Force one config to build 'out-of-tree' (object files and executables
> are created in a tree outside the project source code).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> I noticed various out-of-tree issue in the last 2 merge windows.

That's odd, because all my pre-merge build tests are out-of-tree
(in-tree is the case I don't cover). Presumably they were only
for specific oddball configs ?

(Not that there's any harm in covering this in travis too.)

thanks
-- PMM
