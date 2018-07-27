Received: from eggs.gnu.org ([2001:4830:134:3::10]:40051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fj6PE-0000mp-RU
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fj6PD-0002vY-UF
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:19:56 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fj6PD-0002ue-NN
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:19:55 -0400
Received: by mail-oi0-x243.google.com with SMTP id v8-v6so10365040oie.5
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 10:19:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180727155602.10148-1-armbru@redhat.com>
References: <20180727155602.10148-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jul 2018 18:19:34 +0100
Message-ID: <CAFEAcA8pkdr7Rsh+XMNbWrFpue26LGeHL5KpD8X+djiSVjpbwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] QObject patches for 2018-07-27
 (3.0.0-rc3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 July 2018 at 16:55, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc:
>
>   Update version for v3.0.0-rc2 release (2018-07-24 22:06:31 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qobject-2018-07-27
>
> for you to fetch changes up to 307fb894ce0608aede990ec40ce84eaeb358c8ec:
>
>   qstring: Move qstring_from_substr()'s @end one to the right (2018-07-27 17:16:03 +0200)
>
> ----------------------------------------------------------------
> QObject patches for 2018-07-27 (3.0.0-rc3)
>
> This pull request fixes an integer overflow bug, and hardens the code
> in question a bit.  Abuse of QMP can make the bug crash QEMU, so it
> seems worth fixing at this late stage.
>
> ----------------------------------------------------------------
> Markus Armbruster (2):
>       qstring: Assert size calculations don't overflow
>       qstring: Move qstring_from_substr()'s @end one to the right
>
> liujunjie (1):
>       qstring: Fix qstring_from_substr() not to provoke int overflow


Hi -- this passes my buildtests, but the commit from liujunjie
seems to be missing your maintainer signed-off-by (and possibly
a reviewed-by tag ?) Can I ask you to fix that up and resend,
please?

thanks
-- PMM
