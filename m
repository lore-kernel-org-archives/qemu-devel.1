Received: from eggs.gnu.org ([2001:4830:134:3::10]:39952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3MhX-00068Q-Dc
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3MhS-0003o8-Ki
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:09:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170426115826.1826-1-n54@gmx.com>
Date: Wed, 26 Apr 2017 15:09:39 +0200
In-Reply-To: <20170426115826.1826-1-n54@gmx.com> (Kamil Rytarowski's message
	of "Wed, 26 Apr 2017 13:58:26 +0200")
Message-ID: <871ssfuxgs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] scripts: Switch to more portable Perl
 shebang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-trivial@nongnu.org

Kamil Rytarowski <n54@gmx.com> writes:

> The default NetBSD package manager is pkgsrc and it installs Perl
> along other third party programs under custom and configurable prefix.
> The default prefix for binary prebuilt packages is /usr/pkg, and the
> Perl executable lands in /usr/pkg/bin/perl.
>
> This change switches "/usr/bin/perl" to "/usr/bin/evn perl" as it's

/usr/bin/env

> the most portable solution that should work for almost everybody.
> Perl's executable is detected automatically.
>
> This change switches -w option passed to the executable with more
> modern "usr warnings;" approach. There is no functional change to the

use warnings;

> default behavior.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>

Cc: qemu-trivial
