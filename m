Received: from eggs.gnu.org ([2001:4830:134:3::10]:50206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d86RB-00080w-63
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d86RA-0000MV-8I
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:48:29 -0400
References: <CAKVPjOZ8Y8U2zHgo_06aozrdd9_Cq6txWrX5F4HnFefAUjimyQ@mail.gmail.com>
	<971bcdf7-046f-4fea-223c-ebd75505b94b@redhat.com>
	<CAKVPjObJA2Vhz58AQG74E3AuH7Eus1wc_phrS2VqNbWX65COMA@mail.gmail.com>
	<c86e58d0-920a-0a09-fe3e-a522759af1c7@redhat.com>
	<CAKVPjOa9WJrTEbX8mG=pyrjngT1dvx_Bw5L0s0ME1CGik1879Q@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <88605941-13cf-6812-20bc-607de2b7303f@redhat.com>
Date: Tue, 9 May 2017 10:48:21 -0400
MIME-Version: 1.0
In-Reply-To: <CAKVPjOa9WJrTEbX8mG=pyrjngT1dvx_Bw5L0s0ME1CGik1879Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] migration: add incremental drive-mirror and
 blockdev-mirror with dirtymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_Ku=c4=8dera?= <daniel.kucera@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:Block Jobs" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>



On 05/09/2017 03:35 AM, Daniel Ku=C4=8Dera wrote:
>=20
>=20
>     Hm, I suppose that's right, pending cache issues, perhaps?
>=20
>     (1) Write occurs; cached
>     (2) Bitmap is added
>     (3) Write occurs, cached
>     (4) ZFS snapshot is taken
>     (5) Data is flushed to backing storage.
>=20
>     Now, the ZFS snapshot is migrated, but is missing the writes that
>     occurred in (1) and (3).
>=20
>     Next, we mirror the data in the bitmap, but it only includes the da=
ta
>     from (3).
>=20
>     The target now appears to be missing the write from (1) -- maybe,
>     depending on how the volume snapshot occurs.
>=20
>=20
> Yes, that's why I'm using cache=3Dnone. Libvirt doesn't allow you to
> migrate VM which uses drive cache anyway (unless you specify flag unsaf=
e).

It will be important to document the exact use cases in which this mode
is "supported" and the shortcomings and cases in which it is not supporte=
d.

The final version should include a test and some documentation, but I
think the feature is workable once we pay attention to error conditions.

Thanks!

--js
