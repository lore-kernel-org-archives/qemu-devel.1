Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF40FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B359620650
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B359620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7oq-0002BV-0p
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iL6zQ-0004Nh-CG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iL6zO-0006D0-Na
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:42:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iL6zL-00069Z-Bn; Thu, 17 Oct 2019 10:42:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D41FC04D936;
 Thu, 17 Oct 2019 14:42:50 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ECDE60497;
 Thu, 17 Oct 2019 14:42:50 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] iotests: Include QMP input in .out files
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20191015193503.25591-1-eblake@redhat.com>
 <20191015193503.25591-3-eblake@redhat.com>
 <0962fe1d-df21-0efb-818a-1afabdc4fcfe@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3d3ea98f-49db-8fc4-e0df-d99a9d7963d9@redhat.com>
Date: Thu, 17 Oct 2019 09:42:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <0962fe1d-df21-0efb-818a-1afabdc4fcfe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 17 Oct 2019 14:42:50 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 7:59 AM, Max Reitz wrote:
> On 15.10.19 21:35, Eric Blake wrote:
>> We generally include relevant HMP input in .out files, by virtue of
>> the fact that HMP echoes its input.  But QMP does not, so we have to
>> explicitly inject it in the output stream, in order to make it easier
>> to read .out files to see what behavior is being tested (especially
>> true where the output file is a sequence of {'return': {}}).
>>
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>=20
> That was actually not my intention. :-)
>=20
> I was thinking of a new parameter that enables this behavior and is
> disabled by default so that existing tests don=E2=80=99t change.
>=20
> But then again I did see that you interpreted my suggestion in a
> slightly different way, and thought this is probably better, actually.

I'm glad you like how it turned out.  Now to fix the problems ;)


>> +++ b/tests/qemu-iotests/common.qemu
>> @@ -123,6 +123,9 @@ _timed_wait_for()
>>   # until either timeout, or a response.  If it is not set, or <=3D0,
>>   # then the command is only sent once.
>>   #
>> +# If neither $silent nor $mismatch_only is set, and $cmd begins with =
'{',
>> +# echo the command before sending it the first time.
>> +#
>>   # If $qemu_error_no_exit is set, then even if the expected response
>>   # is not seen, we will not exit.  $QEMU_STATUS[$1] will be set it -1=
 in
>>   # that case.
>> @@ -152,6 +155,12 @@ _send_qemu_cmd()
>>           shift $(($# - 2))
>>       fi
>>
>> +    # Display QMP being sent, but not HMP (since HMP already echoes i=
ts
>> +    # input back to output); decide based on leading '{'
>> +    if [ -z "$silent" ] && [ -z "$mismatch_only" ] &&
>> +            [ "$cmd" !=3D "${cmd#{}" ]; then
>=20
> It=E2=80=99s a shame that this breaks syntax highlighting in (my) vim. =
 (Also I
> have to admit googling to understand ${cmd#{} wasn=E2=80=99t trivial.)
>=20
> Can I persuade you to use "${cmd#\{}" instead?  That seems to work for =
me.

Yes.  That, or "${cmd#'{'}" should also work.

>=20
>> diff --git a/tests/qemu-iotests/094.out b/tests/qemu-iotests/094.out
>> index f3b9ecf22b73..f3e1a9ecf736 100644
>> --- a/tests/qemu-iotests/094.out
>> +++ b/tests/qemu-iotests/094.out
>> @@ -1,16 +1,20 @@
>>   QA output created by 094
>>   Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>   Formatting 'TEST_DIR/source.IMGFMT', fmt=3DIMGFMT size=3D67108864
>> +{'execute': 'qmp_capabilities'}
>>   {"return": {}}
>> +{'execute': 'drive-mirror', 'arguments': {'device': 'src', 'target': =
'nbd:127.0.0.1:10810', 'format': 'nbd', 'sync':'full', 'mode':'existing'}=
}
>=20
> This reminds me that we need to fix nbd=E2=80=99s $TEST_IMG to not be f=
ixed to
> port 10810.  I get intermittent failures because of that.

And I should therefore fix the filter to display it as something more=20
stable (perhaps nbd:HOST:PORT).  But I also agree that the hard-coded=20
value is pre-existing broken, so a separate patch here to improve it is=20
warranted.

>=20
> [...]
>=20
>> diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
>> index 67fe44a3e390..3857675f7ebd 100644
>> --- a/tests/qemu-iotests/140.out
>> +++ b/tests/qemu-iotests/140.out
>> @@ -2,14 +2,19 @@ QA output created by 140
>>   Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536
>>   wrote 65536/65536 bytes at offset 0
>>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +{ 'execute': 'qmp_capabilities' }
>>   {"return": {}}
>> +{ 'execute': 'nbd-server-start', 'arguments': { 'addr': { 'type': 'un=
ix', 'data': { 'path': 'TEST_DIR/nbd' }}}}
>=20
> Hmmmmm, this conflicts with my SOCK_DIR series.  common.qemu would then
> also need a SOCK_DIR filter.  Well, or 140 should filter it (and the
> other tests that are concerned).  I=E2=80=99m not 100 % sure, but a SOC=
K_DIR
> filter in common.qemu probably can=E2=80=99t hurt.

Agreed. I will rebase a v3 on top of your pending series.


>> +++ b/tests/qemu-iotests/141.out
>> @@ -2,82 +2,108 @@ QA output created by 141
>>   Formatting 'TEST_DIR/b.IMGFMT', fmt=3DIMGFMT size=3D1048576
>>   Formatting 'TEST_DIR/m.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_=
file=3DTEST_DIR/b.IMGFMT
>>   Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_=
file=3DTEST_DIR/m.IMGFMT
>> +{'execute': 'qmp_capabilities'}
>>   {"return": {}}
>>
>>   =3D=3D=3D Testing drive-backup =3D=3D=3D
>>
>> +{'execute': 'blockdev-add', 'arguments': { 'node-name': 'drv0', 'driv=
er': 'qcow2', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.qcow2' =
}}}
>=20
> 141 also supports qed, so this then results in a mismatch.  I suppose
> common.qemu should filter the image format.
>=20
> (Same for 156, 161, and 229.)

Yep, I'll have to improve the filtering.  I'll make sure I run -qed=20
tests before posting v3.

>=20
> [...]
>=20
>> diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
>> index 4c391a760371..d1865044f81a 100644
>> --- a/tests/qemu-iotests/156.out
>> +++ b/tests/qemu-iotests/156.out
>> @@ -5,21 +5,27 @@ wrote 262144/262144 bytes at offset 0
>>   256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   wrote 196608/196608 bytes at offset 65536
>>   192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +{ 'execute': 'qmp_capabilities' }
>>   {"return": {}}
>>   Formatting 'TEST_DIR/t.IMGFMT.overlay', fmt=3DIMGFMT size=3D1048576 =
backing_file=3DTEST_DIR/t.IMGFMT
>> +{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'sour=
ce', 'snapshot-file': 'TEST_DIR/t.qcow2.overlay', 'format': 'qcow2', 'mod=
e': 'existing' } }
>=20
> Same here (as said above), although there=E2=80=99s also the fact to co=
nsider
> that 156 supports generic protocols.  I hope _filter_testdir handles
> that, though.

or _filter_imgfmt.  It should not be hard to turn on extra filters, such=20
that this looks more like:

'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'format': 'IMGFMT', ...


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

