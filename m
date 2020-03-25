Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A78C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A052073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A052073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH87K-0001rD-En
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH842-0004wr-0e
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH840-0004Mp-O3
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46828
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1jH840-0004Mb-Hz
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PFYdtR017930; Wed, 25 Mar 2020 11:35:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuww877-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:27 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02PFZRNi022932;
 Wed, 25 Mar 2020 11:35:27 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuww864-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:27 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02PFZAcC015323;
 Wed, 25 Mar 2020 15:35:25 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma03dal.us.ibm.com with ESMTP id 2ywaw9twc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 15:35:25 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFZOgX50528650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:35:24 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA44FBE04F;
 Wed, 25 Mar 2020 15:35:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF4D2BE054;
 Wed, 25 Mar 2020 15:35:22 +0000 (GMT)
Received: from localhost (unknown [9.85.207.6])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2020 15:35:22 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 14/15] numa: Introduce
 ram_block_notifiers_support_resize()
Date: Wed, 25 Mar 2020 12:24:28 -0300
Message-ID: <2342235.EQWJVSN7C6@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200305142945.216465-15-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-15-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=1 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250123
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, March 5, 2020 11:29:44 AM -03 David Hildenbrand wrote:
> We want to actually use resizeable allocations in resizeable ram blocks
> (IOW, make everything between used_length and max_length inaccessible) -
> however, not all ram block notifiers can support that.
>
> Introduce a way to detect if any registered notifier does not
> support resizes - ram_block_notifiers_support_resize() - which we can later
> use to fallback to legacy handling if a registered notifier (esp., SEV and
> HAX) does not support actual resizes.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

>  hw/core/numa.c         | 12 ++++++++++++
>  include/exec/ramlist.h |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 37ce175e13..1d5288c22c 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -914,3 +914,15 @@ void ram_block_notify_resize(void *host, size_t
> old_size, size_t new_size) }
>      }
>  }
> +
> +bool ram_block_notifiers_support_resize(void)
> +{
> +    RAMBlockNotifier *notifier;
> +
> +    QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
> +        if (!notifier->ram_block_resized) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> index 293c0ddabe..ac5811be96 100644
> --- a/include/exec/ramlist.h
> +++ b/include/exec/ramlist.h
> @@ -79,6 +79,7 @@ void ram_block_notifier_remove(RAMBlockNotifier *n);
>  void ram_block_notify_add(void *host, size_t size, size_t max_size);
>  void ram_block_notify_remove(void *host, size_t size, size_t max_size);
>  void ram_block_notify_resize(void *host, size_t old_size, size_t new_size);
> +bool ram_block_notifiers_support_resize(void);
>
>  void ram_block_dump(Monitor *mon);


--
Murilo

