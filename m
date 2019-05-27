Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9469C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A026E217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPzueVT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A026E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVHOh-00067Q-U4
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 11:18:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hVHNp-0005oT-GJ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hVHNo-0004WV-IY
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:17:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hVHNo-0004Va-8A
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:17:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id s19so15098996otq.5
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=LDt1ZMVt3jOx5xUfvZNYOQsaRvmy1yW5BL4rhTFQZZY=;
	b=aPzueVT6FSHXaUXwCfrR9/rOYE3/BP3mOapCnLtZucJHNgcSJtPIsMxcMXSp1jcZg5
	0AmBPl+oGN2P2el08Twa12fbuUGo8hSe+2FnKlplx6C5sao35hKw4jxVVTGWh6Q4sY52
	hUwB92YGEcvBAOmfmRLX8Wks73/6XrjiMHivRDUuUM6s3EVM0lpHLdzDdSQH1gZrfhJw
	+8ttwJY2sjyTucVx21gj84vrYPEnTt3CH9QcF8XGbGpBCxk9e0CKkU7362d88T+2nNqs
	xemVE83EV6/BG9cq0PteT5ZT1PTNGvSWpOhypeS8a27trCQ0I/Yz6JNToosVWrQuVwcG
	wZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=LDt1ZMVt3jOx5xUfvZNYOQsaRvmy1yW5BL4rhTFQZZY=;
	b=hnTWVnIKv+VjGFI4gKHpHJ8CEd0xG22qtZWwP0JBaYE3LjoEBNHMwUFQHy1DmF4zoL
	a3HDRR/dCA8Pmw3wjzGSbbXTtTi92U7khDnL8v1JVprdVjSd07H6N/9CqWH6ZicUyMYP
	A4KBJyu+JhhhthAVNoQEXu0u9UJDBFQxhKAb2LaxgAP367drzHCBZD3i6CRV8zlYhI/l
	V8fiStnCtDP3EvaGdX/d+n+LNuKwNhDnXMRDkdMGTh6ivEGW7FTSLNyMJKXs2aLVLmSH
	hHrf+Ao5uY5dNKw7Lupv9FeU09WasUUZpz/U4cc6wSMVc69WKbm5S66vc/rgNpymN2+O
	iZHQ==
X-Gm-Message-State: APjAAAV4kO3kp/Bi0sgM9tmLqKviHlV6GWk7PQ0MD5yW8dDkuobfuyp0
	sTpMX+4PUqE02r/apd6ieUza36iYr7kAaJfGNII=
X-Google-Smtp-Source: APXvYqzHvBsn9bPv5NA0+fFd1sKYE4mG6TyXYJ82ftQoHLLmLVRCOvDWz4kXButqwbCTAUlaJFvzNZg1hxMO41K9oNM=
X-Received: by 2002:a05:6830:138d:: with SMTP id
	d13mr19566302otq.272.1558970271334; 
	Mon, 27 May 2019 08:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	<87sgt7sxhy.fsf@dusky.pond.sub.org>
	<CAJ+F1CJ6hpQZf6199_-rAW98HwEssNT_kXBJF9he9NZFvWaGPA@mail.gmail.com>
	<87tvdlhakq.fsf@dusky.pond.sub.org>
	<CAJ+F1CJLuNVu_aWPjQtFwP_tLMqn=vd_gCtW7SWZWdhYMF6H7w@mail.gmail.com>
	<87blzo1fa5.fsf@dusky.pond.sub.org>
	<20190527090731.uohmamahlg53bu77@sirius.home.kraxel.org>
	<87pno46ngf.fsf@dusky.pond.sub.org>
In-Reply-To: <87pno46ngf.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 May 2019 17:17:39 +0200
Message-ID: <CAJ+F1C+kbKF0nts+GY3KjQj+YXHhkW2S-vphuzCKhE2Ob08ihQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v4 00/20] monitor: add asynchronous command
 type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
	QEMU <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, May 27, 2019 at 3:23 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Gerd Hoffmann <kraxel@redhat.com> writes:
>
> > On Mon, May 27, 2019 at 10:18:42AM +0200, Markus Armbruster wrote:
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >>
> >> > Hi
> >> >
> >> > On Thu, May 23, 2019 at 9:52 AM Markus Armbruster <armbru@redhat.com=
> wrote:
> >> >> I'm not sure how asynchronous commands could support reconnect and
> >> >> resume.
> >> >
> >> > The same way as current commands, including job commands.
> >>
> >> Consider the following scenario: a management application such as
> >> libvirt starts a long-running task with the intent to monitor it until
> >> it finishes.  Half-way through, the management application needs to
> >> disconnect and reconnect for some reason (systemctl restart, or crash =
&
> >> recover, or whatever).
> >>
> >> If the long-running task is a job, the management application can resu=
me
> >> after reconnect: the job's ID is as valid as it was before, and the
> >> commands to query and control the job work as before.
> >>
> >> What if it's and asynchronous command?
> >
> > This is not meant for some long-running job which you have to manage.
> >
> > Allowing commands being asynchronous makes sense for things which (a)
> > typically don't take long, and (b) don't need any management.
> >
> > So, if the connection goes down the job is simply canceled, and after
> > reconnecting the management can simply send the same command again.
>
> Is this worth its own infrastructure?

Yes, not having to change/break the client side API is worth some effort.

> Would you hazard a guess on how many commands can take long enough to
> demand a conversion to asynchronous, yet not need any management?

Some of the currently synchronous commands that are doing some
substantial task (many of them are not simply reading values from
memory) could be gradually converted, as needed.

> >> > Whenever we can solve things on qemu side, I would rather not
> >> > deprecate current API.
> >>
> >> Making a synchronous command asynchronous definitely changes API.
> >
> > Inside qemu yes, sure.  But for the QMP client nothing changes.
>
> Command replies can arrive out of order, can't they?

They are returned in order, see "QmpSession: return orderly".


--=20
Marc-Andr=C3=A9 Lureau

