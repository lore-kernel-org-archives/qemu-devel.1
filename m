Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DEBC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE36206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKNI1Bq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE36206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOGPD-0003IP-Pl
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOGOS-0002sL-4D
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOGOQ-0004KN-Mt
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:54:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOGOQ-0004Jj-J5
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586850841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4s0vhKrzx9Le+awLR3DteaCRyxRNRKlk5MagYryhMk=;
 b=UKNI1Bq1phVOeNr5rm9lGFNZnsXShlZv+vhB66WX4Etbm0seJafQoh6+la9Rzit/3PH0M9
 LgbEzeNz9N/JMTLn1Ifl42Wi9/XV6Mr1qnojOYJgcijWp1FCQuooSMD6cRNyTCianpjeSZ
 TgmBaYrENNxkclz5XkiC08oFOY+Dz9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-JhnSXxkbNt6XYLDaSOn0Tg-1; Tue, 14 Apr 2020 03:53:56 -0400
X-MC-Unique: JhnSXxkbNt6XYLDaSOn0Tg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68D301088380;
 Tue, 14 Apr 2020 07:53:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30C45126512;
 Tue, 14 Apr 2020 07:53:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A91E811385C8; Tue, 14 Apr 2020 09:53:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Supported Sphinx Versions
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <4873c74c-f590-62bf-bd64-dd5ab391c252@redhat.com>
 <CAFEAcA-Nuk8hnbtTrhtmSDroZugoEWheyh1N9E4jcAPikpPx9g@mail.gmail.com>
 <0519cb85-5c86-d202-7649-7928b4696644@redhat.com>
Date: Tue, 14 Apr 2020 09:53:53 +0200
In-Reply-To: <0519cb85-5c86-d202-7649-7928b4696644@redhat.com> (John Snow's
 message of "Mon, 13 Apr 2020 15:24:32 -0400")
Message-ID: <87a73ezeni.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 4/13/20 2:22 PM, Peter Maydell wrote:
>> On Mon, 13 Apr 2020 at 19:08, John Snow <jsnow@redhat.com> wrote:
>>> I was curious about our actual version compatibility, so I did some tes=
ting.
>>=20
>> Thanks for doing the testing.
>>=20
>>> 1.6.1 through 2.2.2 all appear to work just fine, but produce a lot of
>>> warnings about a coming incompatibility with Docutils > 0.16.
>>=20
>> FWIW, I don't get this warning with the stock Ubuntu
>> 1.6.7. The only time I did see it was when I'd managed
>> to accidentally install half of Sphinx 3 to my ~/.local
>> directory and I think it was the system Sphinx and an
>> upgraded docutils or some other weird combo.
>>=20
>
> Yeah, it depends on what versions you pull in. I am using `pip` to
> install sphinx straight from PyPI, and the version dependency resolution
> opts for "the latest that isn't prohibited by the repository", which
> means that I am using (very likely) some cutting edge dependencies for
> an older version of sphinx.
>
> That's OK, it works just fine -- just a note, is all. It likely works
> completely quietly if you scoot back down to Docutils 0.15.
>
> (The requirements specify only Docutils >=3D 0.12. Eventually, older
> sphinx installations may break when Docutils 0.17 comes out unless you
> start pinning versions manually.)
>
>>> Conclusion:
>>>
>>> Required: >=3D 1.6.1
>>> Recommended: >=3D 2.3.0
>>=20
>> I think that what we actually care about is the usual thing:
>> do we build OK with the version of sphinx-build shipped by
>> every distro on our support list?
>
> Sure; if any distro ships a version that's outside of what I laid out
> above it would be good to fix and check.
>
> We can also tighten and document the versions so if we do fall outside
> of that by accident, we'll catch it during RC testing phase.
>
> I'm using this to make a quick assessment:
> https://repology.org/project/python:sphinx/versions
>
> Fedora:
>     30: 1.8.4
>     31: 2.1.2
>
> OpenSUSE:
>     15.1: 1.7.6
>
> Ubuntu:
>     19.10: 1.8.5
>     20.04/LTS: 1.8.5
>
> Debian:
>     8/Jessie: We don't support this anymore AFAIUI.

Correct.

docs/system/build-platforms.rst:

    For distributions with long-lifetime releases, the project will aim
    to support the most recent major version at all times.  Support for
    the previous major version will be dropped 2 years after the new
    major version is released, or when it reaches "end of life".

Debian 8 reached end of life in 2018, one year after 9's release.

>     9/Stretch: 1.4.8 -- Broken at present!

Will reach end of life this summer, one year after 10's release.

>     10/Buster: 1.8.3
>
> Ubuntu LTS:
>     16.04: Dropped
>     18.04: 1.6.7
>     20.04: 1.8.5
>
> RHEL:
>     EPEL7: 1.2.3 -- way, way too old!
>     RHEL8: 1.7.6 [via CentOS8]
>
>
>
> We *might* need to do some surgery to support Stretch, and EPEL7 fell
> off the wagon entirely if repology is to believe -- it doesn't support
> our stated minimum of simply having the "Alabaster" theme, which comes
> in 1.3.
>
> For RHEL7 we *could* start using a virtual environment, which would help
> alleviate the wide version spread.
>
> ...are we opposed to this kind of thing? Has there been a discussion befo=
re?
>
> Targeting the native repo versions is nice (and we should continue to
> make a best effort there), but we *could* start offering a virtual
> python environment for the builds that grabs very precise versions.
>
> --js


