Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46698C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1148321739
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhtLRj9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1148321739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1yvu-0002p2-8o
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1yud-0001P7-AD
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1yuc-0001wQ-6m
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:47:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1yub-0001wF-3L
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581540428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qd/xgooo9ryCPm+/ticDE/NqjPKzSPgzNAKcSdx0Pe0=;
 b=OhtLRj9kozLndKgWBdvqRnhJbwoiUvGQpr3NEEteK0RGXu0GAWwh1anexBm/kEYb3BDaXR
 7d3ydgpZzW0bpeL6iRDdOsWS6q2Cu9sx73nrIOs7EozhHff3CtbEJIwimOohr+psq1w8Cw
 DoO832TTcwXpOTGoqgEubfNSpTYJEUc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-fPqQrIaTNwGIFooG7q9opQ-1; Wed, 12 Feb 2020 15:47:05 -0500
Received: by mail-wm1-f72.google.com with SMTP id b133so1454232wmb.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0rrZpVbnBEJFl5cNBzrT/N86dhoFpwKjnhBwz2P3PLY=;
 b=ij91rFyomSU1phTUn7pg3VJhHH2AaUd01NwbiT6PYJOrxTJvrHN52fI9aUgLQPGHgo
 6lAmcN34b4FuvwYxyXI5DDzrPJ/f4edky5I3KSulNbiAecwEMJUCJycalGZjzXHpVxTV
 Oyr8A0a8qfVFbuGj+1rJ5cVftS4jMsOZPipYB/RvJ2MGYMQJkeP5W7SRv0NZVEHpfPk1
 C9zLgfi383dYeBlyVZqttmxW4Ti6J7Ra+lQ2ZJdAmERXCoQfuHy+cPheikgdhXRoSSM8
 Apmld7bWFGiJ5G2T+djrIuGgKYYITNtd6AOJ12EL03A+W2jwQUlNtLF5lfaB2dRe46oC
 eyLw==
X-Gm-Message-State: APjAAAXK8A28dw5voCQ+C30wdq4iF2x1OvBiZJVHs60Yjmlyuyx+5v0R
 bWcexR6VNl/69dUcK34AGMdyAcFJIFz/sos8TMQeuPCPJHQHVztxy/rPJ535U+12LD87Zes+Plv
 G4fjLnN+Wd03I7to=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr17765963wrv.358.1581540423819; 
 Wed, 12 Feb 2020 12:47:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzijWK47A/pWHC+VIPMrZGYE7l9p0w+9OPDfiCleGS/d90yMyaWdgcZlhSgAu2yoMhlJPCK2w==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr17765948wrv.358.1581540423630; 
 Wed, 12 Feb 2020 12:47:03 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm2102662wmb.37.2020.02.12.12.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 12:47:03 -0800 (PST)
Subject: Re: [PATCH v1 3/5] tests/rcutorture: better document locking of stats
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200207113939.9247-1-alex.bennee@linaro.org>
 <20200207113939.9247-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57f05969-3fbe-6d54-b937-70ce2732a081@redhat.com>
Date: Wed, 12 Feb 2020 21:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207113939.9247-4-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: fPqQrIaTNwGIFooG7q9opQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 12:39 PM, Alex Benn=C3=A9e wrote:
> This is pure code motion with no functional effect.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/rcutorture.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/rcutorture.c b/tests/rcutorture.c
> index e8b2169e7dd..256d24ed5ba 100644
> --- a/tests/rcutorture.c
> +++ b/tests/rcutorture.c
> @@ -65,8 +65,6 @@
>   #include "qemu/rcu.h"
>   #include "qemu/thread.h"
>  =20
> -long long n_reads =3D 0LL;
> -long n_updates =3D 0L;
>   int nthreadsrunning;
>  =20
>   #define GOFLAG_INIT 0
> @@ -78,11 +76,20 @@ static volatile int goflag =3D GOFLAG_INIT;
>   #define RCU_READ_RUN 1000
>  =20
>   #define NR_THREADS 100
> -static QemuMutex counts_mutex;
>   static QemuThread threads[NR_THREADS];
>   static struct rcu_reader_data *data[NR_THREADS];
>   static int n_threads;
>  =20
> +/*
> + * Statistical counts
> + *
> + * These are the sum of local counters at the end of a run.
> + * Updates are protected by a mutex.
> + */
> +static QemuMutex counts_mutex;
> +long long n_reads =3D 0LL;
> +long n_updates =3D 0L;
> +
>   static void create_thread(void *(*func)(void *))
>   {
>       if (n_threads >=3D NR_THREADS) {
> @@ -230,8 +237,9 @@ struct rcu_stress {
>   struct rcu_stress rcu_stress_array[RCU_STRESS_PIPE_LEN] =3D { { 0 } };
>   struct rcu_stress *rcu_stress_current;
>   int rcu_stress_idx;
> -
>   int n_mberror;
> +
> +/* Updates protected by counts_mutex */
>   long long rcu_stress_count[RCU_STRESS_PIPE_LEN + 1];
>  =20
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


