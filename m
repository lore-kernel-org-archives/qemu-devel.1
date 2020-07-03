Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C916BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9233E20826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F55Ky563"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9233E20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKck-0007Jt-Qt
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrKbh-0006Zx-Qe; Fri, 03 Jul 2020 08:15:54 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com
 ([40.107.4.130]:20307 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrKbe-0002a7-8q; Fri, 03 Jul 2020 08:15:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeSiAbTB4VrkK7KZdFE6eSZXlvc2KF0rirff71GDvnvxIPehzbFNxo5MdbSIXjlMbvyuVkQgQ+WQ0HdpLW2r098Z+FpnI79RM8CIKxp2K/MYb840bAwkWzYmkGRwhVKcinwI4avQ8B2nKLrde1VAmPfCxMcq3auiAZXjpwkdZ3WRz6dkuwbpxIGo1TOQ6IPO3uE9wvbA8Z+KmbKdF3lWGdg4JbPdP45uQKwYeWf0lRDp7Ot1+clVe/wmrOMw53+SR9H614R8qO1aNyB12mp9Ak1wiBS78lM1E+zSOYErz6/YJ8Gj9zgrmdEk42AASDb0c3rQ96ZO32NXs4Gxgm0mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yIKfZw2nTT5/RUWtDIl8w9iwAEmWm6pKs3akXMBv74=;
 b=jL4ucGHO86eE5j2UvfrwXwtSUtYmbvsi2A5U7WbKBXibk708c3cWmY13w/okdYcxkAtA/4OdHeKR8VfIZvATLD/dq8AQlEJrVVSTPtf5jo+2GJ54CotkadndM5DB/BMNPXRhEDfyaHoGQL+6+8FAGJ6IHhZlPlYqMMP3xWJGTmPV6Ivpk1C4dHxlJzwN+myHHbHlitLU228wK/n1YljQjQyLBadBhvHsTX8CtvVvCTZpj4/YnNQBmO7hjvbiuNmVqUhu58LiOKhAtw+9HaaTPY9HYvLD8oTrLk0f8dKwzdZDAhOJ/E95saGNAvqAenN1WFar57Np9CkAqaA32cRAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yIKfZw2nTT5/RUWtDIl8w9iwAEmWm6pKs3akXMBv74=;
 b=F55Ky563g+lZHGciWQlfqZh6hagnLO1h0Bb6XeWclwAyJe+uPbr/otcG9uD6QVvXERU6gyW0FUMbpGHyq/XZszFmvmVEImFYwlHPTmw5g50GMF2hxsI3yzkUVUVXpfUSfGrxQ97VUd7OlgYni/y0/Y1f0eKbwWofJTjXOvg1OaM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3895.eurprd08.prod.outlook.com (2603:10a6:20b:81::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Fri, 3 Jul
 2020 12:15:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 12:15:45 +0000
Subject: Re: [PATCH v2 13/44] qemu-option: Use returned bool to check for
 failure
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-14-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a1f551ae-1686-5811-86a1-ebca8ef28737@virtuozzo.com>
Date: Fri, 3 Jul 2020 15:15:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-14-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0083.eurprd02.prod.outlook.com
 (2603:10a6:208:154::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM0PR02CA0083.eurprd02.prod.outlook.com (2603:10a6:208:154::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Fri, 3 Jul 2020 12:15:45 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88961dda-e172-4807-a58e-08d81f4ad044
X-MS-TrafficTypeDiagnostic: AM6PR08MB3895:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3895A2AD89DE8A1FBF831196C16A0@AM6PR08MB3895.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhJCi2rwDnIvWNII1cMflBRWx3i0J777j+nIIdAoVJjNFploRcUYOqAtHMi65q+ZAE4hCOrukta5zaIBhfAOBaolMI17GECbdU808PWwM6eqshM8U8B0SXRlhw1opkfU7DNBAsMSDtt77YiXT3dYJMUjjIQJl2Nahy/bDzmDD0+By/CAjO2eJ+aawNXIWLKcF2iRLLAA0xFZiqxlAGNwzb8c2QXz+4xvTre7+/1P4j32A9zp1XbacxsneFVcaYSTP4kDzxvp5X+46RlGR9UcwJYiyeU6vEO61RB7PsB3E2m1Wzo3xNmD4tDo5vpPCrJFsWrKIP4LhcyB1Djix0EDDP3UszGJFGe+neeGTjdwEj1qEbyPcg9O+dej7taPOtlW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39840400004)(66556008)(26005)(5660300002)(478600001)(83380400001)(6486002)(66946007)(16576012)(31686004)(36756003)(8936002)(316002)(8676002)(2906002)(4326008)(956004)(2616005)(66476007)(52116002)(16526019)(186003)(31696002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6VVEd0htyt3YsjaD2C+ifoR1Z/QxCCWK7YvnF075glc7TNymJQMuCAQCeqAN496Ons9H4Q1nerZksSjy/YF4tBckk7m0/Lc55yVumSrcmJ/pk1XuvpCJ7wQ75lIyUU9c6Zx64E3OGeJJmvQ0AGcTXT5Z1l4fsdmq143mZkPDfG4gL7mULFv6GUWh4dd7opRbjebSqLo7Vn/qUubkaUN7fITC5RSCa1mZ85TTcey9Bls0ZOvmNv6/9T8HVRw6B02PY5nTQK95chehIpN2CWMvL0wMDr3B1lj4M1LX9U3v/v91wit0DkcHYRL3EyUByjxMrCXH8uKudpbLkJiiYORTkRSyh7uEZsIe0pSc4qzSP1nd5VAsZJ81gq+Jz1929tn2ZVGKii85ShrS/z3EiOG+zNbnGegiOKJUsTdmKSvgA/z6WeEMCmRFEAtotKDG81sl/n017rpKwdZZ69im/i8MMV7+EwOt5UBLPOM52bFjw9oq4mwL8Gvn7jRzOwWWKOWL
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88961dda-e172-4807-a58e-08d81f4ad044
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 12:15:45.6838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P7lv8iBd5dKTWkeYXc27oQ6cpgKk0tlHCWA+RDLKXDcL1gRNYnLw7fXVfRJV7aw0mQGnCjvAVTrAyHXZNAGCKnUPi3PQg5+rMuCjtTiz/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3895
Received-SPF: pass client-ip=40.107.4.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 08:15:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> The previous commit enables conversion of
> 
>      foo(..., &err);
>      if (err) {
>          ...
>      }
> 
> to
> 
>      if (!foo(..., &err)) {
>          ...
>      }
> 
> for QemuOpts functions that now return true / false on success /
> error.  Coccinelle script:
> 
>      @@
>      identifier fun = {opts_do_parse, parse_option_bool, parse_option_number, parse_option_size, qemu_opt_parse, qemu_opt_rename, qemu_opt_set, qemu_opt_set_bool, qemu_opt_set_number, qemu_opts_absorb_qdict, qemu_opts_do_parse, qemu_opts_from_qdict_entry, qemu_opts_set, qemu_opts_validate};
>      expression list args, args2;
>      typedef Error;
>      Error *err;
>      @@
>      -    fun(args, &err, args2);
>      -    if (err)
>      +    if (!fun(args, &err, args2))
>           {
>               ...
>           }
> 
> A few line breaks tidied up manually.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>

Improve reviewer script to cover indentation/spacing/wrapping changes:

#!/usr/bin/env python3

import sys
import re


re_remove_add = re.compile(r'(?P<remove>(^-.*\n)+)(?P<add>(^\+.*\n)+)',
                            flags=re.MULTILINE)
re_remove = re.compile(r'(?P<func_call>(?P<func>\w+)\(.*,&(?P<err>\w+)\));'
                        r'if\((?P=err)(!=NULL)?\)\{')
re_add = re.compile(r'if\(!(?P<func_call>.*)\)\{')
all_functions = set()


def check_subchunk(subchunk):
     """check subchunk

     Check that subchunk matches
         - func(args..., &err);
         - if (err) {
         + if (!func(args..., &err)) {
     ignoring indentation and spaces

     Also, while being here, register each found func in all_functions.
     """
     m = re_remove_add.fullmatch(subchunk)
     if not m:
         return False

     remove = re.sub(r'^-', '', m.group('remove'), flags=re.MULTILINE)
     remove = re.sub(r'\s', '', remove)

     add = re.sub(r'^\+', '', m.group('add'), flags=re.MULTILINE)
     add = re.sub(r'\s', '', add)

     m = re_remove.fullmatch(remove)
     if not m:
         return False

     all_functions.add(m.group('func'))
     func_call = m.group('func_call')

     m = re_add.fullmatch(add)

     if not m:
         return False

     return func_call == m.group('func_call')


with open(sys.argv[1]) as f:
     patch = f.read()

# Drop patch header
patch = re.sub('^.*?^---$.*?^diff', 'diff', patch,
                flags=(re.MULTILINE | re.DOTALL))

# Drop patch footer
patch = re.sub(r'^-- *\n(\d+\.)+\d+\s*\Z', '', patch, flags=re.MULTILINE)

files = re.split(r'(^diff .*\n'
                  r'^index .*\n'
                  r'^--- .*\n'
                  r'^\+\+\+ .*)\n', patch, flags=re.MULTILINE)

assert files[0] == ''
del files[0]

subchunk_re = re.compile(r'(^[+-].*\n)+', flags=re.MULTILINE)

all_ok = True
for i in range(0, len(files), 2):
     file = files[i]
     patch = files[i + 1]
     print_caption = True

     for chunk in re.split('^@', patch, flags=re.MULTILINE):
         if not all(check_subchunk(m.group(0))
                    for m in subchunk_re.finditer(chunk)):
             if print_caption:
                 print(file)
                 print_caption = False
             print(chunk)
             all_ok = False

if all_ok:
     print('ALL OK.\nfound functions:\n')
     print('\n'.join(list(all_functions)))



====
run it:
# ./check2.py /work/nfs_share/patches/markus/errors/v2/\[PATCH\ v2\ 13_44\]\ qemu-option\:\ Use\ returned\ bool\ to\ check\ for\ failure\ -\ Markus\ Armbruster\ \<armbru@redhat.com\>\ -\ 2020-07-02\ 1849.eml
ALL OK.
found functions:

qemu_opt_set_bool
qemu_opts_do_parse
qemu_opt_set
qemu_opts_absorb_qdict
qemu_opt_parse
qemu_opt_rename
qemu_opts_validate
parse_option_size
qemu_opts_from_qdict_entry
opts_do_parse

functions seems to have corresponding semantics, all chunks are valid:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

