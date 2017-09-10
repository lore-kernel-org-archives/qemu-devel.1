Received: from eggs.gnu.org ([2001:4830:134:3::10]:36408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqrdE-0002NY-RB
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 22:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqrd9-0004UB-Tv
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 22:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqrd9-0004Tv-Ng
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 22:05:51 -0400
Date: Sun, 10 Sep 2017 10:05:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170910020547.GA32341@lemon.lan>
References: <20170909054613.19148-1-famz@redhat.com>
	<20170909054613.19148-11-famz@redhat.com>
	<CAFEAcA83JDUMAsCAY=YBL+qS8A1n6VMfH1p_DAmouF0W8m-j9g@mail.gmail.com>
	<20170909150710.GA29670@lemon.lan>
	<4377bd37-3309-fe80-666f-f05626efe930@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4377bd37-3309-fe80-666f-f05626efe930@gmx.com>
Subject: Re: [Qemu-devel] [PULL v2 10/37] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, 09/09 17:08, Kamil Rytarowski wrote:
> >>> +submodules=$(git submodule foreach --recursive --quiet 'echo $name')
> >>> +
> >>> +if test -n "$submodules"; then
> >>> +    {
> >>> +        git ls-files
> >>> +        for sm in $submodules; do
> >>> +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> >>> +        done
> >>> +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > $1.list
> >>
> >> Supporting '-e something' in a tar -T listfile seems to
> >> be GNU tar specific. Do we care?
> > 
> > The "-e $sm" will go to the grep command line, so it isn't GNU specific, is it?
> > 
> 
> BSD OSes use GNU grep(1) the latest version GPLv2. There is a work in
> progress BSD grep(1), but not turned on by default as it's slower.
> 
> The -e option is supported by SmartOS grep(1).

Is there a more portable way to filter out multiple patterns?

Fam
