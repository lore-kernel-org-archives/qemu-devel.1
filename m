Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CFEC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 06:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915802173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 06:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915802173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2rBX-0006Yc-Ih
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 02:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i2rAj-00067C-KE
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i2rAi-00052J-L9
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i2rAi-000524-FI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 02:11:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08FF810C6963;
 Wed, 28 Aug 2019 06:11:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC615DA21;
 Wed, 28 Aug 2019 06:11:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6F41216E05; Wed, 28 Aug 2019 08:11:03 +0200 (CEST)
Date: Wed, 28 Aug 2019 08:11:03 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190828061103.u4l4inomwfvbodtn@sirius.home.kraxel.org>
References: <20190827192526.21780-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827192526.21780-1-laurent@vivier.eu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 28 Aug 2019 06:11:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC,Draft] ui: add an embedded Barrier client
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> For instance:
> 
>   section: screens
>       localhost:
>           ...
>       VM-1:
>           ...
>       end
> 
>   section: links
>       localhost:
>           right = VM-1
>       VM-1:
>           left = localhost
>   end
> 
> Then on the QEMU command line:
> 
>     ... -object input-barrier,id=barrie0,name=VM-1 ...
> 
> When the mouse will move out of the screen of the local host on
> the right, the mouse and the keyboard will be grabbed and all
> related events will be send to the guest OS.

Put that into docs/ ?

> +#define BARRIER_VERSION_MAJOR 1
> +#define BARRIER_VERSION_MINOR 6
> +
> +enum cmdids {
> +    MSG_CNoop,
> +    MSG_CClose,
> +    MSG_CEnter,
> +    MSG_CLeave,
> +    MSG_CClipboard,
> +    MSG_CScreenSaver,
> +    MSG_CResetOptions,
> +    MSG_CInfoAck,
> +    MSG_CKeepAlive,
> +    MSG_DKeyDown,
> +    MSG_DKeyRepeat,
> +    MSG_DKeyUp,
> +    MSG_DMouseDown,
> +    MSG_DMouseUp,
> +    MSG_DMouseMove,
> +    MSG_DMouseRelMove,
> +    MSG_DMouseWheel,
> +    MSG_DClipboard,
> +    MSG_DInfo,
> +    MSG_DSetOptions,
> +    MSG_DFileTransfer,
> +    MSG_DDragInfo,
> +    MSG_QInfo,
> +    MSG_EIncompatible,
> +    MSG_EBusy,
> +    MSG_EUnknown,
> +    MSG_EBad,
> +    /* connection sequence */
> +    MSG_Hello,
> +    MSG_HelloBack,
> +};

Put that into a barrier-protocol header file?

> +    case MSG_QInfo:
> +        p = write_cmd(ib, p, MSG_DInfo);
> +        p = write_short(ib, p, 0);    /* x origin */
> +        p = write_short(ib, p, 0);    /* y origin */
> +        p = write_short(ib, p, 1920); /* width */
> +        p = write_short(ib, p, 1080); /* height */

Hmm.

This is the screen size I guess?  Which you don't know ...
What this is used for?
Should we maybe use INPUT_EVENT_ABS_MAX here?


> +    case MSG_DMouseMove:
> +        qemu_input_queue_abs(NULL, INPUT_AXIS_X, msg.mousepos.x, 0, 1920);
> +        qemu_input_queue_abs(NULL, INPUT_AXIS_Y, msg.mousepos.y, 0, 1080);

... and here too of course.

> +    addr.type = SOCKET_ADDRESS_TYPE_INET;
> +    addr.u.inet.host = g_strdup("localhost");
> +    addr.u.inet.port = g_strdup("24800");

Does it make sens to allow connecting to other machines?
Or will the barrier daemon run on every machine anyway?

Looks reasonable overall.

cheers,
  Gerd


