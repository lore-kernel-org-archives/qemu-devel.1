Received: from eggs.gnu.org ([209.51.188.92]:42430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBTNp-00031v-59
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 20:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBTNo-0004FV-AG
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 20:04:01 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBTNn-0004F9-QM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 20:04:00 -0400
Received: by mail-ot1-x341.google.com with SMTP id s24so13706613otk.13
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 17:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <1554194900-22817-1-git-send-email-like.xu@linux.intel.com>
	<871s2kejg1.fsf@dusky.pond.sub.org>
	<e72befe5-c931-5c80-6769-12e1a8e7d4fa@linux.intel.com>
	<20190402174749.71da1efe@redhat.com>
	<871s2k8jxo.fsf@dusky.pond.sub.org>
	<CAFEAcA8ogWn50wWBttM2QpfQoZ8UYnXfG3NSkuSc8j8WOWt6FA@mail.gmail.com>
	<20190402191602.GE22884@habkost.net>
In-Reply-To: <20190402191602.GE22884@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Apr 2019 07:03:47 +0700
Message-ID: <CAFEAcA_qtqE_N-JOZn=M-NqHg4GjohU44R7A6hOXTxbOCqjrtA@mail.gmail.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Like Xu <like.xu@linux.intel.com>, Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 3 Apr 2019 at 02:16, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Tue, Apr 02, 2019 at 11:23:42PM +0700, Peter Maydell wrote:
> > One wrinkle to watch out for is code paths that are used in the
> > linux-user emulator, where there is no machine at all... For instance
> > cpu_common_realizefn() handles this case by explicitly checking
> > whether the thing it gets back from qdev_get_machine() is a
> > TYPE_MACHINE or not.
>
> Is there a real use case for calling qdev_get_machine() in user
> mode?

In this case it's "I'm in a function which is in obj-common (so shared
between user-only and system-emulation) and I need to do something
if we're in system emulation mode". It could probably be restructured
somehow.

thanks
-- PMM
