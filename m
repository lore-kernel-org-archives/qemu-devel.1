Received: from eggs.gnu.org ([2001:4830:134:3::10]:50330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQjV-0001o4-MJ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDQjU-0004aW-3n
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:06:13 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-5-mreitz@redhat.com>
	<b5f45c50-eb78-837e-e1be-114fe758aae6@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0b4c1473-93a6-9841-dd59-6c857b312613@redhat.com>
Date: Fri, 19 Oct 2018 11:06:00 +0200
MIME-Version: 1.0
In-Reply-To: <b5f45c50-eb78-837e-e1be-114fe758aae6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5m7bZlJOyAacNR8scQ1vr7SNnHtxftk9M"
Subject: Re: [Qemu-devel] [PATCH 4/9] iotests: Use // for Python integer
 division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5m7bZlJOyAacNR8scQ1vr7SNnHtxftk9M
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <0b4c1473-93a6-9841-dd59-6c857b312613@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] iotests: Use // for Python integer
 division
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-5-mreitz@redhat.com>
 <b5f45c50-eb78-837e-e1be-114fe758aae6@redhat.com>
In-Reply-To: <b5f45c50-eb78-837e-e1be-114fe758aae6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.10.18 23:13, Cleber Rosa wrote:
>=20
>=20
> On 10/15/18 10:14 AM, Max Reitz wrote:
>> In Python 3, / is always a floating-point division.  We usually do not=

>> want this, and as Python 2.7 understands // as well, change all intege=
r
>> divisions to use that.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/040        |  4 ++--
>>  tests/qemu-iotests/044        |  2 +-
>>  tests/qemu-iotests/093        | 18 +++++++++---------
>>  tests/qemu-iotests/149        |  6 +++---
>>  tests/qemu-iotests/151        | 12 ++++++------
>>  tests/qemu-iotests/163        |  2 +-
>>  tests/qemu-iotests/iotests.py |  2 +-
>>  7 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
>> index 1cb1ceeb33..b81133a474 100755
>> --- a/tests/qemu-iotests/040
>> +++ b/tests/qemu-iotests/040
>> @@ -195,7 +195,7 @@ class TestSingleDrive(ImageCommitTestCase):
>> =20
>>          self.assert_no_active_block_jobs()
>>          result =3D self.vm.qmp('block-commit', device=3D'drive0', top=
=3Dmid_img,
>> -                             base=3Dbacking_img, speed=3D(self.image_=
len / 4))
>> +                             base=3Dbacking_img, speed=3D(self.image_=
len // 4))
>>          self.assert_qmp(result, 'return', {})
>>          result =3D self.vm.qmp('device_del', id=3D'scsi0')
>>          self.assert_qmp(result, 'return', {})
>> @@ -225,7 +225,7 @@ class TestSingleDrive(ImageCommitTestCase):
>> =20
>>          self.assert_no_active_block_jobs()
>>          result =3D self.vm.qmp('block-commit', device=3D'drive0', top=
=3Dmid_img,
>> -                             base=3Dbacking_img, speed=3D(self.image_=
len / 4))
>> +                             base=3Dbacking_img, speed=3D(self.image_=
len // 4))
>>          self.assert_qmp(result, 'return', {})
>> =20
>>          result =3D self.vm.qmp('query-block')
>> diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
>> index 69e736f687..7ef5e46fe9 100755
>> --- a/tests/qemu-iotests/044
>> +++ b/tests/qemu-iotests/044
>> @@ -86,7 +86,7 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
>>                  off =3D off + 1024 * 512
>> =20
>>              table =3D b''.join(struct.pack('>Q', (1 << 63) | off + 51=
2 * j)
>> -                for j in xrange(0, remaining / 512))
>> +                for j in xrange(0, remaining // 512))
>>              fd.write(table)
>> =20
>> =20
>> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
>> index 9d1971a56c..d88fbc182e 100755
>> --- a/tests/qemu-iotests/093
>> +++ b/tests/qemu-iotests/093
>> @@ -69,18 +69,18 @@ class ThrottleTestCase(iotests.QMPTestCase):
>>          # in. The throttled requests won't be executed until we
>>          # advance the virtual clock.
>>          rq_size =3D 512
>> -        rd_nr =3D max(params['bps'] / rq_size / 2,
>> -                    params['bps_rd'] / rq_size,
>> -                    params['iops'] / 2,
>> +        rd_nr =3D max(params['bps'] // rq_size // 2,
>> +                    params['bps_rd'] // rq_size,
>> +                    params['iops'] // 2,
>>                      params['iops_rd'])
>>          rd_nr *=3D seconds * 2
>> -        rd_nr /=3D ndrives
>> -        wr_nr =3D max(params['bps'] / rq_size / 2,
>> -                    params['bps_wr'] / rq_size,
>> -                    params['iops'] / 2,
>> +        rd_nr //=3D ndrives
>> +        wr_nr =3D max(params['bps'] // rq_size // 2,
>> +                    params['bps_wr'] // rq_size,
>> +                    params['iops'] // 2,
>>                      params['iops_wr'])
>>          wr_nr *=3D seconds * 2
>> -        wr_nr /=3D ndrives
>> +        wr_nr //=3D ndrives
>> =20
>>          # Send I/O requests to all drives
>>          for i in range(rd_nr):
>> @@ -196,7 +196,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
>>              self.configure_throttle(ndrives, settings)
>> =20
>>              # Wait for the bucket to empty so we can do bursts
>> -            wait_ns =3D nsec_per_sec * burst_length * burst_rate / ra=
te
>> +            wait_ns =3D nsec_per_sec * burst_length * burst_rate // r=
ate
>>              self.vm.qtest("clock_step %d" % wait_ns)
>> =20
>>              # Test I/O at the max burst rate
>> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
>> index 1225334cb8..4f363f295f 100755
>> --- a/tests/qemu-iotests/149
>> +++ b/tests/qemu-iotests/149
>> @@ -314,13 +314,13 @@ def test_once(config, qemu_img=3DFalse):
>>      image_size =3D 4 * oneTB
>>      if qemu_img:
>>          iotests.log("# Create image")
>> -        qemu_img_create(config, image_size / oneMB)
>> +        qemu_img_create(config, image_size // oneMB)
>>      else:
>>          iotests.log("# Create image")
>> -        create_image(config, image_size / oneMB)
>> +        create_image(config, image_size // oneMB)
>> =20
>>      lowOffsetMB =3D 100
>> -    highOffsetMB =3D 3 * oneTB / oneMB
>> +    highOffsetMB =3D 3 * oneTB // oneMB
>> =20
>>      try:
>>          if not qemu_img:
>> diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
>> index fe53b9f446..1bb74d67c4 100755
>> --- a/tests/qemu-iotests/151
>> +++ b/tests/qemu-iotests/151
>> @@ -67,9 +67,9 @@ class TestActiveMirror(iotests.QMPTestCase):
>>                              'write -P 1 0 %i' % self.image_len);
>> =20
>>          # Start some background requests
>> -        for offset in range(1 * self.image_len / 8, 3 * self.image_le=
n / 8, 1024 * 1024):
>> +        for offset in range(1 * self.image_len // 8, 3 * self.image_l=
en // 8, 1024 * 1024):
>>              self.vm.hmp_qemu_io('source', 'aio_write -P 2 %i 1M' % of=
fset)
>> -        for offset in range(2 * self.image_len / 8, 3 * self.image_le=
n / 8, 1024 * 1024):
>> +        for offset in range(2 * self.image_len // 8, 3 * self.image_l=
en // 8, 1024 * 1024):
>>              self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offs=
et)
>> =20
>>          # Start the block job
>> @@ -83,9 +83,9 @@ class TestActiveMirror(iotests.QMPTestCase):
>>          self.assert_qmp(result, 'return', {})
>> =20
>>          # Start some more requests
>> -        for offset in range(3 * self.image_len / 8, 5 * self.image_le=
n / 8, 1024 * 1024):
>> +        for offset in range(3 * self.image_len // 8, 5 * self.image_l=
en // 8, 1024 * 1024):
>>              self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % of=
fset)
>> -        for offset in range(4 * self.image_len / 8, 5 * self.image_le=
n / 8, 1024 * 1024):
>> +        for offset in range(4 * self.image_len // 8, 5 * self.image_l=
en // 8, 1024 * 1024):
>>              self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offs=
et)
>> =20
>>          # Wait for the READY event
>> @@ -95,9 +95,9 @@ class TestActiveMirror(iotests.QMPTestCase):
>>          # the source) should be settled using the active mechanism.
>>          # The mirror code itself asserts that the source BDS's dirty
>>          # bitmap will stay clean between READY and COMPLETED.
>> -        for offset in range(5 * self.image_len / 8, 7 * self.image_le=
n / 8, 1024 * 1024):
>> +        for offset in range(5 * self.image_len // 8, 7 * self.image_l=
en // 8, 1024 * 1024):
>>              self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % of=
fset)
>> -        for offset in range(6 * self.image_len / 8, 7 * self.image_le=
n / 8, 1024 * 1024):
>> +        for offset in range(6 * self.image_len // 8, 7 * self.image_l=
en // 8, 1024 * 1024):
>>              self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offs=
et)
>> =20
>>          if sync_source_and_target:
>> diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
>> index 403842354e..5fd424761b 100755
>> --- a/tests/qemu-iotests/163
>> +++ b/tests/qemu-iotests/163
>> @@ -38,7 +38,7 @@ class ShrinkBaseClass(iotests.QMPTestCase):
>>          entry_bits =3D 3
>>          entry_size =3D 1 << entry_bits
>>          l1_mask =3D 0x00fffffffffffe00
>> -        div_roundup =3D lambda n, d: (n + d - 1) / d
>> +        div_roundup =3D lambda n, d: (n + d - 1) // d
>> =20
>>          def split_by_n(data, n):
>>              for x in xrange(0, len(data), n):
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index 7290c0b159..7ca94e9278 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -199,7 +199,7 @@ def create_image(name, size):
>>      file =3D open(name, 'wb')
>>      i =3D 0
>>      while i < size:
>> -        sector =3D struct.pack('>l504xl', i / 512, i / 512)
>> +        sector =3D struct.pack('>l504xl', i // 512, i // 512)
>>          file.write(sector)
>>          i =3D i + 512
>>      file.close()
>>
>=20
> Found a few other occurrences:
>=20
> 030:''' % (event, errno, self.STREAM_BUFFER_SIZE / 512, event, event))
> 041:''' % (event, errno, self.MIRROR_GRANULARITY / 512, event, event))
> 041:''' % (event, errno, self.MIRROR_GRANULARITY / 512, event, event))

Oh, thanks.  Right, those just worked because they were converted back
to integers thanks to the %d in the format string.

Will fix.  Thanks for reviewing!

Max


--5m7bZlJOyAacNR8scQ1vr7SNnHtxftk9M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJnngACgkQ9AfbAGHV
z0CvJQgAuLg5utXQxof1v+tVwlMcRi/UHSykRtCC9kwhB0ipBszh2PtbJgKJG6/z
qdzOlsRzbAtFD97gVEB/w27yYph/QiA+oKY6VEjgfPYX35QThPublbwZTwUnuO78
28zUP1lU0QWt4OKmE4dRHrnke2U6wTri510FXWPQXx/5MQHXMkWSKwq/XGr8g9q6
8nkzoiQlGmOZOtwBVP6zPNLFX7rRFJpieT4gH52tsSUcejp97sgqf4O9wlIurW7C
/tJb2FW4co490ky7Q+5J5yxwXEayrDDoEDAKEiMXfe5fpber0Q8ve3UJ1XkPzZQN
cxxqWtCuFaQz5qNstSve+4k8H8DzcQ==
=NG60
-----END PGP SIGNATURE-----

--5m7bZlJOyAacNR8scQ1vr7SNnHtxftk9M--
