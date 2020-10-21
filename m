Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED4DC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49312207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNRieLqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49312207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVDte-0007P1-UP
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 09:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVDsW-0006iS-W2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVDsS-0001ll-Bp
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603285802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qvs2ABlZS0aZZwJRffryyjzSoB/ux6XNxcNKjDnjric=;
 b=gNRieLqMsErXvFHsbUwnmu+yZLPKreDUp2eqsDpeTVkGP5r/8uRLyUn0qeLSjefbBsJrG4
 2xDBAF1UAL52CS84eJO2SeNy0PDQYZ0BkNmNj3zoXRVj9JS0YMcZadloOp6B4iaqwC10H1
 hEZgwoHXoHhSRp/jipEzYTqkh9DFMEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-PQtl8vlRPCu-22Edu1_vXg-1; Wed, 21 Oct 2020 09:09:57 -0400
X-MC-Unique: PQtl8vlRPCu-22Edu1_vXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D94C689BBDA;
 Wed, 21 Oct 2020 13:09:35 +0000 (UTC)
Received: from localhost (unknown [10.40.208.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 966826EF62;
 Wed, 21 Oct 2020 13:09:26 +0000 (UTC)
Date: Wed, 21 Oct 2020 15:09:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 0/3] qom: Simplify pointer property getters/setters
Message-ID: <20201021150924.5187602e@redhat.com>
In-Reply-To: <20201009191520.1799419-1-ehabkost@redhat.com>
References: <20201009191520.1799419-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  9 Oct 2020 15:15:17 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> The existing pointer property getters/setters are awkward because
> they are expected to work with const variables.  If we remove
> that requirement, they can become a lot simpler and simply call
> the visit_type_uint*() functions directly.

see my reply on 'qom: Make all -object types use only class properties' thread.
we should drop  pointer property getters/setter instead of extending it.

> 
> Git tree: https://github.com/ehabkost/qemu work/qom-ptr-prop-not-const
> Based-on: 20201009160122.1662082-1-ehabkost@redhat.com
> 
> Eduardo Habkost (3):
>   acpi: Don't pass const pointers to object_property_add_uint*_ptr()
>   qom: Make object_property_add_uint*_ptr() get non-const pointers
>   qom: Simplify and merge pointer property getters/setters
> 
>  include/qom/object.h |   8 +--
>  hw/acpi/ich9.c       |   2 +-
>  hw/acpi/piix4.c      |  10 ++--
>  hw/isa/lpc_ich9.c    |   4 +-
>  qom/object.c         | 122 +++++++++----------------------------------
>  5 files changed, 38 insertions(+), 108 deletions(-)
> 


