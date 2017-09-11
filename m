Received: from eggs.gnu.org ([2001:4830:134:3::10]:33154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLyt-0007SY-9X
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLyq-0002YE-6p
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:30:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drLyq-0002Xr-1x
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:30:16 -0400
References: <20170818222313.13391-1-eblake@redhat.com>
	<1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
	<ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
	<87d17lqu85.fsf@dusky.pond.sub.org>
	<f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
	<f14f7069-6557-8633-d7c4-3caee567f905@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf940d49-7ab5-d8ba-d8c7-3bc097e0b673@redhat.com>
Date: Mon, 11 Sep 2017 12:30:09 +0200
MIME-Version: 1.0
In-Reply-To: <f14f7069-6557-8633-d7c4-3caee567f905@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org

On 06/09/2017 07:26, Thomas Huth wrote:
> You asked for opinions, so here's mine: I agree with you, please do
> *not* add a new QEMU-specific construct here. assert() should be a
> well-known C construct that every programmer should have understood. Yo=
u
> also need it for other projects. If you haven't understood that it's a
> macro and has side-effects, you should learn it (e.g. during patch
> review), not avoid it, otherwise you'll run into problems in another
> project that is using it again.
>=20
> But IMHO we should still try to get rid of wrong usage of assert() in
> the QEMU sources. So maybe we could allow building with NDEBUG one day
> for the brave people who need the extra percent of additional speed.

It's not only about the side effects.  There are a couple cases in
migration (IIRC) where our error propagation is not up to the task, and
failing assertions are used to validate untrusted input.  NDEBUG in that
case can introduce a known vulnerability.

> But as long as we're not there, I think this patch is a good thing to
> avoid wrong expectations.

Agreed.

Paolo
