Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8A3C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 21:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D093420CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 21:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D093420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8shw-0000Tb-T1
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 17:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i8sgU-0008LV-Vh
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 17:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i8sgQ-0004Mz-KO
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 17:00:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i8sgQ-0004L8-9W
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 17:00:46 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F1B6793ED
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 21:00:42 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id h6so11632660wrh.6
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 14:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kyqv/Y6T9sJQ2ug2lFb61NvZTGauswqC03XbHBBu0ls=;
 b=nYvUfQmZ7STtOhjvzKm53lziJnV/MRoCIMeCOncXlB08/S4oLSg1DUtt1Za5vfErzh
 cXgWQh3ukaZ2aDY73zKop3Blkp6ucJ35nCz2ag9Tzn3R4sDSdk2sdO5ON991r6ttQqMG
 ONB+G3ScG9gTwmtoLsKjC5S0dEKLJCYVzD2sExbp50Dd+R2nHe0BxyKwQSvlMh1jF0Un
 tcN7Ulxo00WFhOK6oyu61vAQ/e1KQQtNjBKgWM6N9xBeuCWGGIE2yBTObNHLiqVB5fuJ
 I/cKslZvsnu+EZ03hiLQz4enUhvcSZ+53dotjUrtbi8ngguai57km3FI5fYFuXLjr7Bl
 NVVA==
X-Gm-Message-State: APjAAAUghFXbegEgsC+iyCVcoYa5/b45mmBO6PIrddahHolNIx6w+dyd
 HXEIdwTWbjOZ7HeZsVX+ESPMuccIlpGoONqAgGV8OM6AGF9B+Y6vLX5awDLEupdJdgVwktYpPVV
 RMwUCuu0vDnFNflk=
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr13379215wrw.304.1568408441159; 
 Fri, 13 Sep 2019 14:00:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxr4krfxK6uAwSAD2CVo8PFPKB/1R2JX+EDPbVIGEJQvcl8q/vEnN81X3v9pozRuswlZFVTVw==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr13379205wrw.304.1568408440936; 
 Fri, 13 Sep 2019 14:00:40 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id u8sm2938692wmj.3.2019.09.13.14.00.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2019 14:00:40 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190913105205.7581-1-philmd@redhat.com>
 <20190913105205.7581-3-philmd@redhat.com>
 <965bb469-c5a0-d854-ba32-ac5485ffae1d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a5664c3e-2c83-b9fc-e3f9-5797356d6b6e@redhat.com>
Date: Fri, 13 Sep 2019 23:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <965bb469-c5a0-d854-ba32-ac5485ffae1d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] trace: Forbid event
 format ending with newline character
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 10:01 PM, John Snow wrote:
> On 9/13/19 6:52 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Event format ending with newlines confuse the trace reports.
>> Forbid them.
>>
>> Add a check to refuse new format added with trailing newline:
>>
>>   $ make
>>   [...]
>>     GEN     hw/misc/trace.h
>>   Traceback (most recent call last):
>>     File "scripts/tracetool.py", line 152, in <module>
>>       main(sys.argv)
>>     File "scripts/tracetool.py", line 143, in main
>>       events.extend(tracetool.read_events(fh, arg))
>>     File "scripts/tracetool/__init__.py", line 367, in read_events
>>       event =3D Event.build(line)
>>     File "scripts/tracetool/__init__.py", line 281, in build
>>       raise ValueError("Event format can not end with a newline charac=
ter")
>>   ValueError: Error at hw/misc/trace-events:121: Event format can not =
end with a newline character
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  docs/devel/tracing.txt        | 2 ++
>>  scripts/tracetool/__init__.py | 3 +++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
>> index 76e492a489..8231bbf5d1 100644
>> --- a/docs/devel/tracing.txt
>> +++ b/docs/devel/tracing.txt
>> @@ -112,6 +112,8 @@ Trace events should use types as follows:
>>  Format strings should reflect the types defined in the trace event.  =
Take
>>  special care to use PRId64 and PRIu64 for int64_t and uint64_t types,
>>  respectively.  This ensures portability between 32- and 64-bit platfo=
rms.
>> +Format strings must not end with a newline character.  It is the resp=
onsibility
>> +of backends to adapt line ending for proper logging.
>> =20
>>  Each event declaration will start with the event name, then its argum=
ents,
>>  finally a format string for pretty-printing. For example:
>> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init_=
_.py
>> index 6fca674936..57df74e67c 100644
>> --- a/scripts/tracetool/__init__.py
>> +++ b/scripts/tracetool/__init__.py
>> @@ -277,6 +277,9 @@ class Event(object):
>>          if fmt.find("%m") !=3D -1 or fmt_trans.find("%m") !=3D -1:
>>              raise ValueError("Event format '%m' is forbidden, pass th=
e error "
>>                               "as an explicit trace argument")
>> +        if fmt.endswith("\\n\""):
>> +            raise ValueError("Event format must not end with a newlin=
e "
>=20
> It's barely worth mentioning, but you can use r"\n" for cases like this=
,
> if it makes it easier to read.

TIL Python r"" :)

This would be r"\n\"", right? We need to match the trailing '"'.
Same length, not sure which string is easier to review =3D)

