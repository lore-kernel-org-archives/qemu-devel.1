Received: from eggs.gnu.org ([2001:4830:134:3::10]:45353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFkdA-0007Xv-1q
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFkd8-00013D-U3
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:08:28 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:34656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFkd8-000131-Lx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:08:26 -0400
Received: by mail-wm0-x236.google.com with SMTP id 123so29002640wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 10:08:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170530140103.GI32274@thinpad.lan.raisama.net>
References: <20170511191843.13784-1-ehabkost@redhat.com>
	<20170511191843.13784-3-ehabkost@redhat.com>
	<CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
	<20170530140103.GI32274@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 18:08:04 +0100
Message-ID: <CAFEAcA8zh4-EJfoW89woUEJngJQdEaOpZYceGCpfNbO99XCD8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 02/29] numa: Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, He Chen <he.chen@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>

On 30 May 2017 at 15:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, May 30, 2017 at 11:45:55AM +0100, Peter Maydell wrote:
>> Hi all; I'm afraid this patch breaks compilation on OSX:
>
> It looks like this wasn't detected by travis-ci because the build
> is not using -Werror:
> https://travis-ci.org/ehabkost/qemu/jobs/236485778#L3881

Hmm. It would be nice to fix that. configure doesn't enable -Werror
by default on OSX because it doesn't handle some of the pragmas
to disable warnings that we use, but on the typical OSX build
the warnings that we use the pragmas to suppress don't get
generated anyway, so -Werror works in practice. It needs
configure '--extra-cflags=-Werror' to turn on.
(It might also need --disable-vnc-sasl depending on OSX version
since Apple helpfully added a pile of deprecation warnings to
their version of the sasl headers without suggesting what to
use instead.)

thanks
-- PMM
