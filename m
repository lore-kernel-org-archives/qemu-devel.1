Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BDCC3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB69C2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB69C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzfcZ-0001zH-KK
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 07:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzfbW-0001OF-NJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzfbV-0007bB-I1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:13:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzfbV-0007Z9-Aa
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:13:37 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 980C765F5A
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 11:13:35 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id f14so205420wmh.7
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 04:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mfY8chG6Ck2VXneH+ptq8e7mdXpFeZ4KoTxRayd8eJk=;
 b=o61v6+kDwffmrkl18R953TesQUHR5y7vuFmVr8FLAZ609y3o5Vc+GiG+1ltW9bHODy
 cuz7wkRl6GcINo8WK1OtRvGe//B4B4zu1adrigssigbMKqhSyYGtn27WLkAOvVYUpDbq
 5dZc/GZuMbMxmrPbB1vX18/0vJGBeiWLkcbs5AKJEaz0wxIWDzBZHC6s1NlIM+lo7aPJ
 sXM6I4D3F/U7+AwN/OQumMt6PosMYLi85Way3X2rMieprQNAU8LiPQtOEDPpjGKMna8Y
 mlUYzjhmBr/vnexPtCK5REm1QanAu5Jddgr/6JS4QB2dM961jIu/pXaZJKa/CHfvqCXy
 ld2Q==
X-Gm-Message-State: APjAAAVtalaI988HadnFfKvxmFeElrE6kOlFjFrJIu968I+mNhvofO2T
 CBbxCgojpt1bTB5Fi8n8LOAkbWp/8/WXRyTyh2HbVQPWe1q9gtdKSonNWtZzf3ucmXd1gyJHaru
 64TrzRE+shYtoQkg=
X-Received: by 2002:a5d:4083:: with SMTP id o3mr13825555wrp.150.1566213214359; 
 Mon, 19 Aug 2019 04:13:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9Yk8eOcaidZJaqUmnZadDBsYTrbkQTEKa7/C35hbuqZRd31ft0T47dMcIfql6HKs/BxHsfg==
X-Received: by 2002:a5d:4083:: with SMTP id o3mr13825542wrp.150.1566213214191; 
 Mon, 19 Aug 2019 04:13:34 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id a6sm10795061wmj.15.2019.08.19.04.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 04:13:33 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20190814020218.1868-1-quintela@redhat.com>
 <20190814020218.1868-6-quintela@redhat.com>
 <99a8c83e-7ddf-1452-ac98-7bb495e8ef88@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f1f1535e-5358-db17-349a-28d3f246a7da@redhat.com>
Date: Mon, 19 Aug 2019 13:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <99a8c83e-7ddf-1452-ac98-7bb495e8ef88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/6] migration: add some multifd traces
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 1:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/14/19 4:02 AM, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c        | 3 +++
>>  migration/trace-events | 4 ++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f1aec95f83..25a211c3fb 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1173,6 +1173,7 @@ static void *multifd_send_thread(void *opaque)
>> =20
>>  out:
>>      if (local_err) {
>> +        trace_multifd_send_error(p->id);
>>          multifd_send_terminate_threads(local_err);
>>      }
>> =20
>> @@ -1203,6 +1204,7 @@ static void multifd_new_send_channel_async(QIOTa=
sk *task, gpointer opaque)
>>      QIOChannel *sioc =3D QIO_CHANNEL(qio_task_get_source(task));
>>      Error *local_err =3D NULL;
>> =20
>> +    trace_multifd_new_send_channel_async(p->id);
>>      if (qio_task_propagate_error(task, &local_err)) {
>>          migrate_set_error(migrate_get_current(), local_err);
>>          multifd_save_cleanup();
>> @@ -1496,6 +1498,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc, E=
rror **errp)
>>                                  atomic_read(&multifd_recv_state->coun=
t));
>>          return false;
>>      }
>> +    trace_multifd_recv_new_channel(id);
>> =20
>>      p =3D &multifd_recv_state->params[id];
>>      if (p->c !=3D NULL) {
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 9fbef614ab..5d85f8bf83 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -81,7 +81,9 @@ migration_bitmap_sync_start(void) ""
>>  migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu6=
4
>>  migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size=
, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%l=
x"
>>  migration_throttle(void) ""
>> +multifd_new_send_channel_async(uint8_t id) "channel %d"
>>  multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t=
 flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pag=
es %d flags 0x%x next packet size %d"
>> +multifd_recv_new_channel(uint8_t id) "channel %d"
>>  multifd_recv_sync_main(long packet_num) "packet num %ld"
>>  multifd_recv_sync_main_signal(uint8_t id) "channel %d"
>>  multifd_recv_sync_main_wait(uint8_t id) "channel %d"
>> @@ -89,7 +91,9 @@ multifd_recv_terminate_threads(bool error) "error %d=
"
>>  multifd_recv_thread_can_start(uint8_t id) "channel %d"
>>  multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages)=
 "channel %d packets %" PRIu64 " pages %" PRIu64
>>  multifd_recv_thread_start(uint8_t id) "%d"
>> +multifd_save_setup_wait(uint8_t id) "%d"
>=20
> This one is not used.
>=20
> For the rest:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Oh I forgot, uint8_t format is "%u", we don't care so far but it could
be useful to enable the -Wformat-signedness cflag one day.

>>  multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t=
 flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pag=
es %d flags 0x%x next packet size %d"
>> +multifd_send_error(uint8_t id) "channel %d"
>>  multifd_send_sync_main(long packet_num) "packet num %ld"
>>  multifd_send_sync_main_signal(uint8_t id) "channel %d"
>>  multifd_send_sync_main_wait(uint8_t id) "channel %d"
>>

