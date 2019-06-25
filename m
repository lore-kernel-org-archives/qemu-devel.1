Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC21C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584D320663
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584D320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfixb-0004WH-KG
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hfiug-0001nE-Uq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hfiue-0000pw-Qy
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:42:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hfiuc-0000mO-SV
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:42:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 575EB308222E;
 Tue, 25 Jun 2019 10:42:53 +0000 (UTC)
Received: from redhat.com (ovpn-112-73.ams2.redhat.com [10.36.112.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8656E600C7;
 Tue, 25 Jun 2019 10:42:49 +0000 (UTC)
Date: Tue, 25 Jun 2019 11:42:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Colin Xu <colin.xu@intel.com>
Message-ID: <20190625104246.GD3139@redhat.com>
References: <20190625032142.13854-1-colin.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190625032142.13854-1-colin.xu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 25 Jun 2019 10:42:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] ui: Correct icon install path
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 11:21:42AM +0800, Colin Xu wrote:
> The double slash in path will fail the installation on MINGW/MSYS.
>=20
> Fixes: a8260d387638 (ui: install logo icons to $prefix/share/icons)
>=20
> Signed-off-by: Colin Xu <colin.xu@intel.com>
> ---
>  Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Hmmm I swear this exact fix has been posted before but I can't find
/ remember where and obviously it didnt get merged.

>=20
> diff --git a/Makefile b/Makefile
> index cfb18f152544..562205be290c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -875,19 +875,19 @@ ifneq ($(DESCS),)
>  	done
>  endif
>  	for s in $(ICON_SIZES); do \
> -		mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps"; \
> +		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
>  		$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
> -			"$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
> +			"$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
>  	done; \
> -	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps"; \
> +	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps"; \
>  	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_32x32.bmp \
> -		"$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
> -	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps"; \
> +		"$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
> +	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps"; \
>  	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu.svg \
> -		"$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
> -	mkdir -p "$(DESTDIR)/$(qemu_desktopdir)"
> +		"$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
> +	mkdir -p "$(DESTDIR)$(qemu_desktopdir)"
>  	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
> -		"$(DESTDIR)/$(qemu_desktopdir)/qemu.desktop"
> +		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
>  ifdef CONFIG_GTK
>  	$(MAKE) -C po $@
>  endif

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

