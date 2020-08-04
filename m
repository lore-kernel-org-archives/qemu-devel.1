Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C39C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782C520792
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUPUN4gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782C520792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k30CN-0003iS-Ld
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k30Bk-0003F5-H0
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:53:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k30Bi-00041D-9F
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596559996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WBCwfirkDEK9xUGhmuwryrwJ/b4wh7bAFmyI5FxB/d0=;
 b=ZUPUN4gb5uzBIAletW0XgnyjvYAcVNH9ymtX12i2EYOP41qibT8cieFnoSznmH/0DEcIeW
 WXOCCNv/dB6prDBhE+XabcJF7oUaz0ymJoCyKurj+YLeIUz6D00MJWmUPa5K0kI7Ieh0Xe
 0VOkLtEUjuaPAtbswhmq3lEo3PZBeis=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-88hu6lIxOl2jYOB7UjBY_g-1; Tue, 04 Aug 2020 12:53:14 -0400
X-MC-Unique: 88hu6lIxOl2jYOB7UjBY_g-1
Received: by mail-wm1-f72.google.com with SMTP id a207so1257370wme.9
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 09:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=bAuktCWuFL3bNvr8NfNIWEedH+D6ag8iLJcy2k00/2Q=;
 b=fzIAaRM3Vy+HQn94DUPSGOpwte76tRFg/WfZIYXWHJybUuLsfl6NJhpbB1AkcbaW+N
 H01/b2dHy2Bx/FCazWHkjyJ4+DwFZQ8r2lhRw9ewlA1SXqan0SpZDNwDgyxDCeOsTcup
 w2DuRYFCtp1bbUPVTeKkHc5WkKKwfaJXs3K2/ijmceazuq/mZjEN3LnNBAYHZAYcLBeu
 duaF/Pdv2tylppew6OEnNrEhXBOH/NW7+S06YJL6Vw4f1MWFtJOAse90Gi83r4fo44Zg
 aHL1zFlraASB8hfQTcCeAW49xnu/OGRa80xf2B5hWFDYKeT3Zf+AtUC6uXR/VV/1zBPD
 WNMQ==
X-Gm-Message-State: AOAM531wCEl1/erW52jRbz67/dtNjb1fs12BUXqymb1qH6DXYdsOwjM3
 2Zq16Uh7zANNC3ej5LHZRpTfZj6mzINyb6hWG1mar+2dKw+Cvb4W2XgyG8OW6m2r3BcszSQsBzr
 WrFVzbx/9J6iZtso=
X-Received: by 2002:adf:ba52:: with SMTP id t18mr2331249wrg.26.1596559992985; 
 Tue, 04 Aug 2020 09:53:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/4yk7Z3YQncmGLJnrjU/b/8eW1Y7XCzFXz43Q455QEvM2Xf+R0CerkjbTfnXcDDt2lMYuog==
X-Received: by 2002:adf:ba52:: with SMTP id t18mr2331232wrg.26.1596559992697; 
 Tue, 04 Aug 2020 09:53:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id 130sm5335972wme.26.2020.08.04.09.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 09:53:11 -0700 (PDT)
Subject: Re: [PATCH 3/3] aio-posix: keep aio_notify_me disabled during polling
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200804052804.1165291-1-stefanha@redhat.com>
 <20200804052804.1165291-4-stefanha@redhat.com>
 <20200804102941.GB1284284@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92e8cc23-a361-f1d4-a2a6-160268cd8b3a@redhat.com>
Date: Tue, 4 Aug 2020 18:53:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200804102941.GB1284284@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ocuxdfT34gUyH9uKyewxnYZ4WS3GKsBkI"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ocuxdfT34gUyH9uKyewxnYZ4WS3GKsBkI
Content-Type: multipart/mixed; boundary="AltOV7tBOxbimPkG7ZZUiat7ucm3YcgLP"

--AltOV7tBOxbimPkG7ZZUiat7ucm3YcgLP
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/08/20 12:29, Stefan Hajnoczi wrote:
> On Tue, Aug 04, 2020 at 06:28:04AM +0100, Stefan Hajnoczi wrote:
>> @@ -597,15 +574,38 @@ bool aio_poll(AioContext *ctx, bool blocking)
>>       * system call---a single round of run_poll_handlers_once suffices.
>>       */
>>      if (timeout || ctx->fdmon_ops->need_wait(ctx)) {
>> +        /*
>> +         * aio_notify can avoid the expensive event_notifier_set if
>> +         * everything (file descriptors, bottom halves, timers) will
>> +         * be re-evaluated before the next blocking poll().  This is
>> +         * already true when aio_poll is called with blocking =3D=3D fa=
lse;
>> +         * if blocking =3D=3D true, it is only true after poll() return=
s,
>> +         * so disable the optimization now.
>> +         */
>> +        if (timeout) {
>> +            atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + =
2);
>> +            /*
>> +             * Write ctx->notify_me before computing the timeout
>> +             * (reading bottom half flags, etc.).  Pairs with
>> +             * smp_mb in aio_notify().
>> +             */
>> +            smp_mb();
>> +
>> +            /* Check again in case a shorter timer was added */
>> +            timeout =3D qemu_soonest_timeout(timeout, aio_compute_timeo=
ut(ctx));
>> +        }
>> +
>>          ret =3D ctx->fdmon_ops->wait(ctx, &ready_list, timeout);
>> -    }
>> =20
>> -    if (blocking) {
>> -        /* Finish the poll before clearing the flag.  */
>> -        atomic_store_release(&ctx->notify_me, atomic_read(&ctx->notify_=
me) - 2);
>> -        aio_notify_accept(ctx);
>> +        if (timeout) {
>> +            /* Finish the poll before clearing the flag.  */
>> +            atomic_store_release(&ctx->notify_me,
>> +                                 atomic_read(&ctx->notify_me) - 2);
>> +        }
>>      }
>=20
> Hi Paolo,
> We can avoid calling aio_compute_timeout() like this, what do you think?

I don't understand :) except I guess you mean we can avoid the second
call.  Can you post either a complete patch with this squashed, or a 4th
patch (whatever you think is best)?

Paolo

>   bool use_notify_me =3D timeout !=3D 0;
>=20
>   if (use_notify_me) {
>       atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);
>       /*
>        * Write ctx->notify_me before computing the timeout
>        * (reading bottom half flags, etc.).  Pairs with
>        * smp_mb in aio_notify().
>        */
>       smp_mb();
>=20
>       /* Don't block if aio_notify() was called */
>       if (atomic_read(ctx->notified)) {
>           timeout =3D 0;
>       }
>   }
>=20
>   ret =3D ctx->fdmon_ops->wait(ctx, &ready_list, timeout);
>=20
>   if (use_notify_me) {
>       /* Finish the poll before clearing the flag.  */
>       atomic_store_release(&ctx->notify_me,
>                            atomic_read(&ctx->notify_me) - 2);
>   }
>=20



--AltOV7tBOxbimPkG7ZZUiat7ucm3YcgLP--

--ocuxdfT34gUyH9uKyewxnYZ4WS3GKsBkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl8pknYACgkQv/vSX3jH
roN7kQf/TzoX2cxuzaoveVFRgbO7l5/0v0BJqkoh8EMPIHiFfhpSN/vEtjDMVU9H
ggNfa+YCPyV5y0xkgWcVLhLOl3Z+m5S+4yB79+lgQ5NkwvvVeGtKTSXI6kCQ4k8t
H+0dPV2K/R5XSIL8e4HrviPwwG/CDNDb6rtGXV4eE9JgtREmeOTVJUCMi70OMvti
GI9g9zuUtK7G1e2RZFnRad7W2h3u1jDdscE+gXtIrPq9IpW3CfcO2J/vMmtM2nnH
xluCg4kPwqjk377W1UU0P1sEogunz97LnXgNPFaLmUlerDYTEPwnYJ9EbiFXvOzs
j65QV7Au7933dW+7s3sqVVkjmXCf4A==
=+IoE
-----END PGP SIGNATURE-----

--ocuxdfT34gUyH9uKyewxnYZ4WS3GKsBkI--


