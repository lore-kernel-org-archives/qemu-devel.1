Received: from eggs.gnu.org ([2001:4830:134:3::10]:50276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e729m-000753-AZ
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e729l-0004fJ-8I
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:34:22 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:57113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e729l-0004eZ-2l
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:34:21 -0400
Received: by mail-wm0-x241.google.com with SMTP id z3so10551582wme.5
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 09:34:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171024162752.GA21671@redhat.com>
References: <20171024085853.32615-1-aik@ozlabs.ru>
	<20171024162752.GA21671@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2017 17:33:59 +0100
Message-ID: <CAFEAcA-eX2+Qv15AZn3W4xrKbL092yos8LM+L2_AXvHKtsHwUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH qemu] git-submodule.sh: Do not try
 writing to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>

On 24 October 2017 at 17:27, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Tue, Oct 24, 2017 at 07:58:53PM +1100, Alexey Kardashevskiy wrote:
>> I compile out of tree on a remote guest system where I mount the
>> source directory as "readonly" and build directory as "rw" and
>> scripts/git-submodule.sh tries writing to the source directory even when
>> I manually update modules on a host machine which is quite annoying.
>>
>> Is this something acceptable? Or I am missing something here?
>
> How did you update the modules - did you manually run  'git submodule update...'
> or did you use the git-submodule.sh script on your host machine ?
>
> If you run git-submodule.sh on the host, then it should save the status
> file, and then when you run make on the guest system, it should notice
> that you're already updated and never even invoke 'git-submodule.sh update'
>
> I'm not against your proposal below, but I'm curious why you're seeing
> 'git-submodule.sh update' being run by make in the first place.

I don't think "git checkout on the fileserver, then build on the
remote machine" is a particularly weird workflow. I'm starting
to feel that the idea of doing git updates during "make" is not
so good as it initially seemed; it's just not something that
people expect to have happen during the build step.

thanks
-- PMM
