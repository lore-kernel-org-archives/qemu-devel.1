Received: from eggs.gnu.org ([2001:4830:134:3::10]:57033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUWUX-0001MX-VP
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gUWUS-0004l2-Uw
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:41:25 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gUWUS-0004i5-3w
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:41:20 -0500
Received: by mail-wr1-x443.google.com with SMTP id t27so19526642wra.6
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 04:41:17 -0800 (PST)
References: <20181124235553.17371-1-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124235553.17371-1-cota@braap.org>
Date: Wed, 05 Dec 2018 12:41:15 +0000
Message-ID: <871s6w2ljo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/13] hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> v5: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02793.html
>
> Changes since v5:
>
> - Rebase on rth/tcg-next-for-4.0
<snip>

Awesome work - the series is looking really good now and I think we are
ready for a merge once the tree re-opens. I think there were a few
wording changes and the #ifdef fix to apply so if you are happy to do
that I'll slurp up v7 prepare a PR once it's ready.

Going forward I think we want to wire up the fp-test code so we can run
it in CI via the rest of make check (or check-tcg?) but no need to hold
up the merge for that.

--
Alex Benn=C3=A9e
