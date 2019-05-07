Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D2C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703422053B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="alUBEqen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703422053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46647 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNztN-0008E1-LK
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 09:12:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hNzsb-0007wv-Bg
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hNzsa-0007jv-Df
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:11:33 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:51571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hNzsZ-0007it-RK
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=47Lb/gBOJ8x2VR1rqxanUphDoM68pm28fhCyW9ooyUQ=;
	b=alUBEqenaCQ3tQJ0NbPZU97YmE
	C/jQQfc/L1RoGuCWjvc2VQOAFRnMjNObPdsaE7+rkpK0iWAGlO1CCUinHvQ7HW8Q1VXmw7bw8EpAd
	qqlptyuKC3PcitYfRY8SB2X/qHwCSjOvalG7wX3slmsa4KtCDFy3H4JNsal4JJIf+a+LIP7tqUJ58
	oQjiUIL182lL0p2x+V+FNJnMJ2TwdK6DpuZn840BUWgS9o7MIknE/h2hYSy26sH3TkVdkRIH4WPvV
	SGydyqt8zRVjlUjtNIDFjHRh38/QBL4lUbrwMIpKjdYVG4N50BQv0aEUWavTEiRpeYTMYiDd6Tphg
	RAi7gCYOEwKLWc47fNSmUrv1AVs8C1AzHhZABXW5zIyMEDOnIpgetubRqnT1TaCoF03V7/TRuv0P4
	KWYkOY7tDnsWSr/zPID50Vxg1DVHOxIxLqfxiBVzq3GviiydSgbk1S3Hfg2toX8fq69I/3wcr8dC+
	CorMcPvSrMpSTpV+nNWFWUYJrqn2TM00IogFGNA77oUwzdhu/+w4BSBU46qZf48pJaaRBo6XU9abI
	iMUqf3LMT3Oz5ly1c9Inu0PtjCPQiwu8E3ZN4Fj1abb8HrhWSR5Jyl6Q0Yyw62Am+4iYe7jtdxoDa
	G+kt57VJLgsBWlQuRxiRfAlVOABNVyvzsnzSw9vJU=;
To: qemu-devel@nongnu.org
Date: Tue, 07 May 2019 15:11:26 +0200
Message-ID: <3809087.3a1rNnKprp@silver>
In-Reply-To: <20190507124247.GN27205@redhat.com>
References: <cover.1557093245.git.qemu_oss@crudebyte.com>
	<5b5c005fbf4e31c07273468cb022d25a8907bc87.1557093245.git.qemu_oss@crudebyte.com>
	<20190507124247.GN27205@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v3 1/5] 9p: mitigates most QID path
 collisions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 7. Mai 2019 13:42:47 CEST Daniel P. Berrang=E9 wrote:
> > This first patch here is an updated version of Antonios Motakis'
> > original 4-patch set (using fixed length 16 bit prefixes), merged to one
> > patch:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02283.html
> >=20
> > * Updated to latest git master, specifically to new qht interface.
> >=20
> > * Merged the original 4 patches to this single patch.
>=20
> Why did you merge them all into one ?  The split patches were "best
> practice" IMHO. The original patch authorship & S-o-B lines could
> be preserved if you kept them split as before too.

Seems I misinterpreted an old comment of Greg that he would like to see the=
m=20
to be merged into less patches. I think it was this one:

https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02590.html

No problem, I will restore Antonios' original individual 4 patches=20
appropriately. What about SOB then? Should I just place Antonio's SOB on th=
ose=20
4 patches or does it need his and mine SOB lines? (I mean I need to rebase=
=20
those 4 patches and address the old issues on them)

Best regards,
Christian Schoenebeck

