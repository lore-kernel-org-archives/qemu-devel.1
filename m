Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE3FC4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1AA20830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1AA20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8k4z-0000VD-GV
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8k3b-0007mz-PH
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8k3a-0004jK-9M
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:48:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8k3U-0004fM-02; Fri, 13 Sep 2019 07:48:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 330058A1C94;
 Fri, 13 Sep 2019 11:47:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 924965C207;
 Fri, 13 Sep 2019 11:47:55 +0000 (UTC)
Message-ID: <a5d1b02b9c2fb4b1500a55837f3c021dba4d05f2.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Fri, 13 Sep 2019 14:47:54 +0300
In-Reply-To: <cd6879cf-222d-ea48-0bb7-49d0fc455374@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-7-mreitz@redhat.com>
 <b3a81eca84577a0524bd1be8366852e2801a65f1.camel@redhat.com>
 <cd6879cf-222d-ea48-0bb7-49d0fc455374@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 13 Sep 2019 11:47:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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

On Fri, 2019-09-13 at 13:20 +0200, Max Reitz wrote:
> On 10.09.19 18:13, Maxim Levitsky wrote:
> > On Tue, 2019-09-10 at 14:41 +0200, Max Reitz wrote:
> > > Background: As of cURL 7.59.0, it verifies that several functions a=
re
> > > not called from within a callback.  Among these functions is
> > > curl_multi_add_handle().
> > >=20
> > > curl_read_cb() is a callback from cURL and not a coroutine.  Waking=
 up
> > > acb->co will lead to entering it then and there, which means the cu=
rrent
> > > request will settle and the caller (if it runs in the same coroutin=
e)
> > > may then issue the next request.  In such a case, we will enter
> > > curl_setup_preadv() effectively from within curl_read_cb().
> > >=20
> > > Calling curl_multi_add_handle() will then fail and the new request =
will
> > > not be processed.
> > >=20
> > > Fix this by not letting curl_read_cb() wake up acb->co.  Instead, l=
eave
> > > the whole business of settling the AIOCB objects to
> > > curl_multi_check_completion() (which is called from our timer callb=
ack
> > > and our FD handler, so not from any cURL callbacks).
> > >=20
> > > Reported-by: Natalie Gavrielov <ngavrilo@redhat.com>
> > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1740193
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  block/curl.c | 69 ++++++++++++++++++++++--------------------------=
----
> > >  1 file changed, 29 insertions(+), 40 deletions(-)
> > >=20
> > > diff --git a/block/curl.c b/block/curl.c
> > > index fd70f1ebc4..c343c7ed3d 100644
> > > --- a/block/curl.c
> > > +++ b/block/curl.c
> > > @@ -229,7 +229,6 @@ static size_t curl_read_cb(void *ptr, size_t si=
ze, size_t nmemb, void *opaque)
> > >  {
> > >      CURLState *s =3D ((CURLState*)opaque);
> > >      size_t realsize =3D size * nmemb;
> > > -    int i;
> > > =20
> > >      trace_curl_read_cb(realsize);
> > > =20
> > > @@ -245,32 +244,6 @@ static size_t curl_read_cb(void *ptr, size_t s=
ize, size_t nmemb, void *opaque)
> > >      memcpy(s->orig_buf + s->buf_off, ptr, realsize);
> > >      s->buf_off +=3D realsize;
> > > =20
> > > -    for(i=3D0; i<CURL_NUM_ACB; i++) {
> > > -        CURLAIOCB *acb =3D s->acb[i];
> > > -
> > > -        if (!acb)
> > > -            continue;
> > > -
> > > -        if ((s->buf_off >=3D acb->end)) {
> > > -            size_t request_length =3D acb->bytes;
> > > -
> > > -            qemu_iovec_from_buf(acb->qiov, 0, s->orig_buf + acb->s=
tart,
> > > -                                acb->end - acb->start);
> > > -
> > > -            if (acb->end - acb->start < request_length) {
> > > -                size_t offset =3D acb->end - acb->start;
> > > -                qemu_iovec_memset(acb->qiov, offset, 0,
> > > -                                  request_length - offset);
> > > -            }
> > > -
> > > -            acb->ret =3D 0;
> > > -            s->acb[i] =3D NULL;
> > > -            qemu_mutex_unlock(&s->s->mutex);
> > > -            aio_co_wake(acb->co);
> > > -            qemu_mutex_lock(&s->s->mutex);
> > > -        }
> > > -    }
> > > -
> > >  read_end:
> > >      /* curl will error out if we do not return this value */
> > >      return size * nmemb;
> > > @@ -351,13 +324,14 @@ static void curl_multi_check_completion(BDRVC=
URLState *s)
> > >              break;
> > > =20
> > >          if (msg->msg =3D=3D CURLMSG_DONE) {
> > > +            int i;
> > >              CURLState *state =3D NULL;
> > > +            bool error =3D msg->data.result !=3D CURLE_OK;
> > > +
> > >              curl_easy_getinfo(msg->easy_handle, CURLINFO_PRIVATE,
> > >                                (char **)&state);
> > > =20
> > > -            /* ACBs for successful messages get completed in curl_=
read_cb */
> > > -            if (msg->data.result !=3D CURLE_OK) {
> > > -                int i;
> > > +            if (error) {
> > >                  static int errcount =3D 100;
> > > =20
> > >                  /* Don't lose the original error message from curl=
, since
> > > @@ -369,20 +343,35 @@ static void curl_multi_check_completion(BDRVC=
URLState *s)
> > >                          error_report("curl: further errors suppres=
sed");
> > >                      }
> > >                  }
> > > +            }
> > > =20
> > > -                for (i =3D 0; i < CURL_NUM_ACB; i++) {
> > > -                    CURLAIOCB *acb =3D state->acb[i];
> > > +            for (i =3D 0; i < CURL_NUM_ACB; i++) {
> > > +                CURLAIOCB *acb =3D state->acb[i];
> > > =20
> > > -                    if (acb =3D=3D NULL) {
> > > -                        continue;
> > > -                    }
> > > +                if (acb =3D=3D NULL) {
> > > +                    continue;
> > > +                }
> > > +
> > > +                if (!error) {
> > > +                    /* Assert that we have read all data */
> > > +                    assert(state->buf_off >=3D acb->end);
> > > +
> > > +                    qemu_iovec_from_buf(acb->qiov, 0,
> > > +                                        state->orig_buf + acb->sta=
rt,
> > > +                                        acb->end - acb->start);
> > > =20
> > > -                    acb->ret =3D -EIO;
> > > -                    state->acb[i] =3D NULL;
> > > -                    qemu_mutex_unlock(&s->mutex);
> > > -                    aio_co_wake(acb->co);
> > > -                    qemu_mutex_lock(&s->mutex);
> > > +                    if (acb->end - acb->start < acb->bytes) {
> > > +                        size_t offset =3D acb->end - acb->start;
> > > +                        qemu_iovec_memset(acb->qiov, offset, 0,
> > > +                                          acb->bytes - offset);
> > > +                    }
> >=20
> > Original code was memsetting the tail of the buffer before waking up =
the coroutine.
> > Is this change intended?
> >=20
> > aio_co_wake doesn't enter the co-routine if already in coroutine, but
> > I think that this is an aio fd handler with isn't run in co-routine i=
tself,
> > so the callback could run with not yet ready data.
>=20
> (Sorry, I don=E2=80=99t know why I forgot to reply.)
>=20
> I don=E2=80=99t see how anything changes.  aio_co_wake() is still calle=
d after
> the qemu_iovec_memset().
Oops, in this specific areas of the patch, I totally missed the diff mark=
ers.

So,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky


