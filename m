Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCEC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C5120862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C5120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9B3-00064a-Re
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iA99O-0004wg-Jq
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iA99N-0001pd-FW
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:47:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iA97Q-0000n0-GQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:47:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8H8hMRo034934
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 04:45:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v2v5vr9de-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 04:45:50 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 17 Sep 2019 09:45:48 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Sep 2019 09:45:43 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8H8jgNL42467358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 08:45:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85C48A405D;
 Tue, 17 Sep 2019 08:45:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BAE0A4053;
 Tue, 17 Sep 2019 08:45:40 +0000 (GMT)
Received: from dhcp-9-120-237-81.in.ibm.com (unknown [9.120.237.81])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Sep 2019 08:45:39 +0000 (GMT)
Date: Tue, 17 Sep 2019 14:15:37 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190916093445.20507-1-bala24@linux.ibm.com>
 <20190916093445.20507-4-bala24@linux.ibm.com>
 <20190916144709.GD2884@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916144709.GD2884@work-vm>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19091708-0028-0000-0000-0000039E07FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091708-0029-0000-0000-000024607FFD
Message-Id: <20190917084537.GA30607@dhcp-9-120-237-81.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170093
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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

On Mon, Sep 16, 2019 at 03:50:06PM +0100, Dr. David Alan Gilbert wrote:
> * Balamuruhan S (bala24@linux.ibm.com) wrote:
> > add migration test to query machine types supported by qemu binary
> > and migrate vm will all supported type.
> > 
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> 
> Depending on the architecture you might find that some machine types
> aren't migratable while some are.

Thanks Dave, is there a way to query/check whether a machine type on the
architecture is migratable or should we try migrating and handle exception
on failure ?

-- Bala
> 
> Dave
> 
> > ---
> >  tests/acceptance/migration.py | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> > index 0f3553c8f0..74416ccc21 100644
> > --- a/tests/acceptance/migration.py
> > +++ b/tests/acceptance/migration.py
> > @@ -49,3 +49,29 @@ class Migration(Test):
> >          self.assertEqual(dest_vm.command('query-status')['status'], 'running')
> >          self.assertEqual(source_vm.command('query-status')['status'],
> >                           'postmigrate')
> > +
> > +
> > +    def test_migration_with_machine_types(self):
> > +        migration_port = self._get_free_port()
> > +        for machine in self.get_machine_types():
> > +            if 'pseries' in machine:
> > +                print("migrating with machine type - {}".format(machine))
> > +                source_vm = self.get_vm('-M', '{},cap-htm=off'.format(machine))
> > +                dest_uri = 'tcp:localhost:%u' % migration_port
> > +                dest_vm = self.get_vm('-M', '{},cap-htm=off'.format(machine),
> > +                                      '-incoming', dest_uri)
> > +                dest_vm.launch()
> > +                source_vm.launch()
> > +                source_vm.qmp('migrate', uri=dest_uri)
> > +                wait.wait_for(
> > +                    self.migration_finished,
> > +                    timeout=self.timeout,
> > +                    step=0.1,
> > +                    args=(source_vm,)
> > +                )
> > +                self.assertEqual(source_vm.command('query-migrate')['status'],
> > +                                                   'completed')
> > +                self.assertEqual(dest_vm.command('query-status')['status'],
> > +                                                 'running')
> > +                self.assertEqual(source_vm.command('query-status')['status'],
> > +                                                   'postmigrate')
> > -- 
> > 2.14.5
> > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


