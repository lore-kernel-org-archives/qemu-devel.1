Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD3C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715DF20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715DF20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MBw-0004Zw-15
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i8M9y-0003Kv-JC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i8M9t-0006e7-El
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:17:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i8M9t-0006cX-0W
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:17:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F2B9302C06D;
 Thu, 12 Sep 2019 10:17:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CABBB5D6A5;
 Thu, 12 Sep 2019 10:16:53 +0000 (UTC)
Date: Thu, 12 Sep 2019 11:16:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190912101651.GK24576@redhat.com>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
 <87d0g6dnbc.fsf_-_@dusky.pond.sub.org> <87y2ytzy17.fsf@linaro.org>
 <CAFEAcA9Db2ENw7e_1-XOTbHeV=sp_zFxqoq4se+63OK+mQaeew@mail.gmail.com>
 <87v9txzv3o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v9txzv3o.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 12 Sep 2019 10:17:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] TCG plugins and the GPL (was: [PATCH v4 00/54]
 plugins for TCG)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pranith Kumar <bobby.prani@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 12, 2019 at 11:07:07AM +0100, Alex Benn=C3=A9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On Thu, 12 Sep 2019 at 10:03, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
> >>
> >> Well the first thing will be we are not intending to offer a guarant=
eed
> >> ABI. While we don't want to be changing it at a whim there shouldn't=
 be
> >> an expectation that the plugin interface will maintain backwards
> >> compatibility (unlike the command line interface ;-). There should b=
e an
> >> expectation that plugins will likely need to be rebuilt against the
> >> current source tree from time to time.
> >
> > Wait, what? From my perspective the whole point of the plugin
> > interface is that it should be stable, in that at least there's
> > a good chance that a plugin you built will work against multiple
> > versions of QEMU, and if it doesn't then it should fail with
> > a reasonable error message telling you to update. I'm not
> > sure we should be landing the plugins infrastructure if we
> > don't have that much stability.
>=20
> There is a big fat blurry line between "set in stone" and "not requirin=
g
> you to re-engineer the plugin every QEMU release". I'm saying we should
> reserve the right to extend and change the plugin API as required but
> the expectation would be the plugins will continue to work the same way
> but maybe with tweaks to the API hooks to support additional features.
>=20
> It's also a pretty young interface so I would expect some evolution onc=
e
> it is released into the field.
>=20
> One problem with the anti-license circumvention measures being suggeste=
d
> is it will mean having to recompile plugins for any given release. This
> isn't a problem for plugins we write but it does add an extra step for
> out of tree plugins. Maybe being forced to re-compile (but not change
> the source) is a hurdle we are willing to accept?

I can understand & totally support not wishing to break the compilation
of plugins for every release, by having a reasonably stable API.

I think forcing recompile for each release is reasonable protection
to make it less atttractive to create license violating closed source
plugins.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

