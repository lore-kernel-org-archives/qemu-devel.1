Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1CEC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C96A24125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTZ4fx82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C96A24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itxoq-0000n9-9Y
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 13:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1itxoG-0000Li-Ek
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1itxoD-0001a9-1k
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:59:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1itxoC-0001Zr-UV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579629564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1yB5Ua33pNN37cqyA5E6Aeh9qs9NLpZzN1htIgVqA0=;
 b=NTZ4fx82/bgFmfIyeOZ+arnNMdpcYTE75rbD+9mGbayIQGUHxdr1cejmTo3WWJam8z6aQu
 +QUgJ3+U7J0aLBEVLwiqHJBuNZu3eb1zJg27LLIb2ZfSC6AAPeJGya1qFQrO94Oy6trm92
 gbc9VBd/dOAbYLb+KGW1EaM8deWVVMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-UI5xsewtNLyhnqX8aXuPJw-1; Tue, 21 Jan 2020 12:59:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47CCF8018C1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 17:59:21 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-114.ams2.redhat.com
 [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1383E86C54;
 Tue, 21 Jan 2020 17:59:20 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 8D4823E0489; Tue, 21 Jan 2020 18:59:18 +0100 (CET)
Date: Tue, 21 Jan 2020 18:59:18 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] docs: qemu-cpu-models: Document '-noTSX' variants and
 'mds-no'
Message-ID: <20200121175918.GD20791@paraplu>
References: <20200116173639.28524-1-kchamart@redhat.com>
 <20200121164508.GB635404@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200121164508.GB635404@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UI5xsewtNLyhnqX8aXuPJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 04:45:08PM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Jan 16, 2020 at 06:36:38PM +0100, Kashyap Chamarthy wrote:

[...]

> >  @table @option
> > +
> > +@item @code{Cascadelake-Server-noTSX}
>=20
> Also needs
>=20
>    @item @code{Cascadelake-Server}

Will add.

> > +
> > +Intell Xeon Processor (Cascade Lake, 2019-2020), with "stepping" level=
s
>=20
> s/Intell/Intel/
>=20
> s/-2020//  as we only need the initial year of introduction IMHO.

Will do.  (I wasn't sure, hence I put both years :-))

> > +6 or 7 only.  (The Cascade Lake Xeon processor with @b{stepping 5 is
> > +vulnerable to MDS variants}; refer below.)
> > +
> > +@code{/proc/cpuinfo}.
> > +
> > +The @code{mds-no} bit does not show up under @code{/proc/cpuinfo}.
> > +Rather it shows up under the @code{sysfs}, as
> > +@code{/sys/devices/system/cpu/vulnerabilities/mds:Not affected}
>=20
> We already talk about this later on we I thin kwe can trim the
> /proc/cpinfo bit

True, will remove this redundancy.

[...]

> > +@item @code{mds-no}
> > +
> > +This is an MSR (Model-Specific Register) used by QEMU to indicate that
> > +the host is @i{not} vulnerable to any of the MDS variants ([MFBDS]
> > +CVE-2018-12130, [MLPDS] CVE-2018-12127, [MSBDS] CVE-2018-12126).
> > +
> > +Note that there are @i{three} versions of Intel's Cascade Lake
> > +processor, as distinguished by their "stepping" levels 5, 6, and 7.  T=
he
> > +CPU with stepping "5" is @b{vulnerable to MDS variants}; and the CPUs
> > +with steppings "6" and "7" are @b{not vulnerable} to the above mention=
ed
> > +MDS variants.  The processor "stepping" is reported in
> > +@code{/proc/cpuinfo}.
> > +
> > +Confusingly, the @code{mds-no} bit does not show up under
> > +@code{/proc/cpuinfo} inside the guest.  Rather the kernel uses it to
> > +fill in the @code{sysfs}, as
> > +@code{/sys/devices/system/cpu/vulnerabilities/mds: Not affected},
> > +assuming the processor is running with stepping 6 or 7.
>=20
> I think we can simplify this a little - we don't need to talk
> about CPU steppings - the user simply needs to know whether the
> sysfs file reports vulnerable or not.
>=20
> So perhaps this text:
>=20
>   Recommended to inform the guest OS that the host is @i{not]
>   vulnerable to any of the MDS variants ([MFBDS]
>   CVE-2018-12130, [MLPDS] CVE-2018-12127, [MSBDS] CVE-2018-12126).
>=20
>   This is a MSR feature rather than a CPUID feature, so will not
>   appear in the Linux @code{/proc/cpuinfo} in the host or guest.
>=20
>   It should only be enabled for VMs if the host reports
>   @code{Not affected} in the
>   @code{/sys/devices/system/cpu/vulnerabilities/mds} file.

Your phrasing is indeed simpler and more to-the-point; will incorporate
it.

I'll also add similar sections about the other two MSRs: 'taa-no' and
'tsx-ctrl' (as mentioned here:
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg03685.html).

Thanks for the careful review.

--=20
/kashyap


