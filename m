Received: from eggs.gnu.org ([209.51.188.92]:60095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gs8gR-0007Nc-Kc
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gs8gP-0005VH-OG
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:07:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gs8gP-0005U7-Dn
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:07:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so4130694wra.6
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 08:07:17 -0800 (PST)
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21d093b7-d414-f049-6dbc-e15af138ca8f@redhat.com>
Date: Fri, 8 Feb 2019 17:07:13 +0100
MIME-Version: 1.0
In-Reply-To: <87d0o24u0s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Maintainers, please git-am -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 2/8/19 8:30 AM, Markus Armbruster wrote:
> Short story: please add
> 
>     [am]
>             messageid = true
> 
> to your .gitconfig.
> 
> Long story.  git-am can add a Message-id: tag.  Looks like this:
> 
>     commit 335dbb5de1e98c4dc73590349f17bb2a4d72596c
>     Author: Thomas Huth <thuth@redhat.com>
>     Date:   Mon Feb 4 09:25:43 2019 +0100
>     Commit:     Peter Maydell <peter.maydell@linaro.org>
>     CommitDate: Mon Feb 4 15:25:21 2019 +0000
> 
>         tests/docker/test-mingw and docs: Remove --with-sdlabi=2.0
> 
>         Patchew currently reports failures with the mingw docker test - this
>         is due to --with-sdlabi=2.0 configure flag which does not exist anymore.
>         Remove this remainder from the docker test and the docs now.
> 
>         Signed-off-by: Thomas Huth <thuth@redhat.com>
>         Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>         Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>         Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>         Acked-by: Alex Bennée <alex.bennee@linaro.org>
> --->    Message-id: 1549268743-18502-1-git-send-email-thuth@redhat.com
>         Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> The Message-id identifies the patch e-mail.  It makes finding the review
> thread easier and more reliable.  It's also a valid key on Patchew[*].

It is sometimes confusing however, see:
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01992.html

We have:

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190123065618.3520-23-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This is probably a special case, and eventually a Patchew limitation,
but I first wondered who wrote this patch? Since the Message-Id is from
Yang Zhong, is the Signed-off-by tag incorrect?
Then I went thru the previous version and understood the author is
indeed Paolo, but his patch was first sent by Yang Zhong, then he
applied his own patch sent by Yang.

And yet this isn't a pull request but a simple patch, so the Message-Id
might not be very relevant there.

> 
> Sadly, not all of our commits don't carry it.  Here's how top committers

'committers' -> 'maintainers'?

(Actually committers don't know their patch Message-Id before sending
the patch).

> have been doing recently[**]:
> 
>    with without
>     264      21 Peter Maydell <peter.maydell@linaro.org>
>      65       2 Gerd Hoffmann <kraxel@redhat.com>
>      64       0 Laurent Vivier <laurent@vivier.eu>
>      64       0 Eric Blake <eblake@redhat.com>
>      62       1 Eduardo Habkost <ehabkost@redhat.com>
>      56       0 Markus Armbruster <armbru@redhat.com>
>      29      72 Richard Henderson <richard.henderson@linaro.org>
>      24      24 Paolo Bonzini <pbonzini@redhat.com>
>      10      31 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>       0     107 Kevin Wolf <kwolf@redhat.com>
>       0     106 David Gibson <david@gibson.dropbear.id.au>
>       0      93 Michael S. Tsirkin <mst@redhat.com>
>       0      81 Aleksandar Markovic <amarkovic@wavecomp.com>
>       0      69 Samuel Thibault <samuel.thibault@ens-lyon.org>
>       0      54 Alex Bennée <alex.bennee@linaro.org>
>       0      50 Thomas Huth <thuth@redhat.com>
>       0      29 Anthony PERARD <anthony.perard@citrix.com>
>       0      28 Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Not bad, but there's room for improvement.
> 
> 
> [*] Try https://patchew.org/search?q=id%3A1549268743-18502-1-git-send-email-thuth%40redhat.com
> 
> [**] git-log master --no-merges --pretty=fuller --since '3 months ago' | gawk '/^Commit: / { if (c) h[c][m]++; c=$0; m=0 } /^    Message-[Ii]d: / { m=1 } END { for (c in h) if (h[c][0] + h[c][1] > 25) printf "%7d %7d %s\n", h[c][1], h[c][0], substr(c,13) }' | sort -nr
> 
