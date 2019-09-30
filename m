Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABECC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 21:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB23205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 21:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB23205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2so-0002kp-G1
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 17:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iF2rW-0001pm-Au
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iF2rT-000130-CJ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:05:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iF2rT-00012X-6l
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:05:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B364510C0938;
 Mon, 30 Sep 2019 21:05:37 +0000 (UTC)
Received: from localhost (ovpn-116-88.gru2.redhat.com [10.97.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B6156012A;
 Mon, 30 Sep 2019 21:05:34 +0000 (UTC)
Date: Mon, 30 Sep 2019 18:05:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: Arch info lost in "info cpus"
Message-ID: <20190930210533.GE4084@habkost.net>
References: <87blv2i5ha.fsf@redhat.com> <87lfu6kuyo.fsf@linaro.org>
 <878sq6hyn5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <878sq6hyn5.fsf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 30 Sep 2019 21:05:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: tao3.xu@intel.com, qemu-devel@nongnu.org, mihajlov@linux.vnet.ibm.com,
 imammedo@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 30, 2019 at 12:22:22PM +0200, Sergio Lopez wrote:
>=20
> Alex Benn=E9e <alex.bennee@linaro.org> writes:
>=20
> > Sergio Lopez <slp@redhat.com> writes:
> >
> >> Hi,
> >>
> >> Commit 137b5cb6ab565cb3781d5337591e155932b4230e (hmp: change
> >> hmp_info_cpus to use query-cpus-fast) updated the "info cpus" commit=
 to
> >> make it more lightweight, but also removed the ability to get the
> >> architecture specific status of each vCPU.
> >>
> >> This information was really useful to diagnose certain Guest issues,
> >> without the need of using GDB, which is more intrusive and requires
> >> enabling it in advance.
> >
> > You can always enable the gdbserver from the HMP when you need it.
> >
> >> Is there an alternative way of getting something equivalent to what
> >> "info cpus" provided previously (in 2.10)?
> >
> > info registers
> >
> > should give you a full dump of the CPU state including the PC.
> >
>=20
> Both methods are less convenient that what we had before. Perhaps it'd
> be reasonable adding a flag to "info cpus" to give users the options of
> having the same behavior as before?

Is "info registers -a" less convenient because it prints too much
information, or because it doesn't print the active CPU indicator
and thread_id?

--=20
Eduardo

