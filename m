Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C671C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0387206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="dY4TIY9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0387206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoCB-0003Jx-LV
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUoAw-0002dj-8A
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:43:26 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:41211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUoAu-0000OI-Bq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=j4zG3K0uQwkfCt5LjdVwMvOIlaslMsv0FkHS2LdSUZk=; b=dY4TIY9BYRCRkuvIo95OmjXD6k
 uzDS/q7Xi2PDCj5C5e2SiNhwmr+xFAJeNck7a8UXnSjCmiBGS0fDyi71AkFsv/mF/z9uSe0of8R8f
 AhKDj+Vy2mSumhRWPy7uiypvNZoV49INC0RgMeOcxMt2FAzXd7skARpZJpeGDD2SZ5HIZckabuNqn
 8GRC4Nf2V/9O8ZX0vLLiezPJqEz/fiLvZse6tYqqnvLHBpQpiA/64dZPakoU2+1FC3MiYSOS42SfU
 nF7kV8PaxExJ8BvMX1lriwaT4Hk5XOFI5OpPh/+x4BXbxpIbRAlQI1/z+DsOGzT2iD9cH64XE5XJS
 GuoZQmVw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PULL v3 2/6] tests/9pfs: change qtest name prefix to synth
Date: Tue, 20 Oct 2020 11:43:18 +0200
Message-ID: <5436271.QZMOO6KbSo@silver>
In-Reply-To: <26d3b93c-5dbd-a58c-19e7-060120cfa326@redhat.com>
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
 <eefd2394efd6ba379d36d80c52de9ad956343b47.1603111175.git.qemu_oss@crudebyte.com>
 <26d3b93c-5dbd-a58c-19e7-060120cfa326@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 05:43:20
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

On Dienstag, 20. Oktober 2020 09:36:10 CEST Philippe Mathieu-Daud=E9 wrote:
> On 10/8/20 8:34 PM, Christian Schoenebeck wrote:
> > All existing 9pfs test cases are using the 'synth' fs driver so far, wh=
ich
> > means they are not accessing real files, but a purely simulated (in RAM
> > only) file system.
> >=20
> > Let's make this clear by changing the prefix of the individual qtest ca=
se
> > names from 'fs/' to 'synth/'. That way they'll be easily distinguishable
> > from upcoming new 9pfs test cases supposed to be using a different fs
> > driver.
> >=20
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > Message-Id:
> > <e04e75acb849b085c6d6320b2433a15fa935bcff.1602182956.git.qemu_oss@crude=
by
> > te.com> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>=20
> Harmless, but don't need to sign twice ;)

Ah, I thought that's the common way, as Greg's PRs contained 2 SOBs as well=
,=20
i.e. I thought this was intended to outline the patch author and submaintai=
ner=20
were the same person.

BTW I actually did not explicitly add the 2nd SOB. It was rather added by t=
he=20
patchwork client automatically. So maybe it should be fixed in the client t=
o=20
detect an already existing SOB line? Or am missing something here?

Best regards,
Christian Schoenebeck



