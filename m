Received: from eggs.gnu.org ([2001:4830:134:3::10]:35561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fufbc-0007ZH-A8
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fufY1-0000el-Dx
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:04:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fufY1-0000ee-9K
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:04:49 -0400
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-6-armbru@redhat.com>
	<2f5517a3-bb02-c7e7-cebc-315fbf8bd89b@redhat.com>
	<87d0u3qf30.fsf@dusky.pond.sub.org>
	<4556c609-2b90-43be-7456-4239eb116a55@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b1add80-0ff2-50c0-0a64-c2d67dd4fad7@redhat.com>
Date: Tue, 28 Aug 2018 10:04:45 -0500
MIME-Version: 1.0
In-Reply-To: <4556c609-2b90-43be-7456-4239eb116a55@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] json: Eliminate lexer state IN_ERROR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/28/2018 10:01 AM, Eric Blake wrote:
> The question remains, then, if a fixed-size gap (by making JSON_MIN be=20
> exactly 100) is any smarter than a contiguous layout (by making JSON_MI=
N=20
> be IN_START_INTERP + 1).=C2=A0 I can't see any strong reason for prefer=
ring=20
> one form over the other, so keeping the gap doesn't hurt.

And having said that, this patch series also introduced a second gap for=20
LOOKAHEAD defined at 0x80, along with assertions that it doesn't collide=20
with either IN_* or JSON_*. It may be just as easy to make JSON_MIN=20
start at LOOKAHEAD+1 than to assert that all of JSON_* fits in the space=20
between 100 and 0x80 - 1.  Although in the long run, I seriously doubt=20
we'll be adding many new enum values to either the lexer or the parser.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
