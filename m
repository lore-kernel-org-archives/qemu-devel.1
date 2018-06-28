Received: from eggs.gnu.org ([2001:4830:134:3::10]:56888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYeKQ-00064Z-HL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fYeKP-00031F-Ok
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:19:46 -0400
References: <20180628180042.3881-1-jsnow@redhat.com>
	<20180628180042.3881-2-jsnow@redhat.com>
	<3a32f921-7800-a4f3-12ac-195212cbe828@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <05a181af-5038-826f-2873-dec4a04f22e9@redhat.com>
Date: Thu, 28 Jun 2018 17:19:37 -0400
MIME-Version: 1.0
In-Reply-To: <3a32f921-7800-a4f3-12ac-195212cbe828@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: allow blockdev-backup from
 any source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>



On 06/28/2018 02:05 PM, Eric Blake wrote:
> On 06/28/2018 01:00 PM, John Snow wrote:
>> In the case of image fleecing, the node we choose as the source
>> for a blockdev-backup is going to be both a root node AND the
>> backing node for the exported image. It does not qualify as a root
>> image in this case.
>>
>> Loosen the restriction.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 blockdev.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> In v1, you mentioned that this used to work but then regressed,
> pinpointing that detail in the commit message might be nice, but not
> essential (since we didn't test it until now).=C2=A0 So,
>=20

Really not sure when it regressed; I consider it unimportant as nothing
uses it presently: no docs, no tests, nothing in libvirt.

My guess, though, is that it worked prior to
cef34eebf3d0f252a3b3e9a2a459b6c3ecc56f68.

In 2.8, possibly?

Kashyap might know, I think he's experimented with this sometime in that
timezone.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
