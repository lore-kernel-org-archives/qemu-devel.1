Received: from eggs.gnu.org ([2001:4830:134:3::10]:32891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ianloic@google.com>) id 1dEOpQ-0006xe-76
	for qemu-devel@nongnu.org; Fri, 26 May 2017 19:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ianloic@google.com>) id 1dEOpP-0001Lj-D6
	for qemu-devel@nongnu.org; Fri, 26 May 2017 19:39:32 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ianloic@google.com>) id 1dEOpP-0001LX-6O
	for qemu-devel@nongnu.org; Fri, 26 May 2017 19:39:31 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l50so9051687wrc.3
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 16:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20170522180217.18234-1-ianloic@google.com>
	<1495533796.30747.2.camel@redhat.com>
	<CA+YAivh=GjS5P_3BXccj5tYSxNSQoHQfeTvjgCQfVtw5QwY=_A@mail.gmail.com>
	<CA+YAiviJq3VSLR1yCD9Yob7xb5z60Gw59mrSLL1+qFrtnv7OUw@mail.gmail.com>
	<1495606647.30747.10.camel@redhat.com>
In-Reply-To: <1495606647.30747.10.camel@redhat.com>
From: Ian McKellar <ianloic@google.com>
Date: Fri, 26 May 2017 23:39:17 +0000
Message-ID: <CA+YAivgJQ6yxy+wN+BMxbXk-NYhMWUWQmpwQZBBeL55vYHZE_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Sent another patch that does a better job of toggling caps-lock. I couldn't
make it fail with the old patch but I think the new patch is somewhat
better.

Ian

On Tue, May 23, 2017 at 11:17 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > After a little more experimentation I think that the approach in this
> > patch is the right one. modifierFlags doesn't[1] indicate which
> > instance of a modifier (ie: left or right) is being held.
>
> Ok, makes sense.  One more thing:  I think capslock must be handled
> differently as keydown + keyup toggle state.
>
> cheers,
>   Gerd
>
>
