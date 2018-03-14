Received: from eggs.gnu.org ([2001:4830:134:3::10]:45548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewCx0-0000oL-8b
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 16:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewCwz-0004gW-I7
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 16:24:42 -0400
References: <20180313161803.1814-1-kwolf@redhat.com>
	<20180313161803.1814-19-kwolf@redhat.com>
	<502f868d-4b92-96fb-63e1-1e1f6c89d996@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <baab16d1-685a-9a1e-cc3c-b03c99e995b2@redhat.com>
Date: Wed, 14 Mar 2018 16:24:34 -0400
MIME-Version: 1.0
In-Reply-To: <502f868d-4b92-96fb-63e1-1e1f6c89d996@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 18/41] blockjobs: add block-job-finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org



On 03/13/2018 02:47 PM, Eric Blake wrote:
> On 03/13/2018 11:17 AM, Kevin Wolf wrote:
>> From: John Snow <jsnow@redhat.com>
>>
>> Instead of automatically transitioning from PENDING to CONCLUDED, gate
>> the .prepare() and .commit() phases behind an explicit acknowledgement
>> provided by the QMP monitor if auto_finalize =3D false has been reques=
ted.
>>
>=20
>> =C2=A0 ##
>> +# @block-job-finalize:
>> +#
>> +# Once a job that has manual=3Dtrue reaches the pending state, it can=
 be
>=20
> Is this wording stale, given that you add two separate auto-* bool flag=
s
> in 19/41?=C2=A0 You may want to prepare a followup patch (doc bug fixes=
 are
> safe during softfreeze, so it need not hold up this pull request) that
> tweaks this and any similar stale wording.
>=20

Fixed up in my local branch, will send out once the dust settles on maste=
r.

Thanks!

--js
