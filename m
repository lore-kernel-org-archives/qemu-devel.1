Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FF1C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CD2206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAlOpApR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CD2206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isS35-0005rn-6T
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isRxP-0000l4-PI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1isRxO-0001W0-EE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:46:39 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1isRxL-0001T9-F9; Fri, 17 Jan 2020 08:46:35 -0500
Received: by mail-wm1-x344.google.com with SMTP id d73so7513703wmd.1;
 Fri, 17 Jan 2020 05:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AGdH/sToa6GCdJmlC1H1cjZWnVXUouTDArWdNrO9e6g=;
 b=GAlOpApRdWvOEHO0aIz4+KJujIw2Q3OYcykLdyOaMg6XQaEJzWrNyO3ShxvDt+PN6N
 HXu0vyQEyCc7+EIyLVX7V3AhpF2w4fSXuPxDQzSX8lS2yy2Lp4zpRPKnLTh5+xidXSPy
 85Z+KD6OUBugztvR4LobdaX9vl9ZbT7UztT+rES0s+vWv7nWrGHZo4ysRWLkqGJ7kJn3
 p69PUJQLzwL9Symi8q5MU2bW44KPsBBcj08X8avjIBNYuvUKyl7BgI8jRa/XaHRSZqYj
 zto+ZQ3Do4e9RGYB4wxMFGOHEYkp+wWfqJySGWJ89DEtEwHfHSW+9CXT52CLBkXV15zK
 BHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AGdH/sToa6GCdJmlC1H1cjZWnVXUouTDArWdNrO9e6g=;
 b=ZPY4zz6Xj9zXyDH4SFvPwrers/eZg1r91N9slAQKixqO7mcgiJV2Op0trNqNQzlNZI
 jh+oDofbr+X8TQCkID1iRjLGEyqC4DJkRQ+zsR2XS7nc85imDY9TI8mLdT8upKtQuQZL
 TlAc5w+zycHa7GuqC/bPFUuA3K2CWtOeQrnnAaZV/KAkSSQpN2ne0xZVEtwRy+xIXTYM
 OGuMJ9SEYAI2oWpxwJ6+A3i3xGxvg8hhu+NlxT61oiYKlVqOmSMSi7Mq/XbDBYbXWi2a
 Xabb3zbt9qZG+GsR1EUh4lNwwjiW2EpVwr/byUF+v/JXp7L7Phrjx2VZD9Vsi9jyUNR4
 iCAg==
X-Gm-Message-State: APjAAAXL3RnPGz36262Y9o7LVJZLYPCTif3hffvFIS4VMR6V29Gr73z5
 5vRynPlsI0TXjKQzBq9Id2vsDAtwEfhB94Aj7y8=
X-Google-Smtp-Source: APXvYqzoIP4w7vxmlWyo+LDKx/UGrmcliiV2JAwr3m1pwH3cdcL4oGq1/nnjzR6z2OYWHdJPRPj5gQYm/5lQApHVBOA=
X-Received: by 2002:a05:600c:2215:: with SMTP id
 z21mr4655018wml.55.1579268794361; 
 Fri, 17 Jan 2020 05:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
 <20200108161012.1821385-5-stefanb@linux.ibm.com>
 <CAJ+F1CJLKnhWW5kz=C5f9EJd=h-_b46ST_qOpwe1zDBjNU76mw@mail.gmail.com>
 <9307b42f-3149-2cea-fbc9-28110ebc481b@linux.ibm.com>
In-Reply-To: <9307b42f-3149-2cea-fbc9-28110ebc481b@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Jan 2020 17:46:21 +0400
Message-ID: <CAJ+F1CKbiNZvzdexR6+=0bNTLT4bO0xEsvotRJYoDJ4h+rUYQA@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] tpm_spapr: Support suspend and resume
To: Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

On Fri, Jan 17, 2020 at 5:41 PM Stefan Berger <stefanb@linux.ibm.com> wrote=
:
>
> On 1/17/20 8:31 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Jan 8, 2020 at 8:14 PM Stefan Berger <stefanb@linux.ibm.com> wr=
ote:
> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>
> >> Extend the tpm_spapr frontend with VM suspend and resume support.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> ---
> >>   hw/tpm/tpm_spapr.c  | 67 +++++++++++++++++++++++++++++++++++++++++++=
+-
> >>   hw/tpm/trace-events |  2 ++
> >>   2 files changed, 68 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> >> index ab184fbb82..cf5c7851e7 100644
> >> --- a/hw/tpm/tpm_spapr.c
> >> +++ b/hw/tpm/tpm_spapr.c
> >> @@ -76,6 +76,9 @@ typedef struct {
> >>
> >>       unsigned char buffer[TPM_SPAPR_BUFFER_MAX];
> >>
> >> +    uint32_t numbytes; /* number of bytes in suspend_buffer */
> >> +    unsigned char *suspend_buffer;
> > Why do you need a copy suspend_buffer? Why not use and save buffer[] di=
rectly?
>
>
> This addresses David's comment:
>
> "Transferring the whole 4kiB buffer unconditionally when it mostly
> won't have anything useful in it doesn't seem like a great idea."
>
> https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg02601.html

Oh ok.. (well really I don't think 4k (usually compressed) will really
matter much in multi-gigabytes streams ;)

>
>
> >
> > Also numbytes wouldn't be necessary, you would just need a bool flag
> > to say if the request_completed is pending.
> >
> >> +
> >>       TPMBackendCmd cmd;
> >>
> >>       TPMBackend *be_driver;
> >> @@ -240,6 +243,13 @@ static void tpm_spapr_request_completed(TPMIf *ti=
, int ret)
> >>
> >>       /* a max. of be_buffer_size bytes can be transported */
> >>       len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
> >> +
> >> +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> >> +        /* defer delivery of response until .post_load */
> >> +        s->numbytes =3D len;
> >> +        return;
> >> +    }
> >> +
> >>       rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->data),
> >>                                s->buffer, len);
> >>
> >> @@ -288,11 +298,13 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
> >>       SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
> >>
> >>       s->state =3D SPAPR_VTPM_STATE_NONE;
> >> +    s->numbytes =3D 0;
> >>
> >>       s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
> >>
> >>       s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driv=
er),
> >>                               TPM_SPAPR_BUFFER_MAX);
> >> +    s->suspend_buffer =3D g_realloc(s->suspend_buffer, s->be_buffer_s=
ize);
> >>
> >>       tpm_backend_reset(s->be_driver);
> >>       tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
> >> @@ -309,9 +321,62 @@ static enum TPMVersion tpm_spapr_get_version(TPMI=
f *ti)
> >>       return tpm_backend_get_tpm_version(s->be_driver);
> >>   }
> >>
> >> +/* persistent state handling */
> >> +
> >> +static int tpm_spapr_pre_save(void *opaque)
> >> +{
> >> +    SpaprTpmState *s =3D opaque;
> >> +
> >> +    tpm_backend_finish_sync(s->be_driver);
> >> +
> >> +    if (s->numbytes) {
> >> +        memcpy(s->suspend_buffer, s->buffer, s->numbytes);
> >> +    }
> >> +
> >> +    trace_tpm_spapr_pre_save(s->numbytes);
> >> +    /*
> >> +     * we cannot deliver the results to the VM since DMA would touch =
VM memory
> >> +     */
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int tpm_spapr_post_load(void *opaque, int version_id)
> >> +{
> >> +    SpaprTpmState *s =3D opaque;
> >> +
> >> +    if (s->numbytes) {
> >> +        trace_tpm_spapr_post_load();
> >> +
> >> +        memcpy(s->buffer, s->suspend_buffer,
> >> +               MIN(s->numbytes, s->be_buffer_size));
> >> +        /* deliver the results to the VM via DMA */
> >> +        tpm_spapr_request_completed(TPM_IF(s), 0);
> >> +        s->numbytes =3D 0;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>   static const VMStateDescription vmstate_spapr_vtpm =3D {
> >>       .name =3D "tpm-spapr",
> >> -    .unmigratable =3D 1,
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 0,
> >> +    .minimum_version_id_old =3D 0,
> >
> > Yyou should leave all the fields to 0 (there is no version 0 so far).
> > Thus no need to have them set explicitly either.
>
>
> Ok, I will fix.
>
>    Thanks.



--=20
Marc-Andr=C3=A9 Lureau

