Received: from eggs.gnu.org ([208.118.235.92]:59587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gezSz-00053J-Dq
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gezSw-0006ty-Or
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:39:05 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190102110804.18155-2-lbloch@janustech.com>
References: <20190102110804.18155-1-lbloch@janustech.com>
	<20190102110804.18155-2-lbloch@janustech.com>
Date: Thu, 03 Jan 2019 10:19:26 +0100
Message-ID: <w51h8eqdroh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed 02 Jan 2019 12:09:05 PM CET, Leonid Bloch wrote:
> +print_sizes() {
> +    local p=10
> +    while [ ${p} -lt 64 ]
> +    do
> +        local pad=' '
> +        local n=$((p % 10))
> +        n=$((1 << n))
> +        [ $((n / 100)) -eq 0 ] && pad='  '
> +        [ $((n / 10)) -eq 0 ] && pad='   '
> +        local suff=$((p / 10))
> +        printf "#define S_%u%s%s%20u\n" ${n} "$(size_suffix ${suff})" \
> +            "${pad}" $((1 << p))
> +        p=$((p + 1))
> +    done
> +}

I have to say that I'm not very convinced of the benefits of replacing a
set of trivial numeric macros with a longer and harder to read shell
script accompanied by changes to the build system.

Berto
