Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D4AC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 00:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2737B21A4C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 00:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2737B21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFp70-00082b-Ak
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 20:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iFp6B-0007WX-9x
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 20:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iFp69-0006VT-7g
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 20:36:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iFp64-0006SN-Ve; Wed, 02 Oct 2019 20:35:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 04CAE3082231;
 Thu,  3 Oct 2019 00:35:56 +0000 (UTC)
Received: from [10.18.17.165] (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4754619C6A;
 Thu,  3 Oct 2019 00:35:55 +0000 (UTC)
Subject: Re: [PATCH 04/67] iotests.py: create_test_image, remove_test_image
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191001194715.2796-1-mreitz@redhat.com>
 <20191001194715.2796-5-mreitz@redhat.com>
 <a65b0919-66ee-d1e6-2ba1-94e7ec8fb184@redhat.com>
 <8604aec2-2a09-7bcc-792a-9e11e8b6fb11@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c9bf1dca-80c5-7271-2269-216338ef6405@redhat.com>
Date: Wed, 2 Oct 2019 20:35:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <8604aec2-2a09-7bcc-792a-9e11e8b6fb11@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 03 Oct 2019 00:35:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/2/19 7:00 AM, Max Reitz wrote:
> On 02.10.19 01:20, John Snow wrote:
>>
>>
>> On 10/1/19 3:46 PM, Max Reitz wrote:
>>> Python tests should use these two new functions instead of
>>> qemu_img('create', ...) + os.remove(), so that user-supplied image
>>> options are interpreted and handled correctly.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  tests/qemu-iotests/iotests.py | 56 +++++++++++++++++++++++++++++++++=
++
>>>  1 file changed, 56 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
>>> index b5ea424de4..fce1ab04c9 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -122,6 +122,62 @@ def qemu_img_create(*args):
>>> =20
>>>      return qemu_img(*args)
>>> =20
>>> +def create_test_image(filename, size=3DNone, fmt=3Dimgfmt, opts=3D[]=
,
>>> +                      backing_file=3DNone, backing_fmt=3DNone,
>>> +                      objects=3D[], unsafe=3DFalse):
>>
>> Python! It's the language that everybody loves and can do no wrong!
>>
>> Ah, wait, no, maybe the opposite.
>>
>> You want this:
>>
>> (..., opts=3DNone, ...):
>>     opts =3D opts or []
>>
>> because, unfortunately, default parameters are bound at definition tim=
e
>> and not at call time, so the default list here is like a static local.
>=20
> OK.  Interesting.
>=20
> I suppose the same goes for @objects, then.
>=20

It is by far the WORST thing about Python.

I realize we use this pattern a few places in iotests, but I think it's
also usually where we don't modify the list, so it's actually OK, but
serves as an example of a bad habit.

>>> +    if fmt =3D=3D imgfmt:
>>> +        # Only use imgopts for the default format
>>> +        opts =3D imgopts + opts
>>> +
>>> +    for i, opt in enumerate(opts):
>>> +        if '$TEST_IMG' in opt:
>>> +            opts[i] =3D opt.replace('$TEST_IMG', filename)
>>> +
>>> +    # default luks support
>>> +    if fmt =3D=3D 'luks':
>>> +        if not any('key-secret' in opt for opt in opts):
>>
>> You can write "if not 'key-secret' in opts"
>=20
> Oh, that=E2=80=99s recursive?
>=20

No, I was just mistaken about the shape of the data.
You are looking for 'key-secret=3DXXX', I was thinking that there was a
token that was really just 'key-secret'.

What you wrote is correct and good and I am wrong and bad.

>>> +            opts.append(luks_default_key_secret_opt)
>>
>> And here we might modify that default list.
>>
>>> +        objects.append(luks_default_secret_object)
>>> +
>>> +    args =3D ['create', '-f', fmt]
>>> +
>>> +    if len(opts) > 0:
>>> +        args +=3D ['-o', ','.join(opts)]
>>> +
>>> +    if backing_file is not None:
>>> +        args +=3D ['-b', backing_file]
>>> +
>>> +    if backing_fmt is not None:
>>> +        args +=3D ['-F', backing_fmt]
>>> +
>>> +    if len(objects) > 0:
>>> +        # Generate a [['--object', $obj], [...], ...] list and flatt=
en it
>>> +        args +=3D [arg for objarg in (['--object', obj] for obj in o=
bjects) \
>>> +                     for arg in objarg]
>>
>> I may have mentioned at one point that I love comprehensions, but
>> dislike nested comprehensions.
>=20
> I can=E2=80=99t remember but I do remember writing this piece of code, =
being sad
> that there is no .flatten, and wanting everyone to see the monster that
> arises.
>=20
>> At this point, I think it's far simpler
>> to say:
>>
>> for obj in objects:
>>     args.extend(['--object', obj])
>>
>> or, even shorter:
>>     args +=3D ['--object', obj]
>=20
> OK, so now you saw it, I=E2=80=99m glad to make the flattening more fla=
ttering
> to read.
>=20

I am sorry I ever mentioned liking Python. I will accept your punishments=
.

>>> +
>>> +    if unsafe:
>>> +        args.append('-u')
>>> +
>>> +    args.append(filename)
>>> +    if size is not None:
>>> +        args.append(str(size))
>>> +
>>> +    return qemu_img(*args)
>>> +
>>> +# Use this to remove images create with create_test_image in the
>>
>> created
>>
>> and you might as well move the # comment to a """docstring""" while
>> you're here.
>>
>>> +# default image format (iotests.imgfmt)
>>> +def remove_test_image(filename):
>>> +    try:
>>> +        os.remove(filename)
>>> +
>>> +        data_file =3D next(opt.replace('data_file=3D', '') \
>>> +                            .replace('$TEST_IMG', filename) \
>>> +                         for opt in imgopts if opt.startswith('data_=
file=3D'))
>>> +
>>
>> Learned something today: you can use next() to get the first value fro=
m
>> a generator expression.
>=20
> I was sad for a bit that Python doesn=E2=80=99t have a find(), but then=
 I
> noticed this works as well.  (Already used extensively in =E2=80=9Ciote=
sts: Add
> VM.assert_block_path()=E2=80=9D from my =E2=80=9Cblock: Fix check_to_re=
place_node()=E2=80=9D
> series.)
>=20

I honestly tried to rewrite this a few times because it looks so chunky,
but realized there isn't ... a great way to do this without implying
that you might find more than one result.

You can filter to a new list and assert that the length is one, but
that's not less chunky.

>>> +        os.remove(data_file)
>>
>> Keep in mind that if the generator expression returns no results, that
>> next() will throw an exception and we won't make it here. That's ok, b=
ut,
>=20
> I did.  If there are no results, it=E2=80=99s good we won=E2=80=99t get=
 here.
>=20
> This code would be wrong if the next() didn=E2=80=99t throw an exceptio=
n.
>=20

It just wasn't clear, because the except is doing the lifting for both
the remove and the finding.

Oh well, it's not really important.

>>> +    except:
>>> +        pass
>>> +
>>
>> The unqualified except doesn't help me know which errors you expected
>> and which you didn't.
>=20
> What I=E2=80=99m expecting: FileNotFound, StopIteration.
>=20
> But the thing is that I feel like maybe removing a file should always
> pass, regardless of the exact exception.  (I can imagine to be wrong.)
>=20

I wonder if that's true ... I just don't know what the full set of
errors we might get are. I don't really like exception driven code,
honestly.

"It's wrong to catch ANY exception because you might suppress errors too
broadly."

"It's wrong to be too specific, because you'll miss cases you meant to
catch."

Awful.

Anyway, like I said I was just being fiddly because I found this odd to
read, but really don't have suggestions that are clearly nicer, so ...
carry on.

>> We have a function like this elsewhere in the python directory:
>>
>> def remove_if_exists(filename):
>>     try:
>>         os.remove(filename)
>>     except FileNotFoundError:
>>         pass
>=20
> We do?  I can=E2=80=99t find it.  I find a _remove_if_exists in machine=
.py,
> which I=E2=80=99m not sure whether it=E2=80=99s supposed to be used out=
side, and it
> works a bit different, actually (but probably to the same effect).
>=20

Yeah, that's the one. Don't worry about plucking it out here for this,
just nothing that we do this in a few places. We might want a util
eventually that gets it exactly right.

Or not, because what's "exactly right" anyway. Ah, ah, ah.

>> Can we use that here and remove the try:/except: from this function? I=
t
>> will require you to change the list search to something like this inst=
ead:
>>
>> remove_if_exists(filename)
>> for opt in (x for x in imgopts if etc):
>>     data_file =3D opt.replace('etc', 'etc')
>>     remove_if_exists(data_file)
>>
>> to avoid the exception when you call next().
>=20
> I don=E2=80=99t know why I=E2=80=99d avoid the exception, though.
>=20
> This is probably because I don=E2=80=99t like pythonic code, again, but=
 I prefer
> a next() + exception over a for loop that just iterates once or not at =
all.
>=20

Nah, Python people LOVE exceptions. They don't like "bare except"
statements, though. I am the weird person in that I like to avoid
exceptions whenever it's elegant and pretty to do so.

I find exceptions as normal control flow to be quite hard to deal with;
but Pythonistas seem to love it.

>>>  def qemu_img_verbose(*args):
>>>      '''Run qemu-img without suppressing its output and return the ex=
it code'''
>>>      exitcode =3D subprocess.call(qemu_img_args + list(args))
>>>
>>
>> My fussiness with the remove() function is just optional picky stuff,
>> but the rest matters, I think.
>=20
> OK.  Indeed it does!
>=20
> Max
>=20

