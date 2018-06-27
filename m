Received: from eggs.gnu.org ([2001:4830:134:3::10]:34712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY5jb-0002N3-CK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fY5jY-0003B0-53
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:23:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fY5jX-0003Ao-W9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:23:24 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180621150254.4922-1-stefanha@redhat.com> (Stefan Hajnoczi's
	message of "Thu, 21 Jun 2018 16:02:54 +0100")
References: <20180621150254.4922-1-stefanha@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Jun 2018 10:26:48 +0200
Message-ID: <878t70my7r.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] trace: forbid floating point types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Only one existing trace event uses a floating point type.  Unfortunately
> float and double cannot be supported since SystemTap does not have
> floating point types.
>
> Remove float and double from the whitelist and document this limitation.
> Update the migrate_transferred trace event to use uint64_t instead of
> double.
>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

We don't really care so much about this value, and or how it is printed.
