Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AA2C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3672082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3672082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he3qg-00052L-4V
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 16:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1he3Q2-0007Ei-88
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1he3Dw-0002nU-A7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 15:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1he3De-0002Fp-8k; Thu, 20 Jun 2019 15:59:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 539403087958;
 Thu, 20 Jun 2019 19:59:14 +0000 (UTC)
Received: from [10.10.123.29] (ovpn-123-29.rdu2.redhat.com [10.10.123.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0B1C608A7;
 Thu, 20 Jun 2019 19:59:12 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-12-jsnow@redhat.com>
 <4f98c07a-cc3a-f249-ba62-b8a98a47ab53@redhat.com>
 <cf20b1e7-76e2-5107-d321-98521597bf58@redhat.com>
 <2d906ba5-bc04-a43f-6a53-d18e67074a34@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cb30c3dc-45ac-dd4f-8bea-c4ee1f291067@redhat.com>
Date: Thu, 20 Jun 2019 15:59:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2d906ba5-bc04-a43f-6a53-d18e67074a34@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 20 Jun 2019 19:59:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 11/12] iotests: add test 257 for
 bitmap-mode backups
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
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/20/19 3:48 PM, Max Reitz wrote:
> On 20.06.19 21:08, John Snow wrote:
>>
>>
>> On 6/20/19 2:35 PM, Max Reitz wrote:
>>> On 20.06.19 03:03, John Snow wrote:
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/257     |  412 +++++++
>>>>  tests/qemu-iotests/257.out | 2199 +++++++++++++++++++++++++++++++++=
+++
>>>>  tests/qemu-iotests/group   |    1 +
>>>>  3 files changed, 2612 insertions(+)
>>>>  create mode 100755 tests/qemu-iotests/257
>>>>  create mode 100644 tests/qemu-iotests/257.out
>>>
>>> This test is actually quite nicely written.
>>>
>>
>> Thanks!
>>
>>> I like that I don=E2=80=99t have to read the reference output but can=
 just grep
>>> for =E2=80=9Cerror=E2=80=9D.
>>>
>>
>> Me too!! Actually, doing the math for what to expect and verifying the
>> output by hand was becoming a major burden, so partially this test
>> infrastructure was my attempt to procedurally verify that the results =
I
>> was seeing were what made sense.
>>
>> At the end of it, I felt it was nice to keep it in there.
>>
>>> Only minor notes below.
>>>
>>>> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
>>>> new file mode 100755
>>>> index 0000000000..5f7f388504
>>>> --- /dev/null
>>>> +++ b/tests/qemu-iotests/257
>>>
>>> [...]
>>>
>>>> +class PatternGroup:
>>>> +    """Grouping of Pattern objects. Initialize with an iterable of =
Patterns."""
>>>> +    def __init__(self, patterns):
>>>> +        self.patterns =3D patterns
>>>> +
>>>> +    def bits(self, granularity):
>>>> +        """Calculate the unique bits dirtied by this pattern groupi=
ng"""
>>>> +        res =3D set()
>>>> +        for pattern in self.patterns:
>>>> +            lower =3D math.floor(pattern.offset / granularity)
>>>> +            upper =3D math.floor((pattern.offset + pattern.size - 1=
) / granularity)
>>>> +            res =3D res | set(range(lower, upper + 1))
>>>
>>> Why you=E2=80=99d do floor((x - 1) / y) + 1 has confused me quite a w=
hile.
>>> Until I realized that oh yeah, Python=E2=80=99s range() is a right-op=
en
>>> interval.  I don=E2=80=99t like Python=E2=80=99s range().
>>>
>>
>> It confuses me constantly, but it's really meant to be used for
>> iterating over lengths.
>=20
> I can see the use for range(x), but not for range(a, b).
>=20
> (At least it=E2=80=99s not Rust, where [a..b] is [a, b), too =E2=80=93 =
it=E2=80=99s enclosed in
> square brackets, it should be closed, damnit.)
>=20
>> This is somewhat of an abuse of it. I always
>> test it out in a console first before using it, just in case.
>>
>>> (Yes, you=E2=80=99re right, this is better to read than just ceil(x /=
 y).
>>> Because it reminds people like me that range() is weird.)
>>>
>>>> +        return res
>>>> +
>>>> +GROUPS =3D [
>>>> +    PatternGroup([
>>>> +        # Batch 0: 4 clusters
>>>> +        mkpattern('0x49', 0x0000000),
>>>> +        mkpattern('0x6c', 0x0100000),   # 1M
>>>> +        mkpattern('0x6f', 0x2000000),   # 32M
>>>> +        mkpattern('0x76', 0x3ff0000)]), # 64M - 64K
>>>> +    PatternGroup([
>>>> +        # Batch 1: 6 clusters (3 new)
>>>> +        mkpattern('0x65', 0x0000000),   # Full overwrite
>>>> +        mkpattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
>>>> +        mkpattern('0x72', 0x2008000),   # Partial-right (32M+32K)
>>>> +        mkpattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K=
)
>>>> +    PatternGroup([
>>>> +        # Batch 2: 7 clusters (3 new)
>>>> +        mkpattern('0x74', 0x0010000),   # Adjacent-right
>>>> +        mkpattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
>>>> +        mkpattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
>>>> +        mkpattern('0x67', 0x3fe0000,
>>>> +                  2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M=
)
>>>> +    PatternGroup([
>>>> +        # Batch 3: 8 clusters (5 new)
>>>> +        # Carefully chosen such that nothing re-dirties the one clu=
ster
>>>> +        # that copies out successfully before failure in Group #1.
>>>> +        mkpattern('0xaa', 0x0010000,
>>>> +                  3*GRANULARITY),       # Overwrite and 2x Adjacent=
-right
>>>> +        mkpattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
>>>> +        mkpattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
>>>> +        mkpattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the=
 right
>>>> +    ]
>>>
>>> I=E2=80=99d place this four spaces to the left.  But maybe placing it=
 here is
>>> proper Python indentation, while moving it to the left would be C
>>> indentation.
>>>
>>
>> Either is fine, I think. In this case it affords us more room for the
>> commentary on the bit ranges. Maybe it's not necessary, but at least
>> personally I get woozy looking at the bit patterns.
>=20
> Oh, no, no, I just meant the final closing =E2=80=9D]=E2=80=9D of GROUP=
S.
>=20
> (I did wonder about why you didn=E2=80=99t place every PatternGroups cl=
osing ])
> on a separate line, too, but I decided not to say anything, because it
> looks Python-y this way.  But you=E2=80=99re right, this gives a nice e=
xcuse why
> to put more space between the patterns and the comments, which helps.)
>=20
>>>> +class Drive:
>>>> +    """Represents, vaguely, a drive attached to a VM.
>>>> +    Includes format, graph, and device information."""
>>>> +
>>>> +    def __init__(self, path, vm=3DNone):
>>>> +        self.path =3D path
>>>> +        self.vm =3D vm
>>>> +        self.fmt =3D None
>>>> +        self.size =3D None
>>>> +        self.node =3D None
>>>> +        self.device =3D None
>>>> +
>>>> +    @property
>>>> +    def name(self):
>>>> +        return self.node or self.device
>>>> +
>>>> +    def img_create(self, fmt, size):
>>>> +        self.fmt =3D fmt
>>>> +        self.size =3D size
>>>> +        iotests.qemu_img_create('-f', self.fmt, self.path, str(self=
.size))
>>>> +
>>>> +    def create_target(self, name, fmt, size):
>>>> +        basename =3D os.path.basename(self.path)
>>>> +        file_node_name =3D "file_{}".format(basename)
>>>> +        vm =3D self.vm
>>>> +
>>>> +        log(vm.command('blockdev-create', job_id=3D'bdc-file-job',
>>>> +                       options=3D{
>>>> +                           'driver': 'file',
>>>> +                           'filename': self.path,
>>>> +                           'size': 0,
>>>> +                       }))
>>>> +        vm.run_job('bdc-file-job')
>>>> +        log(vm.command('blockdev-add', driver=3D'file',
>>>> +                       node_name=3Dfile_node_name, filename=3Dself.=
path))
>>>> +
>>>> +        log(vm.command('blockdev-create', job_id=3D'bdc-fmt-job',
>>>> +                       options=3D{
>>>> +                           'driver': fmt,
>>>> +                           'file': file_node_name,
>>>> +                           'size': size,
>>>> +                       }))
>>>> +        vm.run_job('bdc-fmt-job')
>>>> +        log(vm.command('blockdev-add', driver=3Dfmt,
>>>> +                       node_name=3Dname,
>>>> +                       file=3Dfile_node_name))
>>>> +        self.fmt =3D fmt
>>>> +        self.size =3D size
>>>> +        self.node =3D name
>>>
>>> It=E2=80=99s cool that you use blockdev-create here, but would it not=
 have been
>>> easier to just use self.img_create() + blockdev-add?
>>>
>>> I mean, there=E2=80=99s no point in changing it now, I=E2=80=99m just=
 wondering.
>>>
>>
>> Mostly just because I already wrote this for the last test, and we
>> already test incremental backups the other way. I figured this would
>> just be nice for code coverage purposes, and also because using the
>> blockdev interfaces exclusively does tend to reveal little gotchas
>> everywhere.
>>
>> I also kind of want to refactor a lot of my tests and share some of th=
e
>> common code. I was tinkering with the idea of adding some common objec=
ts
>> to iotests, like "Drive" "Bitmap" and "Backup".
>>
>> That's why there's a kind of superfluous "Drive" object here.
>>
>>>> +
>>>> +def query_bitmaps(vm):
>>>> +    res =3D vm.qmp("query-block")
>>>> +    return {"bitmaps": {device['device'] or device['qdev']:
>>>> +                        device.get('dirty-bitmaps', []) for
>>>> +                        device in res['return']}}
>>>
>>> Python=E2=80=99s just not for me if I find this syntax unintuitive an=
d
>>> confusing, hu?
>>>
>>> [...]
>>>
>>
>> Sorry. It's a very functional-esque way of processing iterables.
> I=E2=80=99m not blaming the basic idea, I=E2=80=99m blaming the syntax.=
  In fact, I=E2=80=99m
> blaming exactly that it isn=E2=80=99t literally functional because ther=
e are no
> functions here (but .get() and []).  I would like to have functions
> because function names would tell me what=E2=80=99s going on.
>=20
> I can never remember what {:} means (why do they use such nice words
> everywhere else, like =E2=80=9Cor=E2=80=9D, =E2=80=9Cfor=E2=80=9D, or =E2=
=80=9Cin=E2=80=9D, and then they do that?).
> And I find it weird that postfix-for can introduce variables after they
> are used.  That may be the way I would read it aloud, but that=E2=80=99=
s
> definitely not the way I *think*.
>=20
>> I've been doing a lot of FP stuff lately and that skews what I find
>> readable...
>>
>> It's a dict comprehension of the form:
>>
>> {key: value for atom in iterable}
>=20
> Ah.  Thanks.  I thought it was some filter where it would only return
> elements where 'device' or 'qdev' is set.  So that seemed completely
> stupid to me, to have the iteration in the end, but the filter in the
> beginning.
>=20
>> Key here is either the device or qdev name,
>> the value is the 'dirty-bitmaps' field of the atom, and
>> res['return'] is the iterable.
>>
>> Effectively it turns a list of devices into a dict keyed by the device
>> name, and the only field (if any) was its dirty-bitmap object.
>=20
> Why can=E2=80=99t they write it like normal human beings.  Like
>=20
> Hash[res['return'].map { |device| [device['device'] || device['qdev'],
>                                    device['dirty-bitmaps'] or {}]}]
>=20

=F0=9F=A4=A0

> By the way, this is the reason why you=E2=80=99ll always see me using m=
ap() and
> filter() and then someone saying that there is a more Python-y way of
> doing themes, namely postfix-for.  I hate postfix-for.  I also hate
> postfix-if-else, by the way, but I felt like I didn=E2=80=99t want to g=
o there.
>=20

I actually really dislike the postfix-if-else too. I prefer C's ternary
there, but when in Rome, etc.

>> However, in explaining this I do notice I have a bug -- the default
>> value for the bitmap object ought to be {}, not [].
>>
>> This is code that should become common testing code too, as I've
>> re-written it a few times now...
>>
>>>> +def bitmap_comparison(bitmap, groups=3DNone, want=3D0):
>>>> +    """
>>>> +    Print a nice human-readable message checking that this bitmap h=
as as
>>>> +    many bits set as we expect it to.
>>>> +    """
>>>> +    log("=3D Checking Bitmap {:s} =3D".format(bitmap.get('name', '(=
anonymous)')))
>>>> +
>>>> +    if groups:
>>>> +        want =3D calculate_bits(groups)
>>>> +    have =3D int(bitmap['count'] / bitmap['granularity'])
>>>
>>> Or just bitmap['count'] // bitmap['granularity']?
>>>
>>> [...]
>>>
>>
>> I forget that exists. If you prefer that, OK.
>=20
> Well, it is shorter and more optimal!!!  (Saves two conversions to FP,
> then an FP division, and then one conversion back to integer!!)
>=20

ok!!!!!

>>>> +def test_bitmap_sync(bsync_mode, failure=3DNone):
>>>
>>> [...]
>>>
>>>> +        log('--- Preparing image & VM ---\n')
>>>> +        drive0 =3D Drive(img_path, vm=3Dvm)
>>>> +        drive0.img_create(iotests.imgfmt, SIZE)
>>>> +        vm.add_device('virtio-scsi-pci,id=3Dscsi0')
>>>
>>> Judging from 238, this should be virtio-scsi-ccw on s390-ccw-virtio.
>>>
>>> (This is the reason I cannot give an R-b.)
>>>
>>> [...]
>>>
>>
>> Oh, good catch. Alright.
>>
>>>> +        vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
>>>> +                   pre_finalize=3D_callback,
>>>> +                   cancel=3Dfailure =3D=3D 'simulated')
>>>
>>> I=E2=80=99d prefer =E2=80=9Ccancel=3D(failure =3D=3D 'simulated')=E2=80=
=9D.  (Or spaces around =3D).
>>>
>>> Also in other places elsewhere that are of the form x=3Dy where y con=
tains
>>> spaces.
>>>
>>> [...]
>>>
>>
>> OK; I might need to make a pylintrc file to allow that style. Python i=
s
>> VERY aggressively tuned to omitting parentheses.
>=20
> It seems to me more and more like Python is very aggressively tuned to
> what I find difficult to read.
>=20
> (You=E2=80=99re also still free to write =E2=80=9Ccancel =3D failure =3D=
=3D 'simulated'=E2=80=9D.  I
> wouldn=E2=80=99t write that in C, but well.)
>=20

It turns out that your suggestion is fine. I do agree, though: I like my
unnecessary parentheses a lot.

Python wants:

assert a =3D=3D b

And will get mad about:

assert (a =3D=3D b)

And that's just so hard to deal with when working with C-brain.

>> (I do actually try to run pylint on my python patches now to make sure=
 I
>> am targeting SOME kind of style. I realize this is not standardized in
>> this project.)
>=20
> Sorry for becoming very grumpy here (can=E2=80=99t help myself), but wh=
y would I
> run it when apparently Python has just bad opinions about what=E2=80=99=
s
> readable and what isn=E2=80=99t.
>=20
> Max
>=20



