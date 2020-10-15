Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33445C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343BF218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lv2Bcctm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343BF218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT26O-00044S-43
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 08:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kT25X-0003bl-AD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kT25V-0005bo-5d
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602763828;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNjbJUtWbgOku837d3guxO3UyuQVy08mw+okuKBuhSQ=;
 b=Lv2Bcctm/vvr72bgPUidL/Z4ZbwHEHtKwSftytlRx3V/dGz1C4NESmWdX0lDSGJIvJepvv
 SLXBLjtWM1flAtsuQRsJ4afmXgb6Bmc+ZFYN59kfQX/4QhpPvA+zR96+duYR+zwGUcxSjk
 stwJLp+RXc+fVN0uXBHgV0qhoqejXlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-XdssEIgtM2ayDd-2xLO79w-1; Thu, 15 Oct 2020 08:10:23 -0400
X-MC-Unique: XdssEIgtM2ayDd-2xLO79w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7ECC802B4B;
 Thu, 15 Oct 2020 12:10:22 +0000 (UTC)
Received: from redhat.com (ovpn-114-115.ams2.redhat.com [10.36.114.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C748D60C0F;
 Thu, 15 Oct 2020 12:10:17 +0000 (UTC)
Date: Thu, 15 Oct 2020 13:10:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH 2/2] qga: add ssh-{add,remove}-authorized-keys
Message-ID: <20201015121015.GG163620@redhat.com>
References: <20201013202502.335336-1-marcandre.lureau@redhat.com>
 <20201013202502.335336-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201013202502.335336-3-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 12:25:02AM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Add new commands to add and remove SSH public keys from
> ~/.ssh/authorized_keys.
> 
> I took a different approach for testing, including the unit tests right
> with the code. I wanted to overwrite the function to get the user
> details, I couldn't easily do that over QMP. Furthermore, I prefer
> having unit tests very close to the code, and unit files that are domain
> specific (commands-posix is too crowded already). Fwiw, that
> coding/testing style is Rust-style (where tests can or should even be
> part of the documentation!).
> 
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=1885332
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/commands-posix-ssh.c | 394 +++++++++++++++++++++++++++++++++++++++
>  qga/commands-win32.c     |  10 +
>  qga/meson.build          |  17 +-
>  qga/qapi-schema.json     |  32 ++++
>  4 files changed, 452 insertions(+), 1 deletion(-)
>  create mode 100644 qga/commands-posix-ssh.c

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> +##
> +# @guest-ssh-add-authorized-keys:
> +#
> +# @username: the user account to add the authorized key
> +# @keys: the public keys to add (in OpenSSH format)
> +#
> +# Append a public key to user $HOME/.ssh/authorized_keys on Unix systems (not
> +# implemented for other systems).

s/a public key/public keys/

> +#
> +# Returns: Nothing on success.
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'guest-ssh-add-authorized-keys',
> +  'data': { 'username': 'str', 'keys': ['str'] } }
> +
> +##
> +# @guest-ssh-remove-authorized-keys:
> +#
> +# @username: the user account to add the authorized key
> +# @keys: the public keys to remove (in OpenSSH format)
> +#
> +# Remove public keys from the user $HOME/.ssh/authorized_keys on Unix systems
> +# (not implemented for other systems).

Mention that if the requested key does not exist, it is not an
error.

> +#
> +# Returns: Nothing on success.
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'guest-ssh-remove-authorized-keys',
> +  'data': { 'username': 'str', 'keys': ['str'] } }

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


