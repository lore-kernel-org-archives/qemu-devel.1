Received: from eggs.gnu.org ([2001:4830:134:3::10]:47279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fo0gD-0008FS-NP
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fo0gD-0007WQ-1Q
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:13:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fo0gC-0007Uk-Py
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:13:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id g6-v6so7232380wrp.0
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 23:13:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180808210750.3915-5-jusual@mail.ru>
References: <20180808210750.3915-1-jusual@mail.ru>
	<20180808210750.3915-5-jusual@mail.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 10 Aug 2018 07:13:43 +0100
Message-ID: <CAJSP0QXiCUPjCRoLL9J80ZA3+CFTjTnKwEXMeZwukTx7N9igsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] tests/microbit-test: Check nRF51
 UART functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On Wed, Aug 8, 2018 at 10:07 PM, Julia Suvorova <jusual@mail.ru> wrote:
>      ret = g_test_run();
>
>      qtest_quit(global_qtest);
> +
> +    close(sock_fd);
> +    rmdir(serialtmpdir);

This temporary directory is leaked if the test fails.  Please remove
it immediately after connect().
