Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56205C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2002F2189D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2002F2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9EN-00011s-5w
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iA9D4-0008Qs-Sd
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iA9D3-0004bZ-Bu
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:51:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32818
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iA9D3-0004bI-65
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:51:41 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8H8l7rZ123935
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 04:51:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v2tkpmcwv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 04:51:38 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 17 Sep 2019 09:51:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Sep 2019 09:51:34 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8H8pXHm59310148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2019 08:51:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27784AE059;
 Tue, 17 Sep 2019 08:51:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1160AE045;
 Tue, 17 Sep 2019 08:51:30 +0000 (GMT)
Received: from dhcp-9-120-237-81.in.ibm.com (unknown [9.120.237.81])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Sep 2019 08:51:30 +0000 (GMT)
Date: Tue, 17 Sep 2019 14:21:28 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190916093445.20507-1-bala24@linux.ibm.com>
 <20190916093445.20507-2-bala24@linux.ibm.com>
 <20190916185016.GF2884@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916185016.GF2884@work-vm>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19091708-0016-0000-0000-000002AD0D46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091708-0017-0000-0000-0000330DAFD3
Message-Id: <20190917085128.GB30607@dhcp-9-120-237-81.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170094
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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

On Mon, Sep 16, 2019 at 07:50:44PM +0100, Dr. David Alan Gilbert wrote:
> * Balamuruhan S (bala24@linux.ibm.com) wrote:
> > assert `query-migrate` in target doesn't give migration
> > status and test errors even if migration succeeds.
> > 
> > In target:
> > {'execute': 'query-migrate'}
> > {"return": {}}
> 
> On which version of qemu?

sorry I worked on this earlier and I haven't notice the version,
I re-tried the same in upstream Qemu and observed the one you have
posted. Thanks, I will remove this change in the next version.

But I am observing the error often while executing `query-migrate` from
test,

2019-09-17 03:15:34,797 qmp              L0167 DEBUG| >>> {'execute': 'query-migrate'}
2019-09-17 03:15:34,798 qmp              L0175 DEBUG| <<< {'return': {'expected-downtime': 300, 'status': 'active', 'setup-time': 1, 'total-time': 102, 'ram': {'total': 536870912, 'postcopy-requests': 0, 'dirty-sync-count': 1, 'multifd-bytes': 0, 'pages-per-second': 0, 'page-size': 4096, 'remaining': 4521984, 'mbps': 0, 'transferred': 3372844, 'duplicate': 129430, 'dirty-pages-rate': 0, 'skipped': 0, 'normal-bytes': 2203648, 'normal': 538}}}
2019-09-17 03:15:34,899 qmp              L0167 DEBUG| >>> {'execute': 'query-migrate'}
2019-09-17 03:15:34,899 qmp              L0087 DEBUG| <<< {'timestamp': {'seconds': 1568704534, 'microseconds': 802440}, 'event': 'STOP'}
2019-09-17 03:15:34,900 qmp              L0175 DEBUG| <<< {'return': {'status': 'completed', 'setup-time': 1, 'downtime': 30, 'total-time': 137, 'ram': {'total': 536870912, 'postcopy-requests': 0, 'dirty-sync-count': 4, 'multifd-bytes': 0, 'pages-per-second': 1299680, 'page-size': 4096, 'remaining': 0, 'mbps': 474.753235, 'transferred': 4548090, 'duplicate': 133244, 'dirty-pages-rate': 0, 'skipped': 0, 'normal-bytes': 3342336, 'normal': 816}}}
2019-09-17 03:15:34,900 qmp              L0167 DEBUG| >>> {'execute': 'query-migrate'}
2019-09-17 03:15:34,900 qmp              L0087 DEBUG| <<< {'timestamp': {'seconds': 1568704534, 'microseconds': 832595}, 'event': 'RESUME'}
2019-09-17 03:15:35,545 stacktrace       L0039 ERROR|
2019-09-17 03:15:35,545 stacktrace       L0042 ERROR| Reproduced traceback from: /usr/local/lib/python3.6/site-packages/avocado/core/test.py:853
2019-09-17 03:15:35,547 stacktrace       L0045 ERROR| Traceback (most recent call last):
2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/migration.py", line 47, in test_migration_with_tcp_localhost
2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|     self.assertEqual(dest_vm.command('query-migrate')['status'], 'completed')
2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/machine.py", line 378, in command
2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|     reply = self.qmp(cmd, conv_keys, **args)
2019-09-17 03:15:35,547 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/machine.py", line 370, in qmp
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     return self._qmp.cmd(cmd, args=qmp_args)
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/qmp.py", line 191, in cmd
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     return self.cmd_obj(qmp_cmd)
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/qmp.py", line 174, in cmd_obj
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     resp = self.__json_read()
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|   File "/home/bala/qemu/tests/acceptance/avocado_qemu/../../../python/qemu/qmp.py", line 82, in __json_read
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     data = self.__sockfile.readline()
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|   File "/usr/lib64/python3.6/socket.py", line 586, in readinto
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR|     return self._sock.recv_into(b)
2019-09-17 03:15:35,548 stacktrace       L0045 ERROR| ConnectionResetError: [Errno 104] Connection reset by peer


could you help me on what do I miss here ?

-- Bala

> 
> On the current version I see:
> 
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 4}, "package": "v4.1.0-852-g1a0b66e787"}, "capabilities": ["oob"]}}
> { "execute": "qmp_capabilities" }
> {"return": {}}
> {'execute': 'query-migrate'}
> {"return": {"status": "completed"}}
> 
> Dave
> > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > ---
> >  tests/acceptance/migration.py | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> > index a44c1ae58f..0f3553c8f0 100644
> > --- a/tests/acceptance/migration.py
> > +++ b/tests/acceptance/migration.py
> > @@ -44,7 +44,8 @@ class Migration(Test):
> >              step=0.1,
> >              args=(source_vm,)
> >          )
> > -        self.assertEqual(dest_vm.command('query-migrate')['status'], 'completed')
> > -        self.assertEqual(source_vm.command('query-migrate')['status'], 'completed')
> > +        self.assertEqual(source_vm.command('query-migrate')['status'],
> > +                         'completed')
> >          self.assertEqual(dest_vm.command('query-status')['status'], 'running')
> > -        self.assertEqual(source_vm.command('query-status')['status'], 'postmigrate')
> > +        self.assertEqual(source_vm.command('query-status')['status'],
> > +                         'postmigrate')
> > -- 
> > 2.14.5
> > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


