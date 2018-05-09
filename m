Received: from eggs.gnu.org ([2001:4830:134:3::10]:47110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGHvw-0001y9-A1
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGHvs-0006eA-3j
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:46:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fGHvr-0006ad-Ve
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:46:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 097E0818F6EC
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 05:46:26 +0000 (UTC)
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
	<1525817687-34620-15-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b728aae7-9f5d-8700-259f-8e2d65af1de8@redhat.com>
Date: Wed, 9 May 2018 07:46:19 +0200
MIME-Version: 1.0
In-Reply-To: <1525817687-34620-15-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 14/30] opts: don't silently truncate long
 parameter keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 09.05.2018 00:14, Paolo Bonzini wrote:
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Here the accent is right ^

> The existing QemuOpts parsing code uses a fixed size 128 byte buffer
> for storing the parameter keys. If a key exceeded this size it was
> silently truncate and no error reported to the user. This behaviour was
> reasonable & harmless because traditionally the key names are all
> statically declared, and it was known that no code was declaring a key
> longer than 127 bytes. This assumption, however, ceased to be valid onc=
e
> the block layer added support for dot-separate compound keys. This
> syntax allows for keys that can be arbitrarily long, limited only by th=
e
> number of block drivers you can stack up. With this usage, silently
> truncating the key name can never lead to correct behaviour.
>=20
> Hopefully such truncation would turn into an error, when the block code
> then tried to extract options later, but there's no guarantee that will
> happen. It is conceivable that an option specified by the user may be
> truncated and then ignored. This could have serious consequences,
> possibly even leading to security problems if the ignored option set a
> security relevant parameter.
>=20
> If the operating system didn't limit the user's argv when spawning QEMU=
,
> the code should honour whatever length arguments were given without
> imposing its own length restrictions. This patch thus changes the code
> to use a heap allocated buffer for storing the keys during parsing,
> lifting the arbitrary length restriction.
>=20
> Signed-off-by: Daniel P. Berrang=C3=83=C2=A9 <berrange@redhat.com>

But this one got mojibaked -------^

 Thomas
