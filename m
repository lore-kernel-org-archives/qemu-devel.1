Received: from eggs.gnu.org ([2001:4830:134:3::10]:38287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eo9e4-0001D7-L7
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eo9dz-0003Wd-VH
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:15:52 -0500
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-19-mreitz@redhat.com>
	<b9fa2031-a042-165a-47fd-e0d4b4a24738@redhat.com>
	<b937024c-5fbb-1250-a02c-f187f1522594@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d179b9b-363d-8b89-073f-72599db43f1f@redhat.com>
Date: Tue, 20 Feb 2018 09:15:30 -0600
MIME-Version: 1.0
In-Reply-To: <b937024c-5fbb-1250-a02c-f187f1522594@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 18/26] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

On 02/20/2018 08:51 AM, Max Reitz wrote:
> On 2018-02-06 20:43, Eric Blake wrote:
>> On 02/05/2018 09:18 AM, Max Reitz wrote:
>>> This new field can be set by block drivers to list the runtime option=
s
>>> they accept that may influence the contents of the respective BDS. As=
 of
>>> a follow-up patch, this list will be used by the common
>>> bdrv_refresh_filename() implementation to decide which options to put
>>> into BDS.full_open_options (and consequently whether a JSON filename =
has
>>> to be created), thus freeing the drivers of having to implement that
>>> logic themselves.
>>>
>>> Additionally, this patch adds the field to all of the block drivers t=
hat
>>> need it and sets it accordingly.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>
>>> +=C2=A0=C2=A0=C2=A0 /* Pointer to a NULL-terminated array of names of=
 significant
>>> options that
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * can be specified for bdrv_open(). A signi=
ficant option is one
>>> that
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * changes the data of a BDS.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If this pointer is NULL, the array is con=
sidered empty.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * "filename" and "driver" are always consid=
ered significant. */
>>> +=C2=A0=C2=A0=C2=A0 const char *const *sgfnt_runtime_opts;
>>
>> Warning: Bikeshedding follows:
>>
>> s/sgfnt/vital/
>>
>> might read easier (same number of letters, but has some vowels rthr th=
n
>> bng crptc bbrvtn).
>=20
> So, did we reach any verdict on this? :-)
>=20
> To sum up IRC (as far as I've understood), I don't quite like "vital" o=
r
> "needed" because they sound like those options would be required; but
> they usually have defaults so they are not.
>=20
> I preferred "strong", but you said that might mean something else
> (although I still don't know what exactly :-)).
>=20
> So...?

major?  apt?

(the thesaurus mentions other words like meaningful or influential, but=20
those don't buy you any length reduction or easier abbreviations)

I don't recall what (if anything) I said against strong, so I'm also=20
fine if that's what you choose.

At the end of the day, it's all bikeshedding - pick a term, and I'll=20
live with it ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
