Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2741FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9FD21D41
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vR1xehxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9FD21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuAs-00066q-KD
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kQu9z-0005aA-MV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:18:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kQu9w-0004Fe-9L
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:18:19 -0400
Received: by mail-oi1-x242.google.com with SMTP id w141so10572256oia.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6wWiax1fA3+EVw+HMK8qEHvCcvAxagBJg4UC6w3+UF8=;
 b=vR1xehxW1HZrWraNiB5WXDDPraeXQZ3RqIXzXsHrJ3+Kvvx7bqlh3d60OtTcnNJOZz
 qyaMYX+ruzL1IgILKHyaTwAiPrIGafMut5V9aJ24mZhIHwORwM9+RSN5rA57PfELgymd
 7nT49B2OLPx3O+kry4Z4xa9NbqnThB0l0ta/TSCTycsdAui7zvaXAUdHmF0IKALvAH3G
 fw8fUnOJ4pOx6GhuEtJDxchDzTDhsHmEUvY0BdyackXRD+trltvLhh/cVFwv4ZrWaqIZ
 zbe8sjqEaSKprA/x3L6LvR3RYWraOITmTZ0+u7ITB0zL1qLwWnocBmgroW1DduHT8ZkX
 Cu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6wWiax1fA3+EVw+HMK8qEHvCcvAxagBJg4UC6w3+UF8=;
 b=XRAPoURaclgiLzzO6pS1GcvAeEu5X3MP2vs0+TWigPk+vDxroFbjkNWkOi/pRFNLJ3
 Zohm7LVCL2AX6rII0fgmnMHluRTWLpl1azuqL7APpJ59AX/p01fPpqaGgcjVWuD4AqoR
 TK5/03f4fJuLZwo2pFyzWDOFss9PO3sV+DzQdSKaXCJIkEZ2Ta5j7Wv8bus6YEjsyRf5
 q0GJO2xjhTjSwXpdUPSYV7WLLTS0VDFOy/2ucaikhZGEgCO0UCyPgLm3MfFg/IsYkIvN
 C1Fsj1NLN2HruO3T5N2cHr/pFSvo+I3t/ZgxV+HPbo5rmzwzg3rUvpmHGeF3uPLIYLvS
 YgVg==
X-Gm-Message-State: AOAM532feJ+LWfXYAGdh84bD7IrxykqoBuZBrq7P1IDCWyKiOh5yaMAJ
 Aik4pubK9Drt9FdAIzU9XcWHwW0TVa1fNhWq6io=
X-Google-Smtp-Source: ABdhPJz/qn1ydHUXtdwX1341e69tZXIQG8fFYG0c3mP2gx8Gewx+f9OmZ3/adZ/33jPgw3J1QQhvMJDmdrkow2I+2Gk=
X-Received: by 2002:a54:4d88:: with SMTP id y8mr2803869oix.97.1602256695142;
 Fri, 09 Oct 2020 08:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201008202713.1416823-1-ehabkost@redhat.com>
 <20201008202713.1416823-3-ehabkost@redhat.com>
In-Reply-To: <20201008202713.1416823-3-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 9 Oct 2020 23:17:39 +0800
Message-ID: <CAKXe6S+-OyQGG3YRguuyXMngz=5AjO28_XY4qpskJ7jDJLOxKQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] can-host-socketcan: Fix crash when 'if' option is not
 set
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=884:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Fix the following crash:
>
>   $ qemu-system-x86_64 -object can-host-socketcan,id=3Dobj0
>   Segmentation fault (core dumped)
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Cc: Vikram Garhwal <fnu.vikram@xilinx.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  net/can/can_socketcan.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
> index 92b1f79385..4b68f60c6b 100644
> --- a/net/can/can_socketcan.c
> +++ b/net/can/can_socketcan.c
> @@ -194,6 +194,11 @@ static void can_host_socketcan_connect(CanHostState =
*ch, Error **errp)
>      struct sockaddr_can addr;
>      struct ifreq ifr;
>
> +    if (!c->ifname) {
> +        error_setg(errp, "'if' property not set");
> +        return;
> +    }
> +
>      /* open socket */
>      s =3D qemu_socket(PF_CAN, SOCK_RAW, CAN_RAW);
>      if (s < 0) {
> --
> 2.26.2
>
>

