Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF2C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184D72073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b19LtwkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184D72073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdWO-00040e-5v
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iVdVm-0003ay-5E
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iVdVj-0008C3-Im
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:27:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iVdVj-0008BA-4I
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573831666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiCnlWumJgTyd2jDeJfFZ8DVe01VAYOASeeJXABtG9I=;
 b=b19LtwkNcg4rhEuMA7gi4bnP0KBfri7k3GWz2D5Vo8Oj8WL8VWO0ry/7ECOmCK+8VfxGm5
 Ex6zVNHwsF1+ExwhqnC6DO4mbbgz9zxj3CRMxvooaZulfKmffRYG/7f23LrpFgbJ31nV2Z
 d8zrS+m5LpU0rL08dWwox++d/0esYwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-sy_7heD6MeiukL2U8QxeHA-1; Fri, 15 Nov 2019 10:27:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF308C5EF0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 15:27:43 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-60.ams2.redhat.com [10.36.117.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 330081BC6E;
 Fri, 15 Nov 2019 15:27:41 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id AF3523E0483; Fri, 15 Nov 2019 16:27:39 +0100 (CET)
Date: Fri, 15 Nov 2019 16:27:39 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH qemu-web] Add a blog post on "Micro-Optimizing KVM
 VM-Exits"
Message-ID: <20191115152739.GV7754@paraplu>
References: <20191108092247.16207-1-kchamart@redhat.com>
 <5c1e9646-2e76-7429-95e6-c78afe9e93be@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5c1e9646-2e76-7429-95e6-c78afe9e93be@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sy_7heD6MeiukL2U8QxeHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: aarcange@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 15, 2019 at 01:45:51PM +0100, Laszlo Ersek wrote:
> On 11/08/19 10:22, Kashyap Chamarthy wrote:

[...]

> > +Guest workloads that are hard to virtualize
> > +-------------------------------------------
> > +
> > +At the 2019 edition of the KVM Forum in Lyon, kernel developer, Andrea
> > +Arcangeli, attempted to address the kernel part of minimizing VM-Exits=
.
>=20
> I'd suggest "addressed", not "attempted to address".

Will fix in next iteration.

[...]

> > +Conclusion
> > +----------

[...]

> > +Although, we still have to deal with mitigations for 'indirect branch
> > +prediction' for a long time, reducing the VM-Exit latency is important
> > +in general; and more specifically, for guest workloads that happen to
> > +trigger frequent VM-Exits, without having to disable Spectre v2
> > +mitigations on the host, as Andrea stated in the cover letter of his
> > +patch series.
> >=20
>=20
> This article refers to "indirect calls" and "indirect branches" quite a
> few times.
>=20
> I suggest mentioning "function pointers" at least once...
>=20
> (AIUI, the core of the issue is that kvm.ko calls kvm-intel.ko and
> kvm-amd.ko through function pointers. Such calls are the target of
> malicious branch predictor mis-training, and therefore, as a
> counter-measure, they are compiled into retpolines, rather than the
> directly corresponding indirect call assembly instructions. But
> retpolines run slowly, in comparison. Calling the functions in question
> by name, in the C source code, rather than via function pointers,
> eliminates the indirect call assembly instructions, and obviates the
> need for retpolines. The resultant C source code is less abstract and
> less dynamic at runtime, but the original indirection isn't inherently
> necessary at runtime.)
>=20
> I couldn't attend Andrea's presentation, nor have I seen the slides, or
> a recording thereof, or the patchset; so I could easily be off.=20

I think your above explanation is indeed correct (which I couldn't have
articulated so well; thanks!), based on my understanding, and reading
Andrea's patch[*] and its commit message:

    "This [patch] replaces all kvm_x86_ops pointer to functions with
    regular external functions that don't require indirect calls.

    "[...] The pointer to function virtual template model cannot provide
    any runtime benefit because kvm-intel and kvm-amd can't be loaded at
    the same time. [...]"


[*] https://lkml.org/lkml/2019/9/20/932 --  [PATCH 02/17] KVM:
    monolithic: x86: convert the kvm_x86_ops methods to external functions

> My point is, *if* the expression "function pointers" applies in this
> context, please do mention it; otherwise "indirect calls" just hangs
> in the air, IMHO.
>=20
> It might be as simple as replacing
>=20
>   These indirect calls were not optimal before,
>=20
> with
>=20
>   These indirect calls -- via function pointers in the C source code
>   -- were not optimal before,

Will fix; thanks for the thorough review.

If you want to read Andrea's slides, here they are:

    https://static.sched.com/hosted_files/kvmforum2019/3b/kvm-monolithic.pd=
f

Thanks for the review!

--=20
/kashyap


