Received: from eggs.gnu.org ([2001:4830:134:3::10]:57604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d6WZv-00044p-FO
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d6WZq-00007o-Is
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:18:59 -0400
References: <20170426115826.1826-1-n54@gmx.com>
	<20170426131604.3459-1-n54@gmx.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <7fa8f78f-7e89-d81f-1976-96c229c3bf4c@msgid.tls.msk.ru>
Date: Fri, 5 May 2017 09:16:44 +0300
MIME-Version: 1.0
In-Reply-To: <20170426131604.3459-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] scripts: Switch to more portable Perl
 shebang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, armbru@redhat.com

26.04.2017 16:16, Kamil Rytarowski wrote:
> The default NetBSD package manager is pkgsrc and it installs Perl
> along other third party programs under custom and configurable prefix.
> The default prefix for binary prebuilt packages is /usr/pkg, and the
> Perl executable lands in /usr/pkg/bin/perl.
> 
> This change switches "/usr/bin/perl" to "/usr/bin/env perl" as it's
> the most portable solution that should work for almost everybody.
> Perl's executable is detected automatically.
> 
> This change switches -w option passed to the executable with more
> modern "use warnings;" approach. There is no functional change to the
> default behavior.

Applied to -trivial, thanks!

/mjt
