Received: from eggs.gnu.org ([2001:4830:134:3::10]:46961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnnaP-00046R-5b
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fnnaO-0004en-9j
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:14:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fnnaO-0004dy-0Q
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:14:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id h14-v6so5610465wrw.13
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 09:14:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180806100114.21410-6-contrib@steffen-goertz.de>
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-6-contrib@steffen-goertz.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 9 Aug 2018 17:14:49 +0100
Message-ID: <CAJSP0QWecVwTRiCmHdrbgsN647H9t2svj9bQoNN1CnDdou04rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] tests/microbit-test: Add Tests for
 nRF51 GPIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, Aug 6, 2018 at 11:01 AM, Steffen G=C3=B6rtz
<contrib@steffen-goertz.de> wrote:
> +    /* Check Input propagates */
> +    g_assert_false(true);

Each patch must compile and run successfully.  This test case will
fail here.  Please don't do this - even if a later patch will fill in
the missing part.

The reason for this requirement is that git-bisect(1) must work on any
commit.  If the some commits don't compile or pass tests then it makes
git-bisect(1) much harder or impossible to use.

Stefan
