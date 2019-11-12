Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD82C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD42821783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1W1AcBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD42821783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUSjI-0001wp-TT
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 04:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iUSiR-0001Hu-Se
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iUSiQ-0001o1-GA
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:44:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40334
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iUSiQ-0001nq-CT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573551841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hkG+YUSK1ST7n+NFA16Jni+z6EuhafR3YtYAG6OcxA=;
 b=i1W1AcBp5Sme/wlq8EQL4cgXT/cUD6/bs7n2W7zMzVshbn4P2TS8wA6cLrW8bWXYAjOmyL
 P0uq5/X+XcbdX9JvGFumagqrFtrfbzX+MmE/CrM6B8Fguo7YBcDOr7tpDx5Tp665fCwqOo
 ES46WR6u0uuGyQqxLWaXQkYaGQX8RkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-2Oy9Gp9CORGbvWME0WjbYQ-1; Tue, 12 Nov 2019 04:42:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F232104FB61
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 09:42:43 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4426962671;
 Tue, 12 Nov 2019 09:42:40 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 70BFE3E044D; Tue, 12 Nov 2019 10:42:38 +0100 (CET)
Date: Tue, 12 Nov 2019 10:42:38 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH qemu-web] Add a blog post on "Micro-Optimizing KVM
 VM-Exits"
Message-ID: <20191112094238.GK7754@paraplu>
References: <20191108092247.16207-1-kchamart@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191108092247.16207-1-kchamart@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2Oy9Gp9CORGbvWME0WjbYQ-1
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
Cc: aarcange@redhat.com, dgilbert@redhat.com, rjones@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Cc: Rich Jones, addressing his feedback on IRC, below.]

On Fri, Nov 08, 2019 at 10:22:47AM +0100, Kashyap Chamarthy wrote:
> This blog post summarizes the talk "Micro-Optimizing KVM VM-Exits"[1],
> given by Andrea Arcangeli at the recently concluded KVM Forum 2019.
>=20
> [1] https://kvmforum2019.sched.com/event/Tmwr/micro-optimizing-kvm-vm-exi=
ts-andrea-arcangeli-red-hat-inc
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---

[...]

> +The microbechmark: CPUID in a one million loop
> +----------------------------------------------
> +
> +The synthetic microbenchmark (meaning, focus on measuring the
> +performance of a specific area of code) Andrea used was to run the CPUID
> +instruction one million times, without any GCC optimizations or caching.
> +This was done to test the latency of VM-Exits.

I can send a v2 (but will wait for any other feedback), or when applying
someone please replace the above paragraph with the following:

    "Andrea constructed a synthetic microbenchmark program (without any
    GCC optimizations or caching) which runs the CPUID instructions one
    million times in a loop.  This microbenchmark is meant to focus on
    measuring the performance of a specific area of the code -- in this
    case, to test the latency of VM-Exits."

(Rich, hope that reads better.  Thanks for the review.)

> +While stressing that the results of these microbenchmarks do not
> +represent real-world workloads, he had two goals in mind with it: (a)
> +explain how the software mitigation works; and (b) to justify to the
> +broader community the value of the software optimizations he's working
> +on in KVM.
> +
> +Andrea then reasoned through several interesting graphs that show how
> +CPU computation time gets impacted when you disable or enable the
> +various kernel-space mitigations for Spectre v2, L1TF, MDS, et al.

[...]

--=20
/kashyap


