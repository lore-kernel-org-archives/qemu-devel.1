Received: from eggs.gnu.org ([2001:4830:134:3::10]:38649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f180C-00011F-OG
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f180B-0004a6-Bv
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 06:08:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-4-vsementsov@virtuozzo.com>
	<e21af76d-977d-cadf-0a27-14a2d2aa228a@redhat.com>
	<17359493-4ac4-59d7-0407-03c2d38cb54f@virtuozzo.com>
Message-ID: <099cd2fb-1de3-17fa-f993-ab50580a55dd@virtuozzo.com>
Date: Wed, 28 Mar 2018 13:08:06 +0300
MIME-Version: 1.0
In-Reply-To: <17359493-4ac4-59d7-0407-03c2d38cb54f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/4] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, nbd list <nbd@other.debian.org>, den@openvz.org, pbonzini@redhat.com, mreitz@redhat.com

22.03.2018 18:26, Vladimir Sementsov-Ogievskiy wrote:
> 21.03.2018 19:57, Eric Blake wrote:
>> On 03/21/2018 07:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Rather sparse on the details in the commit message; I had to read the=20
>> patch to even learn what the new namespace is.
>
> oh, yes, sorry :(
>
>>> @@ -92,6 +101,7 @@ typedef struct NBDExportMetaContexts {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool valid; /* means that negotiation of=
 the option finished=20
>>> without
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errors */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool base_allocation; /* export base:all=
ocation context (block=20
>>> status) */
>>> +=C2=A0=C2=A0=C2=A0 bool dirty_bitmap; /* export=20
>>> qemu-dirty-bitmap:<export_bitmap_name> */
>>
>> That's a LONG namespace name, and it does not lend itself well to=20
>> other qemu extensions; so future qemu BLOCK_STATUS additions would=20
>> require consuming yet another namespace and additional upstream NBD=20
>> registration.=C2=A0 Wouldn't it be better to have the namespace be 'qemu=
:'=20
>> (which we register with upstream NBD just once), where we are then=20
>> free to document leafnames to look like 'dirty-bitmap:name' or=20
>> 'foo:bar'?
>
> No doubts. (and this shows, that we may want namespaces in namespaces,=20
> so we'll parse ':' anyway).
>
> Only one note here (I'm ashamed): 'qemu-dirty-bitmap' namespace is=20
> used in Virtuozzo for the feature, yes, without 'x-' prefix. It's my=20
> fault, and it should not influence final solution. The probability of=20
> problems is near to zero (especially if we decide now to use 'qemu:'=20
> namespace for all qemu-specific things. But I'm not sure about, should=20
> we mention this fact in the spec.
> [cc NBD list]
>

Looks like at this point, we can safely move to qemu:dirty-bitmap:name,=20
or any other thing, and we don't need to support my first variant.

--=20
Best regards,
Vladimir
