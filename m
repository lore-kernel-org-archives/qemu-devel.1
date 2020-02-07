Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37938C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5E420726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5E420726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01ql-0007LN-9d
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j01pi-0005NE-D0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j01ph-0006iE-8D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:30:02 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:32969)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j01pg-0006hW-VA; Fri, 07 Feb 2020 06:30:01 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M89P3-1ivv5r35jn-005HrD; Fri, 07 Feb 2020 12:29:56 +0100
Subject: Re: [PATCH] vl: Abort if multiple machines are registered as default
From: Laurent Vivier <laurent@vivier.eu>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200207110259.12544-1-philmd@redhat.com>
 <24bddc77-801e-ae63-dd1d-e06e3ac1cc03@vivier.eu>
 <078fbde9-3c93-b00a-2d53-34e65c7f56d9@redhat.com>
 <c552dea1-821f-08bc-5f08-5bf6b5a70aa6@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <12b9190f-643f-8bb5-6374-57aae6600c3e@vivier.eu>
Date: Fri, 7 Feb 2020 12:29:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <c552dea1-821f-08bc-5f08-5bf6b5a70aa6@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+e77QM3l0lAy1sS14rvhseaFNu2JjlcDmW7zzuJPmJYxHc/+Ly6
 5Mxx2qZdpGUGc0ziJwTuyMI3tSxGp2ZrdQTFSSG3erJ0S+bP+b/jKUfyr+bR4Dyij2hqUci
 vSijmTXjkSnU9s7lpqkv/J4Qbg0v/zc13b0bDu0J7z5hfCsk/fsebdUJuwP6sxaHBPRVzLF
 okljQ0ul2X4gZcjFdkwtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OdgT0kcDZHk=:NQUpw0bmqFM+rQBFqLEW2s
 uAfoeDaJilFxOaaqR8GHqtATMfVDYSEdleOuF3GbtMndj/L1njiMqqH/Fa8AV5nJQ7mgEXYdL
 C8UmrdLxRUwFw5ZxpBaVZWET6FfpXmHPjpa/WayHJquFqjv4FIff8XZalCFDNwolqwf+3NJt1
 FYK4qamOAbkmoCmgB8VAh3jEFAEkSRUAbAJeOAzMyBfODZub5nCVrlA0swEK154E7qec8o2hw
 /riE580ayUp+2qP7ZOp4OW+gTR2wZwcucTRN/9sCCjJSwvEDeLxqpMwvaQPSXDIUV1I+MYSPg
 P5Y2SFQyQV63hRRNezhsBmUp5AF8a1RJKM/HBZvGbHUMyKVKOIsTe0JL5AN286vroTy0IUMV0
 3rVGT9kaBkL84Mjz4em2sZBYLECt2B9M6ROTp1NTgBWuXOX8h172yWGzhgpr+XeFVWzkuljrR
 mgQ5uiSYx6DA51GxEKUakClsu8JXzZWf/5iWjtRBRHztIUcUafFEg5uLB/C1lZMmSR4iwPBZj
 1pnlIXkOp42hN2g0dDouZ2jCLsHUglv0DQ1b1HVdJIo3wnMi1vsoqBr2DxtOakyQcwOf3FiWz
 rQmCjq6ZHryCRY/zdlf1cY2cCQEe6LEjBlMv7ggHmJ+LsWTKufOyFow7/x/x66XjDAdsRcDpZ
 lv1RsI/QbDHrYEy9ft1TNIvw2saRB9zmdUi4CAuzIH/plTOyAgPIgDFroZrd90oF2FIUDDnyi
 iqbHRniHGgnDL2+8SMSFV6EdsjKd/FNIiZhU7zSt0Mk4QlhHNH7+yhZLt6m/i3ny5bAHVzxNY
 05a3VF1FBsKf8/Pc8HTofYQgfmaERuzNCTPQVYPUJtnQjDIfgioae78B/xtH9Cwdrt0CjyA
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/02/2020 à 12:28, Laurent Vivier a écrit :
> Le 07/02/2020 à 12:25, Philippe Mathieu-Daudé a écrit :
>> On 2/7/20 12:08 PM, Laurent Vivier wrote:
>>> Le 07/02/2020 à 12:02, Philippe Mathieu-Daudé a écrit :
>>>> It would be confusing to have multiple default machines.
>>>> Abort if this ever occurs.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>>   vl.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/vl.c b/vl.c
>>>> index 7dcb0879c4..da828188eb 100644
>>>> --- a/vl.c
>>>> +++ b/vl.c
>>>> @@ -2354,6 +2354,8 @@ static MachineClass *machine_parse(const char
>>>> *name, GSList *machines)
>>>>       GSList *el;
>>>>         if (is_help_option(name)) {
>>>> +        int default_count = 0;
>>>> +
>>>>           printf("Supported machines are:\n");
>>>>           machines = g_slist_sort(machines, machine_class_cmp);
>>>>           for (el = machines; el; el = el->next) {
>>>> @@ -2364,6 +2366,11 @@ static MachineClass *machine_parse(const char
>>>> *name, GSList *machines)
>>>>               printf("%-20s %s%s%s\n", mc->name, mc->desc,
>>>>                      mc->is_default ? " (default)" : "",
>>>>                      mc->deprecation_reason ? " (deprecated)" : "");
>>>> +            default_count += !!mc->is_default;
>>>> +        }
>>>> +        if (default_count > 1) {
>>>> +            error_printf("Multiple default machines available\n");
>>>> +            abort();
>>>>           }
>>>>           exit(0);
>>>>       }
>>>>
>>>
>>> Does it really deserve an abort?
>>> Ideal solution would be to be able to check this at build or in the unit
>>> tests.
>>
>> This is for developers, not for users. I'll use Marc-André suggestion
>> and use an assertion.
> 
> I agree, but it's why it would be better if it is detected before it
> comes to the user.
> 
> Perhaps you can add a test to run "qemu -h" to trigger the abort() early
> in the develompment process (if it doesn't already exist).

I mean "-M help".

Thanks,
Laurent


