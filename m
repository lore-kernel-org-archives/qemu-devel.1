Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D99C04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C89921743
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C89921743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55231 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6Gz-00038g-7T
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:01:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT6G7-0002lb-TI
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT6G2-0005ri-If
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hT6G0-0005qj-Gy
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:00:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFFEC30B4A5E;
	Tue, 21 May 2019 15:00:45 +0000 (UTC)
Received: from redhat.com (ovpn-112-26.ams2.redhat.com [10.36.112.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4417766846;
	Tue, 21 May 2019 15:00:41 +0000 (UTC)
Date: Tue, 21 May 2019 16:00:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190521150038.GP25835@redhat.com>
References: <20190521145318.12787-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190521145318.12787-1-stefanha@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 21 May 2019 15:00:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] build: use $(DESTDIR)x instead of
 $(DESTDIR)/x
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 03:53:18PM +0100, Stefan Hajnoczi wrote:
> The GNU make manual[1] demonstrates $(DESTDIR)$(bindir)/foo and QEMU
> mostly follows that.  There are just a few instances of
> $(DESTDIR)/$(bindir)/foo.  Fix these inconsistencies.
>=20
> [1] https://www.gnu.org/software/make/manual/html_node/DESTDIR.html
>=20
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 155f066a20..57b786d238 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -840,19 +840,19 @@ ifneq ($(DESCS),)
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

