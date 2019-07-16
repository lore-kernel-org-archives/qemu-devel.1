Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F9AC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CA0205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CA0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQnI-0003OU-1B
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32907)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hnQn6-0002vP-ML
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hnQn5-0004mx-Hl
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:59:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hnQn2-0004jC-RZ; Tue, 16 Jul 2019 12:58:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29EDF13A41;
 Tue, 16 Jul 2019 16:58:56 +0000 (UTC)
Received: from [10.18.17.130] (dhcp-17-130.bos.redhat.com [10.18.17.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 430CA60C44;
 Tue, 16 Jul 2019 16:58:55 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190716000117.25219-1-jsnow@redhat.com>
 <20190716000117.25219-12-jsnow@redhat.com>
 <9cf9c85d-c41e-123c-07cb-81c453363aea@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFTKefwBEAChvwqYC6saTzawbih87LqBYq0d5A8jXYXaiFMV/EvMSDqqY4EY6whXliNO
 IYzhgrPEe7ZmPxbCSe4iMykjhwMh5byIHDoPGDU+FsQty2KXuoxto+ZdrP9gymAgmyqdk3aV
 vzzmCa3cOppcqKvA0Kqr10UeX/z4OMVV390V+DVWUvzXpda45/Sxup57pk+hyY52wxxjIqef
 rj8u5BN93s5uCVTus0oiVA6W+iXYzTvVDStMFVqnTxSxlpZoH5RGKvmoWV3uutByQyBPHW2U
 1Y6n6iEZ9MlP3hcDqlo0S8jeP03HaD4gOqCuqLceWF5+2WyHzNfylpNMFVi+Hp0H/nSDtCvQ
 ua7j+6Pt7q5rvqgHvRipkDDVsjqwasuNc3wyoHexrBeLU/iJBuDld5iLy+dHXoYMB3HmjMxj
 3K5/8XhGrDx6BDFeO3HIpi3u2z1jniB7RtyVEtdupED6lqsDj0oSz9NxaOFZrS3Jf6z/kHIf
 h42mM9Sx7+s4c07N2LieUxcfqhFTaa/voRibF4cmkBVUhOD1AKXNfhEsTvmcz9NbUchCkcvA
 T9119CrsxfVsE7bXiGvdXnzyGLXdsoosjzwacKdOrVaDmN3Uy+SHiQXo6TlkSdV0XH2PUxTM
 LsBFIO9qXO43Ai6J6iPAP/01l8fuZfpJE0/L/c25yyaND7xA3wARAQABtCpKb2huIFNub3cg
 KEpvaG4gSHVzdG9uKSA8anNub3dAcmVkaGF0LmNvbT6JAlQEEwECAD4CGwMCHgECF4AFCwkI
 BwMFFQoJCAsFFgIDAQAWIQT665cRoSz0dYEvGPKIqQZNGDVh6wUCXF392gUJC1Xq3gAKCRCI
 qQZNGDVh6558D/9pM4pu4njX5aT6uUW3vAmbWLF1jfPxiTQgSHAnm9EBMZED/fsvkzj97clo
 LN7JKmbYZNgJmR01A7flG45V4iOR/249qAfaVuD+ZzZi1R4jFzr13WS+IEdn0hYp9ITndb7R
 ezW+HGu6/rP2PnfmDnNowgJu6Dp6IUEabq8SXXwGHXZPuMIrsXJxUdKJdGnh1o2u7271yNO7
 J9PEMuMDsgjsdnaGtv7aQ9CECtXvBleAc06pLW2HU10r5wQyBMZGITemJdBhhdzGmbHAL0M6
 vKi/bafHRWqfMqOAdDkv3Jg4arl2NCG/uNateR1z5e529+UlB4XVAQT+f5T/YyI65DFTY940
 il3aZhA8u788jZEPMXmt94u7uPZbEYp7V0jt68SrTaOgO7NaXsboXFjwEa42Ug5lB5d5/Qdp
 1AITUv0NJ51kKwhHL1dEagGeloIsGVQILmpS0MLdtitBHqZLsnJkRvtMaxo47giyBlv2ewmq
 tIGTlVLxHx9xkc9aVepOuiGlZaZB72c9AvZs9rKaAjgU2UfJHlB/Hr4uSk/1EY0IgMv4vnsG
 1sA5gvS7A4T4euu0PqHtn2sZEWDrk5RDbw0yIb53JYdXboLFmFXKzVASfKh2ZVeXRBlQQSJi
 3PBR1GzzqORlfryby7mkY857xzCI2NkIkD2eq+HhzFTfFOTdGrkCDQRUynn8ARAAwbhP45BE
 d/zAMBPV2dk2WwIwKRSKULElP3kXpcuiDWYQob3UODUUqClO+3aXVRndaNmZX9WbzGYexVo3
 5j+CVBCGr3DlU8AL9pp3KQ3SJihWcDed1LSmUf8tS+10d6mdGxDqgnd/OWU214isvhgWZtZG
 MM/Xj7cx5pERIiP+jqu7PT1cibcfcEKhPjYdyV1QnLtKNGrTg/UMKaL+qkWBUI/8uBoa0HLs
 NH63bXsRtNAG8w6qG7iiueYZUIXKc4IHINUguqYQJVdSe+u8b2N5XNhDSEUhdlqFYraJvX6d
 TjxMTW5lzVG2KjztfErRNSUmu2gezbw1/CV0ztniOKDA7mkQi6UIUDRh4LxRm5mflfKiCyDQ
 L6P/jxHBxFv+sIgjuLrfNhIC1p3z9rvCh+idAVJgtHtYl8p6GAVrF+4xQV2zZH45tgmHo2+S
 JsLPjXZtWVsWANpepXnesyabWtNAV4qQB7/SfC77zZwsVX0OOY2Qc+iohmXo8U7DgXVDgl/R
 /5Qgfnlv0/3rOdMt6ZPy5LJr8D9LJmcP0RvX98jyoBOf06Q9QtEwJsNLCOCo2LKNL71DNjZr
 nXEwjUH66CXiRXDbDKprt71BiSTitkFhGGU88XCtrp8R9yArXPf4MN+wNYBjfT7K29gWTzxt
 9DYQIvEf69oZD5Z5qHYGp031E90AEQEAAYkCPAQYAQIAJgIbDBYhBPrrlxGhLPR1gS8Y8oip
 Bk0YNWHrBQJcXf3JBQkLVerNAAoJEIipBk0YNWHrU1AP/1FOK2SBGbyhHa5vDHuf47fgLipC
 e0/h1E0vdSonzlhPxuZoQ47FjzG9uOhqqQG6/PqtWs/FJIyz8aGG4aV+pSA/9Ko3/2ND8MSY
 ZflWs7Y8Peg08Ro01GTHFITjEUgHpTpHiT6TNcZB5aZNJ8jqCtW5UlqvXXbVeSTmO70ZiVtc
 vUJbpvSxYmzhFfZWaXIPcNcKWL1rnmnzs67lDhMLdkYVf91aml/XtyMUlfB8Iaejzud9Ht3r
 C0pA9MG57pLblX7okEshxAC0+tUdY2vANWFeX0mgqRt1GSuG9XM9H/cKP1czfUV/FgaWo/Ya
 fM4eMhUAlL/y+/AJxxumPhBXftM4yuiktp2JMezoIMJI9fmhjfWDw7+2jVrx9ze1joLakFD1
 rVAoHxVJ7ORfQ4Ni/qWbQm3T6qQkSMt4N/scNsMczibdTPxU7qtwQwIeFOOc3wEwmJ9Qe3ox
 TODQ0agXiWVj0OXYCHJ6MxTDswtyTGQW+nUHpKBgHGwUaR6d1kr/LK9+5LpOfRlK9VRfEu7D
 PGNiRkr8Abp8jHsrBqQWfUS1bAf62bq6XUel0kUCtb7qCq024aOczXYWPFpJFX+nhp4d7NeH
 Edq+wlC13sBSiSHC7T5yssJ+7JPa2ATLlSKhEvBsLe2TsSTTtFlA0nBclqhfJXzimiuge9qU
 E40lvMWBuQINBFTKimUBEADDbJ+pQ5M4QBMWkaWImRj7c598xIZ37oKM6rGaSnuB1SVb7YCr
 Ci2MTwQcrQscA2jm80O8VFqWk+/XsEp62dty47GVwSfdGje/3zv3VTH2KhOCKOq3oPP5ZXWY
 rz2d2WnTvx++o6lU7HLHDEC3NGLYNLkL1lyVxLhnhvcMxkf1EGA1DboEcMgnJrNB1pGP27ww
 cSfvdyPGseV+qZZa8kuViDga1oxmnYDxFKMGLxrClqHrRt8geQL1Wj5KFM5hFtGTK4da5lPn
 wGNd6/CINMeCT2AWZY5ySz7/tSZe5F22vPvVZGoPgQicYWdNc3ap7+7IKP86JNjmec/9RJcz
 jvrYjJdiqBVldXou72CtDydKVLVSKv8c2wBDJghYZitfYIaL8cTvQfUHRYTfo0n5KKSec8Vo
 vjDuxmdbOUBA+SkRxqmneP5OxGoZ92VusrwWCjry8HRsNdR+2T+ClDCO6Wpihu4V3CPkQwTy
 eCuMHPAT0ka5paTwLrnZIxsdfnjUa96T10vzmQgAxpbbiaLvgKJ8+76OPdDnhddyxd2ldYfw
 RkF5PEGg3mqZnYKNNBtwjvX49SAvgETQvLzQ8IKVgZS0m4z9qHHvtc1BsQnFfe+LJOFjzZr7
 CrDNJMqk1JTHYsSi2JcN3vY32WMezXSQ0TzeMK4kdnclSQyp/h23GWod5QARAQABiQRbBBgB
 AgAmAhsCFiEE+uuXEaEs9HWBLxjyiKkGTRg1YesFAlxd/coFCQtV2mQCKcFdIAQZAQIABgUC
 VMqKZQAKCRB974EGqvw5DiJoEACLmuiRq9ifvOh5DyBFwRS7gvA14DsGQngmC57EzV0EFcfM
 XVi1jX5OtwUyUe0Az5r6lHyyHDsDsIpLKBlWrYCeLpUhRR3oy181T7UNxvujGFeTkzvLAOo6
 Hs3b8Wv9ARg+7acRYkQRNY7k0GIJ6YZz149tRyRKAy/vSjsaB9Lt0NOd1wf2EQMKwRVELwJD
 y0AazGn+0PRP7Bua2YbtxaBmhBBDb2tPpwn8U9xdckB4Vlft9lcWNsC/18Gi9bpjd9FSbdH/
 sOUI+3ToWYENeoT4IP09wn6EkgWaJS3nAUN/MOycNej2i4Yhy2wDDSKyTAnVkSSSoXk+tK91
 HfqtokbDanB8daP+K5LgoiWHzjfWzsxA2jKisI4YCGjrYQzTyGOT6P6u6SEeoEx10865B/zc
 8/vN50kncdjYz2naacIDEKQNZlnGLsGkpCbfmfdi3Zg4vuWKNdWr0wGUzDUcpqW0y/lUXna+
 6uyQShX5e4JD2UPuf9WAQ9HtgSAkaDd4O1I2J41sleePzZOVB3DmYgy+ECRJJ5nw3ihdxpgc
 y/v3lfcJaqiyCv0PF+K/gSOvwhH7CbVqARmptT7yhhxqFdaYWo2Z2ksuKyoKSRMFCXQY5oac
 uTmyPIT4STFyUQFeqSCWDum/NFNoSKhmItw2Td+4VSJHShRVbg39KNFPZ7mXYAkQiKkGTRg1
 YesWJA/+PV3qDUtPNEGwjVvjQqHSbrBy94tu6gJvPHgGPtRDYvxnCaJsmgiC0pGB2KFRsnfl
 2zBNBEWF/XwsI081jQE5UO60GKmHTputChLXpVobyuc+lroG2YhknXRBAV969SLnZR4BS/1s
 Gi046gOXfaKYatve8BiZr5it5Foq3FMPDNgZMit1H9Dk8rkKFfDMRf8EGS/Z+TmyEsIf99H7
 TH3n7lco8qO81fSFwkh4pvo2kWRFYTC5vsIVQ+GqVUp+W1DZJHxX8LwWuF1AzUt4MUTtNAvy
 TXl5EgsmoY9mpNNL7ZnW65oG63nEP5KNiybvuQJzXVxR8eqzOh2Mod4nHg3PE7UCd3DvLNsn
 GXFRo44WyT/G2lArBtjpkut7bDm0i1nENABy2UgS+1QvdmgNu6aEZxdNthwRjUhuuvCCDMA4
 rCDQYyakH2tJNQgkXkeLodBKF4bHiBbuwj0E39S9wmGgg+q4OTnAO/yhQGknle7a7G5xHBwE
 i0HjnLoJP5jDcoMTabZTIazXmJz3pKM11HYJ5/ZsTIf3ZRJJKIvXJpbmcAPVwTZII6XxiJdh
 RSSX4Mvd5pL/+5WI6NTdW6DMfigTtdd85fe6PwBNVJL2ZvBfsBJZ5rxg1TOH3KLsYBqBTgW2
 glQofxhkJhDEcvjLhe3Y2BlbCWKOmvM8XS9TRt0OwUs=
Message-ID: <91af10c4-e4ff-df49-d1e9-31ea210fc637@redhat.com>
Date: Tue, 16 Jul 2019 12:58:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9cf9c85d-c41e-123c-07cb-81c453363aea@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="98eXdLKidghy7XXXjOOBp0zqqYZU4IR3W"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 16 Jul 2019 16:58:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 11/11] iotests/257: test traditional
 sync modes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--98eXdLKidghy7XXXjOOBp0zqqYZU4IR3W
Content-Type: multipart/mixed; boundary="JiO4KX4g4DzfjD2WNzm2KqNoPOj3RSPxf";
 protected-headers="v1"
From: John Snow <jsnow@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <91af10c4-e4ff-df49-d1e9-31ea210fc637@redhat.com>
Subject: Re: [PATCH v2 11/11] iotests/257: test traditional sync modes
References: <20190716000117.25219-1-jsnow@redhat.com>
 <20190716000117.25219-12-jsnow@redhat.com>
 <9cf9c85d-c41e-123c-07cb-81c453363aea@redhat.com>
In-Reply-To: <9cf9c85d-c41e-123c-07cb-81c453363aea@redhat.com>

--JiO4KX4g4DzfjD2WNzm2KqNoPOj3RSPxf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 7/16/19 8:04 AM, Max Reitz wrote:
> On 16.07.19 02:01, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/qemu-iotests/257     |   41 +-
>>  tests/qemu-iotests/257.out | 3089 +++++++++++++++++++++++++++++++++++=
+
>>  2 files changed, 3128 insertions(+), 2 deletions(-)
>=20
> This needs a %s/specify Bitmap sync mode/specify bitmap sync mode/.
>=20
>> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
>> index 53ab31c92e..c2a72c577a 100755
>> --- a/tests/qemu-iotests/257
>> +++ b/tests/qemu-iotests/257
>=20
> [...]
>=20
>> @@ -393,7 +399,7 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bit=
map', failure=3DNone):
>>              # group 1 gets cleared first, then group two gets written=
=2E
>>              if ((bsync_mode =3D=3D 'on-success' and not failure) or
>>                  (bsync_mode =3D=3D 'always')):
>> -                ebitmap.clear_group(1)
>> +                ebitmap.clear()
>=20
> Hmmm...  Why?
>=20

=46rom an order of operations standpoint, if we are here, we are expectin=
g
the bitmap to be synchronized. We can clear any existing data it holds,
and then:

>>              ebitmap.dirty_group(2)
>> =20

Add new writes that occurred during the job; which only happen here in
this callback.

(The old code cleared specifically only group 1, the new code is just
more general. I wound up changing it for a version that didn't make it
to the list, but this is still correct.)

>>          vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
>> @@ -404,8 +410,19 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bi=
tmap', failure=3DNone):
>>          log('')
>> =20
>>          if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermediat=
e':
>> +            # TOP treats anything allocated as dirty, expect to see:
>> +            if msync_mode =3D=3D 'top':
>> +                ebitmap.dirty_group(0)
>> +

Sorry, this code is definitely in the "cute" category...

If the failure was intermediate, we never call the pre-finalize callback
above. So we know that the allocated regions of the file are only from
groups 0 and 1.

So, HERE, we can mark the emulated bitmap's group 0 as dirty, to mimic
what the copy_bitmap is going to have started the operation with.

>>              # We manage to copy one sector (one bit) before the error=
=2E
>>              ebitmap.clear_bit(ebitmap.first_bit)

And then right here, we clear the first bit which we did copy out
successfully. The emulated bitmap is now correct for sync=3Dtop.

>> +
>> +            # Full returns all bits set except what was copied/skippe=
d
>> +            if msync_mode =3D=3D 'full':
>> +                fail_bit =3D ebitmap.first_bit
>> +                ebitmap.clear()
>> +                ebitmap.dirty_bits(range(fail_bit, SIZE // GRANULARIT=
Y))
>> +

The full mode, though, is special. We cleared the first allocated bit
just like for sync=3Dtop, but we take note of the second bit which is the=

one that caused the injected failure.

For both 'top' and 'full' modes here we're really using the ebitmap as
an allocation record to inform what the output bitmap is going to look li=
ke.

>=20
> So sync=3Dtop didn=E2=80=98t copy anything?  Is that because it now err=
ors out
> before getting to copy something?
>=20

The ebitmap.clear_bit(ebitmap.first_bit) triggers for top, too. The test
output should hopefully make sense here.

> (The rest looks good to me.)
>=20
> Max
>=20
>>          ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0')=
)
>> =20
>>          # 2 - Writes and Reference Backup
>=20


--JiO4KX4g4DzfjD2WNzm2KqNoPOj3RSPxf--

--98eXdLKidghy7XXXjOOBp0zqqYZU4IR3W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+ber27ys35W+dsvQfe+BBqr8OQ4FAl0uAk4ACgkQfe+BBqr8
OQ5q7A//QTeRdv8slMa+mHuIrKz01pYJcawTx6l5taCUN+z6zzdTZiF8GpO/8FTH
R5QZVW0dUifpRCbTgJVyitqF+37utMaPfwShMpFQDk2Q/I5noYoXON+WJ31UhhGc
QfNqAnvNFxY67K/eK3dH8+wvHFbNb9U3WU+2b0hakK6qiARCtjRYvTuEUWxCINF7
7hFiTIedMZ56e3t4X+mxUmKA0L2gJ9A4XfAa3hREKLqIfAFm08sUSoGi6TtvefBW
LfBQNQawMeIrGM4dAGNMqZSf0xHvJVExAukQJZTTi5L9MfSGWOzbwIFB/xiPyLDB
jJWo5FG5JiFjYaJ/U3I7LclnfvqQ26g4RHHgj83cllGFWlcmMKLg/moNOeT0vI3O
IyK/0O8ZbLt+Ax33zkjM1JWGRkt35h2U5JWc8VVr+7rfb5z4kg8y8Ec2I+UtWXVb
duh7kYEfsGmsHAYWhSQX/gENZdX4P8LrV0B0GPPBXfMeN1ToYLWBG+fbQNqeMnAg
kvbkFLMfexJCEiPcYacJEhDpvteGIx/gvy+urWvrFqKFymWfyFpfQAlj4GTvxQvy
NlxSs/zkVllWPTWOGDTaFMjx/hQ0h4vfXTh3Jo/9FHfSXipmDwk5AXpXIZJT9YTj
6Dl0hKA2qQSEONXFpQWDhRMhUFfVg7dKGCCNQ/kOWvzHjL/MQDU=
=E1I9
-----END PGP SIGNATURE-----

--98eXdLKidghy7XXXjOOBp0zqqYZU4IR3W--

