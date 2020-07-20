Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94342C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CE620B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbvFRrRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CE620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWbg-0002gK-Kg
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxWac-00012G-MY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:16:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25087
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxWaa-0002lG-V2
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595254580;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VnWwnBA7bibI/BD/RADjapULEjAc8iF6V3spLaU7rbg=;
 b=EbvFRrRyp/pugjEo8TuFXP6SnsQQ2sDb2UG0a9n0cvr2JHzuBpNRDDwoARRewWyFmWTcty
 XTeBGHT+D7smELHyqjhnf5IdGHvhxxAbR8xmh6mflWWjlqblSKYt1a7CBkn11N8jxOq01c
 0SAFyLhdqoYlSEhXt6vVkN7rneRKDSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-eOA1W7IkO7aEzLjInQYOWg-1; Mon, 20 Jul 2020 10:16:17 -0400
X-MC-Unique: eOA1W7IkO7aEzLjInQYOWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E9E8527ED;
 Mon, 20 Jul 2020 14:16:12 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF5C119C71;
 Mon, 20 Jul 2020 14:16:09 +0000 (UTC)
Date: Mon, 20 Jul 2020 15:16:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 3/4] qemu-common: Document qemu_find_file()
Message-ID: <20200720141607.GH643836@redhat.com>
References: <20200714164257.23330-1-f4bug@amsat.org>
 <20200714164257.23330-4-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200714164257.23330-4-f4bug@amsat.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 06:42:56PM +0200, Philippe Mathieu-Daudé wrote:
> Document qemu_find_file(), in particular the returned
> value which must be freed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/qemu-common.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index d0142f29ac..d6a08259d3 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -110,6 +110,20 @@ const char *qemu_get_vm_name(void);
>  
>  #define QEMU_FILE_TYPE_BIOS   0
>  #define QEMU_FILE_TYPE_KEYMAP 1
> +/**
> + * qemu_find_file:
> + * @type: QEMU_FILE_TYPE_BIOS (for BIOS, VGA BIOS)
> + *        or QEMU_FILE_TYPE_KEYMAP (for keymaps).
> + * @name: File name

s/File name/relative or absolute file name/

> + *

Insert:

  "If @name exists on disk as an absolute path, or a path relative
   to the current directory, then returns @name unchanged.


> + * Search for @name file in the data directories, either configured at
> + * build time (DATADIR) or registered with the -L command line option.

s/Search/Otherwise searches/


> + *
> + * The caller must use g_free() to free the returned data when it is
> + * no longer required.
> + *
> + * Returns: absolute path to the file or NULL on error.

It doesn't always return an absolute path. It can return a path
relative to the currently working directory via the initial
short-circuit access() check.

   Returns: a path that can access @name, or NULL if no matching
            file exists.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


