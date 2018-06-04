Received: from eggs.gnu.org ([2001:4830:134:3::10]:40537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPloQ-0005HA-40
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPloP-0000IP-D5
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:30:02 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:36211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPloP-0000He-7N
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:30:01 -0400
Received: by mail-ot0-x22e.google.com with SMTP id m11-v6so36750327otf.3
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:30:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604092008.GA13674@stefanha-x1.localdomain>
References: <20180603203412.11033-1-contrib@steffen-goertz.de>
	<20180604092008.GA13674@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 10:29:40 +0100
Message-ID: <CAFEAcA9kdvxa61HNxv-cDhcv07E_NUpwVcSJVYNw4weS3k7nUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v3] qapi: command category to stimulate
 high-level machine devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 4 June 2018 at 10:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Many of these inputs/outputs can be tied to an external UI.  A degree of
> timing precision is required so that the UI is responsive, although
> cycle-accurate timing is not what I'd expect from QMP.

Would we also be able to tie them to an internal UI, ie
something that appears as another view in the GTK/etc
UI frontends we have?

thanks
-- PMM
