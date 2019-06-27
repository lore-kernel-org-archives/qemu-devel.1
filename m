Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8575CC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0532080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0532080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgQJX-00031l-Iz
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 05:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59140)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgQIF-0002Uq-9F
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgQID-0008Go-Ii
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:02:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgQID-0007ic-8J
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:02:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so4911898wmj.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 02:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FlOWw/XFm2REc278TnM4G9fixGXO++7lGpaubJ3RO60=;
 b=cHt6GS9npykApAay6ZnARFWg+ydKJcmia7I/sJoIDK2jsWGoHK0oGqnQ45hLgGh5MY
 A3PhHxW1tbVUf8RsJ4Ix/K5lqZEjM92FWZu7rOc2dZVvxaJppVKuv6H8xr/7y8vy38+M
 JlJZMCh2mdCRnjuX8qoUk5ztK0nwhmWcl7YHcTWf7lf6sansCcl7ykkkihC4nTwL6IpT
 SIlUvmrX6WTnoKXBRAnOTwPwWN90g6791rKspgregwr4Rhfb5/b9IlIfxsixebhQxdBp
 OlKLIae9KakcycwFw5PNlVYiUymkDSkw+gxHA45IyNH5dLJ1UWk52yvrG0eIaZfPv4sY
 vsxQ==
X-Gm-Message-State: APjAAAXQ1pxx7xhIVzj+9wwHKsRQ3dN57pBSlcQJwX09LJ7ZC9nUTMsj
 GrmvmO2viw6YrVIwhAY6y4Jfiw==
X-Google-Smtp-Source: APXvYqyGkjW+tbYqkiLtmFDHE2uMyvpcWbWlNcF8n+CgNQUOTiOpZHA8TQiNZDG39rHRiykj/1dNxQ==
X-Received: by 2002:a1c:bbc1:: with SMTP id l184mr2318628wmf.111.1561626071300; 
 Thu, 27 Jun 2019 02:01:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:41bc:c7e6:75c9:c69f?
 ([2001:b07:6468:f312:41bc:c7e6:75c9:c69f])
 by smtp.gmail.com with ESMTPSA id m9sm2070914wrn.92.2019.06.27.02.01.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 02:01:10 -0700 (PDT)
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
Date: Thu, 27 Jun 2019 11:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw/scsi: Report errors and sense to
 guests through scsi-block
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
Cc: fam@euphon.net, shinichiro.kawasaki@wdc.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/06/19 00:46, Alistair Francis wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> When host block devices are bridged to a guest system through
> virtio-scsi-pci and scsi-block driver, scsi_handle_rw_error() in
> hw/scsi/scsi-disk.c checks the error number to judge which error to
> report to the guests. EIO and EINVAL are not reported and ignored. Once
> EIO or EINVAL happen, eternal wait of guest system happens. This problem
> was observed with zoned block devices on the host system attached to the
> guest via virtio-scsi-pci. To avoid the eternal wait, add EIO and EINVAL
> to the list of error numbers to report to the guest.

This is certainly correct for EINVAL, I am not sure about EIO.  Did you
run the VM with "-drive ...,rerror=report,werror=report"?

The update_sense part is okay too.

Paolo

> On top of this, it is required to report SCSI sense data to the guest
> so that the guest can handle the error correctly. However,
> scsi_handle_rw_error() does not passthrough sense data that host
> scsi-block device reported. Instead, it newly generates fixed sense
> data only for certain error numbers. This is inflexible to support new
> error codes to report to guest. To avoid this inflexiblity, pass the SCSI
> sense data that the host scsi-block device reported as is. To be more
> precise, set valid sense_len in the SCSIDiskReq referring sb_len_wr that
> host SCSI device SG_IO ioctl reported. Add update_sense callback to
> SCSIDiskClass to refer the SG_IO ioctl result only when scsi-block device
> is targeted.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/scsi/scsi-disk.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index ed7295bfd7..6801e3a0d0 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -62,6 +62,7 @@ typedef struct SCSIDiskClass {
>      DMAIOFunc       *dma_readv;
>      DMAIOFunc       *dma_writev;
>      bool            (*need_fua_emulation)(SCSICommand *cmd);
> +    void            (*update_sense)(SCSIRequest *r);
>  } SCSIDiskClass;
>  
>  typedef struct SCSIDiskReq {
> @@ -438,6 +439,7 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
>  {
>      bool is_read = (r->req.cmd.mode == SCSI_XFER_FROM_DEV);
>      SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +    SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
>      BlockErrorAction action = blk_get_error_action(s->qdev.conf.blk,
>                                                     is_read, error);
>  
> @@ -452,9 +454,12 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
>               * pause the host.
>               */
>              assert(r->status && *r->status);
> +            if (sdc->update_sense) {
> +                sdc->update_sense(&r->req);
> +            }
>              error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
>              if (error == ECANCELED || error == EAGAIN || error == ENOTCONN ||
> -                error == 0)  {
> +                error == EIO || error == EINVAL || error == 0)  {
>                  /* These errors are handled by guest. */
>                  scsi_req_complete(&r->req, *r->status);
>                  return true;
> @@ -2894,6 +2899,13 @@ static int scsi_block_parse_cdb(SCSIDevice *d, SCSICommand *cmd,
>      }
>  }
>  
> +static void scsi_block_update_sense(SCSIRequest *req)
> +{
> +    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
> +    SCSIBlockReq *br = DO_UPCAST(SCSIBlockReq, req, r);
> +    r->req.sense_len = MIN(br->io_header.sb_len_wr, sizeof(r->req.sense));
> +}
> +
>  #endif
>  
>  static
> @@ -3059,6 +3071,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
>      sc->parse_cdb    = scsi_block_parse_cdb;
>      sdc->dma_readv   = scsi_block_dma_readv;
>      sdc->dma_writev  = scsi_block_dma_writev;
> +    sdc->update_sense = scsi_block_update_sense;
>      sdc->need_fua_emulation = scsi_block_no_fua;
>      dc->desc = "SCSI block device passthrough";
>      dc->props = scsi_block_properties;
> 


