Received: from eggs.gnu.org ([2001:4830:134:3::10]:50945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLS9-0003fX-AQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daLS3-0008Qy-Mx
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:30:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daLS3-0008OM-Hp
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:30:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 999E262657
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:30:06 +0000 (UTC)
References: <20170726114437.19624-1-pbonzini@redhat.com>
	<9e187829-fc01-8140-22f0-7cf67fc294bd@redhat.com>
	<20170726121913.GJ7620@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57875caf-4378-7257-7f83-12da82289579@redhat.com>
Date: Wed, 26 Jul 2017 14:30:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170726121913.GJ7620@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] add Thomas's bug reporting dos
 and don'ts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On 26/07/2017 14:19, Daniel P. Berrange wrote:
> On Wed, Jul 26, 2017 at 01:57:35PM +0200, Thomas Huth wrote:
>> On 26.07.2017 13:44, Paolo Bonzini wrote:
>>> We don't want the page to become too long, but these are good suggest=
ions.
>>>
>>> Also tone down the sentence about using the latest release or latest =
git
>>> tree, though we do prefer those.
>>
>> Well, sometimes people still report bugs against QEMU 2.1 or so ... so
>> I'd say everything that is older than the current version - 2 has a ve=
ry
>> high chance to be ignored completely. So maybe we should ask people to
>> use at least one of the versions that is mentioned on the front-page o=
f
>> www.qemu.org ?
>=20
> The biggest reason people would be using old versions of QEMU is if the=
y
> are running a distro's build. Such people should really file bugs in
> their vendor's bug tracker, rather than against upstream directly.
>=20
> IOW, it would be worth having a bit of text on the bug reporting page
> to suggest people should preferrentially use their vendor's bug tracker=
,
> if they are using a 3rd party build of QEMU.

There is already this sentence: "If you've got a problem with how your
Linux distribution packages QEMU, use the bug tracker from your distro
instead" but I'm not sure I'd generalize it to all bugs from a distro QEM=
U.

It's not like we get bugs about distro QEMUs (or bugs in general for
that matter) every day.  Most bug reports we get are from Ubuntu or
Fedora QEMUs, and they're good enough for reproduction.

Paolo
