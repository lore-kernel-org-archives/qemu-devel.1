Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CA0CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78252067D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmobQ3EA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78252067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQW8h-0000XI-Mw
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 08:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdenemar@redhat.com>) id 1iQW6U-0008Rw-R1
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdenemar@redhat.com>) id 1iQW6T-0007PO-O6
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:32:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1iQW6T-0007P0-Kc
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572611553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5yGqcBjN0WC8oIIPzuqHTYlo6GMXO14lRxeQz2s6Qg=;
 b=ZmobQ3EAMmUZLRspGcx0lIe1RENPeGpmg0H1dQS5RvkYA9npD1VjlslLPyGwOKhVpt94Ru
 /T0qLc25dhONqkMuKYWRKG7pNMBQIAQ4aYAZ8SdNA4Y1M1HInVX850QDjZ5fyQ3YdkzhjY
 mT1tPn8MTbAmDwaAhdSctMOB/5+TJOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-aDIjU4RbOFSQh7fla0hhUg-1; Fri, 01 Nov 2019 08:27:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E5CB800A1A;
 Fri,  1 Nov 2019 12:27:52 +0000 (UTC)
Received: from orkuz.int.mamuti.net (unknown [10.40.205.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 319D15D9CD;
 Fri,  1 Nov 2019 12:27:48 +0000 (UTC)
Received: by orkuz.int.mamuti.net (Postfix, from userid 500)
 id C9E452A7C74; Fri,  1 Nov 2019 13:27:55 +0100 (CET)
Date: Fri, 1 Nov 2019 13:27:55 +0100
From: Jiri Denemark <jdenemar@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
Message-ID: <20191101122755.GQ12962@orkuz.int.mamuti.net>
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
In-Reply-To: <20191030163243.10644-1-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: aDIjU4RbOFSQh7fla0hhUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: david@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 30, 2019 at 17:32:43 +0100, David Gibson wrote:
> We have to set the default model of all machine classes, not just for the
> active one. Otherwise, "query-machines" will indicate the wrong CPU model
> ("qemu-s390x-cpu" instead of "host-s390x-cpu") as "default-cpu-type".
>=20
> s390x already fixed this in de60a92e "s390x/kvm: Set default cpu model fo=
r
> all machine classes".  This patch applies a similar fix for the pseries-*
> machine types on ppc64.
>=20
> Doing a
>     {"execute":"query-machines"}
> under KVM now results in
>     {
>       "hotpluggable-cpus": true,
>       "name": "pseries-4.2",
>       "numa-mem-supported": true,
>       "default-cpu-type": "host-powerpc64-cpu",
>       "is-default": true,
>       "cpu-max": 1024,
>       "deprecated": false,
>       "alias": "pseries"
>     },
>     {
>       "hotpluggable-cpus": true,
>       "name": "pseries-4.1",
>       "numa-mem-supported": true,
>       "default-cpu-type": "host-powerpc64-cpu",
>       "cpu-max": 1024,
>       "deprecated": false
>     },
>     ...
>=20
> Libvirt probes all machines via "-machine none,accel=3Dkvm:tcg" and will
> currently see the wrong CPU model under KVM.
>=20
> Reported-by: Ji=C5=99i Denemark <jdenemar@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>

Works as expected now, thanks.

Tested-by: Jiri Denemark <jdenemar@redhat.com>


