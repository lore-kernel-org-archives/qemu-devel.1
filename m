Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF22C3A59B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F842084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F842084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyHK5-0002KI-Lm
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hyHJG-0001bW-7k
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hyHJ8-0001ME-BE
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:04:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hyHJ8-0001Lq-5C
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:04:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so1527138wme.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 08:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BXqakQouAf8iNefsUR10DgPLRdonq6VSp8J+jEhvq7U=;
 b=O0HUA3JAgcl7bTs/dXmsbBzMtNSNV5uEqee2ixni/8z1jtwdAPvrqeioFjdl7EgJpo
 R7SuoQTOhhqhPBI0okSUVhzUHnwhueuWNSjNwZXHyyHZeT92gPJtChl5iu0HFnETlQhV
 S8qwVXy3m2qw6hsTfqgyHipTvjp3yEUnHZd7S5PMcISzloAMouPhlF9qOqTxk/RVMXaW
 OJkqHjwb27NI5Rhr0iKc90bbCmn6vRAnjfInEHV/5IMHO64dO/dmvDxtgxZEogHQa3IM
 ALqnHTTqAWvSsZVvam18GNWpzcCUd19ezA5WNLc+yqMkw5j+wd7PHLpJVIgqmRFUwDNU
 y23w==
X-Gm-Message-State: APjAAAV7OZlVXKyUO31OqQJPLQ144ZxxrKBs/DGo/73jUxcjpFrTcbFp
 UppkgwiDYdQ6jN4RWybGRvln0g==
X-Google-Smtp-Source: APXvYqy86f3oQmfrVE8vYZcvpbGvEeCCI32BoF/cvJsl/HDM0/P8PljPgydlgQxBXb06bSXLS91u+Q==
X-Received: by 2002:a05:600c:352:: with SMTP id
 u18mr3196669wmd.141.1565881492865; 
 Thu, 15 Aug 2019 08:04:52 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id c12sm2733314wrx.46.2019.08.15.08.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2019 08:04:52 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190815120247.13413-1-philmd@redhat.com>
 <20190815144542.GH10996@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d6f7a21f-1294-52e8-5164-2fbdcf169e9d@redhat.com>
Date: Thu, 15 Aug 2019 17:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190815144542.GH10996@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] trace: Clarify DTrace/SystemTap help
 message
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/15/19 4:45 PM, Stefan Hajnoczi wrote:
> On Thu, Aug 15, 2019 at 02:02:47PM +0200, Philippe Mathieu-Daudé wrote:
>> Most tracing backends are implemented within QEMU, except the
>> DTrace/SystemTap backends.
>>
>> One side effect is when running 'qemu -trace help', an incomplete
>> list of trace events is displayed when using the DTrace/SystemTap
>> backends.
>>
>> This is partly due to trace events registered as modules with
>> trace_init(), and since the events are not used within QEMU,
>> the linker optimize and remove the unused modules (which is
>> OK in this particular case).
>> Currently only the events compiled in trace-root.o and in the
>> last trace.o member of libqemuutil.a are linked, resulting in
>> an incomplete list of events.
>>
>> To avoid confusion, improve the help message, recommending to
>> use the proper systemtap script to display the events list.
>>
>> Before:
>>
>>   $ lm32-softmmu/qemu-system-lm32 -trace help 2>&1 | wc -l
>>   70
>>
>> After:
>>
>>   $ lm32-softmmu/qemu-system-lm32 -trace help
>>   Run 'qemu-trace-stap list qemu-system-lm32' to print a list
>>   of names of trace points with the DTrace/SystemTap backends.
>>
>>   $ qemu-trace-stap list qemu-system-lm32 | wc -l
>>   1136
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  trace/control.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/trace/control.c b/trace/control.c
>> index 43fb7868db..bc2fe0859d 100644
>> --- a/trace/control.c
>> +++ b/trace/control.c
>> @@ -159,12 +159,19 @@ TraceEvent *trace_event_iter_next(TraceEventIter *iter)
>>  
>>  void trace_list_events(void)
>>  {
>> +#ifdef CONFIG_TRACE_DTRACE
>> +    fprintf(stderr, "Run 'qemu-trace-stap list %s' to print a list\n"
>> +                    "of names of trace points with the DTrace/SystemTap"
>> +                    " backends.\n",
>> +                    error_get_progname());
>> +#else
>>      TraceEventIter iter;
>>      TraceEvent *ev;
>>      trace_event_iter_init(&iter, NULL);
>>      while ((ev = trace_event_iter_next(&iter)) != NULL) {
>>          fprintf(stderr, "%s\n", trace_event_get_name(ev));
>>      }
>> +#endif
> 
> Multiple trace backends can be built into QEMU.  In that case the list

I did not know, that explains the final 's' to the
--enable-trace-backends option.

The "== Trace backends ==" of docs/devel/tracing.txt is not clear about
this.

> might be complete and the user may not be using stap at all.  Perhaps
> the message should be turned into a warning instead and the list should
> still be printed:
> 
>   This list of trace events may be incompletel.  Run 'qemu-trace-stap
>   list %s' to print a list of names of trace events with the
>   DTrace/SystemTap backends.

OK, thanks!

Phil.

