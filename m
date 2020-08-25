Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C3DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60462204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chGwryvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60462204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAa7y-0001zM-FW
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAa7H-00012M-Ih
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:40:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60240
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAa7G-0006cq-1i
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598366400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtZUDai+s7L6QNSMrmPh12MI6mIeUr/342AVDTJ+krw=;
 b=chGwryvbPubBmBxHr4LYjML87gyd0Cgn1Twt0TliVbwtr0I2HWKkGRcopwHOuaUBuTROjn
 61d5zGNw/nYYCuATxsQq1M+86rdTJGjnHZvqQK34lE0WL9SwUlffiJuTYrn2KDBWZaxAND
 PeYmmQTXpRYS+0a4iCoizCssN+ZMmT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238--XibY0vnNqeGH-cAKH_TmA-1; Tue, 25 Aug 2020 10:39:58 -0400
X-MC-Unique: -XibY0vnNqeGH-cAKH_TmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA36E2FD03;
 Tue, 25 Aug 2020 14:39:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D03595D9CA;
 Tue, 25 Aug 2020 14:39:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 64C5E112D737; Tue, 25 Aug 2020 16:39:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v2 08/10] usb/bus: Remove dead assignment in
 usb_get_fw_dev_path()
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-9-kuhn.chenqun@huawei.com>
Date: Tue, 25 Aug 2020 16:39:53 +0200
In-Reply-To: <20200825112447.126308-9-kuhn.chenqun@huawei.com> (Chen Qun's
 message of "Tue, 25 Aug 2020 19:24:45 +0800")
Message-ID: <87r1rudc1y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 pannengyuan@huawei.com, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chen Qun <kuhn.chenqun@huawei.com> writes:

> Clang static code analyzer show warning:
> qemu/hw/usb/bus.c:615:13: warning: Value stored to 'pos' is never read
>             pos += snprintf(fw_path + pos, fw_len - pos, "%s@%lx",
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/usb/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index b17bda3b29..7bab0499ad 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -612,8 +612,8 @@ static char *usb_get_fw_dev_path(DeviceState *qdev)
           if (in[0] == '.') {
               /* some hub between root port and device */
               pos += snprintf(fw_path + pos, fw_len - pos, "hub@%lx/", nr);
>              in++;
>          } else {
>              /* the device itself */
> -            pos += snprintf(fw_path + pos, fw_len - pos, "%s@%lx",
> -                            qdev_fw_name(qdev), nr);
> +            snprintf(fw_path + pos, fw_len - pos, "%s@%lx", qdev_fw_name(qdev),
> +                     nr);
>              break;
>          }
>      }

I'd prefer to keep the line break where it is:

            snprintf(fw_path + pos, fw_len - pos, "%s@%lx",
                     qdev_fw_name(qdev), nr);

The patch is safe, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>

The loss of symmetry betwen the two arms of the if is a bit sad.  Up to
Gerd.


