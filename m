Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821BCC33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510D8206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOFdacIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510D8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRlW-00032T-Dz
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isRjZ-0001h6-1D
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isRjX-0007Rr-I5
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:32:20 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1isRjF-0007De-8R; Fri, 17 Jan 2020 08:32:01 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so7611582wmi.5;
 Fri, 17 Jan 2020 05:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mioe/9HZfqfzSVn02mYmnCPY8fpS9h77Fy+VH9U44fg=;
 b=nOFdacIhaTemhJe6MKrYp1joWfFf8k6hdRTD1Zd5nkAU4T9PfxmSZOnA65Od0YMtCI
 9eYhsruBqhramQE7mzmBIs6D+qSclJUVFFhePSswwNrMTGC05VYOXv4feCNHG0Ypma/3
 oJQwLLuoy+Eh2ePgBA2nXEFP+hYxGT+PxshOkKFUFXz6J4zSoirsPZfZzrF+CqUTVQSn
 oJmMlfsQclNamZvzlWuwbTJFmGjTZcULE3SWnQY04UbxiMAtA45DRhQzwJfugCD+4RWb
 x6h8oErboGc/GzWouUzJyfD6yKcA322AR9/JQ6Djb1lge8JySqF/xeF2O8CvcMDPUAAw
 Zx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mioe/9HZfqfzSVn02mYmnCPY8fpS9h77Fy+VH9U44fg=;
 b=i0oWdqUor0pslRBAApiMEWOMJE9sFa+h21X6MALCxp5jdx1cLceo/HFZuQhvp25DxI
 YQ/ifK8lMenJdIs36OPULjCPKyWDQIUWNgJEwpdkQQIbpvckbFTs6mbfSfupDelB2QQ4
 p0JRdo5u7/u0q5Uu9hUPYsovA4wLgHaOi+94GbMCcR8ooPBZHNPzC/+Oj4yZ+IZw3E34
 dxUTwcVrCPK3oDUhaKxwbXV4w3JmzEi7YBJXDuEEFU+jSlnsQvEBTy8Po32Hhq14NRoV
 I2lXi62Tdfgljw2s62/WyxFehFxDr6Az+LSOwPP2mtp7i/4RxaxH6EpiNBJamZcN0UA3
 QRjw==
X-Gm-Message-State: APjAAAUX4J3O9vfRlsV1nTzl0/uVDtn8fADVWtahG8rA3wdd3JYdqIW6
 4LPuzVgMQYZ7cmAKRQ9EJVq2+Iwcpm7Id/EDgjs=
X-Google-Smtp-Source: APXvYqyuUaOQcHZ48P+r8CFRKcQU85d2erjt/vXeoQaue2CRzLME+AYv0sz0MolndR+dw8ea10qSFbc99on2Ff6MWIo=
X-Received: by 2002:a05:600c:24ca:: with SMTP id
 10mr4702359wmu.4.1579267919831; 
 Fri, 17 Jan 2020 05:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
 <20200108161012.1821385-5-stefanb@linux.ibm.com>
In-Reply-To: <20200108161012.1821385-5-stefanb@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Jan 2020 17:31:47 +0400
Message-ID: <CAJ+F1CJLKnhWW5kz=C5f9EJd=h-_b46ST_qOpwe1zDBjNU76mw@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] tpm_spapr: Support suspend and resume
To: Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 8, 2020 at 8:14 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> Extend the tpm_spapr frontend with VM suspend and resume support.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_spapr.c  | 67 ++++++++++++++++++++++++++++++++++++++++++++-
>  hw/tpm/trace-events |  2 ++
>  2 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index ab184fbb82..cf5c7851e7 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -76,6 +76,9 @@ typedef struct {
>
>      unsigned char buffer[TPM_SPAPR_BUFFER_MAX];
>
> +    uint32_t numbytes; /* number of bytes in suspend_buffer */
> +    unsigned char *suspend_buffer;

Why do you need a copy suspend_buffer? Why not use and save buffer[] direct=
ly?

Also numbytes wouldn't be necessary, you would just need a bool flag
to say if the request_completed is pending.

> +
>      TPMBackendCmd cmd;
>
>      TPMBackend *be_driver;
> @@ -240,6 +243,13 @@ static void tpm_spapr_request_completed(TPMIf *ti, i=
nt ret)
>
>      /* a max. of be_buffer_size bytes can be transported */
>      len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
> +
> +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> +        /* defer delivery of response until .post_load */
> +        s->numbytes =3D len;
> +        return;
> +    }
> +
>      rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->data),
>                               s->buffer, len);
>
> @@ -288,11 +298,13 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>      SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
>
>      s->state =3D SPAPR_VTPM_STATE_NONE;
> +    s->numbytes =3D 0;
>
>      s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
>
>      s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver),
>                              TPM_SPAPR_BUFFER_MAX);
> +    s->suspend_buffer =3D g_realloc(s->suspend_buffer, s->be_buffer_size=
);
>
>      tpm_backend_reset(s->be_driver);
>      tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
> @@ -309,9 +321,62 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *=
ti)
>      return tpm_backend_get_tpm_version(s->be_driver);
>  }
>
> +/* persistent state handling */
> +
> +static int tpm_spapr_pre_save(void *opaque)
> +{
> +    SpaprTpmState *s =3D opaque;
> +
> +    tpm_backend_finish_sync(s->be_driver);
> +
> +    if (s->numbytes) {
> +        memcpy(s->suspend_buffer, s->buffer, s->numbytes);
> +    }
> +
> +    trace_tpm_spapr_pre_save(s->numbytes);
> +    /*
> +     * we cannot deliver the results to the VM since DMA would touch VM =
memory
> +     */
> +
> +    return 0;
> +}
> +
> +static int tpm_spapr_post_load(void *opaque, int version_id)
> +{
> +    SpaprTpmState *s =3D opaque;
> +
> +    if (s->numbytes) {
> +        trace_tpm_spapr_post_load();
> +
> +        memcpy(s->buffer, s->suspend_buffer,
> +               MIN(s->numbytes, s->be_buffer_size));
> +        /* deliver the results to the VM via DMA */
> +        tpm_spapr_request_completed(TPM_IF(s), 0);
> +        s->numbytes =3D 0;
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_spapr_vtpm =3D {
>      .name =3D "tpm-spapr",
> -    .unmigratable =3D 1,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 0,
> +    .minimum_version_id_old =3D 0,


Yyou should leave all the fields to 0 (there is no version 0 so far).
Thus no need to have them set explicitly either.

> +    .pre_save =3D tpm_spapr_pre_save,
> +    .post_load =3D tpm_spapr_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_SPAPR_VIO(vdev, SpaprTpmState),
> +
> +        VMSTATE_UINT8(state, SpaprTpmState),
> +        VMSTATE_UINT32(numbytes, SpaprTpmState),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(suspend_buffer,
> +                                     SpaprTpmState, 0, NULL,
> +                                     numbytes),
> +        /* remember DMA address */
> +        VMSTATE_UINT32(crq.data, SpaprTpmState),
> +        VMSTATE_END_OF_LIST(),
> +    }
>  };
>
>  static Property tpm_spapr_properties[] =3D {
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 9143a8eaa3..5592cec7de 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -67,3 +67,5 @@ tpm_spapr_do_crq_get_version(uint32_t version) "respons=
e: version %u"
>  tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspen=
d"
>  tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x=
%02x"
>  tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x=
%02x 0x%02x ..."
> +tpm_spapr_pre_save(uint32_t v) "Number of TPM response bytes to deliver =
after resume: %u"
> +tpm_spapr_post_load(void) "Delivering TPM response after resume"
> --
> 2.24.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

