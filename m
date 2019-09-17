Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FAEC4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C8121881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C8121881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9zd-0001y0-SY
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iA9yv-0001Vn-6F
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iA9ys-0000TU-H4
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:41:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1iA9ys-0000So-8H; Tue, 17 Sep 2019 05:41:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A13110C0924;
 Tue, 17 Sep 2019 09:41:05 +0000 (UTC)
Received: from work-vm (ovpn-116-53.ams2.redhat.com [10.36.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A7F45D9DC;
 Tue, 17 Sep 2019 09:41:00 +0000 (UTC)
Date: Tue, 17 Sep 2019 10:40:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190917094057.GC3370@work-vm>
References: <20190916093445.20507-1-bala24@linux.ibm.com>
 <20190916093445.20507-2-bala24@linux.ibm.com>
 <20190916185016.GF2884@work-vm>
 <20190917085128.GB30607@dhcp-9-120-237-81.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917085128.GB30607@dhcp-9-120-237-81.in.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 17 Sep 2019 09:41:05 +0000 (UTC)
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
> On Mon, Sep 16, 2019 at 07:50:44PM +0100, Dr. David Alan Gilbert wrote:
> > * Balamuruhan S (bala24@linux.ibm.com) wrote:
> > > assert `query-migrate` in target doesn't give migration
> > > status and test errors even if migration succeeds.
> > > 
> > > In target:
> > > {'execute': 'query-migrate'}
> > > {"return": {}}
> > 
> > On which version of qemu?
> 
> sorry I worked on this earlier and I haven't notice the version,
> I re-tried the same in upstream Qemu and observed the one you have
> posted. Thanks, I will remove this change in the next version.
> 

Great; I don't think it always returns a status; but it should in most
cases after a migration.

> But I am observing the error often while executing `query-migrate` from
> test,
> 
> 2019-09-17 03:15:34,797 qmp              L0167 DEBUG| >>> {'execute': 'query-migrate'}
> 2019-09-17 03:15:34,798 qmp              L0175 DEBUG| <<< {'return': {'expected-downtime': 300, 'status': 'active', 'setup-time': 1, 'total-time': 102, 'ram': {'total': 536870912, 'postcopy-requests': 0, 'dirty-sync-count': 1, 'multifd-bytes': 0, 'pages-per-second': 0, 'page-size': 4096, 'remaining': 4521984, 'mbps': 0, 'transferred': 3372844, 'duplicate': 129430, 'dirty-pages-rate': 0, 'skipped': 0, 'normal-bytes': 2203648, 'normal': 538}}}
> 2019-09-17 03:15:34,899 qmp              L0167 DEBUG| >>> {'execute': 'query-migrate'}
> 2019-09-17 03:15:34,899 qmp              L0087 DEBUG| <<< {'timestamp': {'seconds': 1568704534, 'microseconds': 802440}, 'event': 'STOP'}
> 2019-09-17 03:15:34,900 qmp              L0175 DEBUG| <<< {'return': {'status': 'completed', 'setup-time': 1, 'downtime': 30, 'total-time': 137, 'ram': {'total': 536870912, 'postcopy-requests': 0, 'dirty-sync-count': 4, 'multifd-bytes': 0, 'pages-per-second': 1299680, 'page-size': 4096, 'remaining': 0, 'mbps': 474.753235, 'transferred': 4548090, 'duplicate': 133244, 'dirty-pages-rate': 0, 'skipped': 0, 'normal-bytes': 3342336, 'normal': 816}}}
> 2019-09-17 03:15:34,900 qmp              L0167 DEBUG| >>> {'execute': 'query-migrate'}
> 2019-09-17 03:15:34,900 qmp              L0087 DEBUG| <<< {'timestamp': {'seconds': 1568704534, 'microseconds': 832595}, 'event': 'RESUME'}
> 2019-09-17 03:15:35,545 stacktrace       L0039 ERROR|
> 2019-09-17 03:15:35,545 stacktrace       L0042 ERROR| Reproduced traceback from: /usr/local/lib/python3.6/site-packages/avocado/core/test.py:853
> 2019-09-17 03:15:35,547 stacktrace       L0045 ERROR| Traceback (most recent call last):
> 2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/migration.py", line 47, in test_migration_with_tcp_localhost
> 2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|     self.assertEqual(dest_vm.command('query-migrate')['status'], 'completed')
> 2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/machine.py", line 378, in command
> 2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|     reply = self.qmp(cmd, conv_keys, **args)
> 2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/machine.py", line 370, in qmp
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     return self._qmp.cmd(cmd, args=qmp_args)
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/qmp.py", line 191, in cmd
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     return self.cmd_obj(qmp_cmd)
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/qmp.py", line 174, in cmd_obj
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     resp = self.__json_read()
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/qmp.py", line 82, in __json_read
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     data = self.__sockfile.readline()
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|   File "/usr/lib64/python3.6/socket.py", line 586, in readinto
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     return self._sock.recv_into(b)
> 2019-09-17 03:15:35,548 stacktrace       L0045 ERROR| ConnectionResetError: [Errno 104] Connection reset by peer
> 
> 
> could you help me on what do I miss here ?

I don't know avocado much; but that looks as though the qemu has exited
on you.

Dave


> -- Bala
> 
> > 
> > On the current version I see:
> > 
> > {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 4}, "package": "v4.1.0-852-g1a0b66e787"}, "capabilities": ["oob"]}}
> > { "execute": "qmp_capabilities" }
> > {"return": {}}
> > {'execute': 'query-migrate'}
> > {"return": {"status": "completed"}}
> > 
> > Dave
> > > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > > ---
> > >  tests/acceptance/migration.py | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> > > index a44c1ae58f..0f3553c8f0 100644
> > > --- a/tests/acceptance/migration.py
> > > +++ b/tests/acceptance/migration.py
> > > @@ -44,7 +44,8 @@ class Migration(Test):
> > >              step=0.1,
> > >              args=(source_vm,)
> > >          )
> > > -        self.assertEqual(dest_vm.command('query-migrate')['status'], 'completed')
> > > -        self.assertEqual(source_vm.command('query-migrate')['status'], 'completed')
> > > +        self.assertEqual(source_vm.command('query-migrate')['status'],
> > > +                         'completed')
> > >          self.assertEqual(dest_vm.command('query-status')['status'], 'running')
> > > -        self.assertEqual(source_vm.command('query-status')['status'], 'postmigrate')
> > > +        self.assertEqual(source_vm.command('query-status')['status'],
> > > +                         'postmigrate')
> > > -- 
> > > 2.14.5
> > > 
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

