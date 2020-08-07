Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F8C206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2G4aORk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F8C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3y74-0005dF-Qs
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3y6R-0004wp-7a
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:51:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3y6O-0006hH-7P
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596790307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=NKPp9awrEbTAdOuGAdGtnjaQjX3EMVWfu/JuxJg149c=;
 b=e2G4aORkNkNMIwcCcmS+pWZXT0j56NZ4MS0VrpkG5htAXXpfA1Alpl/Q30CEYDm9LNCEyl
 45bXgvXFgzcR++3oFKz8FqGzyrZm1MMUWFMXjBsNM7hhiKN+KCKG0oO9Q01nmCckM8ZAYn
 bQwCkcV+DRHDrtFPcMCi6FvDh61+LzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-BPFmqyQCO1CgB0ayNPd3pw-1; Fri, 07 Aug 2020 04:51:44 -0400
X-MC-Unique: BPFmqyQCO1CgB0ayNPd3pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01D73102C7ED;
 Fri,  7 Aug 2020 08:51:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-31.ams2.redhat.com [10.36.113.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73B535DA33;
 Fri,  7 Aug 2020 08:51:34 +0000 (UTC)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <761b4058-7a2b-d992-2cc2-6efe654ee62e@redhat.com>
Date: Fri, 7 Aug 2020 10:51:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 armbru@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/2020 21.13, Paolo Bonzini wrote:
> This the more or less final version of the Meson conversion.  Due to
> the sheer size of the series you have been CCed only on the cover
> letter.
> 
> The series reaches the point where Makefile.target and unnest-vars
> can be removed, and all builds become non-recursive.  I have also
> converted parts of the testsuite, notably qtest since it is needed
> for fuzzing.  What's left for _after_ the merge is: 1) unit tests;
> 2) moving the rest of installation to meson (for which I have patches);
> 3) moving feature detection from configure to meson.
> 
> Things I still haven't tested:
> - fuzzing
> - non-x86/Linux builds
> - static builds
> - Docker and VM builds
> 
> Things I have checked:
> - x86 builds
> - modules
> - "make install"
> - internal slirp/dtc/capstone.
> 
> It should be more or less bisectable.  I have not tried building
> _all_ steps, but I have tried both before and after each major one.
> 
> Build system rebuild rules seem to work reliably.
> 
> After a week or quite intense rebasing, my impression is more or less
> the same as last December: Meson looks more daunting, but it is actually
> much nicer to work with.
> 
> The diffstat so far is not very favorable, but remember that:
> 
> 1) the series leaves quite a few nearly-obsolete bits in configure,
> Makefile and rules.mak (over 200 lines only in the makefiles).
> 
> 2) configure test conversion will be where meson really shines.  I
> included a couple examples just to show
> 
>     meson: convert VNC and dependent libraries to meson
>        4 files changed, 44 insertions(+), 134 deletions(-)
> 
>     meson: move SDL and SDL-image detection to meson
>        5 files changed, 30 insertions(+), 144 deletions(-)
> 
>     meson: replace create-config with meson configure_file
>        6 files changed, 80 insertions(+), 168 deletions(-)
> 
> 3) the idea behind using Makefile generators is to have stable
> code written in a high-level language instead of Makefile magic
> that tends to grow by accretion.  So even though ninjatool is
> large at 1000 lines of Python, it can already be considered mature
> or even "done".  It had only ~15 lines changed since the last post,
> and whenever debugging meson.build issues looking at build.ninja has
> always (literally!) been enough.
> 
> Available on git://github.com/bonzini/qemu branch meson-poc-next.

I just threw your meson-poc-next branch at our CI systems. Observations:

1) If no meson is installed, configure quickly aborts with "ERROR: Meson
not found. Use --meson=/path/to/meson|git|internal":

 https://gitlab.com/huth/qemu/-/jobs/675533520

Could you simply change it to default got git/internal instead (where is
the difference between git and internal?), so that we do not have to add
a --meson=xxx to all the CI jobs everywhere?

2) With --meson=git added, I also do not get much further:
 "./ui/meson.build:77:0: ERROR: Program 'keycodemapdb/tools/keymap-gen'
not found"

 https://gitlab.com/huth/qemu/-/jobs/675546229

Any idea what's going wrong here?

3) macOS build fails in a different way:

../meson.build:1:0: ERROR: Value "gnu++03" for combo option "C++
language standard to use" is not one of the choices. Possible choices
are: "none", "c++98", "c++03", "c++11", "c++14", "c++17", "c++1z",
"c++2a", "gnu++11", "gnu++14", "gnu++17", "gnu++1z", "gnu++2a".
A full log can be found at
/private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/build/meson-logs/meson-log.txt
ERROR: meson setup failed

 https://cirrus-ci.com/task/6514035426328576

Maybe we should use gnu++11 for C++ code nowadays? ... we still used
gnu++98 in the past since GCC 4.8 (from CentOS/RHEL 7) has only
"experimental" support for c++11 ... but since we're soon (in less than
a year) going to drop support for that anyway, maybe we could switch it
now already to gnu++11 ... ?

 Thomas


