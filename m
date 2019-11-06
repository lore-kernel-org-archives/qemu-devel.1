Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0A6C5DF65
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1467E217F5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAUrCC/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1467E217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMhW-0001xy-9M
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iSMgE-0000lH-DT
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iSMgD-0004mu-Ev
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:53:06 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iSMgD-0004mR-9F
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:53:05 -0500
Received: by mail-wr1-x442.google.com with SMTP id b3so20400878wrs.13
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8Ou7/+fnkybLtb3uLbZ3l14cSRIlBL4Ppw/OmMmJj5Q=;
 b=mAUrCC/B2YM0y9Ro/eEaV36A41Lb4aBBVosaSBDotRh8OuY85dfedKAbRrJrzvtilf
 75WtNc5PIBG4YFYo4ZDkeTM0V6wJNqw1QSyE0lNBe28VrqIIR+Gx/337HvSCeN7W0vBD
 70O3+oNnIUcuznffovSZBiVxf1bF2yjz2Zmb4twua6WC8HDPL0FY8/+Dr9KSWrhmD5M5
 2g1xbXnfRGte3eFdSxx5wQOIwxtOp3o4wSvn/kBO4dDnWmLQfxOguun1W+CyD6FINwcv
 hM69UtOk4QMDlyv6bFCaiq9tCg62YPC5Q+vA+4ZlxBmfGTIhLmQq7oRiAKuieD3m48k8
 TkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8Ou7/+fnkybLtb3uLbZ3l14cSRIlBL4Ppw/OmMmJj5Q=;
 b=fuGoG2Xt/YAUw7fy+IfCjUNEBTIrAqt7scl+nqpCJyCOSt1Pt/UpXb8Ri/pTyB/oAn
 WIyyUchnoi6F/PHIlIOv0h9ub1MQCJD8Cvk40ySmJCcTx/bi2mnBMQvAmmsA7lpMuwLc
 KIa8pSmmZhTJvd9reHTuEBKrFNITWcOuCLUtw7Gq99f6MvYi3kPJKfzdSvW76iFiHDaK
 TxvJD08xTMxVh//3CisSdKONskZ1QNi4nBfJCiJuCTFcKuT4EsaHfW3hc4tzpK8O+osP
 glwDxJFp3Vuj15D43BItPtAkDDH4/4sYImD1D8+N+UYSvRdV9H8qCzG0jEBDHVNdvPCR
 71lw==
X-Gm-Message-State: APjAAAU2JACEIpQTZOFAaXKsCYRNDqlTdyWKW3Ez/UMxlVDj2Db5s+sh
 35ioKbG0ZO6w3+keX4f7ERIrqzb+/N92Du8oYHo=
X-Google-Smtp-Source: APXvYqzOZfbgh2PZ3Z7wEeZsXgy0sP61RXeLlcyYRWE7PJm5kLlsbLgOzLVkNCv2ZdmS87vVRczXSGg554kJe6xJJ0I=
X-Received: by 2002:adf:ef0f:: with SMTP id e15mr3221449wro.312.1573051983722; 
 Wed, 06 Nov 2019 06:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20191106130309.6737-1-jandryuk@gmail.com>
In-Reply-To: <20191106130309.6737-1-jandryuk@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Nov 2019 18:52:51 +0400
Message-ID: <CAJ+F1CJLffYST5eVXBrOarYxRhkNvgGF0J3wGJ50xny7pLE2NA@mail.gmail.com>
Subject: Re: [PATCH] qmp: Reset mon->commands on CHR_EVENT_CLOSED
To: Jason Andryuk <jandryuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 6, 2019 at 5:04 PM Jason Andryuk <jandryuk@gmail.com> wrote:
>
> Currently, mon->commands is uninitialized until CHR_EVENT_OPENED where
> it is set to &qmp_cap_negotiation_commands.  After capability
> negotiation, it is set to &qmp_commands.  If the chardev is closed,
> CHR_EVENT_CLOSED, mon->commands remains as &qmp_commands.  Only once the
> chardev is re-opened with CHR_EVENT_OPENED, is it reset to
> &qmp_cap_negotiation_commands.
>
> monitor_qapi_event_emit compares mon->commands to
> &qmp_cap_negotiation_commands, and skips sending events when they are
> equal.  In the case of a closed chardev, QMP events are still sent down
> to the closed chardev which needs to drop them.

This is a minor improvement, not really a bug fix or do I read that incorre=
ctly?

>
> Set mon->commands to &qmp_cap_negotiation_commands for CHR_EVENT_CLOSED
> to stop sending events.  Setting for the CHR_EVENT_OPENED case remains
> since that is how mon->commands is set for a newly opened connections.
>
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
>  monitor/qmp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 9d9e5d8b27..5e2073c5eb 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -333,6 +333,7 @@ static void monitor_qmp_event(void *opaque, int event=
)
>           * is closed.
>           */
>          monitor_qmp_cleanup_queues(mon);
> +        mon->commands =3D &qmp_cap_negotiation_commands;
>          json_message_parser_destroy(&mon->parser);
>          json_message_parser_init(&mon->parser, handle_qmp_command,
>                                   mon, NULL);
> --
> 2.21.0
>
>

Looks good to me,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

