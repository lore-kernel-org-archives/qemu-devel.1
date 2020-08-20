Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B7BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFDC2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Llrf9U7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFDC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8rq0-000812-0s
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 17:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8rp0-0007Rw-OB; Thu, 20 Aug 2020 17:10:06 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:25070 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8rox-0004kV-5u; Thu, 20 Aug 2020 17:10:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+XEophCQjZf0IYhr3CHse7uskgUjvmCVuJfUiuMA4zwZOs4MCyXPCoVdqoAtKHmlv6iOwT2sRtQuKYtnZ8aKraAWQktkF3BNHU6acHUUIPBswHgqKbHlMcIu7x6afF0EOGWzVEYIZevzabCAYPpn6rReSX39ReZCXDfoaTOENTb7mu4ojPRh9rJi/3QZOb10H6Zz9dDDI8ryooC9ta7aUFwdl+Of9w3yijmUd0tharFW4ZDzfgKc8S98ASD+ZRyimT6oEk0l/GOSDe+iEOV8k9yShU8gWAR7skIcoujITl6LOZUKdaHBv20whrJkTwnjMIKy2fv5Y7MgNjvTVxoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7m/GssqI3O7hXfCXItLtUrqn/FJbj+UiuqkD+fU4tQ=;
 b=hKlzYWM2XD0CdBNO0VPxmNioop34wHFk3a1VVQyMWCs8zEaYI6SBbF98rCHNa0VSAxif9EFZJ7JWretKe9pd7bxb0cuZdGRzGfQtmOnZIGGav4noIQnSEGY1fBq95zBSmaHC4besHYA8Jk0taFrb95WVWrENfMyu/ronSd4U2sVe9zbV9bFVGKrJ3ghc+56Nlizx1UqfTBt+RaHYxhwnxwmtZ6ZnoD3V75vd3tMQa0iWjlg/t02OJjgo62GcFGnkawaca0UreQCsRLmBiJsraRxhE/cYe7Aa31l7MpMjtjy3thLkIttSHC/ZJYaAx7CMv4QPJBIRMjVUOmDHvzpeYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7m/GssqI3O7hXfCXItLtUrqn/FJbj+UiuqkD+fU4tQ=;
 b=Llrf9U7yi781AJY2syx6OsssFRiZxSh75Hkr4m6Ap51RhwGogyh/e+SZ0gI8/VFNyCYGWwwtpCWLYbKlNtdQm49tiSmKGxANzO8XjsWQsH/U89HdBq9BcXk5R7lRxUWVYNY4S1MkfRSg+JkuODkahDeDsQiI76bs8UZQWMWwfDI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4692.eurprd08.prod.outlook.com (2603:10a6:20b:d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 20 Aug
 2020 21:09:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 21:09:54 +0000
Subject: Re: [PATCH v4 08/10] iotests.py: add verify_o_direct helper
To: Nir Soffer <nsoffer@redhat.com>
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
 <20200820183950.13109-9-vsementsov@virtuozzo.com>
 <CAMRbyyvpPyu9ONLUVax_xssXaS5f2O5pkaK7um0X7dWbng=2Jw@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fcb17574-8c8e-f823-31c7-08e7a650559e@virtuozzo.com>
Date: Fri, 21 Aug 2020 00:09:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <CAMRbyyvpPyu9ONLUVax_xssXaS5f2O5pkaK7um0X7dWbng=2Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0107.eurprd05.prod.outlook.com
 (2603:10a6:207:1::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM3PR05CA0107.eurprd05.prod.outlook.com (2603:10a6:207:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 21:09:53 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82bf8855-6852-4a74-3a33-08d8454d6254
X-MS-TrafficTypeDiagnostic: AM6PR08MB4692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB46921606B1E2DEE0F5C54AA8C15A0@AM6PR08MB4692.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmf3IPYpH/UiZB7QZgZt9bam7Y0vWxeL4fgSzjS/my9YqQ62szY6bmJgB8Y2xX1bxewX2Rez8Wluh2c9KwBhTgrxqCTy6S/tXObyHAeWPQlqFeezraS78gWGykQqzLMadH0K1Iwsk0iRccR8a7CYUjia3y6rQZ0NKSRfD3U3qyVDatYVysoNDovwssB0N7m9z853KMwJnMvD6vDG1byiw/7cr7VLtoORovy/qOY4FHM1Epl8B6rDbs7peSpdFPtH20Mw6C2VlMlNC6KjzgosB7cssP07U/G99Xd+8FeDEcvhngTXrLf/G3OnvUOKNW+ImHpWa9OF6bZXyIIrntvFeJUjxMYoNYbE6WZl/HDUv7I9rbyvzRexnS8/uvrMkA5Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(136003)(346002)(376002)(6486002)(8936002)(16526019)(186003)(107886003)(52116002)(5660300002)(31696002)(54906003)(316002)(53546011)(16576012)(15650500001)(83380400001)(4326008)(6916009)(2616005)(66946007)(66556008)(36756003)(26005)(956004)(66476007)(2906002)(8676002)(478600001)(31686004)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lM0WBVRdZuOeuYYtX2wPI+s6dE/wJgtqFtXKsrR9RVseViKGeBANQuPfuma+GgcFZTh1FJKTlIYipAR7wUHzPXgI7ZysPVcISnLbau3P7sG39dOOnD1cUaIyq7nYFpzj3gjwKXL3Gvw/HJNg4Y6jMw4b0o8r9tFyhYySM7vbhLWLNc1C+asL+GripaxoMM1U8eMKbjy/aqVyIhyadSsr9aXgKqBahZ1xhbcSZl4Lniscsw8RQqU3yNsMiDkdMZgk2Hl8M6Tbc/61MmyRodMB7r3X2UHgpjIV7JONpULcoaRklLnEpqxnjIp4lZQpqr4/VbtrJTRH+v+YfQN6ht9Tx+nk5wgRkEPc5asJVJUn49C2bkJiY22YtwLzLEV4ispK3PnTz4LmcGQGkuvQzAmPLq9Sg0MbOnlLGPkUD+gCTcvMkMCs/LIcvnsUH7rwj56AyRZ4x8199RuL/si7xgI7Z7g7qb697gLhxc0vS+H28aUKdvZTJA4j7rk1/mzFn3xDCyL7WuDIBLhFF98wXeCvYZrhN5+ugiSbldiqDsgxoyJqGyDgPTW7/XJGWmW/IQGUiZ9RQ3TNSzcC+pgmHAHTSdzhj+bb6/unTl5HYMQCzR+emW5whYJO6iSjnfvxmcxDsSvw4Yo1ixszh/thGvd+Xg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bf8855-6852-4a74-3a33-08d8454d6254
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 21:09:53.9252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Q+LnfGFqj1pef1Fqav8Mh/WWfTnvBcYG4f3X7HEnsNDEDM33XsQDpiRJkZZSG25poh+gbd/3ommhdeQaG9lGwkODOsvozH5FXzVjmVUkBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4692
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 17:09:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.08.2020 00:00, Nir Soffer wrote:
> On Thu, Aug 20, 2020 at 9:49 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
>>
>> Add python notrun-helper similar to _check_o_direct for bash tests.
>> To be used in the following commit.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   tests/qemu-iotests/iotests.py | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>> index 717b5b652c..369e9918b4 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -1083,6 +1083,12 @@ def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()) -> None:
>>       if supported_aio_modes and (aiomode not in supported_aio_modes):
>>           notrun('not suitable for this aio mode: %s' % aiomode)
>>
>> +def verify_o_direct() -> None:
>> +    with FilePath('test_o_direct') as f:
>> +        qemu_img_create('-f', 'raw', f, '1M')
>> +        if 'O_DIRECT' in qemu_io('-f', 'raw', '-t', 'none', '-c', 'quit', f):
>> +            notrun(f'file system at {test_dir} does not support O_DIRECT')
> 
> Why not:
> 
>      with FilePath('test_o_direct') as f:
>          try:
>              fd = os.open(f, os.O_DIRECT | os.O_CREAT | os.O_RDWR)
>          except OSError as e:
>              if e.errno != errno.EINVAL:
>                  raise
>              notrun(...)
>          else:
>             os.close(fd)
> 
> More verbose, but the intent is more clear, and we do not depend on the output
> of qemu-io which is not a public API. For example if someone improves qemu-io
> to fail with:
> 
>      Direct I/O is not supported
> 
> It would break the tests using this helper.
> 

Agree, that's better. Will use it, thanks!

> 
>> +
>>   def supports_quorum():
>>       return 'quorum' in qemu_img_pipe('--help')
>>
>> --
>> 2.21.3
>>
>>
> 


-- 
Best regards,
Vladimir

