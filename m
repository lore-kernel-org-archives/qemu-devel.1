Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B862C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B8E20673
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B8E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAsS-0006TN-VD
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJArj-0005dm-Fc
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJAri-0005T7-8M
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:26:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJAri-0005St-0N
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:26:58 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0321481F22
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:26:57 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id 7so158415wrl.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VuSV8RuVhikDQIgVjK7iSVtEiPNRh79URjuDjnbfxb8=;
 b=o+ymmepdl5UUEpsydKJa38PvQDqTjNm30B8Vypi1+3blZmf97sgB9wsWvFMbyxPEpp
 b5yqFwxjaUBDB1F4+wfc6ZMgXUQ0i7Pd8EKVdwbA2oDK+1Ic2xmgTXTTiwER2OcoR+aa
 pJ7kpNCstipwDhbJu/vmFfHufDUDuDpyGhRBqbfNKZjzeTch0pP4cPa4m2oUMlRu6Eh0
 NdjoevUF5BwBc8ZhVb6pvDO9SSETDvCKGoKnkGmxeZd9UsEGp7jUHF6foG1Oe9E3ucHP
 vVCLWx+JMQps0+8UPa/6fNQ3SSDaz6xg8Y/XbCiZczDTS5rNnXr6fL9SuJbgxhP0slvw
 o1zg==
X-Gm-Message-State: APjAAAXzgF16b3Fs/ADpmZ+sCrqp4CFLSwmHOgqiM0DSwO+jvEJUTv89
 HCsBnWitY4P+WicpQj2490oQE8zOZ+baoKP7i1wxk/g4Ygz6udSTDp1P+ZMuRP9gUjVfkCnSIs8
 fjXV3pxEtVzF+XmU=
X-Received: by 2002:a1c:20d8:: with SMTP id g207mr6156390wmg.79.1570861615673; 
 Fri, 11 Oct 2019 23:26:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/8r7w+sAW4GrqiQmdlI+cxKvRzezoPbqcMvcs3AIXPvHVem1Mrl8CAVYvzRqrW72JODnecA==
X-Received: by 2002:a1c:20d8:: with SMTP id g207mr6156372wmg.79.1570861615423; 
 Fri, 11 Oct 2019 23:26:55 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id h7sm10200343wrt.17.2019.10.11.23.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:26:54 -0700 (PDT)
Subject: Re: [RFC v5 085/126] Tracing: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-86-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <22a1be14-c018-8739-4fa0-c57d8506cef1@redhat.com>
Date: Sat, 12 Oct 2019 08:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-86-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 6:05 PM, Vladimir Sementsov-Ogievskiy wrote:
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp =3D=3D &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>=20
> If we want to check error after errp-function call, we need to
> introduce local_err and than propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>     &error_fatel, this means that we don't break error_abort
>     (we'll abort on error_set, not on error_propagate)
>=20
> This commit (together with its neighbors) was generated by
>=20
> for f in $(git grep -l errp \*.[ch]); do \
>      spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>      --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff =
$f; \
> done;
>=20
> then fix a bit of compilation problems: coccinelle for some reason
> leaves several
> f() {
>      ...
>      goto out;
>      ...
>      out:
> }
> patterns, with "out:" at function end.
>=20
> then
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>=20
> (auto-msg was a file with this commit message)
>=20
> Still, for backporting it may be more comfortable to use only the first
> command and then do one huge commit.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   trace/qmp.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/trace/qmp.c b/trace/qmp.c
> index 38246e1aa6..05335f2da4 100644
> --- a/trace/qmp.c
> +++ b/trace/qmp.c
> @@ -70,7 +70,7 @@ TraceEventInfoList *qmp_trace_event_get_state(const c=
har *name,
>                                                 bool has_vcpu, int64_t =
vcpu,
>                                                 Error **errp)
>   {
> -    Error *err =3D NULL;
> +    ERRP_AUTO_PROPAGATE();
>       TraceEventInfoList *events =3D NULL;
>       TraceEventIter iter;
>       TraceEvent *ev;
> @@ -78,9 +78,8 @@ TraceEventInfoList *qmp_trace_event_get_state(const c=
har *name,
>       CPUState *cpu;
>  =20
>       /* Check provided vcpu */
> -    cpu =3D get_cpu(has_vcpu, vcpu, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> +    cpu =3D get_cpu(has_vcpu, vcpu, errp);
> +    if (*errp) {
>           return NULL;
>       }
>  =20
> @@ -135,16 +134,15 @@ void qmp_trace_event_set_state(const char *name, =
bool enable,
>                                  bool has_vcpu, int64_t vcpu,
>                                  Error **errp)
>   {
> -    Error *err =3D NULL;
> +    ERRP_AUTO_PROPAGATE();
>       TraceEventIter iter;
>       TraceEvent *ev;
>       bool is_pattern =3D trace_event_is_pattern(name);
>       CPUState *cpu;
>  =20
>       /* Check provided vcpu */
> -    cpu =3D get_cpu(has_vcpu, vcpu, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> +    cpu =3D get_cpu(has_vcpu, vcpu, errp);
> +    if (*errp) {
>           return;
>       }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

