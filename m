Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E6AC43457
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36739221FC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ZKQIqn3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36739221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUqEs-0004MW-TY
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUqDw-0003vA-OR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:54:40 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:49691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUqDu-0004sz-KZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ch3+0h/gP7Eil7GZICDxJegf1FdrNcbpHMfaAAfdAwk=; b=ZKQIqn3+Q6ErSBRLBjiCFZx58g
 3iJs6FaPOtdqRR1Tyf8wpSNsyq//sJ4XT9rOw1qrrQD0V/vWLV0CxcuUdECwOOlYyVRK7ytvgcoFi
 LS+M8qG9J8+atOrGCcM70szqEYeEVhIImu/9BeCfdxyZlf0X1ekwqe46bODKzbWaOV4UsanP+UPnX
 J1vqFX+iS6UaAge+mUyplCwF8bPPq55f8pSCXwL4RJHnCcWgi7BwwsvuByIFACmrLZVO26njwt4/L
 b5/VuaE9iZqEp9lssqKVJx4y/vqfk4krbaqDnKEZerguOMEqxtZ8VPixjvCiaS7tprNfxhNPv91Ni
 gbKJjMxg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Subject: Re: [PULL v3 2/6] tests/9pfs: change qtest name prefix to synth
Date: Tue, 20 Oct 2020 13:54:32 +0200
Message-ID: <2028136.PJCruPdmoF@silver>
In-Reply-To: <20201020120057.42c85b2e@bahia.lan>
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
 <5436271.QZMOO6KbSo@silver> <20201020120057.42c85b2e@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:54:35
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

On Dienstag, 20. Oktober 2020 12:00:57 CEST Greg Kurz wrote:
> On Tue, 20 Oct 2020 11:43:18 +0200
>=20
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Dienstag, 20. Oktober 2020 09:36:10 CEST Philippe Mathieu-Daud=E9 wr=
ote:
> > > On 10/8/20 8:34 PM, Christian Schoenebeck wrote:
> > > > All existing 9pfs test cases are using the 'synth' fs driver so far,
> > > > which
> > > > means they are not accessing real files, but a purely simulated (in
> > > > RAM
> > > > only) file system.
> > > >=20
> > > > Let's make this clear by changing the prefix of the individual qtest
> > > > case
> > > > names from 'fs/' to 'synth/'. That way they'll be easily
> > > > distinguishable
> > > > from upcoming new 9pfs test cases supposed to be using a different =
fs
> > > > driver.
> > > >=20
> > > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > > Message-Id:
> > > > <e04e75acb849b085c6d6320b2433a15fa935bcff.1602182956.git.qemu_oss@c=
rud
> > > > eby
> > > > te.com> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.co=
m>
> > >=20
> > > Harmless, but don't need to sign twice ;)
> >=20
> > Ah, I thought that's the common way, as Greg's PRs contained 2 SOBs as
> > well, i.e. I thought this was intended to outline the patch author and
> > submaintainer were the same person.
> >=20
> > BTW I actually did not explicitly add the 2nd SOB. It was rather added =
by
> > the patchwork client automatically. So maybe it should be fixed in the
> > client to detect an already existing SOB line? Or am missing something
> > here?
> Yeah this is the reason why my sob appears twice on patches authored by
> me, and since this is harmless I never really investigated how to fix
> pwclient :)

Well, I would usually offer my 'I can look at it' at this point, but I am=20
reluctant this time as I assume it will end up as my recently suggested lib=
qos=20
patches where I did not get any response from the officially assigned=20
maintainers; not even a simple 'nack'.

Best regards,
Christian Schoenebeck



