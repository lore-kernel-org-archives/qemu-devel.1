Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 06:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1353E21D80
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 06:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1353E21D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLLdm-0007Ua-66
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 02:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iLLcu-0006xc-VI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 02:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iLLct-0001Cb-FI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 02:20:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iLLcp-0001Ac-4i; Fri, 18 Oct 2019 02:20:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 355EB2B94;
 Fri, 18 Oct 2019 06:20:33 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF9BC60852;
 Fri, 18 Oct 2019 06:20:31 +0000 (UTC)
Subject: Re: iotest failure -- test possibly not using sufficiently unique
 temp filename?
To: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>
References: <CAFEAcA8fwM03PXzkMvLdOWAL0R1Mq8hLmt8O-+NFSri6oHun1w@mail.gmail.com>
 <010553d9-9dc6-907f-fc74-4cd5614f4a0e@redhat.com>
 <CAFEAcA89CTV2jfv5chWH3fdCFS55CqMjqQ4MwFGwFumaqig6RA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <22502e83-f630-f9a6-8099-2373a52c6873@redhat.com>
Date: Fri, 18 Oct 2019 08:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89CTV2jfv5chWH3fdCFS55CqMjqQ4MwFGwFumaqig6RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 18 Oct 2019 06:20:33 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/2019 18.41, Peter Maydell wrote:
> On Fri, 27 Sep 2019 at 17:44, Max Reitz <mreitz@redhat.com> wrote:
>>
>> On 27.09.19 18:39, Peter Maydell wrote:
>>> Hi; I just saw this iotest failure (on an s390x box, as it happens):
>>>
>>>   TEST    iotest-qcow2: 130 [fail]
>>> QEMU          --
>>> "/home/linux1/qemu/build/all/tests/qemu-iotests/../../s390x-softmmu/q=
emu-system-s390x"
>>> -nodefaults -display none -machine accel=3Dqtest
>>> QEMU_IMG      -- "/home/linux1/qemu/build/all/tests/qemu-iotests/../.=
./qemu-img"
>>> QEMU_IO       --
>>> "/home/linux1/qemu/build/all/tests/qemu-iotests/../../qemu-io"
>>> --cache writeback -f qcow2
>>> QEMU_NBD      -- "/home/linux1/qemu/build/all/tests/qemu-iotests/../.=
./qemu-nbd"
>>> IMGFMT        -- qcow2 (compat=3D1.1)
>>> IMGPROTO      -- file
>>> PLATFORM      -- Linux/s390x lxub05 4.15.0-58-generic
>>> TEST_DIR      -- /home/linux1/qemu/build/all/tests/qemu-iotests/scrat=
ch
>>> SOCKET_SCM_HELPER --
>>> /home/linux1/qemu/build/all/tests/qemu-iotests/socket_scm_helper
>>>
>>> --- /home/linux1/qemu/tests/qemu-iotests/130.out        2019-05-10
>>> 12:27:16.948075733 -0400
>>> +++ /home/linux1/qemu/build/all/tests/qemu-iotests/130.out.bad
>>> 2019-09-27 12:01:23.649722655 -0400
>>> @@ -18,20 +18,22 @@
>>>  QEMU X.Y.Z monitor - type 'help' for more information
>>>  (qemu) commit testdisk
>>>  (qemu)
>>> -image: TEST_DIR/t.IMGFMT
>>> -file format: IMGFMT
>>> -virtual size: 64 MiB (67108864 bytes)
>>> -backing file: TEST_DIR/t.IMGFMT.orig
>>> -backing file format: raw
>>> +qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared "=
write" lock
>>> +Is another process using the image [TEST_DIR/t.IMGFMT]?
>>>
>>>  =3D=3D=3D Marking image dirty (lazy refcounts) =3D=3D=3D
>>>
>>> +qemu-img: TEST_DIR/t.IMGFMT: Failed to get "write" lock
>>> +Is another process using the image [TEST_DIR/t.IMGFMT]?
>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>> -wrote 4096/4096 bytes at offset 0
>>> -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +qemu-io: can't open device
>>> /home/linux1/qemu/build/all/tests/qemu-iotests/scratch/t.qcow2: Faile=
d
>>> to get "write" lock
>>> +Is another process using the image
>>> [/home/linux1/qemu/build/all/tests/qemu-iotests/scratch/t.qcow2]?
>>> +no file open, try 'help open'
>>>  image: TEST_DIR/t.IMGFMT
>>>  file format: IMGFMT
>>>  virtual size: 64 MiB (67108864 bytes)
>>> +backing file: TEST_DIR/t.IMGFMT.orig
>>> +backing file format: raw
>>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>> backing_file=3DTEST_DIR/t.IMGFMT.orig backing_fmt=3Draw
>>>  wrote 4096/4096 bytes at offset 0
>>>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>
>>>
>>>
>>> This looks suspiciously like the test isn't using a unique
>>> filename for its disk image: "qemu-iotests/scratch/t.qcow2"
>>> in the build directory, and so perhaps it has collided with
>>> another iotest ?
>>>
>>> If we run 'make check' with a -j<something> option do the
>>> iotests all get run serially anyway, or do they run in
>>> parallel against each other ?
>>
>> As far as I know, all iotests are executed serially.  Anything else
>> would not work with the same scratch directory.
>>
>> The only thing I suspect is that some tool has been accidentally left
>> running by some previous test that still accesses its own image.  But =
I
>> don=E2=80=99t know.
>=20
> Just saw this one again with the same iotest 130 on the same
> s390 box; only difference is that the log this time around
> has the first part where qemu-img fails, but not the second part
> where qemu-io fails:
>=20
> --- /home/linux1/qemu/tests/qemu-iotests/130.out        2019-05-10
> 12:27:16.948075733 -0400
> +++ /home/linux1/qemu/build/all/tests/qemu-iotests/130.out.bad
> 2019-10-17 11:56:43.450750873 -0400
> @@ -18,11 +18,8 @@
>  QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) commit testdisk
>  (qemu)
> -image: TEST_DIR/t.IMGFMT
> -file format: IMGFMT
> -virtual size: 64 MiB (67108864 bytes)
> -backing file: TEST_DIR/t.IMGFMT.orig
> -backing file format: raw
> +qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared "wr=
ite" lock
> +Is another process using the image [TEST_DIR/t.IMGFMT]?
>=20
>  =3D=3D=3D Marking image dirty (lazy refcounts) =3D=3D=3D
>=20
> On the host machine there don't seem to be any stray
> processes which might have held the file open, and
> indeed the file doesn't exist at all, so it got removed
> by some cleanup or other.

Ok, so unless someone has a clue what might be going on here (is there a
race in the test?), I'd suggest that we simply remove 130 from the auto
group again. Shall I send a patch?

 Thomas

