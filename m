Received: from eggs.gnu.org ([2001:4830:134:3::10]:52176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ernyl-0004iz-Ho
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ernyk-0001JO-Ko
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:56:19 -0500
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ernyk-0001Ic-Ds
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:56:18 -0500
Received: by mail-ot0-x22e.google.com with SMTP id n74so9301994ota.1
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 08:56:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302153205.9107-1-eblake@redhat.com>
References: <20180302153205.9107-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 16:55:53 +0000
Message-ID: <CAFEAcA_bJRe-iWra+8othHo0xo1TYjKp3mmU2TF1Buab1==7LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/30] QAPI patches for 2018-03-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2018 at 15:31, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 2e7b766594e17f786a6b2e5be690bc5b43ce6036:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-03-01' into staging (2018-03-02 12:39:13 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-01-v3
>
> for you to fetch changes up to cfe6a7fc6da20349ef62966c437f18ed6c49fcd5:
>
>   qapi: Don't create useless directory qapi-generated (2018-03-02 09:01:40 -0600)
>
> v3: (attempt to) fix warnings about empty .o files on OSX toolchain [Peter]
> (sending just the changed patch)
>
> ----------------------------------------------------------------
> qapi patches for 2018-03-01
>
> - Markus Armbruster: Modularize generated QAPI code
>

As I suspected, this isn't sufficient to silence the warnings.

thanks
-- PMM
