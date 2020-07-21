Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8685BC433ED
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AD520720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD02Z8YN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AD520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxo0q-0004OL-Ij
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxo0D-0003t3-9G
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:51:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxo0A-0003LZ-96
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595321513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIpG0bL/Vk9hwg0/bNtGM7jmcH1ViWQcHp6c70efdmE=;
 b=LD02Z8YNP7iP6EVsUlFWjBGDgkB8DeNuhIVAQvZTAVmfCn5NhrPDLk2R6tRq2um8F/ywj2
 hwzildzFQf1Iu7U5PTircW52yBnNiPfrf/LKKO/cgSzRxqRd2Dd1M3mIkyVrY8+sR9pXmi
 pBCFHzfSBQMow4mIq3TtvkXgjLgaLVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-gZF6FJVNPlumrteuk7330Q-1; Tue, 21 Jul 2020 04:51:45 -0400
X-MC-Unique: gZF6FJVNPlumrteuk7330Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11A0C8014D7;
 Tue, 21 Jul 2020 08:51:44 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9B157303C;
 Tue, 21 Jul 2020 08:51:42 +0000 (UTC)
Date: Tue, 21 Jul 2020 09:51:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 1/3] qga/qapi-schema: Document -1 for invalid PCI
 address fields
Message-ID: <20200721085139.GA843362@redhat.com>
References: <20200720110133.4366-1-thuth@redhat.com>
 <20200720110133.4366-2-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200720110133.4366-2-thuth@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 01:01:31PM +0200, Thomas Huth wrote:
> The "guest-get-fsinfo" could also be used for non-PCI devices in the
> future. And the code in GuestPCIAddress() in qga/commands-win32.c seems
> to be using "-1" for fields that it can not determine already. Thus
> let's properly document "-1" as value for invalid PCI address fields.

Urgh that's a bit of a design flaw - "pci-controller" should have
been an optional field instead, but we can't fix that without
breaking compat with existing clients :-(

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qga/qapi-schema.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 4be9aad48e..408a662ea5 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -846,7 +846,7 @@
>  ##
>  # @GuestDiskAddress:
>  #
> -# @pci-controller: controller's PCI address
> +# @pci-controller: controller's PCI address (fields are set to -1 if invalid)
>  # @bus-type: bus type
>  # @bus: bus id
>  # @target: target id

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


