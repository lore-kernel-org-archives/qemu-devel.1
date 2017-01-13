Received: from eggs.gnu.org ([2001:4830:134:3::10]:53719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cS5Tj-0003f4-Fj
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cS5Ti-00049z-I2
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:17:27 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:33474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cS5Ti-00049r-DE
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:17:26 -0500
Received: by mail-vk0-x22c.google.com with SMTP id 137so37644492vkl.0
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 09:17:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112175356.21701-1-ehabkost@redhat.com>
References: <20170112175356.21701-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jan 2017 17:17:05 +0000
Message-ID: <CAFEAcA-fpz+dZStci1+fUuQBMObo75idbgSBDp5zUSLZ0YyBVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] x86 and machine queue, 2017-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 12 January 2017 at 17:53, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 204febd17f9ebb9e94b1980b42c7f2c2307851c1:
>
>   libqtest: handle zero length memwrite/memread (2017-01-12 10:45:59 +0000)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>
> for you to fetch changes up to 8ed877b78498c89aa7ce5c76aa20841ff5072796:
>
>   qmp: Report QOM type name on query-cpu-definitions (2017-01-12 15:51:36 -0200)
>
> ----------------------------------------------------------------
> x86 and machine queue, 2017-01-17
>
> Includes i386, CPU, NUMA, and memory backends changes.
>
> i386:
>  target/i386: Fix bad patch application to translate.c
>
> CPU:
>  qmp: Report QOM type name on query-cpu-definitions
>
> NUMA:
>  numa: make -numa parser dynamically allocate CPUs masks
>
> Memory backends:
>  qom: remove unused header
>  monitor: reuse user_creatable_add_opts() instead of user_creatable_add()
>  monitor: fix qmp/hmp query-memdev not reporting IDs of memory backends
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
