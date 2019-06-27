Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D7C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 08:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA4A20656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 08:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA4A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgQ9v-0006Cr-H6
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 04:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57290)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgQ99-0005kd-D0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgQ98-0000jX-0c
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:52:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgQ97-0000ig-Ou
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:52:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so4887184wmf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 01:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=troRUkJnCfgIJDPPi/ltL2ck1COg4U9uezkFp9TwJzM=;
 b=CJHssV36AuhmWh15u0XnF/+iZ2aO/JrEO9sdEx8ZpbHCAfvs3/ssiuaV4Duj1tS00T
 Ju+cNrIg+sh1NFuKezV5ex93h6WK1b4UNtoLsoprT8+E5ammWCldQv812iAHlDl7P+KU
 myRDsFcJS3aozUl0LmyHBUEc4/8xEYZAx9VwApY9nJUxWe7avzGj5PW16MYgOCezXsrB
 7S46kwF2HRJWe/iiJWfxDB0+wI5mfPbxtHTQhWFXB+X/07bwKAeMASM8iNCrX66xv819
 C/nRpnpty3EB0ktmZs5xkHoKZgAJW7RZ5sdMXRAgcncb7wGoBiWf4j2MR3ywMWps2jyK
 bUxw==
X-Gm-Message-State: APjAAAWJE3d3ZNm+DrimtHj/XXGqvR90Anh9XN1jiOcdUkdZm22hRnby
 FtRO6dyUUn0QAa1CVfhT88doLuabu6U=
X-Google-Smtp-Source: APXvYqz+svrIQrR3NW20Yc4jxSTK7/sXWoUb5X6vzfx6sNllKJ4PJqQcf4G1vNZ2jxxWEc5rZbOTwg==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr2452015wmj.143.1561625564221; 
 Thu, 27 Jun 2019 01:52:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:41bc:c7e6:75c9:c69f?
 ([2001:b07:6468:f312:41bc:c7e6:75c9:c69f])
 by smtp.gmail.com with ESMTPSA id t80sm1621869wmt.26.2019.06.27.01.52.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 01:52:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-4-git-send-email-pbonzini@redhat.com>
 <87woh8i725.fsf@dusky.pond.sub.org>
Message-ID: <44cb12ee-ee3d-43b0-47bd-e706bdf37a01@redhat.com>
Date: Thu, 27 Jun 2019 10:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87woh8i725.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 3/7] configure: integrate Meson in the
 build system
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/19 19:34, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> The Meson build system is integrated in the existing configure/make steps
>> by invoking Meson from the configure script and converting Meson's build.ninja
>> rules to an included Makefile.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  Makefile             |   9 +
>>  configure            |  30 ++
>>  meson.build          |   9 +
>>  scripts/ninjatool.py | 964 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Uff.

What, the 9+30+9 or the 964? :)

>> +export NINJA=./ninjatool
>> +Makefile.ninja: build.ninja ninjatool
>> +	./ninjatool -t ninja2make --omit dist uninstall < $< > $@
>> +-include Makefile.ninja
>> +
>> +ninjatool: $(SRC_PATH)/scripts/ninjatool.py
>> +	sed -e '1c\' -e '#! $(PYTHON)' $< > $@
>> +	chmod +x $@
> 
> Why do we need this here, but not for other Python scripts?
> 
> We have 39 Python scripts with #!/usr/bin/env python, one with
> #!/usr/bin/env python2, and 12 with #!/usr/bin/python.  The Makefiles
> generally use $(PYTHON) SCRIPT ARGS...

Because this script is invoked by meson too.  While my patch to support
a NINJA environment variable was accepted (and we point it to
ninjatool), meson invokes it as "$(NINJA)" --foo with no splitting, so
we need the above change.

But I can do better than this.  I can generate the file directly from
meson.build:

   configure_file(input: files('scripts/ninjatool.py'),
                  output: 'ninjatool',
                  configuration: config_host)

and avoid code duplication between configure and Makefile.

>> +rm -rf meson-private meson-info meson-logs
> 
> Ignorant question: why do we need configure remove this stuff?

By default, reinvoking meson complains that you probably want to
reconfigure (a la config.status) because there is already a build tree
here.  Our configure script always reconfigures the tree from scratch.
 So I just cause meson to fail that check.

>> +NINJA=$PWD/ninjatool $python $meson setup \
> 
> This prints
> 
>     /usr/bin/python3: can't open file 'meson': [Errno 2] No such file or directory
> 
> for me, then goes on happily.
> 
> For what it's worth:
> 
>     $ type meson
>     meson is /usr/bin/meson
> 
> Are you sure you want to override /usr/bin/meson's #! line?

No I'm not.  It should be just $meson, as you do below, though it could
also be $python "$(type -p meson)" if I wanted to override---but
certainly not $python $meson.  It worked for me because I was pointing
$meson to an absolute path under my home directory.

There is actually one reason to override it, which is why I did it in
the patch.  Meson has an automagic way to invoke all Python programs
with the same interpreter that was used to run meson itself (you make
the script non-executable and add "#! /usr/bin/env python3" as the first
line).  If we want to use that feature, we should invoke meson with $python.

> If I drop $python, I get
> 
>     meson.build:1:0: ERROR: Meson version is 0.50.1 but project requires >=0.50.999.
> 
> which is expected.
> 
> It's too hot right for me now to figure out how to obtain a suitable
> version.

FWIW 0.51.0 has now been released so you could grab it from Koji.

>> diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
>> new file mode 100644
>> index 0000000..6d90919
>> --- /dev/null
>> +++ b/scripts/ninjatool.py
> [Lots of code...]
> 
> Did you write ninjatool.py specifically for QEMU, or did you steal it
> (or parts) somewhere?

I wrote it specifically for QEMU.

Paolo

