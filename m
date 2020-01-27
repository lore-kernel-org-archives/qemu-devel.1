Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3615DC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0582A207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuYzkBvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0582A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1eO-000886-4b
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iw1do-0007jR-Hq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iw1dn-0002xf-3q
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:29:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iw1dm-0002xD-St
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580120949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuNhzB6XztjWiEcjPEzKyepRptuWnLe0yx1S7FSKiGg=;
 b=BuYzkBvEosSZOyDvGM7SbB30M+ac5ivUqX573oQYpqb/5UQFV8oCo3u9ykztyb+p9ugd2X
 a4zvNOkRYcOB4YZI42hYDk+2hd6iPXf/WxkrVgnGt4xSHgOjvrUqcPET5b+fW4amnRU/1R
 nVjeCt8yE6IXGUSYi+4/ZPRJNjxDN00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-OGa3K9k6PYCcJ34_TBJdlw-1; Mon, 27 Jan 2020 05:29:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ED5E477
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 10:29:07 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-97.ams2.redhat.com [10.36.117.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BF045C1D6;
 Mon, 27 Jan 2020 10:29:06 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 1BD0A3E0489; Mon, 27 Jan 2020 11:29:05 +0100 (CET)
Date: Mon, 27 Jan 2020 11:29:05 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] qemu-cpu-models: Document -noTSX, mds-no, taa-no, and
 tsx-ctrl
Message-ID: <20200127102905.GA17663@paraplu.home>
References: <20200121184940.26520-1-kchamart@redhat.com>
 <5fe2c318-6212-feb5-960a-d6b96c022d3f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5fe2c318-6212-feb5-960a-d6b96c022d3f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OGa3K9k6PYCcJ34_TBJdlw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 06:20:51PM +0100, Paolo Bonzini wrote:
> On 21/01/20 19:49, Kashyap Chamarthy wrote:
> > Question: How can a user validate that TSX is indeed disabled for the
> >           guest?
>=20
> Look for rtm in /proc/cpuinfo, or look at the TAA entry in the sysfs
> vulnerabilities directory.

Noted.

[...]

> > +@item @code{taa-no}
> > +
> > +Recommended to inform that the guest that the host is @i{not} vulnerab=
le
> > +to CVE-2019-11135, TSX Asyncrnous Abort (TAA).
>=20
> Asynchronous

Will fix.

[...]

> > +@item @code{tsx-ctrl}
> > +
> > +Recommended to inform the guest to @i{disable} the Intel TSX
> > +(Transactional Synchronization Extensions) feature.
>=20
> Not "to disable" but rather:
>=20
> Recommended to inform the guest that it can disable the Intel TSX
> feature or (if vulnerable) use the VERW instruction as a mitigation for
> the TAA vulnerability.

Thanks.  I'll make that last bit to:

    ... use the Intel 'VERW' instruction (a processor-level instruction
    that performs checks on memory access) as a mitigation for the
    TAA vulnerability.

Hope that's accurate-but-vague-enough description of 'VERW'.  (I
realize, as Dave Gilbert said on IRC, the actual description of VERW is
besides the point, as Intel reused that to do something else in addition
to its original purpose).

I just wanted to note a small, high-level blurb on _what_ VERW is,
because I feel awkward leaving such words like that in the air in a
user-facing doc.

[...]

--=20
/kashyap


