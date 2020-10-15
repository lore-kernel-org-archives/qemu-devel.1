Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A307C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61DB21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUcdg5sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61DB21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5mg-0007uC-Fj
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT5jM-0004R8-Bl
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT5jJ-0003Fm-0v
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602777827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nmic/FuGOqCx9N2HiaICOHOhqYqCugXaJrO+KUjniuk=;
 b=AUcdg5shfSwxO/qyc4PtGSHKtRo5XZXYjr+IwTgENGyIk5mrHES5e4W8IR/CwXJBZ7Miyy
 dpKvRUgZIdktFGcN/Jz9Cz8v7QDm6XFotld/SPo2tr0FTvEr6cMmMDMemI5NIVg6yc3QoG
 w/qJq2RgVScaAy7WKaxmFwFhGA3QFdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-ODx0xcPjPoqocMDP5uUaTw-1; Thu, 15 Oct 2020 12:03:45 -0400
X-MC-Unique: ODx0xcPjPoqocMDP5uUaTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FD4512C6C4;
 Thu, 15 Oct 2020 16:03:44 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECF3B10013DB;
 Thu, 15 Oct 2020 16:03:43 +0000 (UTC)
Date: Thu, 15 Oct 2020 12:03:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] docs: Print warning when running Sphinx 3.x and newer
Message-ID: <20201015160343.GD5733@habkost.net>
References: <20201014223356.324990-1-ehabkost@redhat.com>
 <CAFEAcA_pqLT5BNuw8tEyuiBZj1LJCLTqh-ucFoA9aNPecWsfWg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_pqLT5BNuw8tEyuiBZj1LJCLTqh-ucFoA9aNPecWsfWg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 01:38:49PM +0100, Peter Maydell wrote:
> On Wed, 14 Oct 2020 at 23:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > This won't prevent the docs from being built, but will let people
> > know Sphinx 3.x is not fully supported yet.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Sphinx 3.0.1 works fine for me, so I think we probably
> want to set the cutoff somewhere else than just 3.0.

Sphinx 3.0.0+ doesn't know how to handle macro documentation generated by
kernel-doc:

  Running Sphinx v3.0.1
  building [mo]: targets for 0 po files that are out of date
  building [html]: targets for 22 source files that are out of date
  updating environment: [new config] 22 added, 0 changed, 0 removed
  reading sources... [100%] testing
  
  Warning, treated as error:
  /home/ehabkost/rh/proj/virt/qemu/docs/../include/qom/object.h:155:Error in declarator
  If declarator-id with parameters (e.g., 'void f(int arg)'):
    Invalid C declaration: Expected identifier in nested name. [error at 25]
      DECLARE_INSTANCE_CHECKER ( InstanceType,  OBJ_NAME,  TYPENAME)
      -------------------------^
  If parenthesis in noptr-declarator (e.g., 'void (*f(int arg))(double)'):
    Error in declarator or parameters
    Invalid C declaration: Expecting "(" in parameters. [error at 39]
      DECLARE_INSTANCE_CHECKER ( InstanceType,  OBJ_NAME,  TYPENAME)
      ---------------------------------------^
  
  make: *** [Makefile.ninja:9897: docs/devel.stamp] Error 2
  make: *** Deleting file 'docs/devel.stamp'


-- 
Eduardo


