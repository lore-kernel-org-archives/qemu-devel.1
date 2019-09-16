Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01A1C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A3120678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A3120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tXt-000123-NJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i9sKU-0004Ps-C8
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i9sKS-00028M-Og
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:50:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1i9sKS-000289-G5; Mon, 16 Sep 2019 10:50:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EE6010CC1F7;
 Mon, 16 Sep 2019 14:50:11 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D528643C1;
 Mon, 16 Sep 2019 14:50:09 +0000 (UTC)
Date: Mon, 16 Sep 2019 15:50:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190916144709.GD2884@work-vm>
References: <20190916093445.20507-1-bala24@linux.ibm.com>
 <20190916093445.20507-4-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916093445.20507-4-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 16 Sep 2019 14:50:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] tests/acceptance/migration: test to
 migrate will all machine types
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
> add migration test to query machine types supported by qemu binary
> and migrate vm will all supported type.
> 
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>

Depending on the architecture you might find that some machine types
aren't migratable while some are.

Dave

> ---
>  tests/acceptance/migration.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> index 0f3553c8f0..74416ccc21 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -49,3 +49,29 @@ class Migration(Test):
>          self.assertEqual(dest_vm.command('query-status')['status'], 'running')
>          self.assertEqual(source_vm.command('query-status')['status'],
>                           'postmigrate')
> +
> +
> +    def test_migration_with_machine_types(self):
> +        migration_port = self._get_free_port()
> +        for machine in self.get_machine_types():
> +            if 'pseries' in machine:
> +                print("migrating with machine type - {}".format(machine))
> +                source_vm = self.get_vm('-M', '{},cap-htm=off'.format(machine))
> +                dest_uri = 'tcp:localhost:%u' % migration_port
> +                dest_vm = self.get_vm('-M', '{},cap-htm=off'.format(machine),
> +                                      '-incoming', dest_uri)
> +                dest_vm.launch()
> +                source_vm.launch()
> +                source_vm.qmp('migrate', uri=dest_uri)
> +                wait.wait_for(
> +                    self.migration_finished,
> +                    timeout=self.timeout,
> +                    step=0.1,
> +                    args=(source_vm,)
> +                )
> +                self.assertEqual(source_vm.command('query-migrate')['status'],
> +                                                   'completed')
> +                self.assertEqual(dest_vm.command('query-status')['status'],
> +                                                 'running')
> +                self.assertEqual(source_vm.command('query-status')['status'],
> +                                                   'postmigrate')
> -- 
> 2.14.5
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

