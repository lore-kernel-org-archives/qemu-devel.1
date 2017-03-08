Received: from eggs.gnu.org ([2001:4830:134:3::10]:47860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clWLu-0006ue-Fb
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clWLt-0004rp-OU
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:49:42 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clWLt-0004rh-Id
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:49:41 -0500
Received: by mail-wr0-x22e.google.com with SMTP id u48so17385504wrc.0
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 23:49:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170307194617.GJ2869@work-vm>
References: <20170307194617.GJ2869@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Mar 2017 08:49:19 +0100
Message-ID: <CAFEAcA8KxG8OC3YzuYCHJyT_Ya6cnLFnZRWnm-k74uYQjh0eww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] RAMBlock's named ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>

On 7 March 2017 at 20:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> The real fun is that there doesn't seem to be anything that stops
> two blocks having the same name!

The memory region API says that the name is for debugging only,
so the problem is in code which relies on them being unique :-)

thanks
-- PMM
