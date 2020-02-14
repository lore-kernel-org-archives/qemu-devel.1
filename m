Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CE2C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CE8222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXmz/9hw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CE8222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hke-00018A-90
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j2hk4-0000dC-F7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j2hk2-0000FO-VB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:39:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j2hk2-0000Em-Jl
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581712753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgIUKBnnV71rnTvO6OA1AkbkBxAcg0LNA6gYHOyj8b8=;
 b=CXmz/9hwNcmhuayVf9n1Xd07rROaUUuKIqOffNWNJ+43cmjXWdeKTHmigsYrrUehkXuSuj
 3cCtAPj3rXMDGIpP8MaFFHK8oVp0tllZGdGmG/dqRE5X2o4IQDOzLW6elaZFj2QXlt3OaF
 OJ1rZCwTzcAD6RsYkA5MdMiPzTDVxrc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-LGNAyxI-PDqLnu4IRV41Ng-1; Fri, 14 Feb 2020 15:39:11 -0500
Received: by mail-qt1-f198.google.com with SMTP id d9so6695293qtq.13
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 12:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RkP2ynoeSpOezY5+WNptDBWwzcFyItUxA86TjmfWZgU=;
 b=cI24AKOz7sTaZN1L5CBqt02SPRqWVp2vhFFVb41glRDvftOtnrGUnHVM3/KwoBx8ro
 4gXW6Ek45pFe85fHLAB1S7md//EYK4plhcZ3tMQKqQgflwfn7rGIfgTrk38jWBc7MQjS
 1J2kTvytiyM7OEb5duq3hVyUWKVzpdOb4xws7iC0vjVItaqJiLYzw5OKu3DtL++lqkMN
 2i7SnL4sYtvytdi5GMjjolDS2/TBhpMSniTy7NK7f0C37x3q6d7pXeixnu+GQTu0h/vA
 roWpi/w4HUYLhzFOxMnA7Ytn9qYdUkT79bf+fC3KSzS3ZWAmD2dcWWpLWSgAsSIv49T5
 CIsg==
X-Gm-Message-State: APjAAAWj3guHTttx1309r68rBs94IcYK1Ru/i+3z7iDXJBEQvD/8l4He
 9tS3LhYyj9xGLtommw2R4u0ymYzhtfmSU6jsVroFjp07no3HAtEEBJE+kCsBAbaOmomzZD1Jreg
 XwwOVIo16HRJHA08=
X-Received: by 2002:a05:620a:101a:: with SMTP id
 z26mr4298595qkj.141.1581712745190; 
 Fri, 14 Feb 2020 12:39:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxodyal1c7qX8eW1Js3Ror0fFU3UyQflMghFlXalHEYl5JB2jxOtI5e/Bd7lzDTugrSXB05tw==
X-Received: by 2002:a05:620a:101a:: with SMTP id
 z26mr4298569qkj.141.1581712744877; 
 Fri, 14 Feb 2020 12:39:04 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id z6sm3751165qkz.101.2020.02.14.12.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 12:39:04 -0800 (PST)
Date: Fri, 14 Feb 2020 15:38:57 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH RFC] memory: Don't allow to resize RAM while migrating
Message-ID: <20200214203857.GA1195634@xz-x1>
References: <20200214194459.GB1193332@xz-x1>
 <A5C9F372-A9A6-4D6C-8C08-798F4ED15C10@redhat.com>
MIME-Version: 1.0
In-Reply-To: <A5C9F372-A9A6-4D6C-8C08-798F4ED15C10@redhat.com>
X-MC-Unique: LGNAyxI-PDqLnu4IRV41Ng-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhao@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 14, 2020 at 03:04:23PM -0500, David Hildenbrand wrote:
>=20
>=20
> > Am 14.02.2020 um 20:45 schrieb Peter Xu <peterx@redhat.com>:
> >=20
> > =EF=BB=BFOn Fri, Feb 14, 2020 at 07:26:59PM +0100, David Hildenbrand wr=
ote:
> >>>>>> +    if (!postcopy_is_running()) {
> >>>>>> +        Error *err =3D NULL;
> >>>>>> +
> >>>>>> +        /*
> >>>>>> +         * Precopy code cannot deal with the size of ram blocks c=
hanging at
> >>>>>> +         * random points in time. We're still running on the sour=
ce, abort
> >>>>>> +         * the migration and continue running here. Make sure to =
wait until
> >>>>>> +         * migration was canceled.
> >>>>>> +         */
> >>>>>> +        error_setg(&err, "RAM resized during precopy.");
> >>>>>> +        migrate_set_error(migrate_get_current(), err);
> >>>>>> +        error_free(err);
> >>>>>> +        migration_cancel();
> >>>>>> +    } else {
> >>>>>> +        /*
> >>>>>> +         * Postcopy code cannot deal with the size of ram blocks =
changing at
> >>>>>> +         * random points in time. We're running on the target. Fa=
il hard.
> >>>>>> +         *
> >>>>>> +         * TODO: How to handle this in a better way?
> >>>>>> +         */
> >>>>>> +        error_report("RAM resized during postcopy.");
> >>>>>> +        exit(-1);
> >>>>>=20
> >>>>> Now I'm rethinking the postcopy case....
> >>>>>=20
> >>>>> ram_dirty_bitmap_reload() should only happen during the postcopy
> >>>>> recovery, and when that happens the VM should be stopped on both
> >>>>> sides.  Which means, ram resizing should not trigger there...
> >>>>=20
> >>>> But that guest got the chance to run for a bit and eventually reboot
> >>>> AFAIK. Also, there are other data races possible when used_length
> >>>> suddenly changes, this is just the most obvious one where things wil=
l;
> >>>> get screwed up.
> >>>=20
> >>> Right, the major one could be in ram_load_postcopy() where we call
> >>> host_from_ram_block_offset().  However if FW extension is the major
> >>> use case then it seems to still work (still better than crashing,
> >>> isn't it? :).
> >>=20
> >> "Let's close our eyes and hope it will never happen" ? :) No, I don't
> >> like that. This screams for a better solution long term, and until the=
n
> >> a proper fencing IMHO. We're making here wild guesses about data races
> >> and why they might not be that bad in certain cases (did I mention
> >> load/store tearing? used_length is not an atomic value ...).
> >=20
> > Yeah fencing is good, but crashing a VM while it wasn't going to crash
> > is another thing, imho.  You can dump an error message if you really
> > like, but instead of exit() I really prefer we either still let the
> > old way to at least work or really fix it.
>=20
> I=E2=80=98ll do whatever Juan/Dave think is best. I am not convinced that=
 there is no way to corrupt data or crash later when the guest is already r=
unning again post-reboot and doing real work.

Yeah I never said it will always work. :)

However it does not mean it'll break every time.  My guess is that for
the happened cases it might still survive quite a few, confessing that
is without much clue.  I just prefer to avoid having an explicit patch
to bail out like that, because it doesn't really help that much by
crashing earlier.

That's something I learnt when I started to work on migration, that
is, we don't call exit() on source VM when we really, really needed
to.  For postcopy, it's the destination VM that matters here.

Yeh not a big deal since this is really corner case even if it
happened.  Let's follow the maintainers' judgement.

Thanks,

--=20
Peter Xu


