Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B962C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD05206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD05206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxfGI-0002jg-Ec
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 18:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53342)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hxfFr-0002Fr-Bh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hxfFo-0004su-8a
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:26:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hxfFj-0004qv-JJ; Tue, 13 Aug 2019 18:26:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6617583F3C;
 Tue, 13 Aug 2019 22:26:50 +0000 (UTC)
Received: from [10.18.17.169] (dhcp-17-169.bos.redhat.com [10.18.17.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9598E18E35;
 Tue, 13 Aug 2019 22:26:49 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-8-mreitz@redhat.com>
 <42b23025-5270-8b53-1fa0-724883d9a746@redhat.com>
 <74692040-e5c7-4ec3-8a6c-df565e6bae3f@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5496dd9a-1a78-4a5b-b84b-fb870ad409e5@redhat.com>
Date: Tue, 13 Aug 2019 18:26:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <74692040-e5c7-4ec3-8a6c-df565e6bae3f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 13 Aug 2019 22:26:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 7/7] iotests: Disable 126 for
 some vmdk subformats
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



On 8/13/19 10:00 AM, Max Reitz wrote:
> On 12.08.19 23:33, John Snow wrote:
>>
>>
>> On 7/25/19 11:57 AM, Max Reitz wrote:
>>> Several vmdk subformats do not work with iotest 126, so disable them.
>>>
>>> (twoGbMaxExtentSparse actually should work, but fixing that is a bit
>>> difficult.  The problem is that the vmdk descriptor file will contain=
 a
>>> referenc to "image:base.vmdk", which the block layer cannot open beca=
use
>>
>> reference
>>
>>> it does not know the protocol "image".  This is not trivial to solve,
>>> because I suppose real protocols like "http://" should be supported.
>>> Making vmdk treat all paths with a potential protocol prefix that the
>>> block layer does not recognize as plain files seems a bit weird,
>>> though.  Ignoring this problem does not seem too bad.)
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  tests/qemu-iotests/126 | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
>>> index 9b0dcf9255..8e55d7c843 100755
>>> --- a/tests/qemu-iotests/126
>>> +++ b/tests/qemu-iotests/126
>>> @@ -33,6 +33,12 @@ status=3D1	# failure is the default!
>>> =20
>>>  # Needs backing file support
>>>  _supported_fmt qcow qcow2 qed vmdk
>>> +# (1) Flat vmdk images do not support backing files
>>> +# (2) Split vmdk images simply fail this test right now.  Fixing tha=
t
>>> +#     is left for another day.
>>
>> Which one? :)
>=20
> Hmmmm?  Fixing refers to #2.  #1 is not a bug or missing feature, it=E2=
=80=99s
> just how it is.  (This test needs backing files, so...)
>=20
> If you mean =E2=80=9Cwhich are which=E2=80=9C, then the ones with *Flat=
 are flat images
> (:-)), and the ones with twoGbMaxExtent* are split.
>=20

"Which day" ;)

>>> +_unsupported_imgopts "subformat=3DmonolithicFlat" \
>>> +                     "subformat=3DtwoGbMaxExtentFlat" \
>>> +                     "subformat=3DtwoGbMaxExtentSparse"
>>>  # This is the default protocol (and we want to test the difference b=
etween
>>>  # colons which separate a protocol prefix from the rest and colons w=
hich are
>>>  # just part of the filename, so we cannot test protocols which requi=
re a prefix)
>>>
>>
>> What exactly fails?
>=20
> Interestingly I only now noticed that the test passes with =E2=80=9Cvmd=
k: Use
> bdrv_dirname() for relative extent paths=E2=80=9D (patch 2) reverted...
>=20
>>                     Does the VMDK driver see `image:` and think it's a
>> special filename it needs to handle and fails to do so?
> No.  Whenever the block layer sees a parsee filename[1] with a colon
> before a slash, it thinks everything before the colon is a protocol
> prefix.  For example:
>=20

Actually, I think we're on the same page here. I maybe meant to type
"block layer" instead of "VMDK driver", but it does look like it does
special processing on this sort of filename that breaks in this case.

> $ qemu-img info foo:bar
> qemu-img: Could not open 'foo:bar': Unknown protocol 'foo'
>=20
> This test is precisely for this.  How can you specify an image filename
> that has a colon in it (without using -blockdev)?  One way is to prepen=
d
> it with =E2=80=9C./=E2=80=9D, the other is =E2=80=9Cfile:=E2=80=9D.
>=20
> Now with split VMDKs, we must write something in the header file to
> reference the extents.  What vmdk does for an image like
> =E2=80=9Cimage:foo.vmdk=E2=80=9D is it writes =E2=80=9Cimage:foo-s001.v=
mdk=E2=80=9D there.
>=20
> When it tries to open that extent, what happens depends on whether
> =E2=80=9Cvmdk: Use bdrv_dirname() for relative extent paths=E2=80=9D (p=
atch 2) is applied:
>=20
> --- Before that patch ---
>=20
> vmdk takes the descriptor filename, which, thanks to some magic in the
> block layer, is always =E2=80=9C./image:foo.vmdk=E2=80=9D, even when yo=
u gave it as
> =E2=80=9Cfile:image:foo.vmdk=E2=80=9D (the =E2=80=9Cfile:=E2=80=9D is s=
tripped because it does nothing,
> generally, and the =E2=80=9C./=E2=80=9D is then prepended because of th=
e false protocol
> prefix =E2=80=9Cimage:=E2=80=9D).
>=20
> It then invokes path_combine() with that path and the path given in the
> descriptor file (=E2=80=9Cimage:foo-s001.vmdk=E2=80=9D).  This yields
> =E2=80=9C./image:foo-s001.vmdk=E2=80=9D, which actually works.
>=20
> --- After that patch ---
>=20
> OK, what I messed up is that I just took the extent path to be an
> absolute path if it has a protocol prefix.  (Because that=E2=80=99s how=
 we
> usually do it.)  Turns out that vmdk never did that, and path_combine()
> actually completely ignores protocol prefixes in the relative filename.
>=20
> I suppose I could do the same and just drop the path_has_protocol() fro=
m
> patch 2.  But that=E2=80=99d be a bit broken, as I wrote in the commit
> message...  If the descriptor file refers to an extent on
> =E2=80=9Chttp://example.com/extent.vmdk=E2=80=9D, I suppose that should=
 not be
> interpreted as a relative path, but actually work...
>=20
> But anyway, I guess if it=E2=80=99s a bit broken already, I might just =
keep it
> that way.
>=20
>=20
> tl;dr: Turns out patch 2 broke this test, because it (accidentally)
> tried to fix something that I consider broken.  If I just keep it broke=
n
> (I didn=E2=80=99t know it was), this test will continue to work and pro=
bably
> nobody will care because, well, it already is broken and nobody cares.
>=20

So which kinda-broken thing are you making the case for? Are you
re-spinning in light of your discovery or... are we fine with the state
of things as they land here?

(Sorry, it wasn't clear to me which way you were leaning.)

--js

> Max
>=20
>=20
> [1] By this I mean whether it is piped through .bdrv_parse_filename().
> If you specifying something with -hda or -drive file=3D, it will be.
> These are filenames like nbd://localhost:10809 or blkdebug:conf:image.
> If you pass a filename through QMP, that is, with -blockdev or
> blockdev-add, it will not be parsed.  It will be given to the block
> driver as is.  Protocol prefixes and other filename magic are ignored
> (you need to explicitly specify the driver anyway).
>=20

