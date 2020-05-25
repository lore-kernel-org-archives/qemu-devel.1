Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5F5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EE22071C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecfbjVem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EE22071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdHUt-0001P0-JP
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 14:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jdHUJ-0000wz-IP
 for qemu-devel@nongnu.org; Mon, 25 May 2020 14:06:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jdHUH-0007Rx-Hm
 for qemu-devel@nongnu.org; Mon, 25 May 2020 14:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590429967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/DDgapRgUhw5fsX2mco1n6wVSvH9IZ17HbLPwNCSB9Y=;
 b=ecfbjVemOFRl0xGyQ7SyX1yoBmDSZ6tHjlif2SzOJnuwOU5KJ2YKVlhPw8VCPtEFFL02hi
 GJGXRvCX4qIc1b/s4aVKBRXIJCaQAwj7ZoU6enPkRmN8aCQBFg0MM5Vgdssuk9EhIYQrE5
 pCl2VjNsSBmLciZn1qvzoCv0meuYsY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-su92_W6BOnaE7K-TRGnlcQ-1; Mon, 25 May 2020 14:06:05 -0400
X-MC-Unique: su92_W6BOnaE7K-TRGnlcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 785A9460;
 Mon, 25 May 2020 18:06:04 +0000 (UTC)
Received: from localhost (ovpn-112-192.phx2.redhat.com [10.3.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DB9D5C1C5;
 Mon, 25 May 2020 18:06:04 +0000 (UTC)
Date: Mon, 25 May 2020 14:06:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH 2/2] qmp: Expose MachineClass::default_ram_id
Message-ID: <20200525180603.GS577771@habkost.net>
References: <cover.1590426097.git.mprivozn@redhat.com>
 <2dbffbc4e2c0f3a0184daaadf56f94a85aedef58.1590426097.git.mprivozn@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2dbffbc4e2c0f3a0184daaadf56f94a85aedef58.1590426097.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 07:03:28PM +0200, Michal Privoznik wrote:
> If a management application (like Libvirt) want's to preserve
> migration ability and switch to '-machine memory-backend' it
> needs to set exactly the same RAM id as QEMU would. Since the id
> is machine type dependant, expose it under 'query-machines'
> result.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

The code looks good, but documentation was a bit confusing:

> ---
[...]
> +# @default-ram-id: the default name of initial RAM memory region (since 5.1)
> +#

Everywhere else in the commit message you call it "id", but here
you say "name".  Also, I don't think we have any references to a
"memory region" abstraction in the docs for the QAPI schema,
-machine options, or memory backend objects.

I had to look it up in the code, to finally understand you were
talking about the memory backend object ID.

To make it consistent with terminology used for -machine and
QAPI, I suggest:

  @default-ram-id: the default ID of initial RAM memory backend (since 5.1)

I can change it before committing, if you agree.



>  # @default-cpu-type: default CPU model typename if none is requested via
>  #                    the -cpu argument. (since 4.2)
>  #
> @@ -361,7 +363,8 @@
>    'data': { 'name': 'str', '*alias': 'str',
>              '*is-default': 'bool', 'cpu-max': 'int',
>              'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
> -            'deprecated': 'bool', '*default-cpu-type': 'str' } }
> +            'deprecated': 'bool', 'default-ram-id': 'str',
> +            '*default-cpu-type': 'str' } }
>  
>  ##
>  # @query-machines:
> -- 
> 2.26.2
> 

-- 
Eduardo


