Received: from eggs.gnu.org ([2001:4830:134:3::10]:38229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eYfoZ-0005RV-AT
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1eYfoW-0000Dr-7W
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:22:43 -0500
Received: from bart.luffy.cx ([78.47.78.131]:47967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vincent@bernat.im>) id 1eYfoV-0000Cw-Su
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:22:40 -0500
From: Vincent Bernat <vincent@bernat.im>
References: <20180108205052.24385-1-vincent@bernat.im>
	<20180108211623.GJ6646@localhost.localdomain>
	<m3d12k9fyj.fsf@luffy.cx>
	<20180108221422.GK6646@localhost.localdomain>
Date: Mon, 08 Jan 2018 23:22:36 +0100
In-Reply-To: <20180108221422.GK6646@localhost.localdomain> (Eduardo Habkost's
	message of "Mon, 8 Jan 2018 20:14:22 -0200")
Message-ID: <m38td89ej7.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: add pcid to both Sandy Bridge
 and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

 =E2=9D=A6  8 janvier 2018 20:14 -0200, Eduardo Habkost <ehabkost@redhat.co=
m>=C2=A0:

>> What are the consequences of running a too old kernel? Would KVM just
>> hide PCID flag?
>
> On an old kernel, the SandyBridge and IvyBridge CPU models will
> be unexpectedly become not runnable.

But, isn't it the same for more recent models that already have PCID
enabled?
--=20
Extreme fear can neither fight nor fly.
		-- William Shakespeare, "The Rape of Lucrece"
