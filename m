Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C08C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F4008206F5
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lpf/ZbFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4008206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLioY-0002AX-4y
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 03:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLins-0001kx-6g
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLinq-0006S1-On
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:37:48 -0400
Received: from mail-eopbgr70110.outbound.protection.outlook.com
 ([40.107.7.110]:25383 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLinq-0006QV-GU; Tue, 07 Apr 2020 03:37:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg6Kremn5z6o9gvtt/irTVVAw1B+Ap2mBo95DRoaiHYZCT14J71ju2tMLkPBdLEUKdY9TWhL3QbazFjN7KwtoN4ToYKgY7h57OM/ige/h+c1Gi1m3uqZerE1ZzDGkG/6bcFvD6+grlwefmO+60oYVA1KjDf/QGiJ2HwoR9mP+wvX0LS/caLTCTBKxyzTvl0PHnkS/jPGaPjvYdwG0NhB9vS39E0a/WwYyuqnMxDMvOkzCZpLXjiZt12t6T7MRe2PGShDf1AzNb/8lljUHFBKHBXZcTxGFgcEZTDA7K59YkmH44wQjPm/2sd94cJ3oD0kDUiEE/zePIFc0iLszhr5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNTGBsQQ/wncu5GU2bckT/ajX/bBwux9uikC5E7CZeY=;
 b=AyanjHCQdxfie2frg2VZgSpBCEjs4Nf751ON50nHI5C2NKhxZQ1eWvcVOrUpK0wu5MdRfqUttWLDoC9sRON6df+x+0Tenc68jGnvQgBBiigiwGjT1nydZdDolSmAeA484vfavHqf/HjrBaAmQTSC4XaM0i4qUxsJgNx0CJx3brUhja0SeJumouWOo45oOtgO3op3GbA2Dc97x1WLn4iRpSGc8dFPEx1KxtoiBWP4GZcCxPL5IfDFcqYaED3iYRxwI4RDOUx1pTtkvpKRm8wP5uA0WTsqz34P4dP3vHF7Kt3nSnEswozreMPg8Ox1fPutg0trTQ3D0G0GphCbiqXP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNTGBsQQ/wncu5GU2bckT/ajX/bBwux9uikC5E7CZeY=;
 b=lpf/ZbFXMxp/tS43Eymfh3qXhe3uhVqI3qSexuOovT7Fc9KV/s6SvqpdB3NAgwUGZC3CjRPTsKvMBB45r4STIoCkMwQZBNhtkKnisokcqv1e4EDOVwX4dnkeLvFaDlGhO6oEjVLnqvY/bbcFlES4VBGPBvqhlr6D6k9OPhR3MX0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.174.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Tue, 7 Apr 2020 07:37:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 07:37:43 +0000
Subject: Re: [PATCH v2 2/2] iotests: rework test finding
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200325102131.23270-1-vsementsov@virtuozzo.com>
 <20200325102131.23270-3-vsementsov@virtuozzo.com>
 <d3ff5ccf-88cc-5be7-d56c-49f394c0ba23@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407103741454
Message-ID: <c6f04077-1d17-2292-286c-35553cc19317@virtuozzo.com>
Date: Tue, 7 Apr 2020 10:37:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <d3ff5ccf-88cc-5be7-d56c-49f394c0ba23@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P194CA0063.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM6P194CA0063.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Tue, 7 Apr 2020 07:37:42 +0000
X-Tagtoolbar-Keys: D20200407103741454
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64d64bf3-9539-4a45-e9fa-08d7dac68ebf
X-MS-TrafficTypeDiagnostic: AM7PR08MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB535208DB44A11F019EFF8E3DC1C30@AM7PR08MB5352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(39840400004)(376002)(8936002)(86362001)(8676002)(186003)(66946007)(66556008)(66476007)(16526019)(31696002)(81156014)(81166006)(6486002)(2616005)(956004)(478600001)(31686004)(2906002)(5660300002)(316002)(36756003)(4326008)(52116002)(16576012)(53546011)(26005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBOd4VdKELmZ7a9DQKZBt0bXEoCyKLRU4nPSDTv7ypjT3MuuUp6FLAGMM1i3OMsALh9Znkqn0/3c2Jkb7uoS+0SPCMuIm0VAGJIfWVtB9pmRYp/cz0BpDEpLCYXnGqDrVbxcVwtDy3i3MPYlpF+kyAFfMLNaSWyJibcEmSXD45cnxFEpujPFR8Lk5qOFfcE+Z1p9RiZ41oJfr9sw/ZdN0dM4ljkt0XK/rtcJOfv6Cvj4OKUuI6f8FejUUWTQISauB+q2oAfytkzm4jBi7WTppCbzAJJ2Oa4cA4UhjqOHB5myKD2VU8gwtJJrxT0fK6fPvOLn/qTIIyiC5ax16/PBAVHCFkxl7P6J9XLD2UwTpfb57X3rzPkZ9I0u7aWVbsIE95A+VlXEo6Wsy30U3B/RlxM17SYy3elcnz5hB5b43eoqjAqJfLBJUQqewrlnak+j
X-MS-Exchange-AntiSpam-MessageData: j5t27e6Rsa3amu52RE7jaR4KhikG83+46NOjVZ1rdUdPy7FJnJ9ONDfFhbuM+THQ+JGbx0NfSYdnla2HxZVSNA3gV6pP0Y9QWwBXk1Ikn2nwn7HkDd1FDdw0H++qmq8CkHpnNYg0Wkl0uXuAnG3x1w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d64bf3-9539-4a45-e9fa-08d7dac68ebf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 07:37:43.0979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMk8ZTyPXWka2ROQ36K5P5CbQkBsbE9iI/fuSRvwo06CYiD4BhjkPB6oK1Tdm1rFc+tL9UauxzXUKc41fDzkZ6c+Th8bnm6A2sQ3UibnCKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.110
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.04.2020 16:02, Max Reitz wrote:
> On 25.03.20 11:21, Vladimir Sementsov-Ogievskiy wrote:
>> Add python script with new logic of searching for tests:
>>
>> Old behavior:
>>   - tests are named [0-9][0-9][0-9]
>>   - tests must be registered in group file (even if test doesn't belong
>>     to any group, like 142)
>>
>> New behavior:
>>   - group file is dropped
>>   - tests are searched by file-name instead of group file, so it's not
>>     needed more to "register the test", just create it with name
>>     test-*. Old names like [0-9][0-9][0-9] are supported too, but not
>>     recommended for new tests
>>   - groups are parsed from '# group: ' line inside test files
>>   - optional file group.local may be used to define some additional
>>     groups for downstreams
>>   - 'disabled' group is used to temporary disable tests. So instead of
>>     commenting tests in old 'group' file you now can add them to
>>     disabled group with help of 'group.local' file
>>
>> Benefits:
>>   - no rebase conflicts in group file on patch porting from branch to
>>     branch
>>   - no conflicts in upstream, when different series want to occupy same
>>     test number
>>   - meaningful names for test files
>>     For example, with digital number, when some person wants to add some
>>     test about block-stream, he most probably will just create a new
>>     test. But if there would be test-block-stream test already, he will
>>     at first look at it and may be just add a test-case into it.
>>     And anyway meaningful names are better and test-* notation is
>>     already used in tests directory.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   docs/devel/testing.rst           |  51 +++++-
>>   tests/qemu-iotests/check         |  20 +--
>>   tests/qemu-iotests/find_tests.py |  72 ++++++++
>>   tests/qemu-iotests/group         | 298 -------------------------------
>>   4 files changed, 132 insertions(+), 309 deletions(-)
>>   create mode 100755 tests/qemu-iotests/find_tests.py
>>   delete mode 100644 tests/qemu-iotests/group
>=20
> [...]
>=20
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index f7a2d3d6c3..09b2ced2f0 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -168,9 +168,7 @@ do
>>       if $group
>>       then
>>           # arg after -g
>> -        group_list=3D$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "=
/^[0-9][0-9][0-9].* $r /"'{
>> -s/ .*//p
>> -}')
>> +        group_list=3D$(./find_tests.py "$r")
>>           if [ -z "$group_list" ]
>>           then
>>               echo "Group \"$r\" is empty or not defined?"
>> @@ -193,10 +191,8 @@ s/ .*//p
>>       then
>>           # arg after -x
>>           # Populate $tmp.list with all tests
>> -        awk '/^[0-9]{3,}/ {print $1}' "${source_iotests}/group" > $tmp.=
list 2>/dev/null
>> -        group_list=3D$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "=
/^[0-9][0-9][0-9].* $r /"'{
>> -s/ .*//p
>> -}')
>> +        ./find_tests.py > $tmp.list 2>/dev/null
>> +        group_list=3D$(./find_tests.py "$r")
>>           if [ -z "$group_list" ]
>>           then
>>               echo "Group \"$r\" is empty or not defined?"
>> @@ -486,10 +482,14 @@ testlist options
>>               fi
>>               ;;
>>  =20
>> -        *)
>> +        [0-9]*)
>>               start=3D$r
>>               end=3D$r
>>               ;;
>> +        *)
>=20
> Should this be test-*, or do we really want to allow any filename here?
>=20
>> +            echo $r >> $tmp.list
>> +            xpand=3Dfalse
>> +            ;;
>>  =20
>>       esac
>>  =20
>> @@ -504,7 +504,7 @@ testlist options
>>   BEGIN        { for (t=3D'$start'; t<=3D'$end'; t++) printf "%03d\n",t =
}' \
>>           | while read id
>>           do
>> -            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev/nu=
ll
>> +            if (./find_tests.py | grep "$id")
>=20
> I... Actually have no idea what this loop is supposed to do, but
> couldn=92t we cache the find_tests.py output?
>=20
>>               then
>>                   # in group file ... OK
>>                   echo $id >>$tmp.list
>> @@ -566,7 +566,7 @@ else
>>           touch $tmp.list
>>       else
>>           # no test numbers, do everything from group file
>> -        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$source_i=
otests/group" >$tmp.list
>> +        find_tests.py > $tmp.list
>>       fi
>>   fi
>>  =20
>=20
> The modifications to check seem a bit too tame to me.  Can=92t we do some
> more radical changes to drastically reduce the complexity of the check
> script and move it to the new Python script?  Do we need the whole code
> to handle a number of groups and excluded groups there?  Can=92t we just
> give the Python scripts a list of groups to include and a list of groups
> to exclude and let it handle the rest?

Okay.. It is inevitable. I will)

>=20
>> diff --git a/tests/qemu-iotests/find_tests.py b/tests/qemu-iotests/find_=
tests.py
>> new file mode 100755
>> index 0000000000..5de0615ebc
>> --- /dev/null
>> +++ b/tests/qemu-iotests/find_tests.py
>> @@ -0,0 +1,72 @@
>> +#!/usr/bin/env python3
>> +
>> +import os
>> +import glob
>> +from collections import defaultdict
>> +
>> +
>> +class TestFinder:
>> +    def __init__(self):
>> +        self.groups =3D defaultdict(set)
>> +        self.all_tests =3D glob.glob('[0-9][0-9][0-9]')
>> +
>> +        self.all_tests +=3D [f for f in glob.iglob('test-*')
>> +                           if not f.endswith('.out')]
>> +
>> +        for t in self.all_tests:
>> +            with open(t) as f:
>> +                for line in f:
>> +                    if line.startswith('# group: '):
>> +                        for g in line.split()[2:]:
>> +                            self.groups[g].add(t)
>> +
>> +    def add_group_file(self, fname):
>> +        with open(fname) as f:
>> +            for line in f:
>> +                line =3D line.strip()
>> +
>> +                if (not line) or line[0] =3D=3D '#':
>> +                    continue
>> +
>> +                words =3D line.split()
>> +                test_file =3D words[0]
>> +                groups =3D words[1:]
>> +
>> +                if test_file not in self.all_tests:
>> +                    print('Warning: {}: "{}" test is not found. '
>> +                          'Skip.'.format(fname, test_file))
>> +                    continue
>> +
>> +                for g in groups:
>> +                    self.groups[g].add(test_file)> +
>> +    def find_tests(self, group=3DNone):
>> +        if group is None:
>> +            tests =3D self.all_tests
>=20
> Should we exclude the disabled group here?

Hmm, yes we should.

>=20
>> +        elif group not in self.groups:
>> +            tests =3D []
>> +        elif group !=3D 'disabled' and 'disabled' in self.groups:
>> +            tests =3D self.groups[group] - self.groups['disabled']
>> +        else:
>> +            tests =3D self.groups[group]
>> +
>> +        return sorted(tests)
>> +
>> +
>> +if __name__ =3D=3D '__main__':
>> +    import sys
>> +
>> +    if len(sys.argv) > 2:
>> +        print("Usage ./find_tests.py [group]")
>> +        sys.exit(1)
>> +
>> +    tf =3D TestFinder()
>> +    if os.path.isfile('group'):
>> +        tf.add_group_file('group')
>=20
> So is it =93group=94 or =94group.local=94? :)

oops.

>=20
> Max
>=20
>> +
>> +    if len(sys.argv) =3D=3D 2:
>> +        tests =3D tf.find_tests(sys.argv[1])
>> +    else:
>> +        tests =3D tf.find_tests()
>> +
>> +    print('\n'.join(tests))
>=20


--=20
Best regards,
Vladimir

