Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3084FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB8F2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB8F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16hg-0003P4-DE
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1k16gr-0002xY-2z; Thu, 30 Jul 2020 07:25:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1k16gn-0004x7-Qe; Thu, 30 Jul 2020 07:25:36 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06UB4nxp071462; Thu, 30 Jul 2020 07:25:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32krge0fpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2020 07:25:30 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06UB51bY071925;
 Thu, 30 Jul 2020 07:25:29 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32krge0fna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2020 07:25:29 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06UBKtiX008393;
 Thu, 30 Jul 2020 11:25:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03fra.de.ibm.com with ESMTP id 32gcr0kqvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2020 11:25:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 06UBNwHJ66453910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 11:23:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C3E442041;
 Thu, 30 Jul 2020 11:25:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9A7342042;
 Thu, 30 Jul 2020 11:25:23 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.26.108])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2020 11:25:23 +0000 (GMT)
Date: Thu, 30 Jul 2020 13:25:21 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] s390x/s390-virtio-ccw: fix off-by-one in loadparm
 getter
Message-ID: <20200730132521.674ded34.pasic@linux.ibm.com>
In-Reply-To: <20200730122656.4942edbb.cohuck@redhat.com>
References: <20200729130222.29026-1-pasic@linux.ibm.com>
 <20200730122656.4942edbb.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-30_09:2020-07-30,
 2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 07:25:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 12:26:56 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 29 Jul 2020 15:02:22 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > As pointed out by Peter, g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1)
> > reads one past of the end of ms->loadparm, so g_memdup() can not be used
> > here.
> > 
> > Let's use malloc and memcpy instead!
> 
> Hm, an alternative would be to use g_strndup(). What do you think?

Sure. It is more concise and does exactly what we want. I'm not too
familiar with the string utility funcitons of glib, so it didn't jup
at me.

Shall I spin a v2?

Halil

> 
> > 
> > Fixes: d664548328 ("s390x/s390-virtio-ccw: fix loadparm property getter")
> > Fixes: Coverity CID 1431058
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  hw/s390x/s390-virtio-ccw.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index 403d30e13b..8b7bac0392 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -704,8 +704,8 @@ static char *machine_get_loadparm(Object *obj, Error **errp)
> >      char *loadparm_str;
> >  
> >      /* make a NUL-terminated string */
> > -    loadparm_str = g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1);
> > -    loadparm_str[sizeof(ms->loadparm)] = 0;
> > +    loadparm_str = g_malloc0(sizeof(ms->loadparm) + 1);
> > +    memcpy(loadparm_str, ms->loadparm, sizeof(ms->loadparm));
> >      return loadparm_str;
> >  }
> >  
> > 
> > base-commit: 5772f2b1fc5d00e7e04e01fa28e9081d6550440a
> 
> 


