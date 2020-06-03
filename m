Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E067EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B7C20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B7C20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUv7-0001Cy-UH
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jgUjQ-0001nu-Av
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:51:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:47528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jgUjP-0000Dc-1a
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:51:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 431C4AD75;
 Wed,  3 Jun 2020 14:51:04 +0000 (UTC)
Subject: Re: [PATCH 4/4] scsi-disk: Add support for the GET LBA STATUS 16
 command
To: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org
References: <20200602074201.10879-1-lma@suse.com>
 <20200602074201.10879-5-lma@suse.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <bc41a8bc-60fb-d391-826e-dc145710034b@suse.de>
Date: Wed, 3 Jun 2020 16:51:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200602074201.10879-5-lma@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 22:45:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 9:42 AM, Lin Ma wrote:
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  hw/scsi/scsi-disk.c      | 92 ++++++++++++++++++++++++++++++++++++++++
>  include/scsi/constants.h |  1 +
>  2 files changed, 93 insertions(+)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 387503e11b..2d2c6b4b82 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -1866,6 +1866,91 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
>      }
>  }
>  
> +typedef struct GetLbaStatusCBData {
> +    uint32_t num_blocks;
> +    uint32_t is_deallocated;
> +    SCSIDiskReq *r;
> +} GetLbaStatusCBData;
> +
> +static void scsi_get_lba_status_complete(void *opaque, int ret);
> +
> +static void scsi_get_lba_status_complete_noio(GetLbaStatusCBData *data, int ret)
> +{
> +    SCSIDiskReq *r = data->r;
> +    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb == NULL);
> +
> +    block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
> +                     s->qdev.blocksize, BLOCK_ACCT_GET_LBA_STATUS);
> +
> +    r->req.aiocb = blk_aio_get_lba_status(s->qdev.conf.blk,
> +                                          r->req.cmd.lba * s->qdev.blocksize,
> +                                          s->qdev.blocksize,
> +                                          scsi_get_lba_status_complete, data);
> +    return;

this return statement does not add anything of value, I think you can remove it.

> +}
> +
> +static void scsi_get_lba_status_complete(void *opaque, int ret)
> +{
> +    GetLbaStatusCBData *data = opaque;
> +    SCSIDiskReq *r = data->r;
> +    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> +
> +    assert(r->req.aiocb != NULL);
> +    r->req.aiocb = NULL;
> +
> +    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
> +    if (scsi_disk_req_check_error(r, ret, true)) {
> +        g_free(data);
> +        goto done;
> +    }
> +
> +    block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
> +    scsi_req_unref(&r->req);
> +    g_free(data);
> +
> +done:
> +    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
> +}
> +
> +static void scsi_disk_emulate_get_lba_status(SCSIRequest *req, uint8_t *outbuf)
> +{
> +    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
> +    GetLbaStatusCBData *data;
> +    uint32_t *num_blocks;
> +    uint32_t *is_deallocated;
> +
> +    data = g_new0(GetLbaStatusCBData, 1);
> +    data->r = r;
> +    num_blocks = &(data->num_blocks);
> +    is_deallocated = &(data->is_deallocated);
> +
> +    scsi_req_ref(&r->req);
> +    scsi_get_lba_status_complete_noio(data, 0);
> +
> +    /* 8 + 16 is the length in bytes of response header and
> +     * one LBA status descriptor
> +     */

this should probably look like:

/*
 * 8 + 16 ...
 * one LBA ...
 */

> +    memset(outbuf, 0, 8 + 16);
> +    outbuf[3] = 20;
> +    outbuf[8] = (req->cmd.lba >> 56) & 0xff;
> +    outbuf[9] = (req->cmd.lba >> 48) & 0xff;
> +    outbuf[10] = (req->cmd.lba >> 40) & 0xff;
> +    outbuf[11] = (req->cmd.lba >> 32) & 0xff;
> +    outbuf[12] = (req->cmd.lba >> 24) & 0xff;
> +    outbuf[13] = (req->cmd.lba >> 16) & 0xff;
> +    outbuf[14] = (req->cmd.lba >> 8) & 0xff;
> +    outbuf[15] = req->cmd.lba & 0xff;
> +    outbuf[16] = (*num_blocks >> 24) & 0xff;
> +    outbuf[17] = (*num_blocks >> 16) & 0xff;
> +    outbuf[18] = (*num_blocks >> 8) & 0xff;
> +    outbuf[19] = *num_blocks & 0xff;
> +    outbuf[20] = *is_deallocated ? 1 : 0;
> +
> +    return;

(see above)

> +}
> +
>  static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
>  {
>      SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
> @@ -2076,6 +2161,13 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
>  
>              /* Protection, exponent and lowest lba field left blank. */
>              break;
> +        } else if ((req->cmd.buf[1] & 31) == SAI_GET_LBA_STATUS) {
> +            if (req->cmd.lba > s->qdev.max_lba) {
> +                goto illegal_lba;
> +            }
> +            scsi_disk_emulate_get_lba_status(req, outbuf);
> +            r->iov.iov_len = req->cmd.xfer;
> +            return r->iov.iov_len;
>          }
>          trace_scsi_disk_emulate_command_SAI_unsupported();
>          goto illegal_request;
> diff --git a/include/scsi/constants.h b/include/scsi/constants.h
> index 874176019e..1b6417898a 100644
> --- a/include/scsi/constants.h
> +++ b/include/scsi/constants.h
> @@ -154,6 +154,7 @@
>   * SERVICE ACTION IN subcodes
>   */
>  #define SAI_READ_CAPACITY_16  0x10
> +#define SAI_GET_LBA_STATUS  0x12
>  
>  /*
>   * READ POSITION service action codes
> 


