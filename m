Received: from eggs.gnu.org ([2001:4830:134:3::10]:33827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fyTgw-0008Kt-15
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 23:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fyTgv-0002kS-8x
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 23:13:45 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fyTgu-0002jd-Sv
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 23:13:45 -0400
Received: by mail-oi0-x241.google.com with SMTP id b15-v6so30759357oib.10
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 20:13:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180908030136.844-1-programmingkidx@gmail.com>
References: <20180908030136.844-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Sep 2018 04:13:23 +0100
Message-ID: <CAFEAcA-W-J30u=AaJ6U8eAD6HppWW37h6pW95kVOd8rXE6mpEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: add help for each command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 8 September 2018 at 04:01, John Arbuckle <programmingkidx@gmail.com> wrote:

> +    /* print the help for this command */
> +    if (strcmp("--help", argv[optind + 1]) == 0) {
> +        if (strcmp("amend", cmdname) == 0) {
> +            help_amend();
> +        } else if (strcmp("bench", cmdname) == 0) {
> +            help_bench();
> +        } else if (strcmp("check", cmdname) == 0) {
> +            help_check();
> +        } else if (strcmp("commit", cmdname) == 0) {
> +            help_commit();
> +        } else if (strcmp("compare", cmdname) == 0) {
> +            help_compare();
> +        } else if (strcmp("convert", cmdname) == 0) {
> +            help_convert();
> +        } else if (strcmp("create", cmdname) == 0) {
> +            help_create();
> +        } else if (strcmp("dd", cmdname) == 0) {
> +            help_dd();
> +        } else if (strcmp("info", cmdname) == 0) {
> +            help_info();
> +        } else if (strcmp("map", cmdname) == 0) {
> +            help_map();
> +        } else if (strcmp("measure", cmdname) == 0) {
> +            help_measure();
> +        } else if (strcmp("snapshot", cmdname) == 0) {
> +            help_snapshot();
> +        } else if (strcmp("rebase", cmdname) == 0) {
> +            help_rebase();
> +        } else if (strcmp("resize", cmdname) == 0) {
> +            help_resize();

Any time you find yourself writing very repetitive code like
this, it's a good idea to ask yourself "is there a way to make
this data-driven?".

thanks
-- PMM
