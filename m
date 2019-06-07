Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E238C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0644B20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 08:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0644B20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAKs-0001WZ-65
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 04:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZAJd-0000fT-53
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZAJW-0000LC-Ts
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:33:33 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZAJS-00006y-Em
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 04:33:26 -0400
Received: by mail-wm1-f54.google.com with SMTP id x15so1098553wmj.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 01:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5ZQw4/n0dqYZBceUrFHhAfPiuOk/UGSk1gPjssKrYyY=;
 b=YudChXgEMiEqMG8eXNLSsnyjW6lwyE3SfqG//w/3DInmv4Y4qlhlfFPqw+1FAzZHhS
 ctGIvAPZvNLebHSMudS0mpvCgBJBTbrAjfR+1X4l8Xf7281q2aJTdOP2CX6lW5cg+Gvz
 jlzLCfBBmtH1E5NlcTnr6ZxZ/jV5iHF+dnbNF9GEgisgMLvqho7fqLTGx7FsA9ei44BO
 xa5Vy0PkFgmqDnRbUgz53xxcRhC/vTqeYdRyJR7YOVIt8n793ZK9iJ56DUDwl0f4rd36
 ae349BRTg0Sj9bTRFRALEt0GrVS76ad8UpmqUPygD/2tedaTQK/hC+WTy+Pa8VuKm7y5
 ZJPA==
X-Gm-Message-State: APjAAAWHKXoG/5MXxizGqiI5sCi0HxN1FxIlPO1q4LDAJo05CXX9MlxI
 jEZH46C1nriNC/dJsxsrFhgHow==
X-Google-Smtp-Source: APXvYqz+jWxhRP6ttLVcY/6kdVKxI9UQP/ElSescesZkI/wcNFAgg5Vkwr7TnGf3Bhm0Rm/UiI5Eyw==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr1552704wma.20.1559896395918; 
 Fri, 07 Jun 2019 01:33:15 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id 65sm1356336wro.85.2019.06.07.01.33.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 01:33:15 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <87woihi1wl.fsf@dusky.pond.sub.org>
 <20190524185344.GJ10764@habkost.net> <87r28k1g4q.fsf@dusky.pond.sub.org>
 <e5372760-7599-3155-44f7-dc704c9cbaa5@redhat.com>
 <875zphg9t8.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <47942a1d-efa4-c20d-a854-bd0e3b4ec1f2@redhat.com>
Date: Fri, 7 Jun 2019 10:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <875zphg9t8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.54
Subject: Re: [Qemu-devel] qapi/misc.json is too big,
 let's bite off a few chunks
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 8:59 AM, Markus Armbruster wrote:
[...]
> QOM is not a particularly active subsystem now: 51 commits in two years.
> 
> We obviously need maintainers to review and merge patches.  The nominal
> maintainer hasn't been doing that since 2015.  Git shows the following
> top committers taking on / getting sucked into QOM:
> 
>     Markus Armbruster <armbru@redhat.com>
>     Eduardo Habkost <ehabkost@redhat.com>
>     Paolo Bonzini <pbonzini@redhat.com>
>     Marc-André Lureau <marcandre.lureau@redhat.com>
>     Eric Blake <eblake@redhat.com>
> 
> We really need nominal maintainer(s) again.
> 
> Of course, *active* maintainers would be even better: I consider QOM
> stuck in an unhappy place where much of its potential is still
> potential.
> 
> But let's start small.  Volunteers for the reviewer role, please step
> forward :)
> 
> 
> 
> The details I promised:
> 
> Output of "scripts/get_maintainer.pl --git --git-since='2-years-ago' |
> grep commit_signer" sorted by file size:
> 
[...]
> = include/qom/object_interfaces.h =
> Eduardo Habkost <ehabkost@redhat.com> (commit_signer:8/5=100%)
> Igor Mammedov <imammedo@redhat.com> (commit_signer:3/5=60%)
> "Marc-André Lureau" <marcandre.lureau@redhat.com> (commit_signer:2/5=40%)
> "Philippe Mathieu-Daudé" <f4bug@amsat.org> (commit_signer:2/5=40%)
> Eric Blake <eblake@redhat.com> (commit_signer:1/5=20%)

get_maintainer's commit_signer is lying...

[...]
> = qom/trace-events =
> Stefan Hajnoczi <stefanha@redhat.com> (commit_signer:2/2=100%)
> "Philippe Mathieu-Daudé" <philmd@redhat.com> (commit_signer:2/2=100%)
> Markus Armbruster <armbru@redhat.com> (commit_signer:1/2=50%)
> Michael Tokarev <mjt@tls.msk.ru> (commit_signer:1/2=50%)

This 'git log -p' history of this file is very interesting...

