Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD60FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985AC206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GdHkiIPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985AC206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj1Dd-0002TM-UP
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj19L-0006hq-3m; Wed, 10 Jun 2020 09:52:15 -0400
Received: from mail-vi1eur05on2113.outbound.protection.outlook.com
 ([40.107.21.113]:54881 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj19I-0005sW-76; Wed, 10 Jun 2020 09:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaHZvB4p2e4AdWxRHXJ8NdRwJdBSDQcc+y7PZpMp+/SqUBISoXdHvj4bFivM3Gmglk4MjrZkLq8mweYTk2W0Zu2Q51nqPEeCmTyrS59jDgT9csf8+q69OwMQQqXha4P/dwSSrxVZfurhvzG+1bprrLFnVxpSNJMM4UNFjw3Q+fSbHUnhlt73XmCUnlB/NSx0fxUuI0f7miVVB262UpH0rzBo/zJlUafUK7vj80QoZl43nUo1Bfjv/mHB7gAqLkGFl+eout8zuPU5YauOljVx4nR49lFiK84ItWKClUz27PyXpjqR/IygawBwV5LrRWZ+MBmZL0m6cfRCg7eY6k7Jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTIlBfDlmkg7z/18aDIbAYE+uB/rswrg0Y6+/s4YSuE=;
 b=bOXDJwucwH4prLFHYUHspYQuyDRrAN9EX7L31ecuJcZHqC6/iAb+/dPzgNO+w9oAqVC5znsG21/21MchcKzlnCjyUf7wBfKi4CMrZ8H28QBH0rMw9IbDA6o/nVZQ0UYOBdn5HvnkuxckLfiWj2QFPN9hmA+1Z9fS7NnoAODlknnl2VuTT498YYtOSIxkRAmPz+Ha7ZHQdwbpo3v0qrd9m60CA2lN5bTDtYk2RlaonVK/5tsy6SiIxX1tCSA2ed8JE0fXfc9fRFJP5pNbJ1vdmg2Z7EgyjNBk4e1z6jt4gwFOrbde4cofRqglYCRCBnKFRPQt8oza4egfX2SaK2PzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTIlBfDlmkg7z/18aDIbAYE+uB/rswrg0Y6+/s4YSuE=;
 b=GdHkiIPjepAhqv2CUpiA5PLWOLk4aVXIwBZxiS74CXR2CNk4aNDFvPU+4FpHG9fVYuyc2+8XERc2dAlYIvT27qwWGCjd181ctMo8bdoCOwuIeW4qyb74hyNM7zTGkINroPW8CwfIqnjtFWyH/hJB6iSv6dlCSV7cXzShlKnU9/0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Wed, 10 Jun
 2020 13:52:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 13:52:08 +0000
Subject: Re: [PATCH 1/2] nbd/server: Avoid long error message assertions
 CVE-2020-10761
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200608182638.3256473-1-eblake@redhat.com>
 <20200608182638.3256473-2-eblake@redhat.com>
 <678021fb-d34d-4067-31b3-f864efe13dbd@virtuozzo.com>
 <5a8ce391-a16e-1af9-78bb-8e1aab5b213c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b990bfe3-c72d-801e-99e9-d2f3f9b77402@virtuozzo.com>
Date: Wed, 10 Jun 2020 16:52:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <5a8ce391-a16e-1af9-78bb-8e1aab5b213c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 13:52:07 +0000
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 660e7486-b92e-40e4-e54f-08d80d45777c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-Microsoft-Antispam-PRVS: <AM7PR08MB55265BF0B3753F41316B50FAC1830@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKg4eD6yYLZ+cP6TuQFjCHRsoTGdUvpoI1UxfUBw0NUoAKZuKOa6NpbedQ/UBt8N+gpRQseEflFIPBZ1835QxI49QJNX1Kz3+XO0YnZjk6qI8LgknKhxlaDvcd7/gZnkGi9w6rPHEjRoWZshGpaEazJ8VjGwsLE8aBIRxmY4E/3L2q15b4oRfQAarLh9kqAPBzqHjUNFtObrIzBUpS9M9EkXsDeWRpTLDFj5ZAFJfqHix6RTQ6bRG2cKsk5Ly/u5xZhTkll/OUHC31y1FTIYg4naiRbg/9BEi0fad6ywuRG8R3eSfgFukZ5EnqOD/2B3cTJPD9Z2kvetRQnkVMZtK+5+/ExWevKbB4UVKjELrtut4v96GMrUt9xbR0WSMsheQy9o1n8c9NPFwWc5yDrOzLInlQ9QXDRrF3flPihcEDvHbzR6ofYrXvFzAQBxOBaEeh3gLLx5bVYe2h/B6Hf3bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39840400004)(376002)(346002)(6486002)(52116002)(8936002)(86362001)(16576012)(31696002)(83380400001)(16526019)(316002)(54906003)(4326008)(8676002)(478600001)(966005)(26005)(186003)(15650500001)(53546011)(956004)(66946007)(66476007)(36756003)(31686004)(66556008)(5660300002)(2906002)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MdLwrHrzVCb9DWrc2aFuXAZfOb0l6H6+R4s9iI48PD6nf5h4GIrqKN3VpnhykpHf40OKiYspT17Rw/ggo1xeRM8W4nmWsapelVGZo7oJmD9CTJJ+zmTwnpnoWTP8DPAZqPeXxAfmycSHGQg302vrfp6LPxYt4lfoIW+9mfAkDSbWix9F2FZrzp4+jHy1TheDeyRND6mZWkkFyFF0dPJ4JFlsmqUlqgn3OfhhwpfRN1P1FKSX3wc9fKW3igI6XpBv0cJUsx9eSwJguI3QU5BsCdr2NDsTWRm9N2KfgLjivV+TmIp++kel6kiRYLcKfvN3Ilm/Zlk7wSQqcw2TuRjbKbCKUQEEKj8pifaN70m42p55N/LZBJYBDJ4RMWWmunl8YQOzIvCkfRis0CQjkoSJLCujNGOKGYlYeGHUF0Yf5j8DnwBwVqTgO3gPoyjjlNb8LpwoOBKEZmUiPNv0WNXOW9A69aonqTqGHLhH98rZkIhuvHy5GPFqKI21fglB7z8r
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660e7486-b92e-40e4-e54f-08d80d45777c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 13:52:08.2250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6Ybow22UDdePPfbQghl344AU8Fib+NmqO9JrT63pbaPdBmfIrOUcZZw6y7nj2zvLL+Za4mqSFtfsSQ35s4XACUuHwO7KPRybNg/5Cow9FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
Received-SPF: pass client-ip=40.107.21.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:52:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, ppandit@redhat.com,
 xuwei@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.06.2020 16:39, Eric Blake wrote:
> On 6/10/20 3:57 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 08.06.2020 21:26, Eric Blake wrote:
>>> Ever since commit 36683283 (v2.8), the server code asserts that error
>>> strings sent to the client are well-formed per the protocol by not
>>> exceeding the maximum string length of 4096.  At the time the server
>>> first started sending error messages, the assertion could not be
>>> triggered, because messages were completely under our control.
>>> However, over the years, we have added latent scenarios where a client
>>> could trigger the server to attempt an error message that would
>>> include the client's information if it passed other checks first:
>>>
>>> - requesting NBD_OPT_INFO/GO on an export name that is not present
>>>    (commit 0cfae925 in v2.12 echoes the name)
>>>
>>> - requesting NBD_OPT_LIST/SET_META_CONTEXT on an export name that is
>>>    not present (commit e7b1948d in v2.12 echoes the name)
>>>
>>> At the time, those were still safe because we flagged names larger
>>> than 256 bytes with a different message; but that changed in commit
>>> 93676c88 (v4.2) when we raised the name limit to 4096 to match the NBD
>>> string limit.  (That commit also failed to change the magic number
>>> 4096 in nbd_negotiate_send_rep_err to the just-introduced named
>>> constant.)  So with that commit, long client names appended to server
>>> text can now trigger the assertion, and thus be used as a denial of
>>> service attack against a server.  As a mitigating factor, if the
>>> server requires TLS, the client cannot trigger the problematic paths
>>> unless it first supplies TLS credentials, and such trusted clients are
>>> less likely to try to intentionally crash the server.
>>>
>>> Reported-by: Xueqiang Wei <xuwei@redhat.com>
>>> CC: qemu-stable@nongnu.org
>>> Fixes: https://bugzilla.redhat.com/1843684 CVE-2020-10761
>>> Fixes: 93676c88d7
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>   nbd/server.c               | 28 +++++++++++++++++++++++++---
>>>   tests/qemu-iotests/143     |  4 ++++
>>>   tests/qemu-iotests/143.out |  2 ++
>>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/nbd/server.c b/nbd/server.c
>>> index 02b1ed080145..ec130303586d 100644
>>> --- a/nbd/server.c
>>> +++ b/nbd/server.c
>>> @@ -217,7 +217,7 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
>>>
>>>       msg = g_strdup_vprintf(fmt, va);
>>>       len = strlen(msg);
>>> -    assert(len < 4096);
>>> +    assert(len < NBD_MAX_STRING_SIZE);
>>>       trace_nbd_negotiate_send_rep_err(msg);
>>>       ret = nbd_negotiate_send_rep_len(client, type, len, errp);
>>>       if (ret < 0) {
>>> @@ -231,6 +231,27 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
>>>       return 0;
>>>   }
>>>
>>> +/*
>>> + * Truncate a potentially-long user-supplied string into something
>>> + * more suitable for an error reply.
>>> + */
>>> +static const char *
>>> +nbd_truncate_name(const char *name)
>>> +{
>>> +#define SANE_LENGTH 80
>>> +    static char buf[SANE_LENGTH + 3 + 1]; /* Trailing '...', NUL */
>>
>> s/NUL/NULL/
> 
> NULL is the pointer (typically 4 or 8 bytes); NUL is the character (exactly one byte in all multi-byte-encodings like UTF-8, or sizeof(wchar_t) when using wide characters).
> 
>>
>> Hmm. It may break if we use it in parallel in two coroutines or threads.. Not sure, is it possible now, neither of course will it be possible in future.
> 
> After some testing (including adding some temporary sleep() into the code), it looks like 'qemu-nbd -e 2' is currently serialized (we don't start responding to a second client until we are done negotiating with the first); on that grounds, we are not risking that information leaks from one client to another.  But you are correct that it is not obvious, and that if we do have a situation where two threads can try to allow an NBD connection, then this static buffer could leak information from one client to another.  So I'll need to post a v2.
> 
>>
>> I'd avoid creating functions returning  instead use g_strdup_printf(), like
>>
>> char *tmp = g_strdup_printf("%.80s...", name);
>>
>>    ( OR, if you want explicit constant: g_strdup_printf("%.*s...", SANE_LENGTH, name) )
>>
>> ... report error ...
>>
>> g_free(tmp)
>>
>> Using g_strdup_printf also is safer as we don't need to care about buf size.
> 
> malloc'ing the buffer is not too bad; error messages are not the hot path. I'll change it along those lines for v2.
> 
>>> @@ -996,7 +1017,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>>>       meta->exp = nbd_export_find(export_name);
>>>       if (meta->exp == NULL) {
>>>           return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
>>> -                            "export '%s' not present", export_name);
>>> +                            "export '%s' not present",
>>> +                            nbd_truncate_name(export_name));
>>>       }
>>>
>>
>> Hmm, maybe instead of assertion, shrink message in nbd_negotiate_send_rep_verr() too?
>> This will save us from forgotten (or future) uses of the function.
> 
> Truncating in nbd_negotiate_send_rep_verr is arbitrary; it does not have the context of what makes sense to truncate.  With an artificially short length, and a client request for "longname_from_the_client", the difference would be between:
> 
> export "longnam..." not present
> export "longname_from_the_cl...
> 
> As a user, I prefer the first form, but truncating in nbd_negotiate_send_rep_verr is the second form.
> 
>>
>> Shrinking name is better, as it provides better message on result. But generally shrink
>> all two long messages in nbd_negotiate_send_rep_verr() (maybe, together with error_report())
>> seems a good thing for me.
> 
> What would error_report() accomplish?  Logging on the server that we are truncating a message sent back to the client doesn't help the client. This is not a case of protocol violation, and a server sending an error message to the client is not out of the ordinary.
> 

I mean the following:

If we have too long message in nbd_negotiate_send_rep_verr() it's a bug, and assertion is correct. But in this particular case, It seems better to use error_report() instead of assertion and shrink the message for client, just to avoid similar CVEs in future. So if the situation will come again (we call nbd_negotiate_send_rep_verr() from some new place, forgetting to check length of user-provided part of the message) it will not be a CVE but just user will have not-well-formed message and we'll have errror-report in server log.

-- 
Best regards,
Vladimir

