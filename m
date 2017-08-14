Received: from eggs.gnu.org ([2001:4830:134:3::10]:35283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dh9It-0004Tb-10
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dh9Ip-0002oC-Us
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:56:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dh9Ip-0002o2-O6
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:56:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <150107094952.114.932926322923994155@5d477a5b5989>
	<e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
	<87fud24drm.fsf@dusky.pond.sub.org>
	<b289a6e6-9773-c490-6c12-d43a6920d1c3@redhat.com>
Date: Mon, 14 Aug 2017 08:56:36 +0200
In-Reply-To: <b289a6e6-9773-c490-6c12-d43a6920d1c3@redhat.com> (Eric Blake's
	message of "Tue, 8 Aug 2017 10:04:48 -0500")
Message-ID: <871soeljrv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: no-reply@patchew.org, famz@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <mlureau@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2017 04:20 AM, Markus Armbruster wrote:
>> Just back from the signed-vs-unsigned swamp, still catching up, sorry
>> for the delay...
>>=20
>
>>>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py"=
, line 160, in texi_members
>>>>     items +=3D member_func(section.member) + desc + '\n'
>>>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py"=
, line 133, in texi_enum_value
>>>>     return '@item @code{%s}\n' % value.name
>>>> AttributeError: 'NoneType' object has no attribute 'name'
>>>
>>> Eww, we have a bug in our qapi generator (a stack dump instead of a nice
>>> error message).  I suspect this is caused by your use of '@ac_*' instead
>>> of spelling out all the ac_ members added in qapi-schema.json in 4/5 -
>>=20
>> Yes, we require doc comments to match the schema.  Wildcards aren't
>> supported.  They could be, if we want them badly enough.
>>=20
>>> but it IS something that needs to be fixed on your end to quit tripping
>>> up the doc generator.
>>=20
>> Has anyone worked on a fix for qapi2texi.py?
>
> We worked around the generator bug in the meantime, so the qapi2texi.py
> bug is still latent (sadly, it's not my highest priority)

Marc-Andr=C3=A9, can you have a look perhaps?
