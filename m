Received: from eggs.gnu.org ([2001:4830:134:3::10]:53376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEeC-0002hL-BW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEeB-0000xA-F7
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:20:44 -0400
References: <20180813022006.7216-1-mreitz@redhat.com>
	<20180813022006.7216-3-mreitz@redhat.com>
	<20180813125457.GA11625@kermit-br-ibm-com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fd3efd1e-520b-50ff-b1c5-ffcc08094f3a@redhat.com>
Date: Mon, 13 Aug 2018 17:20:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180813125457.GA11625@kermit-br-ibm-com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GBGVnQCMJ5bQMmqu2vaC22cTYC6LhmC00"
Subject: Re: [Qemu-devel] [PATCH 02/17] mirror: Make
 wait_for_any_operation() coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GBGVnQCMJ5bQMmqu2vaC22cTYC6LhmC00
From: Max Reitz <mreitz@redhat.com>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <fd3efd1e-520b-50ff-b1c5-ffcc08094f3a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/17] mirror: Make wait_for_any_operation()
 coroutine_fn
References: <20180813022006.7216-1-mreitz@redhat.com>
 <20180813022006.7216-3-mreitz@redhat.com>
 <20180813125457.GA11625@kermit-br-ibm-com>
In-Reply-To: <20180813125457.GA11625@kermit-br-ibm-com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-13 14:54, Murilo Opsfelder Araujo wrote:
> Hi, Max.

Hi, Murilo!

> On Mon, Aug 13, 2018 at 04:19:51AM +0200, Max Reitz wrote:
>> mirror_wait_for_any_operation() calls qemu_co_queue_wait(), which is a=

>> coroutine_fn (technically it is a macro which resolves to a
>> coroutine_fn).  Therefore, this function needs to be a coroutine_fn as=

>> well.
>>
>> This patch makes it and all of its callers coroutine_fns.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/mirror.c | 30 ++++++++++++++++--------------
>>  1 file changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 85f5742eae..c28b6159d5 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c

[...]

>> @@ -1098,11 +1100,11 @@ static void mirror_complete(Job *job, Error **=
errp)
>>      job_enter(job);
>>  }
>>
>> -static void mirror_pause(Job *job)
>> +static void coroutine_fn mirror_pause(Job *job)
>=20
> Other functions in this patch were renamed to mirror_co_*.  I'm not sur=
e if
> mirror_pause() should follow that, i.e. be renamed to mirror_co_pause()=
=2E

Hm.  I don't know why I didn't do that.  Makes sense, why not.

(Well, JobDriver.pause() is not called .co_pause(), but then again,
JobDriver.start is set to mirror_run(), so it's not like our function
names match so far...)

Max


--GBGVnQCMJ5bQMmqu2vaC22cTYC6LhmC00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxocEACgkQ9AfbAGHV
z0D99wf/a4vX2Dg1vg4YXl8NgPxnw0+A4oE/ulQl4bHXs8iIgbxluFRlt8Rv5sgm
reoQc9fy9WPNRwtDwIP8K3TZkxRt69lHqa1bKoowqczYQc3ou03G0O10F5vmOooW
/6wJZEpSveKOcFPivajYNfw/lB4zXGkB1CMVduDXosZVMa0ojOi1DPI0O52kHWaL
Et9j3TOPGc+sTC5MDF+VuNArnZVDI8+hBNf9WrzO19Q+2emwZRO9JynYejjtSO0d
qYfod8GQpJPpKQfceRiixPdQscWG+BUM28bIQpZVezboLpnWJfatYBJsrChoN0Fa
geucZgtvG+TaittQc0Mxk9dLdYtccg==
=2l13
-----END PGP SIGNATURE-----

--GBGVnQCMJ5bQMmqu2vaC22cTYC6LhmC00--
