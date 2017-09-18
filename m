Received: from eggs.gnu.org ([2001:4830:134:3::10]:48096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dttM4-0000Xj-6y
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dttM3-0002dS-El
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:32:44 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:48104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dttM3-0002d8-9G
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:32:43 -0400
Received: by mail-wm0-x231.google.com with SMTP id 13so1325370wmq.2
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 03:32:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918052524.4045-1-kwolf@redhat.com>
References: <20170918052524.4045-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 11:32:21 +0100
Message-ID: <CAFEAcA_13Xd2koorvnbr8ADDwT9oq1qVGVebQS1s58sfaW4C7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Fix syntax error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Lukas Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Amador Pahim <apahim@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 18 September 2017 at 06:25, Kevin Wolf <kwolf@redhat.com> wrote:
> Python requires parentheses around multiline expression. This fixes the
> breakage of all Python-based qemu-iotests cases that was introduced in
> commit dab91d9aa0.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>
> Eduardo, I think I'm going to include this patch in a block layer pull
> request today, just to stop the CI spam I'm getting, so the CC is just
> FYI.

Applied to master as a buildfix; thanks.

-- PMM
