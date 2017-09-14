Received: from eggs.gnu.org ([2001:4830:134:3::10]:42586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsVDX-0002qj-Ai
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsVDP-0003pX-Mk
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:34:11 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:46925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsVDP-0003nM-E4
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:34:03 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i189so1031754wmf.1
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 07:34:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504729728-23279-1-git-send-email-cota@braap.org>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 15:33:41 +0100
Message-ID: <CAFEAcA93-A3rLfWGAHSe5+mNutNkM17YTsrPo7YyK8Zo_ngGVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 0/6] initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

On 6 September 2017 at 21:28, Emilio G. Cota <cota@braap.org> wrote:
> Related threads:
>   [PATCH 00/13] instrument: Add basic event instrumentation
>   Date: Mon, 24 Jul 2017 20:02:24 +0300
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html
> and
>   [PATCH v4 00/20] instrument: Add basic event instrumentation
>   Date: Wed, 6 Sep 2017 20:22:41 +0300
>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07419.html
>
> This set does something similar to the instrumentation patches by Lluis,
> but with a different implementation (and for now less events).
>
> My focus has been on working on the skeleton of a (pseudo) stable API,
> as Stefan requested. Of course more events would have to be added, but
> before spending more time on this I'd like to get some feedback on the
> core of the design. Patch 2 has all the details.
>
> Note: yes, patch 1 is not used in the series, but this is an RFC. It's there
> because it will be needed to get the tb->plugin_mask when deciding whether
> to generate a mem_cb helper when generating loads/stores from TCG.
>
> This set applies on top of:
>   https://github.com/cota/qemu/tree/tcg-generic-15%2Bmulti-tcg-v4-parallel
>
> The tree can be fetched from:
>   https://github.com/cota/qemu/tree/plugins

Hi -- do you have documentation of what the plugin-facing
API here is? What I'd like to do for the initial evaluation of
this series and Luis's is just to look at the plugin API
and the command line/etc interface for users to provide the
API, because I think that's the interesting part.

thanks
-- PMM
