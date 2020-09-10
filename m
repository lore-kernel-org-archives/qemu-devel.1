Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9108EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B6362076D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="hgiewjl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6362076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNld-0008O5-6E
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kGNl5-0007xR-93
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:41:07 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:50353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kGNkz-00018A-Bf
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=vw/kQvH+Re3zF90WdxY9u/UpUmvXm33AydzgH4O5D/A=; b=hgiewjl4bieU4qkWUJ5ILA+cZ4
 +nra/oI7G5jpbu5d5fDKWSvUfoupNFm4EhJ7UdF4n9H69jtHa6Ne6xirNwSn3sbtppBc6WNv8e8R5
 e4FOjqXAI7/kUPp1+UNbu+9KcBfRxFcqi0UP8P3a/n2gBZW3CtD0gL/LgykUUrnQz/uwgPjwKBrqC
 9TZTBr1UvUzRukMtSnkSdoiNQql1jGuX+FdbUyM4c7MARbV+1kUx2R04DSN5F6/+CZ+1YvWkT6Ez4
 FaV1u+BRe9Y4yRFyKpmE/27CBam6d1pQmn54dgUWNh60jUKoKOdD2bKztJgWNo2ShkibffDmOBPpD
 z7A2TMDg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Date: Thu, 10 Sep 2020 16:40:55 +0200
Message-ID: <5694401.8H58FrkmUv@silver>
In-Reply-To: <CAFEAcA_CPNppKwwJSu4O6U6qF-rfHR2NtG=hWBFatZmD4aiMdg@mail.gmail.com>
References: <2764135.D4k31Gy3CM@silver> <4878996.4JzhbN1UZ4@silver>
 <CAFEAcA_CPNppKwwJSu4O6U6qF-rfHR2NtG=hWBFatZmD4aiMdg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 10:40:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 10. September 2020 12:35:46 CEST Peter Maydell wrote:
> Does Apple (or anybody else) provide a framework for doing this
> so that developers of individual applications can just say "my
> app needs libs X, Y, Z" and they don't have to mess around
> finding, figuring out how to compile, and shipping the sources of
> libs X, Y, Z? If there's a better mechanism than Homebrew for this
> that's great, but at the moment what you seem to be saying is
> "you should do a lot more work to manually set something up where
> you ship the sources to all your dependencies and then build them
> all". There's no way we're ever going to do that, it is just
> way too much work for very little gain.

On Mac I have 'framework'ed & Xcoded the FOSS libs I need. And when I need to 
compile a new FOSS lib/app that requires libs x,y,z then I just drag those 
already existing Xcode projects as referenced subprojects into that new Xcode 
project:

https://developer.apple.com/library/archive/documentation/ToolsLanguages/
Conceptual/Xcode_Overview/WorkingonRelatedProjects.html

For instance if I have to compile some new app that needs gtk(mm), all I need 
to do is pulling in gtkmm.xcodeproj (e.g. per drag & drop) which in turn 
already references all its own dependencies (subsubsub..projects) like glib, 
cairo, etc. So I just click 'Run' and that's it.

And if the app triggers a crash in some of the subprojects, Xcode stops at the 
precise lib's source location, you fix it, click 'Run' and you're done in 
seconds. With the regular 'make' approach you would spend hours for that.

So that's a highly modular end-to-end-from-source approach. The precise 
location of the individual xcode projects does not matter BTW as Xcode 
references subprojects by UDID. You can move them around as you want and it 
still works. No need to install them at global space, predefined structures, 
or even hard coded locations, and no duplication of sources either.

I know, all this sounds very unorthodox what I am doing at first glance. But 
if you think about it, all it would take is if individual FOSS projects would 
start maintaining an .xcodeproj file, which in turn could then be referenced 
by UUID from other FOSS project's .xcodeproj file as dependency and you would 
get a low cost end-to-end-by-source solution, already on upstream level, i.e. 
without the need of having dedicated projects managing "distributions".

On Donnerstag, 10. September 2020 12:41:45 CEST Paolo Bonzini wrote:
> You're very welcome to do this, but what you're doing is effectively a
> *distribution of QEMU* that targets the "macOS build from source" scenario,
> for people that don't want to use Homebrew. It is *not* going to be used by
> QEMU developers, because QEMU developers have conflicting requirements:

Okay, no problem. I will see where to go from here. I am not even sure yet 
whether all those source generating scripts of QEMU would be a show stopper 
for what I have planned. I mean (counting): ... yes, still just 2 hands here.

If it turns out to work fine, then maybe I just push a branch of QEMU for Mac 
developers somewhere for a while, as I think it would lower the entry level 
for new developers on Mac tremendously. Apparently there is still more changes 
with Meson ahead anyway (getting rid of the Makefiles or whatever else is 
planned). So we'll see ...

Best regards,
Christian Schoenebeck



