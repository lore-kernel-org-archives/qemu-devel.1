Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3017C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 19:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C35F222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 19:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqjpKaw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C35F222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inSIR-0006JR-GO
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 14:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1inSHQ-0005Uv-5S
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 14:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1inSHJ-0004R0-7Z
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 14:06:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56102
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1inSHJ-0004KE-1r
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 14:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578078391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIsQ4aJo0L3ps69lPGFqpV///xOApSu1YuG1Ys8BKzA=;
 b=iqjpKaw2AxuEd+MfDIgeSTq3vfAjbhd8pIenROK1mL0wSDnG/z1np8a+D1yWc64BEAHfVU
 Zp9kyuXnIFJzoqU0BUKhhTcm+IIJSliMwTN/leErvdzSg34WeTOidw+F+kD7VPBaYgzLTk
 /73hGW6yBQ84iDTOLJqnv11sJMU+tD8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-IUVbT8Y0Pcml4XgXOjSoew-1; Fri, 03 Jan 2020 14:06:30 -0500
Received: by mail-qv1-f71.google.com with SMTP id x22so28537396qvc.18
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 11:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vfzCk8ICMzM9u/f+m2mM/q2a5f78C7jv9zndOhfIbus=;
 b=rAKp3+MMRps5QJZBZVReWx8chYWQzk1ao8VNReh1lQoPR0ssjwNNgiGtx+VdQLyxbA
 L85AvmzOUgZ8ndre0Sfswg3mYAeWO5w2ZtuZr8kkvPN9lTu5ludAcvJ8u9uyW32tBRDU
 PaTU7osXQDTtHwE1CSWjg00n2+Gn3/YaZ8Flh6IETzZCTu9cllrHRNL9g7neE9FvFGRN
 10zfmn9q4P5JILluhWJTLHehlcerhq27/qf65HIU6dkd3zGMpUV2+e0Yqo3mBDhyT2Ye
 a5TUw6P1W43kHvkK1W90nznk4rEjrMQFxcowVas1xPKuK+bsou6EuwPH95mkoGTfu1Fh
 tf6Q==
X-Gm-Message-State: APjAAAW05kaPr4SEjKnEcdgMEMvg91VFYELBw47cRNDWF9dOOB1Zt1Ub
 z+KY/NvTgQF33HAEyJ6htJuR32bXDHOXqZSRqHUp8mE+9ppDuNiTwq/XNh9fJUfJdX++p/T4led
 a1tokTuOd1TKUPfQ=
X-Received: by 2002:ac8:22fd:: with SMTP id g58mr63985211qta.125.1578078389939; 
 Fri, 03 Jan 2020 11:06:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSsR7cgPynd2vs0JeoaZnWKVFERM8qgpYMlLNqcoOd2hf2OlgXxMZDSyvpsjh8ZC1+BTtD+w==
X-Received: by 2002:ac8:22fd:: with SMTP id g58mr63985191qta.125.1578078389663; 
 Fri, 03 Jan 2020 11:06:29 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id y91sm18924621qtd.28.2020.01.03.11.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 11:06:28 -0800 (PST)
Date: Fri, 3 Jan 2020 14:06:27 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/2] Speed up QMP stream reading
Message-ID: <20200103190627.GE157597@xz-x1>
References: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
 <87a77ndlms.fsf@dusky.pond.sub.org>
 <549941577104857@iva4-9c479177d279.qloud-c.yandex.net>
 <20200103110731.GC3804@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200103110731.GC3804@work-vm>
X-MC-Unique: IUVbT8Y0Pcml4XgXOjSoew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 03, 2020 at 11:07:31AM +0000, Dr. David Alan Gilbert wrote:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> > Hi!
> >=20
> > 20.12.2019, 19:09, "Markus Armbruster" <armbru@redhat.com>:
> > > Yury Kotov <yury-kotov@yandex-team.ru> writes:
> > >
> > >>  Hi,
> > >>
> > >>  This series is continuation of another one:
> > >>  [PATCH] monitor: Fix slow reading
> > >>  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg03722.html
> > >>
> > >>  Which also tried to read more than one byte from a stream at a time=
,
> > >>  but had some problems with OOB and HMP:
> > >>  https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg05018.html
> > >>
> > >>  This series is an attempt to fix problems described.
> > >
> > > Two problems: (1) breaks HMP migrate -d, and (2) need to think throug=
h
> > > how this affects reading of QMP input, in particular OOB.
> > >
> > > This series refrains from changing HMP, thus avoids (1). Good.
> > >
> > > What about (2)? I'm feeling denser than usual today... Can you explai=
n
> > > real slow how QMP input works? PATCH 2 appears to splice in a ring
> > > buffer. Why is that needed?
> >=20
> > Yes, the second patch introduced the input ring buffer to store remaini=
ng
> > bytes while monitor is suspended.
> >=20
> > QMP input scheme:
> > 1. monitor_qmp_can_read returns a number of bytes, which it's ready to =
receive.
> >    Currently it returns 0 (if suspended) or 1 otherwise.
> >    In my patch: monitor_qmp_can_read returns a free size of the introdu=
ced
> >    ring buffer.
> >=20
> > 2. monitor_qmp_read receives and handles input bytes
> >    Currently it just puts received bytes into a json lexer.
> >    If monitor is suspended this function won't be called and thus it wo=
n't
> >    process new command until monitor resume.
> >    In my patch: monitor_qmp_read stores input bytes into the buffer and=
 then
> >    handles bytes in the buffer one by one while monitor is not suspende=
d.
> >    So, it allows to be sure that the original logic is preserved and
> >    we won't handle new commands while monitor is suspended.
> >=20
> > 3. monitor_resume schedules monitor_accept_input which calls
> >    monitor_qmp_handle_inbuf which tries to handle remaining bytes
> >    in the buffer. monitor_accept_input is a BH scheduled by monitor_res=
ume
> >    on monitor's aio context. It is needed to be sure, that we access
> >    the input buffer only in monitor's context.
> >=20
> > Example:
> > 1. QMP read 100 bytes
> > 2. Handle some command in the first 60 bytes
> > 3. For some reason, monitor becomes suspended after the first command
> > 4. 40 bytes are remaining
> > 5. After a while, something calls monitor_resume which handles
> >    the remaining bytes in the buffer (implicitly: resume -> sched bh ->=
 buf)
> >=20
> > Actually, QMP continues to receive data even though the monitor is susp=
ended
> > until the buffer is full. But it doesn't process received data.
>=20
> I *think* that's OK for OOB; my reading is that prior to this set of
> patches, if you filled the queue (even with oob enabled) you could
> suspend the monitor and block - but you're just not supposed to be
> throwing commands quickly at an OOB monitor; but I'm cc'ing in Peter.

I read this first:

https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg00472.html

Which makes sense to me.  From OOB POV, IMHO it's fine, because as
Markus pointed out that we only call emit() after the json
parser/streamer, so IIUC it should not be affected on how much we read
from the chardev frontend each time.

But from my understanding what Markus suggested has nothing to do with
the currently introduced ring buffer.  Also, from what I read above I
still didn't find anywhere that explained on why we need a ring buffer
(or I must have missed it).

Thanks,

--=20
Peter Xu


