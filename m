Received: from eggs.gnu.org ([209.51.188.92]:38890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBMPu-0006HL-47
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBMCb-0006tm-HP
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:23:58 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBMCZ-0006na-G2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:23:57 -0400
Received: by mail-oi1-x244.google.com with SMTP id w139so10969324oie.9
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <1554194900-22817-1-git-send-email-like.xu@linux.intel.com>
	<871s2kejg1.fsf@dusky.pond.sub.org>
	<e72befe5-c931-5c80-6769-12e1a8e7d4fa@linux.intel.com>
	<20190402174749.71da1efe@redhat.com>
	<871s2k8jxo.fsf@dusky.pond.sub.org>
In-Reply-To: <871s2k8jxo.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 23:23:42 +0700
Message-ID: <CAFEAcA8ogWn50wWBttM2QpfQoZ8UYnXfG3NSkuSc8j8WOWt6FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] vl.c: make current_machine as
 non-global variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Like Xu <like.xu@linux.intel.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 2 Apr 2019 at 23:13, Markus Armbruster <armbru@redhat.com> wrote:
>
> Igor Mammedov <imammedo@redhat.com> writes:
> > maybe we can assert in qdev_get_machine() if machine hasn't been created yet?
> > with this at least it will be hard to misuse function or catch invalid users.
> > (but it still might miss some use cases/CLI options which are not tested)
>
> Good idea.  When my code created "/machine" as a container, debugging
> the resulting crash took me a bit of time.  The assertion you propose
> would've saved me some.

One wrinkle to watch out for is code paths that are used in the
linux-user emulator, where there is no machine at all... For instance
cpu_common_realizefn() handles this case by explicitly checking
whether the thing it gets back from qdev_get_machine() is a
TYPE_MACHINE or not.

thanks
-- PMM
