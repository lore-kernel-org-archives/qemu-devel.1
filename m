Received: from eggs.gnu.org ([2001:4830:134:3::10]:55720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBhVq-0007DB-Ek
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBhVl-0000Y9-Th
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:04:42 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:38780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBhVl-0000Xw-P6
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:04:37 -0400
Received: by mail-oi0-x22b.google.com with SMTP id k17-v6so4951914oih.5
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 07:04:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180426135755.GI29865@localhost.localdomain>
References: <20180426135755.GI29865@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 15:04:16 +0100
Message-ID: <CAFEAcA_4_K-aGJL4ds3G3p_-Dc1=6OGp9fUaZFuE+PW=UBoSSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Yash Mankad <ymankad@redhat.com>

On 26 April 2018 at 14:57, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Peter, do you have additional tests you run before merging a pull
> request?  Additional test sets run before tagging a release?

I run make && make check, on a variety of hosts, before merging
any pull request. That's the only testing I do, and I don't
do anything more before I do a tag.

thanks
-- PMm
