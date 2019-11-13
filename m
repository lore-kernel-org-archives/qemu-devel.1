Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F52C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984CD222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6YXGdRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984CD222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUuWG-0006wP-PL
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUuVd-0006WO-O3
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUuVc-0000mk-Bk
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:24:41 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUuVc-0000mB-3x
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:24:40 -0500
Received: by mail-wm1-x341.google.com with SMTP id u18so2437924wmc.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=t9Wl2ZEqfmI5CPvb5IUFZM4/pwAOfCIAlphatKun1Pk=;
 b=J6YXGdRpaBYLGZRm1o1iNDnDp3qReXWmiBgTS9YN6yWqwOVqgCUurEBk42VD4tP8J1
 1yv0Ncap+st8eXEgVK7iIarvRdmSviO7MWYFhu8g+C/zZcxqfQtixb3jv9P8LqwsHWBR
 VedzHJ3gI6Fyswt7pIwX5i72LSutQ51rgfEe0GTdJCd9yu02LPYw0lqwSHlzIzOytCXW
 Ux7TjmqeTZA2mvubCQtp6n336PyPCRubEUYceFaQOPlTi50GACEpHZ5/0LkiACBIuHT7
 +tI1dWaGNw3Y8h8mb3XYGDEJC7vpjSD9LxfRQUqsr6X2n0CvvVcXZecSdxAgK3GreZh0
 rRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=t9Wl2ZEqfmI5CPvb5IUFZM4/pwAOfCIAlphatKun1Pk=;
 b=OsyCwSduLQU78ODMDEv2rtV+f6/TNPnO8azs/hBXoQvghfGbz3NigGTTw7k7haSWIf
 6i7LSz0yDjoy4ya1+zRngNy6qwPjqMMTNZMIcIL2ToJcrMsoE98wXeKNPP3ikIlda2DK
 bb6lxTn39m/xVhOHQAYABuD6OU417FF0U06KsnliivcnT13iegwFoNOi7fwkk7G6CVWy
 UU/zLe6ZLnqiJ0G0CqDVuDAT9AmWFQDkaNSQI0oRb3Fzi5Z3FdEnWVbr1nWADPaJT3+9
 Pu3rfbM+FDyc8Zw4hDNaIU8opQYPnB4Fp/eA2RaZnL3KfM5a40kBxbT34MwCSTWwlpxW
 g0RQ==
X-Gm-Message-State: APjAAAVqpnJUwMAKzryDJH8RaIEr9zcyRjQt6ycScW1Se4NX8bhvcg13
 stJBs13LI1rcKmwulSa8PJR1Hw==
X-Google-Smtp-Source: APXvYqx+0nmyglTAIp74hFb5AObxFyvnFFPKYGoagLx3afeRpXjcK76rwa3fztrqrvu0RncA8L1D4g==
X-Received: by 2002:a1c:e08a:: with SMTP id x132mr3399734wmg.146.1573658678056; 
 Wed, 13 Nov 2019 07:24:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w7sm3057839wru.62.2019.11.13.07.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 07:24:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD2BC1FF87;
 Wed, 13 Nov 2019 15:24:35 +0000 (GMT)
References: <20191112150105.2498-1-robert.foley@linaro.org>
 <20191112150105.2498-4-robert.foley@linaro.org>
 <87lfsl809m.fsf@linaro.org>
 <CAEyhzFtk4uewBK9dY1SpJh4UVn7g3Pd8qCvqhskJX38ci9jWSA@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 3/5] Add use of RCU for qemu_logfile.
In-reply-to: <CAEyhzFtk4uewBK9dY1SpJh4UVn7g3Pd8qCvqhskJX38ci9jWSA@mail.gmail.com>
Date: Wed, 13 Nov 2019 15:24:35 +0000
Message-ID: <87k1837qa4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Puhov <peter.puhov@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> On Tue, 12 Nov 2019 at 12:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> >          }
>> > +        atomic_rcu_set(&qemu_logfile, logfile);
>> >      }
>> > -    qemu_mutex_unlock(&qemu_logfile_mutex);
>> > +    logfile =3D qemu_logfile;
>>
>> Isn't this read outside of the protection of both rcu_read_lock() and
>> the mutex? Could that race?
>
> This assignment is under the mutex.  This change moved the mutex
> unlock towards the end of the function, just a few lines below the
> call_rcu().

Ahh I see now, I went +- blind ;-)

>
>> > +
>> >      if (qemu_logfile &&
>> >          (is_daemonized() ? logfilename =3D=3D NULL : !qemu_loglevel))=
 {
>> > -        qemu_log_close();
>> > +        atomic_rcu_set(&qemu_logfile, NULL);
>> > +        call_rcu(logfile, qemu_logfile_free, rcu);
>>
>> I wonder if we can re-arrange the logic here so it's lets confusing? For
>> example the NULL qemu_loglevel can be detected at the start and we
>> should be able just to squash the current log and reset and go. I'm not
>> sure about the damonize/stdout check.
>>
>> >      }
>> > +    qemu_mutex_unlock(&qemu_logfile_mutex);
>> >  }
>> >
>
> Absolutely, the logic that was here originally can be improved.  We
> found it confusing also.
> We could move things around a bit and change it to something like this
> to help clarify.
>
>     bool need_to_open_file =3D false;
>     /*
>      * In all cases we only log if qemu_loglevel is set.
>      * And:
>      *     If not daemonized we will always log either to stderr
>      *       or to a file (if there is a logfilename).
>      *     If we are daemonized,
>      *       we will only log if there is a logfilename.
>      */
>     if (qemu_loglevel && (!is_daemonized() || logfilename) {
>         need_to_open_file =3D true;
>     }
>     g_assert(qemu_logfile_mutex.initialized);
>     qemu_mutex_lock(&qemu_logfile_mutex);
>
>     if(qemu_logfile && !need_to_open_file) {
>         /* Close file. */
>         QemuLogFile *logfile =3D qemu_logfile;
>         atomic_rcu_set(&qemu_logfile, NULL);
>         call_rcu(logfile, qemu_logfile_free, rcu);
>     } else if(!qemu_logfile && need_to_open_file) {
>         logfile =3D g_new0(QemuLogFile, 1);
>        __snip__ existing patch logic for opening the qemu_logfile will
> be inserted here.
>     }
>     qemu_mutex_unlock(&qemu_logfile_mutex);

That reads a lot better thanks. It's probably worth doing the clean-up in
a separate patch so it is easier to see the mutex's when added.

--
Alex Benn=C3=A9e

