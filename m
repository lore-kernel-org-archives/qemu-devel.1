Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612ADC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27950216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27950216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjRUD-0004aR-AZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hjRST-0003ds-Tn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hjRSR-0003Ho-Uw
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:53:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hjRSK-0002xH-6s; Fri, 05 Jul 2019 12:53:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1FF03083394;
 Fri,  5 Jul 2019 16:53:01 +0000 (UTC)
Received: from [10.10.122.149] (ovpn-122-149.rdu2.redhat.com [10.10.122.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05506D1CE;
 Fri,  5 Jul 2019 16:52:56 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-12-jsnow@redhat.com>
 <6fb4a48b-5b69-7d20-eca9-beb01fd2f225@redhat.com>
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
Message-ID: <750e0c38-ba17-b6ae-82d4-bc946b3d029e@redhat.com>
Date: Fri, 5 Jul 2019 12:52:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6fb4a48b-5b69-7d20-eca9-beb01fd2f225@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 05 Jul 2019 16:53:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 11/18] block/backup: upgrade copy_bitmap
 to BdrvDirtyBitmap
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/4/19 1:29 PM, Max Reitz wrote:
> On 03.07.19 23:55, John Snow wrote:
>> This simplifies some interface matters; namely the initialization and
>> (later) merging the manifest back into the sync_bitmap if it was
>> provided.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/backup.c | 76 ++++++++++++++++++++++++-------------------------=
-
>>  1 file changed, 37 insertions(+), 39 deletions(-)
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index d7fdafebda..9cc5a7f6ca 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>=20
> [...]
>=20
>> @@ -202,7 +204,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJ=
ob *job,
>>      cow_request_begin(&cow_request, job, start, end);
>> =20
>>      while (start < end) {
>> -        if (!hbitmap_get(job->copy_bitmap, start)) {
>> +        if (!bdrv_dirty_bitmap_get(job->copy_bitmap, start)) {
>>              trace_backup_do_cow_skip(job, start);
>>              start +=3D job->cluster_size;
>>              continue; /* already copied */
>> @@ -296,14 +298,16 @@ static void backup_abort(Job *job)
>>  static void backup_clean(Job *job)
>>  {
>>      BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.jo=
b);
>> +    BlockDriverState *bs =3D blk_bs(s->target);
>=20
> I=E2=80=99d prefer to call it target_bs, because =E2=80=9Cbs=E2=80=9D i=
s usually the source node.
>=20

Sure;

> Which brings me to a question: Why is the copy bitmap assigned to the
> target in the first place?  Wouldn=E2=80=99t it make more sense on the =
source?
>=20

*cough*;

the idea was that the target is *most likely* to be the temporary node
created for the purpose of this backup, even though backup does not
explicitly create the node.

So ... by creating it on the target, we avoid cluttering up the results
in block query; and otherwise it doesn't actually matter what node we
created it on, really.

I can move it over to the source, but the testing code has to get a
little smarter in order to find the "right" anonymous bitmap, which is
not impossible; but I thought this would actually be a convenience for
people.

>> +
>> +    if (s->copy_bitmap) {
>> +        bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
>> +        s->copy_bitmap =3D NULL;
>> +    }
>> +
>>      assert(s->target);
>>      blk_unref(s->target);
>>      s->target =3D NULL;
>> -
>> -    if (s->copy_bitmap) {
>> -        hbitmap_free(s->copy_bitmap);
>> -        s->copy_bitmap =3D NULL;
>> -    }
>>  }
>> =20
>>  void backup_do_checkpoint(BlockJob *job, Error **errp)
>=20
> [...]
>=20
>> @@ -387,59 +391,49 @@ static bool bdrv_is_unallocated_range(BlockDrive=
rState *bs,
>> =20
>>  static int coroutine_fn backup_loop(BackupBlockJob *job)
>>  {
>> -    int ret;
>>      bool error_is_read;
>>      int64_t offset;
>> -    HBitmapIter hbi;
>> +    BdrvDirtyBitmapIter *bdbi;
>>      BlockDriverState *bs =3D blk_bs(job->common.blk);
>> +    int ret =3D 0;
>> =20
>> -    hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
>> -    while ((offset =3D hbitmap_iter_next(&hbi)) !=3D -1) {
>> +    bdbi =3D bdrv_dirty_iter_new(job->copy_bitmap);
>> +    while ((offset =3D bdrv_dirty_iter_next(bdbi)) !=3D -1) {
>>          if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
>>              bdrv_is_unallocated_range(bs, offset, job->cluster_size))
>>          {
>> -            hbitmap_reset(job->copy_bitmap, offset, job->cluster_size=
);
>> +            bdrv_set_dirty_bitmap(job->copy_bitmap, offset, job->clus=
ter_size);
>=20
> Should be reset.
>=20

Whoa, oops! I got through testing FULL but, clearly, not TOP. This also
doesn't trigger any other failures in our test suite, so I need to make
sure this is being covered.

Thank you.

>>              continue;
>>          }
>> =20
>>          do {
>>              if (yield_and_check(job)) {
>> -                return 0;
>> +                goto out;
>>              }
>>              ret =3D backup_do_cow(job, offset,
>>                                  job->cluster_size, &error_is_read, fa=
lse);
>>              if (ret < 0 && backup_error_action(job, error_is_read, -r=
et) =3D=3D
>>                             BLOCK_ERROR_ACTION_REPORT)
>>              {
>> -                return ret;
>> +                goto out;
>>              }
>>          } while (ret < 0);
>>      }
>> =20
>> -    return 0;
>> + out:
>> +    bdrv_dirty_iter_free(bdbi);
>> +    return ret;
>>  }
>> =20
>>  /* init copy_bitmap from sync_bitmap */
>>  static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
>>  {
>> -    uint64_t offset =3D 0;
>> -    uint64_t bytes =3D job->len;
>> -
>> -    while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
>> -                                             &offset, &bytes))
>> -    {
>> -        hbitmap_set(job->copy_bitmap, offset, bytes);
>> -
>> -        offset +=3D bytes;
>> -        if (offset >=3D job->len) {
>> -            break;
>> -        }
>> -        bytes =3D job->len - offset;
>> -    }
>> +    bdrv_dirty_bitmap_merge_internal(job->copy_bitmap, job->sync_bitm=
ap,
>> +                                     NULL, true);
>=20
> How about asserting that this was successful?
>=20

Sure.

>> =20
>>      /* TODO job_progress_set_remaining() would make more sense */
>>      job_progress_update(&job->common.job,
>> -        job->len - hbitmap_count(job->copy_bitmap));
>> +                        job->len - bdrv_get_dirty_count(job->copy_bit=
map));
>>  }
>> =20
>>  static int coroutine_fn backup_run(Job *job, Error **errp)
>=20
> [...]
>=20
>> @@ -670,7 +668,7 @@ BlockJob *backup_job_create(const char *job_id, Bl=
ockDriverState *bs,
>>   error:
>>      if (copy_bitmap) {
>>          assert(!job || !job->copy_bitmap);
>> -        hbitmap_free(copy_bitmap);
>> +        bdrv_release_dirty_bitmap(bs, copy_bitmap);
>=20
> If you decide to keep the copy_bitmap on the target, s/bs/target/.

Ah, heck. Clearly I didn't test this error pathway either. I'll have to
add some more tests to make sure the error recovery works right.

>=20
> Max
>=20

