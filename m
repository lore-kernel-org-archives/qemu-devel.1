Received: from eggs.gnu.org ([2001:4830:134:3::10]:39468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1enoAv-0004ea-JA
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1enoAs-0003Dw-0P
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1enoAr-0003Ca-Jl
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:20:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49E3E40A0971
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 16:20:17 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
	<1519031728-9850-8-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c298a4a-97cd-4b7a-d170-b70ab2970aac@redhat.com>
Date: Mon, 19 Feb 2018 17:20:14 +0100
MIME-Version: 1.0
In-Reply-To: <1519031728-9850-8-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 7/8] net: Add a new convenience option
 "-n" to configure default/on-board NICs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 19/02/2018 10:15, Thomas Huth wrote:
> The legacy "-net" option can be quite confusing for the users since mos=
t
> people do not expect to get a "vlan" hub between their emulated guest
> hardware and the host backend. But so far, we are also not able to get
> rid of "-net" completely, since it is the only way to configure on-boar=
d
> NICs that can not be instantiated via "-device" yet. It's also a little
> bit shorter to type "-net nic -net tap" instead of "-device xyz,netdev=3D=
n1
> -netdev tap,id=3Dn1".
>=20
> So what we need is a new convenience option that is shorter to type tha=
n
> the full -device + -netdev stuff, and which can be used to configure th=
e
> on-board NICs that can not be handled via -device yet. Thus this patch =
now
> provides such a new option "-n": It adds an entry in the nd_table to
> configure a on-board / default NIC, creates a host backend and connects
> the two directly, without a confusing "vlan" hub inbetween.

Sorry for the bikeshedding, but... perhaps "-n" is a bit bold.  While I
initially couldn't come up with a better one, after putting some thought
into it "-nic" came to mind.  There's precedent in naming the option for
the *front-end* device that it creates, whereas the arguments define
either the front-end (e.g. "model") or the back-end; see for example
"-drive".  "-nic tap,model=3De1000" and "-nic none" both make nice sense.

Thanks,

Paolo
