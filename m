Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B6BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033BA20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezoCPhRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033BA20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqry-0008Ab-92
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAqrR-0007fC-68
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:32:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42052
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAqrP-00087a-FM
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598430766;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCwBnVzUoSX3rfUk0Ds5UrRHtvb2YIdQ1jipLX4s0E0=;
 b=ezoCPhRCxsBIld7rn87HZUoE45WpCQ7ybKDBVvG4S3mhzGjb+vaXs2wpyfvDQvGORAxrS9
 roqloAsWCR/kHOv/iXoHaDfgWdQabp05GSXCjDIryxCm1JjqTxEqLENuD8iLS97t92Ho8W
 8dXDFTRLaGhdYzlFWZJ90kqZKBGXpS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-vLzlYaEtPE-Ee6jMQy3X3g-1; Wed, 26 Aug 2020 04:32:44 -0400
X-MC-Unique: vLzlYaEtPE-Ee6jMQy3X3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D01348030C1;
 Wed, 26 Aug 2020 08:32:40 +0000 (UTC)
Received: from redhat.com (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D23781944D;
 Wed, 26 Aug 2020 08:32:36 +0000 (UTC)
Date: Wed, 26 Aug 2020 09:32:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH v2 3/5] meson: add docdir option and pass pre-prefix
 qemu_docdir
Message-ID: <20200826083234.GE168515@redhat.com>
References: <20200825175827.355940-1-marcandre.lureau@redhat.com>
 <20200825175827.355940-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200825175827.355940-4-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: sw@weilnetz.de, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 09:58:25PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When cross-compiling, by default qemu_docdir is 'c:\Program Files\QEMU\'
> which is not recognized as being an absolute path, and meson will end up
> adding the prefix again.
> 
> Add an option to pass docdir location to meson, pre-prefixed like we do
> with other directories and use that instead of config_host['qemu_docdir'].
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  configure         | 1 +
>  docs/meson.build  | 4 ++--
>  meson.build       | 3 ++-
>  meson_options.txt | 1 +
>  4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index e19e2de2f0..e644841299 100755
> --- a/configure
> +++ b/configure
> @@ -8223,6 +8223,7 @@ NINJA=$PWD/ninjatool $meson setup \
>          --sysconfdir "${pre_prefix}$sysconfdir" \
>          --localstatedir "${pre_prefix}$local_statedir" \
>          -Dconfsuffix="$confsuffix" \
> +        -Ddocdir="${pre_prefix}$qemu_docdir" \

This is passing an absolute path.....


> diff --git a/meson_options.txt b/meson_options.txt
> index 7bb2c0fca9..fb9312fddd 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -1,4 +1,5 @@
>  option('confsuffix', type : 'string', value: 'qemu')
> +option('docdir', type : 'string', value : 'doc/qemu')

...but this default is a relative dir, presumably relative to
datadir.  The code expects an absolute dir.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


