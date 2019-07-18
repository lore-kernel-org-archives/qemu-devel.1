Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F4C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9341E20880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9341E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho6EX-0007y7-HR
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho6EL-0007X0-Us
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho6EK-00074c-Mo
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:13:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho6EK-00074F-Gm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:13:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so28635330wrl.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 06:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vr4B/LxKEDR0H5amYQsM4fFRRSFkcTNnCk0FB7iQTIk=;
 b=pQK7fDgTFZ3PojyKuZ6LbSg0WTKG4EVPlg+9XRabFy4zwNxZ/aOynnrp32rWZCx7O0
 HARGNoZJdARHJBJoqWseQSEnliAfz50ad4Tk6Cm6heQl4FJjX92K3RXyAoiEiWcK505m
 Rulow8/cSshbA8TrKovFh90u/6P7uBfmWOX+YaMBthTWjvW+eHnkBxwEJ1ZtWJbGe5kP
 kaUWTDqQqP13EBzPyYVhG6gQfIlM3SrnTT5k2IAalDpuyvQwyWxZjxqfF23gbrE2aKFF
 VrWrNuVGlHc7WuoWdhxSBliCwh+kPgJtwo4oeMgTnhLQ+PGTxI+zzUmTV+1gozNsNYaQ
 cecQ==
X-Gm-Message-State: APjAAAVdfJtcyKp4UzpfjwyutmiSYY6XJqENTYO7Dar0W7mhd+lLOkLY
 dqU/yBPnxAomF3XoIyFPoUkMdLkIJ8WwYw==
X-Google-Smtp-Source: APXvYqyCtYtDLNHY9z9LyWQvzmOcoTp1R1T/SkacIS5MRWYrMJv+4aG3+arwXXFIWm6bTIskOjRXTA==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr44351063wrt.227.1563455631210; 
 Thu, 18 Jul 2019 06:13:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id o185sm26474213wmo.45.2019.07.18.06.13.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 06:13:50 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20190718120413.27678-1-marcandre.lureau@redhat.com>
 <20190718124928.GA17063@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1c4d3856-4890-d9a9-d51a-fc3823967c29@redhat.com>
Date: Thu, 18 Jul 2019 15:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718124928.GA17063@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] build-sys: do no support modules on Windows
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

On 18/07/19 14:49, Daniel P. Berrangé wrote:
> On Thu, Jul 18, 2019 at 04:04:13PM +0400, Marc-André Lureau wrote:
>> Our module system does not support Windows, because it relies on
>> resolving symbols from the main executable.
>>
>> If there is enough interest in supporting modules on Windows, we could
>> generate an import library for the executable and link with it:
>> https://stackoverflow.com/questions/15454968/dll-plugin-that-uses-functions-defined-in-the-main-executable
>>
>> However, there is a small chicken egg problem, since the executable
>> link and exports extra symbols needed by the library...
> 
> The "solution" to that would presumably be to put everything into a
> library, and the executable merely becomes trivial main() that calls
> a "runme" function in the library. It is kind of ugly though as we
> would need a separate library for each system emulator executable.
> 
> Just ignoring modules on Windows looks like the prudent solution.

See https://github.com/mesonbuild/meson/pull/3683#issuecomment-467815241

The trick is to build the modules in two phases, first as a static
library and then as a shared module (with Meson you'd use link_whole).
Then the list of symbols can be gleaned from the static libraries, but
the executable can still be linked before the shared module:

modules_objs = {}
modules_objs += { 'b': static_library('b.mo', 'src.c', pic: true) }
# ...

undef = []
undefdeps = []
foreach name, lib : modules_objs
    shared_module(name, link_whole: lib, link_with: e)
    undefdeps += [custom_target('undefsym', output: [name+'.undef'],
                            input: lib,
                            command: [files('undefsym.sh'),
                                      '@OUTPUT0@', '@INPUT@'])]
    undef += [ '@' + name + '.undef' ]
endforeach

libutil = static_library('util', 'util.c', pic: true)
e = executable('a', 'main.c', link_with: [libutil],
               link_args: undef, link_depends: undefdeps,
               implib: true)

This in fact is exactly what we're doing now, just with a .o file and
"ld -r" instead of a .a file that is wholly-linked into the shared module.

Paolo

