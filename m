Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02867C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 18:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D5120665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 18:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D5120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9w7L-0003m2-Vj
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 14:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i9w5w-0002ia-Qy
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 14:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i9w5o-0003Yv-Bh
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 14:51:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1i9w5L-0003EA-0M; Mon, 16 Sep 2019 14:51:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2B923003715;
 Mon, 16 Sep 2019 18:50:48 +0000 (UTC)
Received: from work-vm (ovpn-116-39.ams2.redhat.com [10.36.116.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A251E60BE1;
 Mon, 16 Sep 2019 18:50:46 +0000 (UTC)
Date: Mon, 16 Sep 2019 19:50:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190916185016.GF2884@work-vm>
References: <20190916093445.20507-1-bala24@linux.ibm.com>
 <20190916093445.20507-2-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916093445.20507-2-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 16 Sep 2019 18:50:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] tests/acceptance/migration: fix post
 migration check
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
Cc: ehabkost@redhat.com, groug@kaod.org, qemu-devel@nongnu.org,
 sathnaga@linux.vnet.ibm.com, clg@kaod.org, crosa@redhat.com,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Balamuruhan S (bala24@linux.ibm.com) wrote:
> assert `query-migrate` in target doesn't give migration
> status and test errors even if migration succeeds.
> 
> In target:
> {'execute': 'query-migrate'}
> {"return": {}}

On which version of qemu?

On the current version I see:

{"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 4}, "package": "v4.1.0-852-g1a0b66e787"}, "capabilities": ["oob"]}}
{ "execute": "qmp_capabilities" }
{"return": {}}
{'execute': 'query-migrate'}
{"return": {"status": "completed"}}

Dave
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  tests/acceptance/migration.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> index a44c1ae58f..0f3553c8f0 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -44,7 +44,8 @@ class Migration(Test):
>              step=0.1,
>              args=(source_vm,)
>          )
> -        self.assertEqual(dest_vm.command('query-migrate')['status'], 'completed')
> -        self.assertEqual(source_vm.command('query-migrate')['status'], 'completed')
> +        self.assertEqual(source_vm.command('query-migrate')['status'],
> +                         'completed')
>          self.assertEqual(dest_vm.command('query-status')['status'], 'running')
> -        self.assertEqual(source_vm.command('query-status')['status'], 'postmigrate')
> +        self.assertEqual(source_vm.command('query-status')['status'],
> +                         'postmigrate')
> -- 
> 2.14.5
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

