Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE07C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA9F21901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA9F21901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqh8i-0007oq-Pc
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqh8X-0007Kq-4I
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqh8V-0005xa-WD
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hqh8T-0005u5-Js; Thu, 25 Jul 2019 13:02:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D39930BC58B;
 Thu, 25 Jul 2019 17:02:32 +0000 (UTC)
Received: from work-vm (ovpn-117-187.ams2.redhat.com [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B9141001B07;
 Thu, 25 Jul 2019 17:02:30 +0000 (UTC)
Date: Thu, 25 Jul 2019 18:02:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190725170228.GL2656@work-vm>
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725163710.11703-2-peter.maydell@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 25 Jul 2019 17:02:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/2] stellaris_input: Fix vmstate
 description of buttons field
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> gamepad_state::buttons is a pointer to an array of structs,
> not an array of structs, so should be declared in the vmstate
> with VMSTATE_STRUCT_VARRAY_POINTER_INT32; otherwise we
> corrupt memory on incoming migration.
> 
> We bump the vmstate version field as the easiest way to
> deal with the migration break, since migration wouldn't have
> worked reliably before anyway.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

OK, it would be great to change num_buttons to uint32_t and make that a
UINT32 at some point;  it's hard to press negative buttons.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/input/stellaris_input.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
> index 20c87d86f40..3a666d61d47 100644
> --- a/hw/input/stellaris_input.c
> +++ b/hw/input/stellaris_input.c
> @@ -60,12 +60,14 @@ static const VMStateDescription vmstate_stellaris_button = {
>  
>  static const VMStateDescription vmstate_stellaris_gamepad = {
>      .name = "stellaris_gamepad",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_INT32(extension, gamepad_state),
> -        VMSTATE_STRUCT_VARRAY_INT32(buttons, gamepad_state, num_buttons, 0,
> -                              vmstate_stellaris_button, gamepad_button),
> +        VMSTATE_STRUCT_VARRAY_POINTER_INT32(buttons, gamepad_state,
> +                                            num_buttons,
> +                                            vmstate_stellaris_button,
> +                                            gamepad_button),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

