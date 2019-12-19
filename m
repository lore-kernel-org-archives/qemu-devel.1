Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF77C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A670824672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqebAyZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A670824672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwq1-0003tj-H4
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihwoR-0002DU-Sg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:30:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihwoP-00010M-N8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:29:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihwoP-0000yA-Gu
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576765795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=escURGXfnHgsch0E80jJ2eEwQJeqFZwXo6xIZRFk2kY=;
 b=FqebAyZ6nAYF/HH72U/DPgRLO7hI/TDjq+xuvfZ6gXwakOg43s+Dhmns4tc4n7yTady2O6
 q7qnRE5b9TDkknezmhc9gZXqjriDxICNB2uZjnmPjlC1O3sMLj+zDmjLKUF1OogkMpMUUZ
 o09wFDFOaDn7DJuNqMiE0F9CX2cDk7c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-4xBCsJo3PZ21Dx8_E3T5Ew-1; Thu, 19 Dec 2019 09:29:54 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so2421298wrq.12
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 06:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a4zd+Em2BHjrJRW8Kfqkpun58oCyjYMX0hbWmYhVvOY=;
 b=GumccfFVJYgAw+dfMQU2gS28Rf2iTaFsdacvSTPKKFDjbOnqtMNA+ruYYvL5eacGS1
 NepubohfXOsekLBAARbknGyY/fCcifUKpkpsyoFqcx9gunmLYplDXBwwomg86w1udGah
 mgNCSI/Ut8/nOASZdKJ99++XaYIYu912zhEN3tHpmiJibORZoYzyTcqmsDm5O0yE1Qc6
 IqsmG7EwokthVTQKNpYgGjoSY6Fx4frl9cEHXLW4jKARcX0GNqv8YrFgsNPvreN2TIjW
 xu4Rp4wDUNE3TeGhxpftWf7a8aU8RQJL6xZKNnqlTRGlkzdpr8BY3E9J2i8EGM83iXNU
 ID1A==
X-Gm-Message-State: APjAAAWWKnwd3IBerYXUxTtP3hG+GVure0EgO0ntrClPjeuL9tj3xFd5
 TmRueN6v81G8n1RBRu4aYpjT0cu5dd0tcnQSDp6Jp+/MMDAn9ERoHx902EzBDkjYQcsEBAE3Cem
 SyQdvSKxTv0UgOf8=
X-Received: by 2002:a5d:6901:: with SMTP id t1mr9179351wru.94.1576765793221;
 Thu, 19 Dec 2019 06:29:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfg7Bbe6Bt/pEWDC5dK+ZBIXZ4A86HwdeEom4b/7+XnGaTqMak53eId3bFhz90AFsoPqVbGA==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr9179328wru.94.1576765792937;
 Thu, 19 Dec 2019 06:29:52 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id 4sm5997830wmg.22.2019.12.19.06.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 06:29:52 -0800 (PST)
Subject: Re: [PATCH v7 1/6] tpm: Move tpm_tis_show_buffer to tpm_util.c
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
References: <20191219140605.3243321-1-stefanb@linux.vnet.ibm.com>
 <20191219140605.3243321-2-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c37216fe-6370-b42c-5ca4-b9e6a68d49aa@redhat.com>
Date: Thu, 19 Dec 2019 15:29:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219140605.3243321-2-stefanb@linux.vnet.ibm.com>
Content-Language: en-US
X-MC-Unique: 4xBCsJo3PZ21Dx8_E3T5Ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: marcandre.lureau@redhat.com, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 3:06 PM, Stefan Berger wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   hw/tpm/tpm_tis.c    | 32 ++++----------------------------
>   hw/tpm/tpm_util.c   | 25 +++++++++++++++++++++++++
>   hw/tpm/tpm_util.h   |  3 +++
>   hw/tpm/trace-events |  2 +-
>   4 files changed, 33 insertions(+), 29 deletions(-)
>=20
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 7aaf9b946d..5b17c88a7d 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -107,30 +107,6 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr add=
r)
>       return (uint8_t)((addr >> TPM_TIS_LOCALITY_SHIFT) & 0x7);
>   }
>  =20
> -static void tpm_tis_show_buffer(const unsigned char *buffer,
> -                                size_t buffer_size, const char *string)
> -{
> -    size_t len, i;
> -    char *line_buffer, *p;
> -
> -    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
> -
> -    /*
> -     * allocate enough room for 3 chars per buffer entry plus a
> -     * newline after every 16 chars and a final null terminator.
> -     */
> -    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
> -
> -    for (i =3D 0, p =3D line_buffer; i < len; i++) {
> -        if (i && !(i % 16)) {
> -            p +=3D sprintf(p, "\n");
> -        }
> -        p +=3D sprintf(p, "%.2X ", buffer[i]);
> -    }
> -    trace_tpm_tis_show_buffer(string, len, line_buffer);
> -
> -    g_free(line_buffer);
> -}
>  =20
>   /*
>    * Set the given flags in the STS register by clearing the register but
> @@ -156,8 +132,8 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t =
flags)
>    */
>   static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
>   {
> -    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
> -        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
> +    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
> +        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
>       }
>  =20
>       /*
> @@ -325,8 +301,8 @@ static void tpm_tis_request_completed(TPMIf *ti, int =
ret)
>       s->loc[locty].state =3D TPM_TIS_STATE_COMPLETION;
>       s->rw_offset =3D 0;
>  =20
> -    if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
> -        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
> +    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
> +        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
>       }
>  =20
>       if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index 62b091f0c0..c0a0f3d71f 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -350,3 +350,28 @@ void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
>       tsb->buffer =3D NULL;
>       tsb->size =3D 0;
>   }
> +
> +void tpm_util_show_buffer(const unsigned char *buffer,
> +                          size_t buffer_size, const char *string)
> +{
> +    size_t len, i;
> +    char *line_buffer, *p;
> +
> +    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
> +
> +    /*
> +     * allocate enough room for 3 chars per buffer entry plus a
> +     * newline after every 16 chars and a final null terminator.
> +     */
> +    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
> +
> +    for (i =3D 0, p =3D line_buffer; i < len; i++) {
> +        if (i && !(i % 16)) {
> +            p +=3D sprintf(p, "\n");
> +        }
> +        p +=3D sprintf(p, "%.2X ", buffer[i]);
> +    }
> +    trace_tpm_util_show_buffer(string, len, line_buffer);
> +
> +    g_free(line_buffer);
> +}
> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index f397ac21b8..7889081fba 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -79,4 +79,7 @@ typedef struct TPMSizedBuffer {
>  =20
>   void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
>  =20
> +void tpm_util_show_buffer(const unsigned char *buffer,
> +                          size_t buffer_size, const char *string);
> +
>   #endif /* TPM_TPM_UTIL_H */
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 89804bcd64..357c9e9a84 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -14,6 +14,7 @@ tpm_util_get_buffer_size_len(uint32_t len, size_t expec=
ted) "tpm_resp->len =3D %u,
>   tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_=
resp->hdr.len =3D %u, expected =3D %zu"
>   tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp=
->len =3D %u, expected =3D %zu"
>   tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
> +tpm_util_show_buffer(const char *direction, size_t len, const char *buf)=
 "direction: %s len: %zu\n%s"

Please avoid multi-line trace formats if possible.
Since this is a pre-existing issue:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>  =20
>   # tpm_emulator.c
>   tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
> @@ -36,7 +37,6 @@ tpm_emulator_pre_save(void) ""
>   tpm_emulator_inst_init(void) ""
>  =20
>   # tpm_tis.c
> -tpm_tis_show_buffer(const char *direction, size_t len, const char *buf) =
"direction: %s len: %zu\nbuf: %s"
>   tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
>   tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
>   tpm_tis_abort(uint8_t locty) "New active locality is %d"
>=20


