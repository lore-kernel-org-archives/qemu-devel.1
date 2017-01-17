Received: from eggs.gnu.org ([2001:4830:134:3::10]:56619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTSJi-0002oP-FJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTSJh-0006XQ-Kk
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:52:46 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:33146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTSJh-0006XF-Fp
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:52:45 -0500
Received: by mail-ua0-x235.google.com with SMTP id i68so100806894uad.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:52:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112142836.53bbd87b@squid.athome>
References: <cover.1481121503.git.julian@codesourcery.com>
	<b7f0904f00d135f9b2760b8881dbc9ead23cedbf.1481121503.git.julian@codesourcery.com>
	<CAFEAcA-EQ-e39uv1rnTUb5SwDZzPrHUfhydY5hzc8CrP4NhX_w@mail.gmail.com>
	<20170111123552.1873cb3b@squid.athome>
	<20170112142836.53bbd87b@squid.athome>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 11:52:24 +0000
Message-ID: <CAFEAcA8eYeLNrTK-hupM9jA7CPjD8OgEU85As94fWXQETxRgXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/6] Add cfgend parameter for ARM CPU
 selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 12 January 2017 at 14:28, Julian Brown <julian@codesourcery.com> wrote:
> On Wed, 11 Jan 2017 12:35:52 +0000
> Julian Brown <julian@codesourcery.com> wrote:
>
>> I'm a little confused, I think -- these changes seemed to be necessary
>> to allow the parsing of the command-line syntax you suggested earlier
>> (-mcpu=foo,cfgend=bar):
>> [...]
>> Can the existing properties be set like that via the command line?
>
> Aha! The answer was yes, but only currently for the "virt" board
> (which we haven't been using for aarch32, and only supports a few recent
> CPU types at present). I'm less confused now! (The string-splitting code
> in arm_cpu_class_by_name is still dubious though, IMO.)

Oops, I'd forgotten there was board-specific code for handling
cpu feature flags. I think we want to change the other boards
to do it like the virt board does, but maybe I'm wrong.
I've cc'd Eduardo who will hopefully know the right way to handle
this.

thanks
-- PMM
