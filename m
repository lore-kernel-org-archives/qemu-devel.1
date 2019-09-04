Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1547BC3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 10:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21572339D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 10:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21572339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5SGB-0001e9-2Z
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 06:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i5SFU-0001FY-UN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 06:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i5SFS-0008Sy-Hq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 06:10:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i5SFS-0008RO-AK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 06:10:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1727D10576C1;
 Wed,  4 Sep 2019 10:10:45 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-69.ams2.redhat.com [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93E0C100197A;
 Wed,  4 Sep 2019 10:10:40 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20190821155327.25208-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <9076f70a-013c-5f1f-a88a-6bc75e311f59@redhat.com>
Date: Wed, 4 Sep 2019 12:10:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821155327.25208-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 04 Sep 2019 10:10:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests: make filemonitor test more robust
 to event ordering
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/2019 17.53, Daniel P. Berrang=C3=A9 wrote:
> The ordering of events that are emitted during the rmdir
> test have changed with kernel >=3D 5.3. Semantically both
> new & old orderings are correct, so we must be able to
> cope with either.
>=20
> To cope with this, when we see an unexpected event, we
> push it back onto the queue and look and the subsequent
> event to see if that matches instead.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/test-util-filemonitor.c | 43 +++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 9 deletions(-)
>=20
> diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonito=
r.c
> index 46e781c022..301cd2db61 100644
> --- a/tests/test-util-filemonitor.c
> +++ b/tests/test-util-filemonitor.c
> @@ -45,6 +45,11 @@ typedef struct {
>      const char *filedst;
>      int64_t *watchid;
>      int eventid;
> +    /*
> +     * Only valid with OP_EVENT - this event might be
> +     * swapped with the next OP_EVENT
> +     */
> +    bool swapnext;
>  } QFileMonitorTestOp;
> =20
>  typedef struct {
> @@ -98,6 +103,10 @@ qemu_file_monitor_test_handler(int64_t id,
>      QFileMonitorTestData *data =3D opaque;
>      QFileMonitorTestRecord *rec =3D g_new0(QFileMonitorTestRecord, 1);
> =20
> +    if (debug) {
> +        g_printerr("Queue event id %" PRIx64 " event %d file %s\n",
> +                   id, event, filename);
> +    }
>      rec->id =3D id;
>      rec->event =3D event;
>      rec->filename =3D g_strdup(filename);
> @@ -125,7 +134,8 @@ qemu_file_monitor_test_record_free(QFileMonitorTest=
Record *rec)
>   * to wait for the event to be queued for us.
>   */
>  static QFileMonitorTestRecord *
> -qemu_file_monitor_test_next_record(QFileMonitorTestData *data)
> +qemu_file_monitor_test_next_record(QFileMonitorTestData *data,
> +                                   QFileMonitorTestRecord *pushback)
>  {
>      GTimer *timer =3D g_timer_new();
>      QFileMonitorTestRecord *record =3D NULL;
> @@ -139,9 +149,15 @@ qemu_file_monitor_test_next_record(QFileMonitorTes=
tData *data)
>      }
>      if (data->records) {
>          record =3D data->records->data;
> -        tmp =3D data->records;
> -        data->records =3D g_list_remove_link(data->records, tmp);
> -        g_list_free(tmp);
> +        if (pushback) {
> +            data->records->data =3D pushback;
> +        } else {
> +            tmp =3D data->records;
> +            data->records =3D g_list_remove_link(data->records, tmp);
> +            g_list_free(tmp);
> +        }
> +    } else if (pushback) {
> +        qemu_file_monitor_test_record_free(pushback);
>      }
>      qemu_mutex_unlock(&data->lock);
> =20
> @@ -158,13 +174,15 @@ static bool
>  qemu_file_monitor_test_expect(QFileMonitorTestData *data,
>                                int64_t id,
>                                QFileMonitorEvent event,
> -                              const char *filename)
> +                              const char *filename,
> +                              bool swapnext)
>  {
>      QFileMonitorTestRecord *rec;
>      bool ret =3D false;
> =20
> -    rec =3D qemu_file_monitor_test_next_record(data);
> +    rec =3D qemu_file_monitor_test_next_record(data, NULL);
> =20
> + retry:
>      if (!rec) {
>          g_printerr("Missing event watch id %" PRIx64 " event %d file %=
s\n",
>                     id, event, filename);
> @@ -172,6 +190,11 @@ qemu_file_monitor_test_expect(QFileMonitorTestData=
 *data,
>      }
> =20
>      if (id !=3D rec->id) {
> +        if (swapnext) {
> +            rec =3D qemu_file_monitor_test_next_record(data, rec);
> +            swapnext =3D false;
> +            goto retry;
> +        }
>          g_printerr("Expected watch id %" PRIx64 " but got %" PRIx64 "\=
n",
>                     id, rec->id);
>          goto cleanup;
> @@ -347,7 +370,8 @@ test_file_monitor_events(void)
>            .filesrc =3D "fish", },
>          { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
>            .filesrc =3D "", .watchid =3D &watch4,
> -          .eventid =3D QFILE_MONITOR_EVENT_IGNORED },
> +          .eventid =3D QFILE_MONITOR_EVENT_IGNORED,
> +          .swapnext =3D true },
>          { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
>            .filesrc =3D "fish", .watchid =3D &watch0,
>            .eventid =3D QFILE_MONITOR_EVENT_DELETED },
> @@ -493,8 +517,9 @@ test_file_monitor_events(void)
>                  g_printerr("Event id=3D%" PRIx64 " event=3D%d file=3D%=
s\n",
>                             *op->watchid, op->eventid, op->filesrc);
>              }
> -            if (!qemu_file_monitor_test_expect(
> -                    &data, *op->watchid, op->eventid, op->filesrc))
> +            if (!qemu_file_monitor_test_expect(&data, *op->watchid,
> +                                               op->eventid, op->filesr=
c,
> +                                               op->swapnext))
>                  goto cleanup;
>              break;
>          case QFILE_MONITOR_TEST_OP_CREATE:
>=20

I don't know that part of the code, but this looks ok to me at a quick
glance. So FWIW, from my side a light
Reviewed-by: Thomas Huth <thuth@redhat.com>

