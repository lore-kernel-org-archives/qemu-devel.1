Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E009C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2205720872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2205720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7irL-0000bt-C4
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ilc-00036s-9O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7ila-0004nE-Tr
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:13:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7ilX-0004lO-Uk; Tue, 10 Sep 2019 12:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32B0A8980EE;
 Tue, 10 Sep 2019 16:13:15 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B69D660BF7;
 Tue, 10 Sep 2019 16:13:13 +0000 (UTC)
Message-ID: <b3a81eca84577a0524bd1be8366852e2801a65f1.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 19:13:12 +0300
In-Reply-To: <20190910124136.10565-7-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-7-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 10 Sep 2019 16:13:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 6/7] curl: Handle success
 in multi_check_completion
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-09-10 at 14:41 +0200, Max Reitz wrote:
> Background: As of cURL 7.59.0, it verifies that several functions are
> not called from within a callback.  Among these functions is
> curl_multi_add_handle().
> 
> curl_read_cb() is a callback from cURL and not a coroutine.  Waking up
> acb->co will lead to entering it then and there, which means the current
> request will settle and the caller (if it runs in the same coroutine)
> may then issue the next request.  In such a case, we will enter
> curl_setup_preadv() effectively from within curl_read_cb().
> 
> Calling curl_multi_add_handle() will then fail and the new request will
> not be processed.
> 
> Fix this by not letting curl_read_cb() wake up acb->co.  Instead, leave
> the whole business of settling the AIOCB objects to
> curl_multi_check_completion() (which is called from our timer callback
> and our FD handler, so not from any cURL callbacks).
> 
> Reported-by: Natalie Gavrielov <ngavrilo@redhat.com>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1740193
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/curl.c | 69 ++++++++++++++++++++++------------------------------
>  1 file changed, 29 insertions(+), 40 deletions(-)
> 
> diff --git a/block/curl.c b/block/curl.c
> index fd70f1ebc4..c343c7ed3d 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -229,7 +229,6 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>  {
>      CURLState *s = ((CURLState*)opaque);
>      size_t realsize = size * nmemb;
> -    int i;
>  
>      trace_curl_read_cb(realsize);
>  
> @@ -245,32 +244,6 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>      memcpy(s->orig_buf + s->buf_off, ptr, realsize);
>      s->buf_off += realsize;
>  
> -    for(i=0; i<CURL_NUM_ACB; i++) {
> -        CURLAIOCB *acb = s->acb[i];
> -
> -        if (!acb)
> -            continue;
> -
> -        if ((s->buf_off >= acb->end)) {
> -            size_t request_length = acb->bytes;
> -
> -            qemu_iovec_from_buf(acb->qiov, 0, s->orig_buf + acb->start,
> -                                acb->end - acb->start);
> -
> -            if (acb->end - acb->start < request_length) {
> -                size_t offset = acb->end - acb->start;
> -                qemu_iovec_memset(acb->qiov, offset, 0,
> -                                  request_length - offset);
> -            }
> -
> -            acb->ret = 0;
> -            s->acb[i] = NULL;
> -            qemu_mutex_unlock(&s->s->mutex);
> -            aio_co_wake(acb->co);
> -            qemu_mutex_lock(&s->s->mutex);
> -        }
> -    }
> -
>  read_end:
>      /* curl will error out if we do not return this value */
>      return size * nmemb;
> @@ -351,13 +324,14 @@ static void curl_multi_check_completion(BDRVCURLState *s)
>              break;
>  
>          if (msg->msg == CURLMSG_DONE) {
> +            int i;
>              CURLState *state = NULL;
> +            bool error = msg->data.result != CURLE_OK;
> +
>              curl_easy_getinfo(msg->easy_handle, CURLINFO_PRIVATE,
>                                (char **)&state);
>  
> -            /* ACBs for successful messages get completed in curl_read_cb */
> -            if (msg->data.result != CURLE_OK) {
> -                int i;
> +            if (error) {
>                  static int errcount = 100;
>  
>                  /* Don't lose the original error message from curl, since
> @@ -369,20 +343,35 @@ static void curl_multi_check_completion(BDRVCURLState *s)
>                          error_report("curl: further errors suppressed");
>                      }
>                  }
> +            }
>  
> -                for (i = 0; i < CURL_NUM_ACB; i++) {
> -                    CURLAIOCB *acb = state->acb[i];
> +            for (i = 0; i < CURL_NUM_ACB; i++) {
> +                CURLAIOCB *acb = state->acb[i];
>  
> -                    if (acb == NULL) {
> -                        continue;
> -                    }
> +                if (acb == NULL) {
> +                    continue;
> +                }
> +
> +                if (!error) {
> +                    /* Assert that we have read all data */
> +                    assert(state->buf_off >= acb->end);
> +
> +                    qemu_iovec_from_buf(acb->qiov, 0,
> +                                        state->orig_buf + acb->start,
> +                                        acb->end - acb->start);
>  
> -                    acb->ret = -EIO;
> -                    state->acb[i] = NULL;
> -                    qemu_mutex_unlock(&s->mutex);
> -                    aio_co_wake(acb->co);
> -                    qemu_mutex_lock(&s->mutex);
> +                    if (acb->end - acb->start < acb->bytes) {
> +                        size_t offset = acb->end - acb->start;
> +                        qemu_iovec_memset(acb->qiov, offset, 0,
> +                                          acb->bytes - offset);
> +                    }
Original code was memsetting the tail of the buffer before waking up the coroutine.
Is this change intended?

aio_co_wake doesn't enter the co-routine if already in coroutine, but
I think that this is an aio fd handler with isn't run in co-routine itself,
so the callback could run with not yet ready data.


>                  }
> +
> +                acb->ret = error ? -EIO : 0;
> +                state->acb[i] = NULL;
> +                qemu_mutex_unlock(&s->mutex);
> +                aio_co_wake(acb->co);
> +                qemu_mutex_lock(&s->mutex);
>              }
>  
>              curl_clean_state(state);


Best regards,
	Maxim Levitsky


