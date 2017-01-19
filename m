Received: from eggs.gnu.org ([2001:4830:134:3::10]:57390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUHMU-0000Kx-Ls
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUHMT-0005Qn-PU
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:23:02 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:32878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUHMT-0005QK-KW
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:23:01 -0500
Received: by mail-ua0-x22e.google.com with SMTP id i68so42474062uad.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 10:23:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170119175003.GJ16641@redhat.com>
References: <20170116195452.23532-1-ehabkost@redhat.com>
	<20170119175003.GJ16641@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 18:22:40 +0000
Message-ID: <CAFEAcA9HEp+-JvtA49NRUWpA2LsOOLw+SaA-knS5x9=bn89UjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 19 January 2017 at 17:50, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Mon, Jan 16, 2017 at 05:54:52PM -0200, Eduardo Habkost wrote:
>> Change the meaning of "-cpu host" to "enable all features
>> supported by the accelerator in the current host", so that it can
>> be used to enable/query all features supported by TCG.
>>
>> To make sure "host" is still at the end of the list in "-cpu
>> help", add a "ordering" field that will be used when sorting the
>> CPU model list.
>
> To be clear, "-cpu host" for TCG is not talking about the actual
> host OS feature support, right ? x86_64 TCG can be run on a ppc host,
> so presumably "-cpu host" just means "all features that this TCG binary
> is able to emulate" ?
>
> This feels like it is introducing scope for confusion vs KVM -cpu host,
> so I wonder if different naming is better for this.

The idea is that you do want an option that works whatever the
accelerator is, though, so as a user you don't need to worry
about messing with the command line for KVM vs TCG vs "try
KVM and fall back to TCG". (I think "-cpu best" has been thrown about
as a suggestion for this before.)

thanks
-- PMM
