Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2779C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6C321941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="GE9Ybbt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6C321941
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJbt-0000Ew-0a
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kGJb2-0007Ow-Rd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:14:29 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:48439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kGJb0-0000HK-TA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=9UEUxjh3BqBUwq3V7SisMmIjEgjHU2phEw6uPPRbmFc=; b=GE9Ybbt9+8npQHlHdlV1dAH1Ql
 vnEgHLoikrFXa02eaZquOU1XkihSI5Qq4sKU5iQuamolxqO7C3eONzB57mu09NnnaUzoQp4kscJAq
 3YSM8CjlKj+yoVYMIOsf457AMZHTjh2qq8hfKPtOJVwWmICdNYsw4SGpxhiYoaoTyrdEkAxQAydNN
 pwBSluYw5l6UkGqXkOFtSvLu1sEeGUpgcyYkyL0nI+N055fGoDsZiboS9w9NV9t7085Fyy5aAZlZp
 K/GYnqptJ19EzfQcGze2H15yAoAFXgyz0c5epeMuhAAyzAoozHhVb3wHOLZHbvU0FE//hP2ydv97k
 1VdrrVtg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Date: Thu, 10 Sep 2020 12:14:23 +0200
Message-ID: <4878996.4JzhbN1UZ4@silver>
In-Reply-To: <20200910093910.GG1083348@redhat.com>
References: <2764135.D4k31Gy3CM@silver> <2421928.3WNMogbLRJ@silver>
 <20200910093910.GG1083348@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 05:32:37
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

On Donnerstag, 10. September 2020 11:39:10 CEST Daniel P. Berrang=E9 wrote:
> > Well, that's actually the whole point of this thread: saving developers'
> > time. And I think the submodule solution is the most sane one.
> >=20
> > Frankly if you compile FOSS software on Mac that asks you to "just"
> > install
> > dependencies with Homebrew and co, it feels like you have 2 jobs: a
> > software developer, and a distribution maintainer. The difference to the
> > submodule though: a much larger amount of developers have to do that
> > maintainer job (manually resolving conflicts & crashes, rollbacks, etc.=
).
>=20
> I don't think it saves time. If you look at the bigger picture across
> multiple project it costs time. Every project that depends on glib or
> gtk or gnutls or etc  reinvents the wheel figuring out a suitable
> recipe for bundling & building these dependencies. Worse is that they
> will all do it slightly differently, or use a variety of versions, and
> so users get a worse experiance too with different features available
> and different things broken. Projects like HomeBrew exist precisely to
> save developer time because these build steps can be figured out once,
> and every project can now just rely on the well maintained HomeBrew
> packages.

That only works for consumers at most.

=46or developers it is actually the complete opposite on Mac: you start to=
=20
install things from somewhere, then you need to install something from=20
somewhere else, manually build & install stuff, and you end up in conflicts=
=20
and misbehaviours all over the place.

The way to go for devs on Mac is: 3rd party libs should not be installed in=
to=20
global space, rather be built & linked either as dynamic frameworks (includ=
ing=20
assets) or as static libs. Then apps always run with the precise version an=
d=20
flags of libs they were tested with and never conflict with another app's=20
version/config of libs.

Best regards,
Christian Schoenebeck



