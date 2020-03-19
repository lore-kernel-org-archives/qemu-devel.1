Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D9CC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40C12072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcrlNHtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40C12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEy7F-0006hO-5d
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 12:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEy6d-0006HP-DZ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEy6b-0002Gn-PP
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:33:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEy6b-0002Dr-FX
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584635592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kB3Rc39+3+pXGiTAEtfUMGVUvvgInQgFW318aYwKUEE=;
 b=BcrlNHtNvXslEg9s3LMAJXKaB3leqbRwlEZzQz3fg7n1pi76yzycVgos1POaVm03/vfMjD
 UUjkjZLMSPU9ATFTf/zdv78mvBV38nIy+GXaWvPpGMzPjJtYyqvOJ/H72DbMeND7ECbPbg
 1cw9gsLRLS4wD0gInWhZ/FbaT3l+0Es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-giZTViWtOQu42Nl197wzBg-1; Thu, 19 Mar 2020 12:33:08 -0400
X-MC-Unique: giZTViWtOQu42Nl197wzBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B2FB1088382;
 Thu, 19 Mar 2020 16:33:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 713C262673;
 Thu, 19 Mar 2020 16:33:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A99461138404; Thu, 19 Mar 2020 17:33:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/5] QEMU Gating CI
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
 <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
 <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
Date: Thu, 19 Mar 2020 17:33:01 +0100
In-Reply-To: <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 (Peter Maydell's message of "Tue, 17 Mar 2020 14:24:35 +0000")
Message-ID: <87sgi49uf6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 17 Mar 2020 at 14:13, Cleber Rosa <crosa@redhat.com> wrote:
>>
>> On Tue, Mar 17, 2020 at 09:29:32AM +0000, Peter Maydell wrote:
>> > Ah, I see. My assumption was that this was all stuff that you were
>> > working on, so that I would then be able to test that it worked correc=
tly,
>> > not that I would need to do configuration of the gitlab.com setup.
>
>> So, I had to use temporary hardware resources to set this up (and set
>> it up countless times TBH).  I had the understanding based on the list
>> of machines you documented[1] that at least some of them would be used
>> for the permanent setup.
>
> Well, some of them will be (eg the s390 box), but some of them
> are my personal ones that can't be reused easily. I'd assumed
> in any case that gitlab would have at least support for x86 hosts:
> we are definitely not going to continue to use my desktop machine
> for running CI builds! Also IIRC RedHat said they'd be able to
> provide some machines for runners.

Correct!  As discussed at the QEMU summit, we'll gladly chip in runners
to test the stuff we care about, but to match the coverage of your
private zoo of machines, others will have to chip in, too.

>> OK, I see it, now it makes more sense.  So we're "only" missing the
>> setup for the machines we'll use for the more permanent setup.  Would
>> you like to do a staged setup/migration using one or some of the
>> machines you documented?  I'm 100% onboard to help with this, meaning
>> that I can assist you with instructions, or do "pair setup" of the
>> machines if needed.  I think a good part of the evaluation here comes
>> down to how manageable/reproducible the setup is, so it'd make sense
>> for one to be part of the setup itself.
>
> I think we should start by getting the gitlab setup working
> for the basic "x86 configs" first. Then we can try adding
> a runner for s390 (that one's logistically easiest because
> it is a project machine, not one owned by me personally or
> by Linaro) once the basic framework is working, and expand
> from there.

Makes sense to me.

Next steps to get this off the ground:

* Red Hat provides runner(s) for x86 stuff we care about.

* If that doesn't cover 'basic "x86 configs" in your judgement, we
  fill the gaps as described below under "Expand from there".

* Add an s390 runner using the project machine you mentioned.

* Expand from there: identify the remaining gaps, map them to people /
  organizations interested in them, and solicit contributions from these
  guys.

A note on contributions: we need both hardware and people.  By people I
mean maintainers for the infrastructure, the tools and all the runners.
Cleber & team are willing to serve for the infrastructure, the tools and
the Red Hat runners.

Does this sound workable?

> But to a large degree I really don't want to have to get
> into the details of how gitlab works or setting up runners
> myself if I can avoid it. We're going through this migration
> because I want to be able to hand off the CI stuff to other
> people, not to retain control of it.

Understand.  We need contributions to gating CI, but the whole point of
this exercise is to make people other than *you* contribute to our
gating CI :)

Let me use this opportunity to say thank you for all your integration
work!


