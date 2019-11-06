Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3440DC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051D921848
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051D921848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSOmM-00080x-Uw
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 12:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSOjE-00058Y-M8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSOjD-000335-BI
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:04:20 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:51489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iSOjD-000328-0a; Wed, 06 Nov 2019 12:04:19 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mc1hn-1hw4mJ3qSF-00dYQ2; Wed, 06 Nov 2019 18:04:13 +0100
Subject: Re: [PATCH] numa: Add missing \n to error message
To: Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>
References: <157304440026.351774.14607704217028190097.stgit@bahia.lan>
 <bb828956-28b3-9fe7-1d57-ceb723a32997@vivier.eu>
 <20191106151246.2bf44314@bahia.lan> <875zjxosfv.fsf@dusky.pond.sub.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f6c6fff0-3dc5-bc6e-c77d-a20a6d248026@vivier.eu>
Date: Wed, 6 Nov 2019 18:04:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <875zjxosfv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u/zfa4x+ykqb64Nl0BrXiWjVqRqmQ28QxtSdlSxKLChn+UGn0R8
 2bXGR/5ZABGTj71I5ZiTwzOo+UUI5LjrJOCHHv08jl2kXtiG45aGpF4nz8jHlLTj/eCcYPn
 DHbDasJIH3Kpy9sXpZhR8yScdgQ0LHWyaLOoMtNJE9Xm/99O1yDm10c65lF7FwDAxioM2ye
 6SQ96+qetfLFGqYNn97eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0M3HWSWuJ4=:f8Lcy6XPFp9Az9MZSt6OCR
 /VUqXDr7WBZNL6GZ9sdYRwPPJv4e+W9OWF6D2WnF15kZLKh2uhgEPZgTgKp88Y1eTOxUjtgF+
 vN8CuIp+nZIWs66VZK1StOVFoM65NA1aJ1TQhQmFBtsMEiv4XKGgURLE2s3p7FBpt1Kljv2e+
 558AbhFIJVm5JsK6N6b+TB21FSzBkh0fp8Ns3/o5aLOgMWURjv2K+M1PhPJiThSknsvaCmuXB
 8JcBAlQ2wrm41CtDJVOLQTTWXkFuyv9nGGVggeEXiL/0hcWuks7HSrPKa1cVMLvymEsPNKPsv
 8QePuNn0w6Zozghol+MJSynzC/6vfzRYyeG2jSGMKN5BemNa+ZkvS2EgbfW7Sc3vJYGLH6aZm
 dT80PRB9aWOLtbudb3+3G660U7wdj8jMpaEV8kuA93FNAQp3gWR6idUAiIVxB5Gn+a17J/LNB
 cDRp6/L6ealf+QaQPKBjd+lUJPVea07R9GEcyyk6D73B8f74/QL9bSGCELnZ9lQBF4FCFaVmp
 tdo5+JCIWUHHTtqUVU6ij6NCBMuIIVlblTw39N5DnitXGU6/IJmo/TOToTSiQ9bdJ5d8dA+eT
 yl75s6PlsHvocMcQOtH7TJZGCxKWaYloyO/X3hNfo39deKLHc7V9uf7a2GRxJFDgH8chAWObr
 c04cFMMERp1ctWmkkiQKHRP7kIGwUUzogGa6Nq5w9blBsDZ+LRLfu7HNQ6o9WpDh1Qe10KGqG
 wdk9tLtdyCW6C90gsUCIEvkMdFpaTvdbIRCXSxHdR2dQ7WWnXxCcsrcF2KaZVkB3r01lJOKL3
 06Awi6sGDEMUgBjMcQ1wLXfdnjQ6FWgWb/ozvxsxfknP3CjGMsbjAsk1G5wCpoPZRJZXQeN1Z
 5Mvv/P2qyrgWHDBKx7SQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/11/2019 à 17:55, Markus Armbruster a écrit :
> Greg Kurz <groug@kaod.org> writes:
> 
>> On Wed, 6 Nov 2019 14:01:01 +0100
>> Laurent Vivier <laurent@vivier.eu> wrote:
>>
>>> Le 06/11/2019 à 13:46, Greg Kurz a écrit :
>>>> If memory allocation fails when using -mem-path, QEMU is supposed to print
>>>> out a message to indicate that fallback to anonymous RAM is deprecated. This
>>>> is done with error_printf() which does output buffering. As a consequence,
>>>> the message is only printed at the next flush, eg. when quiting QEMU, and
>>>> it also lacks a trailing newline:
>>>>
>>>> qemu-system-ppc64: unable to map backing store for guest RAM: Cannot allocate memory
>>>> qemu-system-ppc64: warning: falling back to regular RAM allocation
>>>> QEMU 4.1.50 monitor - type 'help' for more information
>>>> (qemu) q
>>>> This is deprecated. Make sure that -mem-path  specified path has sufficient resources to allocate -m specified RAM amountgreg@boss02:~/Work/qemu/qemu-spapr$
>>>>
>>>> Add the missing \n to fix both issues.
>>>>
>>>> Fixes: cb79224b7e4b "deprecate -mem-path fallback to anonymous RAM"
>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>>> ---
>>>>  hw/core/numa.c |    2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>>>> index 038c96d4abc6..e3332a984f7c 100644
>>>> --- a/hw/core/numa.c
>>>> +++ b/hw/core/numa.c
>>>> @@ -503,7 +503,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>>>>              warn_report("falling back to regular RAM allocation");
>>>>              error_printf("This is deprecated. Make sure that -mem-path "
>>>>                           " specified path has sufficient resources to allocate"
>>>> -                         " -m specified RAM amount");
>>>> +                         " -m specified RAM amount\n");
>>>>              /* Legacy behavior: if allocation failed, fall back to
>>>>               * regular RAM allocation.
>>>>               */
>>>>
>>>>
>>>
>>> Why is this an error_printf() and not an error_report()?
>>>
>>
>> Because CODING_STYLE suggests to do so I guess:
>>
>> Reporting errors to the human user
>> ----------------------------------
>>
>> Do not use printf(), fprintf() or monitor_printf().  Instead, use
>> error_report() or error_vreport() from error-report.h.  This ensures the
>> error is reported in the right place (current monitor or stderr), and in
>> a uniform format.
>>
>> Use error_printf() & friends to print additional information. <===
> 
> You're right.
> 
> Since I have nothing queued up right now, I'd prefer to have this go via
> qemu-trivial.

Ok, I will take it in my next qemu-trivial pull request (with the other
Greg's patch).

Thanks,
Laurent


