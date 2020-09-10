Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E4AC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA546207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="M2+jWwGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA546207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIyb-0000QY-Br
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kGIwg-0006Yd-6I
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:32:46 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:60739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kGIwb-0002Va-8G
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=r4jlAeKMxz4zmcg9GTziYtnLyqQInHTBPUmMMvEbGZI=; b=M2+jWwGi2wJM9Edsh0XlV3to98
 vWy+ySi2+CM6H5DaIjYRsMSy5neSblQnzeiHbeQjLNmoZ/24sYnWMGiruO6DnAo2z1jf0NQB60yDf
 sinNh+mcs0yYK9rvuhvrf7VcB8PxTLfeV6CPiL9YW/ieVoRb1j6HOpTHVwk4caQ5zFtTalsrPGQ27
 HYIBmfRh3DUeFIfo6PK8mHm9TwPxklewoyObHcJQjkW29yuERnYR5GHYBDt8bAe4vBTf0k+HfZ6sU
 5wFCn0ZHvN8+/c05S/Jndc9aIaWRl+WL58I050jHOOLTYrszvYv4vrcT+Sswbm6PxTe9uFvUZkCH1
 cQDwkNQw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Date: Thu, 10 Sep 2020 11:32:35 +0200
Message-ID: <2421928.3WNMogbLRJ@silver>
In-Reply-To: <20200910073710.GA1083348@redhat.com>
References: <2764135.D4k31Gy3CM@silver> <1695914.5EixHECA2G@silver>
 <20200910073710.GA1083348@redhat.com>
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

On Donnerstag, 10. September 2020 09:37:10 CEST Daniel P. Berrang=E9 wrote:
> I don't think we want to be adding more 3rd party deps as submodules, qui=
te
> the opposite, we want to remove more submodules we currently have.
>=20
> Bundling every important dep we use as a submodule and providing build
> rules, means we're effectively re-inventing Homebrew / MacPorts and this =
is
> not a sane use of our time.

Well, that's actually the whole point of this thread: saving developers' ti=
me.=20
And I think the submodule solution is the most sane one.

=46rankly if you compile FOSS software on Mac that asks you to "just" insta=
ll=20
dependencies with Homebrew and co, it feels like you have 2 jobs: a softwar=
e=20
developer, and a distribution maintainer. The difference to the submodule=20
though: a much larger amount of developers have to do that maintainer job=20
(manually resolving conflicts & crashes, rollbacks, etc.).

Best regards,
Christian Schoenebeck



