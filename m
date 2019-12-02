Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23546C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 22:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7192071E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 22:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GS0Um/g7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7192071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibuNf-0008AK-ID
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 17:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ibuLo-0007Ul-26
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 17:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ibuLh-0000ph-Th
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 17:39:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ibuLg-0000hH-0Z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 17:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575326338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n2x4+nEn1UJjkdYr1K5PiswPrx4654h2gxikrpNtFAI=;
 b=GS0Um/g76+BNz66SZyIRD/+RBVZrE6v1xmc/REUDyXWKE0i4uSe41EQYdmceFd2PkgIbW2
 8+jvSka5H6KSfAXm7cLijPZeMJAC7M+HsW9T9lHFSbPJs2UfHbwGVGXJAVPnlZkqpNstk0
 HuO/roXfcZT0eX7KRamnbR9RgQrHbIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-8Jx5zn0HOBSkLoluD6h6rw-1; Mon, 02 Dec 2019 17:38:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9AC41800D45;
 Mon,  2 Dec 2019 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-75.rdu2.redhat.com
 [10.10.122.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6BF55D9D6;
 Mon,  2 Dec 2019 22:38:44 +0000 (UTC)
Date: Mon, 2 Dec 2019 17:38:42 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20191202223842.GA17680@localhost.localdomain>
References: <20191202140552.GA5353@localhost.localdomain>
 <20191202170018.GD139090@stefanha-x1.localdomain>
 <CAFEAcA_fB1o95JitpzcZ4rtspxfD8dfkUZ3ZOcdMcAQpDFtYYQ@mail.gmail.com>
 <20191202182840.GA24511@localhost.localdomain>
 <CANCZdfpWw=4dD4b_9K4FSoXZkBEVwsQkyuQtdiFk0mkb8MYtsg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANCZdfpWw=4dD4b_9K4FSoXZkBEVwsQkyuQtdiFk0mkb8MYtsg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8Jx5zn0HOBSkLoluD6h6rw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jeff Nelson <jen@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 02, 2019 at 11:36:35AM -0700, Warner Losh wrote:
>=20
> Just make sure that any pipeline and mandatory CI steps don't slow things
> down too much... While the examples have talked about 1 or 2 pull request=
s
> getting done in parallel, and that's great, the problem is when you try t=
o
> land 10 or 20 all at once, one that causes the failure and you aren't sur=
e
> which one it actually is... Make sure whatever you design has sane
> exception case handling to not cause too much collateral damage... I work=
ed
> one place that would back everything out if a once-a-week CI test ran and
> had failures... That CI test-run took 2 days to run, so it wasn't practic=
al
> to run it often, or for every commit. In the end, though, the powers that
> be implemented a automated bisection tool that made it marginally less
> sucky..
>=20
> Warner

What I would personally like to see is the availability of enough
resources to give a ~2 hour max result turnaround, that is, the
complete pipeline finishes within that 2 hours.  Of course the exact
max time should be a constructed consensus.

If someone is contributing a new job supposed to run on existing
hardware, its acceptance should be carefully considered.  If more
hardware is being added and the job is capable of running parallel
with others, than it shouldn't be an issue (I don't think we'll hit
GitLab's scheduling limits anytime soon).

With regards to the "1 or 2 pull requests done in parallel", of course
there could be a queue of pending jobs, but given that the idea is for
these jobs to be run based on maintainers actions (say a Merge
Request), the volume should be much lower than if individual
contributors were triggering the same jobs on their patch series, and
not at all on every commit (as you describe with the ~2 days jobs).

Anyway, thanks for the feedback and please do not refrain from further
participation in this effort.  Your experience seems quite valuable.

Thanks,
- Cleber.


