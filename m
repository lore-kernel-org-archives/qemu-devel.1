Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998A3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628C62075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+tBnqyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628C62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4459-0004Y9-K3
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 11:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k444a-00048U-0N
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:14:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38790
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k444W-0001nX-U9
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596813254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1QrvQuUFP3M3zplWGL0ie2m3tbk+wJ0tBBDvI4O1gTk=;
 b=b+tBnqylxTQM4o3xxkJOQvox6hZOQclmycpPcxiniXcGBxtZvGpiWVYh+uSHTyAKb+xOsd
 9MIGe1cDEdAICsiF4u3rvefvLR2OhqCmS7C6Vzao+EVwiszuzO6wa0Y3m78yVmO/AIiSU8
 I9+c1MvI3ejtuJuiqaYticaqV0PggUU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-W5xygfC_PGi-R2RXWKpX0A-1; Fri, 07 Aug 2020 11:14:11 -0400
X-MC-Unique: W5xygfC_PGi-R2RXWKpX0A-1
Received: by mail-wm1-f72.google.com with SMTP id z1so900442wmf.9
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 08:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1QrvQuUFP3M3zplWGL0ie2m3tbk+wJ0tBBDvI4O1gTk=;
 b=QzN8loHxDE3c+5fYnN5Lm0CcswPqXT10Ix8AnWTbjOttq7XD+FvpiM4UmTvpMfyuv9
 hD3duZ8TUOHMsxaCG3EElENTF8ym/L+nLiuDxWF46pNATWmSukOHtZlOB4oWh9iiDPD0
 BabMInotCHhwQY5sWAFRZXZVSQGLTAfU4+wNhPMwetDaY991CzTG+kvOCjJWSxOZuXWf
 LRNF4t1GMYo2Fac8fugcsv2kvqaKTLkJx/KygRvffFRGAROWq3n8GFEsEldvJmEGKgLl
 YoKq08XyNahNyahB8wMekGcwYpwCm0hAlid60dEordx3PgusaadRF7GmlLqwAsQnk+vt
 5Iwg==
X-Gm-Message-State: AOAM532Zt42v/AK6WPYAvkWOYZRDiPv8vz5epcdCi+ro8ytQUq9gZNIW
 TUP37yDAYWWSFSL4tn6NxPnOU631Wc6kTmPWEdctHYAU4Hp8RNoTktvwyQPn3HG3ZF6pIwVgvc5
 FcCZfM80Q8To7EQo=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr13037862wmh.39.1596813250113; 
 Fri, 07 Aug 2020 08:14:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE0HfVB5TuGceTZEYLjqwML3DmK7e5KszuchA3GyioJUEkLFqpyZBLggx/RNdJULTsdCT2iA==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr13037845wmh.39.1596813249801; 
 Fri, 07 Aug 2020 08:14:09 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id q19sm10479338wrf.48.2020.08.07.08.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 08:14:09 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
 <9d7b7f59-ec3e-1f74-d1d4-359e3388f0f8@redhat.com>
 <87ft8yd0ht.fsf@dusky.pond.sub.org>
 <CAFEAcA8-qAh9RzAZNqFS9HphAEDuCVVGzZO7vKem-1WCJogyjw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8cb36ff-a98a-9147-1c31-6f6394a4ec77@redhat.com>
Date: Fri, 7 Aug 2020 17:14:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-qAh9RzAZNqFS9HphAEDuCVVGzZO7vKem-1WCJogyjw@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:11:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 16:02, Peter Maydell wrote:
> On Fri, 7 Aug 2020 at 14:55, Markus Armbruster <armbru@redhat.com> wrote:
>> I'm notoriously conservative in my choice of tools, and GNU Make is a
>> much better tool than some people give it credit for, but I've long felt
>> we've pushed it beyond its limits.
> 
> The thing is, it feels somewhat like we're already pushing Meson beyond
> *its* limits instead...

We totally are pushing it *to* its limits, though I obviously disagree
with "beyond".  QEMU would certainly be one of the largest projects
using Meson.  In fact we had to add more than one new feature.

One important difference between Make and Meson is that Meson is by
design limited in what it can do.  The idea (which I think has served
them well) is that they want projects to show what they need and work
with them on how to build it.  So:

- with Make you can do everything, it just becomes harder and harder;

- with Meson you cannot do everything, plus you're using software that
is opinionated and conservative in some respects with respect to its
design decisions.  In exchange: 1) you can always propose to add
features to the upstream project like Marc-André and I did; 2) you don't
have to worry about the minute details of everything.

So that's what makes Shell+Make and Meson substantially different tools.

Stuff like automatically cloning git submodules will never be in Meson,
and we can keep Make forever as a small escape hatch for that.  However,
using Make as a Turing-complete language to build our own DSLs on top of
is just a bad idea.  Shell+Make can remain simply as a driver for
executing commands, which is what Make does best.

We also have parts that have effectively separate build systems: I have
no plans to convert the TCG tests at all, the firmware could be
converted to Meson or Autotools (yes I am serious :)) or left aside, and
so on.


That said, and going back to pushing Make beyond its limits, I am quite
positive that unnest-vars has to go even if the solution has some
disadvantages.  Meson is one solution, our own home-grown DSL and
Makefile generator could be another.  However, designing our own build
system DSL is not something I want to spend time on; I prefer to improve
Meson for every other project using it, it's better for the whole open
source development community.

The reason why I started thinking about the conversion is that every now
and then people entered fights against unnest-vars and I was wondering
how those fights would compare to Meson fights.  And the result, after
about one year of hacking on and off, is that---with one exception---it
never felt like I was fighting Meson or the Meson maintainers; any
adaptation or concession came naturally, or was even an improvement in
retrospect.

That one exception, the one thing that disappoints me of the whole
conversion, is the trace.h files.  The current solution is one of the
first parts I did of the conversion and I have never touched it since; I
think it can be improved (I can even think of two ways to do it), but I
don't really have the time to do it now.  But even that bit is just
ugly, not unmaintainable, and I really see nothing in the conversion
that is a step back for QEMU's long term maintainability and our ability
to develop new features.

/me gets off the soap box

Thanks,

Paolo

> (it can't do everything we want it to, we've
> already had to get at least one new feature added upstream for our benefit,
> and in other places we're having to change our existing conventions
> to placate Meson). This would be an easier sell if it was "this is all
> straightforward and Meson has all the functionality we need".
> 
> I admit that I'm partly feeling a bit more conservative about tooling
> right now because we just switched the docs to Sphinx and Sphinx has
> turned out to have some annoying problems we didn't foresee. So taking
> another tool from the Python universe isn't hugely appealing.
> 
> (This is not a 'nak'; I'm just expressing my unease.)

Yes, it's totally understandable.


