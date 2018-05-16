Received: from eggs.gnu.org ([2001:4830:134:3::10]:54963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIuaS-0006Cb-Ky
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIuaR-0003Yx-Au
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:27:16 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-41-kwolf@redhat.com>
	<13ad0be2-6966-db50-3a84-31f4e890a6a1@redhat.com>
	<20180516112129.GA4435@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <56aadee2-1269-936c-afcd-4ea6e58e66c7@redhat.com>
Date: Wed, 16 May 2018 13:27:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180516112129.GA4435@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lo8fHYI7mQs0tf2m2Htz9JiaOXAluEX5S"
Subject: Re: [Qemu-devel] [PATCH 40/42] job: Add query-jobs QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lo8fHYI7mQs0tf2m2Htz9JiaOXAluEX5S
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com,
 armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org
Message-ID: <56aadee2-1269-936c-afcd-4ea6e58e66c7@redhat.com>
Subject: Re: [PATCH 40/42] job: Add query-jobs QMP command
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-41-kwolf@redhat.com>
 <13ad0be2-6966-db50-3a84-31f4e890a6a1@redhat.com>
 <20180516112129.GA4435@localhost.localdomain>
In-Reply-To: <20180516112129.GA4435@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-05-16 13:21, Kevin Wolf wrote:
> Am 15.05.2018 um 01:09 hat Max Reitz geschrieben:
>> On 2018-05-09 18:26, Kevin Wolf wrote:
>>> This adds a minimal query-jobs implementation that shouldn't pose man=
y
>>> design questions. It can later be extended to expose more information=
,
>>> and especially job-specific information.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
>>> +##
>>> +# @JobInfo:
>>> +#
>>> +# Information about a job.
>>> +#
>>> +# @id:                  The job identifier
>>> +#
>>> +# @type:                The job type
>>
>> I'm not really happy with this description that effectively provides n=
o
>> information that one cannot already get from the field name, but I
>> cannot come up with something better, so I'd rather stop typing now.
>>
>> (OK, my issue here is that "job type" can be anything.  That could mea=
n
>> e.g. "Is this a block job?".   Maybe an explicit reference to JobType
>> might help here, although that is already part of the documentation.  =
On
>> that note, maybe a quote from the documentation might help make my poi=
nt
>> that this description is not very useful:
>>
>>        "type: JobType"
>>            The job type
>>
>> Maybe "The kind of job that is being performed"?)
>=20
> IMHO, that's just a more verbose way of saying nothing new.

True, but =93Job.type: JobType -- The job type=94 is exactly the kind of
documentation people like to make fun of.

>                                                             The
> "problem" is that "type: JobType" is already descriptive enough, there
> is no real need for providing any additional information.

Yes, but it still doesn=92t read nicely.

One could give examples (=93e.g. mirror or backup=94), but then again, if=
 we
were to remove any of those, we=92d have to update the documentation here=
=2E
 Also, you can again argue that such a list is precisely under JobType,
which is true.

> Also, I'd like to mention that almost all of the documentation is taken=

> from BlockJobInfo, so if we decide to change something, we should
> probably change it in both places.

Ha!  Good excuse, but you know, you touched this, now you own it. :-)

>>> +# @status:              Current job state/status
>>
>> Why the "state/status"?  Forgive me my incompetence, but I don't see a=

>> real difference here.  But in any case, one ought to be enough, no?
>>
>> (OK, full disclosure: My gut tells me "status" is what we now call the=

>> "progress", and this field should be called "state".  But it's called
>> "status" now and it doesn't really make a difference, so it's fine to
>> describe it as either.)
>=20
> I'll defer to John who wrote this description originally. I think we're=

> just using status/state inconsistently for the same thing (JobStatus,
> which represents the states of the job state machine).
>=20
>>> +#
>>> +# @current-progress:    The current progress value
>>> +#
>>> +# @total-progress:      The maximum progress value
>>
>> Hm, not really.  This makes it sound like at any point, this will be t=
he
>> maximum even in the future, but that's not true.
>>
>> Maybe "estimated progress maximum"?  Or be even more verbose (no, that=

>> doesn't hurt): "This is an estimation of the value @current-progress
>> needs to reach for the job to complete."
>>
>> (Actually, I find it important to note that it is an estimation, maybe=

>> we event want to be really explicit about the fact that this value may=

>> change all the time, in any direction.)
>=20
> I'll try to improve the documentation of these fields (both here and in=

> BlockJobInfo) for v2.

Thanks!

Max


--Lo8fHYI7mQs0tf2m2Htz9JiaOXAluEX5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr8FYsACgkQ9AfbAGHV
z0CFHwf/aR+i/vOpJM7jArI7u6AKfpHODEqOxHdz36kH0QUtJKa2WiwKmXSV138b
2JbzBNFSyxBQf55uGTVKrHwGV/TJMhGX8huYU9yyaPnRVdrRF3qlAwqUeRhOOCIk
17HlVpCdCYaR2heTqCCTF4sN146guzG1gpkZ+DTTTb+VwX5ywsBKTwt0G25Vb9D0
gY0Bw4QQHuEBsXLGzVOS+GAjSC+kOhXSscfAwe09mbKxYdSERgzhE3rvGH86kgCA
4TE8OmQOlu5MTmc7msI46c1boiUD8tHKB4OBZYhAvBcoPVC+a0ygsPoaheWTmrbX
u9UqqJ2lD5682e+2rFcgbmbnPY9xAg==
=c/eO
-----END PGP SIGNATURE-----

--Lo8fHYI7mQs0tf2m2Htz9JiaOXAluEX5S--
