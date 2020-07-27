Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94DAC433ED
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B687E206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4SnhlWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B687E206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04ez-0002zk-Sk
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k04eP-0002XF-KB
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:02:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k04du-0005xR-Tl
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595862138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bsciqIa8fXOddHPzcAGR7K9op1vJPoheDHoXbCvop18=;
 b=N4SnhlWRxkL0pxKdXw/lmv4SD/q0dgut9FI4OZumkCQa3Sfe9qvBI/scmNkwpDSXgQ3+3N
 dmCPOJPXZ+ZKIgLR6STG2yIYRs2zZNsep2QqVbcLmSz8mwj6o04HDXyXyXHbPzC+blys2U
 dpGXeRWxWOcn4dVdpYmAmfTDPtnxG0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-rFIiD02OPoaGU8VroFhj_A-1; Mon, 27 Jul 2020 11:02:13 -0400
X-MC-Unique: rFIiD02OPoaGU8VroFhj_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C2308017FB;
 Mon, 27 Jul 2020 15:02:11 +0000 (UTC)
Received: from work-vm (ovpn-114-135.ams2.redhat.com [10.36.114.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89DDF5D9E8;
 Mon, 27 Jul 2020 15:02:00 +0000 (UTC)
Date: Mon, 27 Jul 2020 16:01:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.2 v4 08/10] spapr: PEF: block migration
Message-ID: <20200727150157.GP3040@work-vm>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-9-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724025744.69644-9-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: pair@us.ibm.com, Cornelia Huck <cohuck@redhat.com>, brijesh.singh@amd.com,
 frankja@linux.ibm.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Gibson (david@gibson.dropbear.id.au) wrote:
> We haven't yet implemented the fairly involved handshaking that will be
> needed to migrate PEF protected guests.  For now, just use a migration
> blocker so we get a meaningful error if someone attempts this (this is the
> same approach used by AMD SEV).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/pef.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/ppc/pef.c b/target/ppc/pef.c
> index 53a6af0347..6a50efd580 100644
> --- a/target/ppc/pef.c
> +++ b/target/ppc/pef.c
> @@ -36,6 +36,8 @@ struct PefGuestState {
>      Object parent_obj;
>  };
>  
> +static Error *pef_mig_blocker;
> +
>  static int pef_kvm_init(HostTrustLimitation *gmpo, Error **errp)
>  {
>      if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_SECURE_GUEST)) {
> @@ -52,6 +54,10 @@ static int pef_kvm_init(HostTrustLimitation *gmpo, Error **errp)
>          }
>      }
>  
> +    /* add migration blocker */
> +    error_setg(&pef_mig_blocker, "PEF: Migration is not implemented");
> +    migrate_add_blocker(pef_mig_blocker, &error_abort);
> +

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

You might want that to be &error_fatal rather than error_abort; I think
someone could trigger it just by using --only-migratable together with
your pef device?

(I previously asked whether this would trigger with -cpu host; I hadn't
noticed this was based on the device rather than the CPU flag that said
whether you had the feature)

Dave

>      return 0;
>  }
>  
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


