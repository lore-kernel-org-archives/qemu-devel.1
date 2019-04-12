Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E1FC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 13:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B97B206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 13:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B97B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEwBU-0004Pj-DU
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 09:25:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEwAQ-00043O-IA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEwAP-0002oe-CF
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEwAP-0002oE-1c
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2070E8B12F;
	Fri, 12 Apr 2019 13:24:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C2F495D706;
	Fri, 12 Apr 2019 13:24:23 +0000 (UTC)
Date: Fri, 12 Apr 2019 14:24:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pu Wen <puwen@hygon.cn>
Message-ID: <20190412132420.GM25308@redhat.com>
References: <1555072669-20441-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1555072669-20441-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 12 Apr 2019 13:24:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC] i386: Add new Hygon 'Dhyana' and
 'Dhyana-IBPB' CPU models
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org,
	ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412132420.U-hQCzsHAqUGbGgOSGKSocU2tbLaTPBsxc3smiEJy1o@z>

On Fri, Apr 12, 2019 at 08:37:49PM +0800, Pu Wen wrote:
> Add two new base CPU models called 'Dhyana' and 'Dhyana-IBPB' to model
> processors from Hygon Dhyana (family 18h), which derived from AMD EPYC
> (family 17h). 'Dhyana-IBPB' is a copy of the 'Dhyana' CPU model with
> just CPUID_8000_0008_EBX_IBPB added.

Do we really need to support both CPU variants ?

The IBPB feature is the Spectre fix which dates from January 2018.
Having both made (limited) sense for EPYC as EPYC CPUs existed
already, so there would be a mix of EPYC CPUs with and without the
microcode that adds IBPB.

The Google results I see suggest that Dhyana CPUs started to become
available in July 2018, so surely they would come with microcode
that has the IBPB right from day 1 ?

Am I missing anything that means there will be a compelling need
to support Dhyana /without/ IBPB ?

If not, then we only need 1 CPU model and that would include IBPB.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

