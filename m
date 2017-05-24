Received: from eggs.gnu.org ([2001:4830:134:3::10]:37948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dDPbx-0006y8-9D
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dDPbu-0007IO-5o
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dDPbu-0007I6-0H
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:17:30 -0400
Message-ID: <1495606647.30747.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 24 May 2017 08:17:27 +0200
In-Reply-To: <CA+YAiviJq3VSLR1yCD9Yob7xb5z60Gw59mrSLL1+qFrtnv7OUw@mail.gmail.com>
References: <20170522180217.18234-1-ianloic@google.com>
	<1495533796.30747.2.camel@redhat.com>
	<CA+YAivh=GjS5P_3BXccj5tYSxNSQoHQfeTvjgCQfVtw5QwY=_A@mail.gmail.com>
	<CA+YAiviJq3VSLR1yCD9Yob7xb5z60Gw59mrSLL1+qFrtnv7OUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/1] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian McKellar <ianloic@google.com>, qemu-devel@nongnu.org

  Hi,

> After a little more experimentation I think that the approach in this
> patch is the right one. modifierFlags doesn't[1] indicate which
> instance of a modifier (ie: left or right) is being held.

Ok, makes sense.  One more thing:  I think capslock must be handled
differently as keydown + keyup toggle state.

cheers,
  Gerd
