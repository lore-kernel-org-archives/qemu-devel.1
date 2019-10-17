Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E8EFA3733
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEDC2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEDC2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4MN-0007wR-9J
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 07:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iL4Kw-0006yO-2M
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iL4Ku-00057M-UM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:52:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iL4Ku-000574-Lw
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:52:56 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6131F7FDC9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:52:55 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k184so1038972wmk.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 04:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=xnWgpye6CWWjgYx0MDMULGRITOWwwMNvlCrv+mBv1Ec=;
 b=l/ek6FvCoXE3R+KTAPOpXYGxRFk8o5mCdnDF7MRPgNBTHiZWXraJKRqhu+g3LcLc9v
 bZTORPd5xO+nhWTpg5ZXA0IRL/pp7KwF1CObos2gmFywULVFcBSDMEak8/DF+PNerwRn
 0R5uBDX7ecUtj8fxw30RqC4Qn6ujb0Kq/v5s9jd0bQ6fKtWjNnqtE8QDgzLBPvSuMpxp
 5w2l2h+ps9KLU50WJfRu4OFy63dytblqmj/4FOxbPdX3PNXMaiVfugONrcJmAy14Qz7a
 tOUYjiOH2YDIwOjFrUgBtUZKaf7kzRDTAjODNqNJ8YHXY7C2Ub4J+UieGpxOREociasY
 ZF2w==
X-Gm-Message-State: APjAAAV8gxBwLF+/wooq2ZKRccAUdI8F3ydY8MN/5Phb50HjzMi+1426
 Es/Bi8AwVPgRl836JbvS8Wb+gm/0QxMK8WSq13ZJCZzOygiwFIx02UkdZ+swnJY1CwVDVU0rLqq
 JFOcm5itd5KWao2k=
X-Received: by 2002:a5d:630f:: with SMTP id i15mr2747488wru.226.1571313174131; 
 Thu, 17 Oct 2019 04:52:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyttAP3t47m1665WWXKO78MkfdLtuJWRxHXA3bqwTU4SMuKHJ9XjNERijxu6RpIJ60D6cs4uQ==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr2747458wru.226.1571313173912; 
 Thu, 17 Oct 2019 04:52:53 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id v20sm1772174wml.26.2019.10.17.04.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 04:52:53 -0700 (PDT)
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-14-slp@redhat.com>
 <d981516f-f23a-47f5-d825-a101fdaaf471@redhat.com> <87ftjrhcq7.fsf@redhat.com>
 <6e84a3fb-0ded-6302-af44-a1d70eea60fa@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v10 13/15] docs/microvm.rst: document the new microvm
 machine type
In-reply-to: <6e84a3fb-0ded-6302-af44-a1d70eea60fa@redhat.com>
Date: Thu, 17 Oct 2019 13:52:50 +0200
Message-ID: <87d0evh9m5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 10/17/19 12:45 PM, Sergio Lopez wrote:
>>
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>>> Hi Sergio,
>>>
>>> On 10/16/19 12:12 PM, Sergio Lopez wrote:
>>>> +Supported devices
>>>> +-----------------
>>>> +
>>>> +The microvm machine type supports the following devices:
>>>> +
>>>> +- ISA bus
>>>> +- i8259 PIC (optional)
>>>> +- i8254 PIT (optional)
>>>> +- MC146818 RTC (optional)
>>>> +- One ISA serial port (optional)
>>>> +- LAPIC
>>>> +- IOAPIC (with kernel-irqchip=3Dsplit by default)
>>>> +- kvmclock (if using KVM)
>>>> +- fw_cfg
>>>> +- Up to eight virtio-mmio devices (configured by the user)
>>>
>>> If we have VirtIO devices, why not use virtio-serial instead of the
>>> one on the ISA bus?
>>
>> The serial port on the ISA bus is simpler, and thus is supported for
>> both SeaBIOS debugging and Linux's earlyprintk. This makes it *very*
>> convenient for debugging boot issues.
>
> "... but it's also compatible with SeaBIOS"
>
> OK. Maybe we can add a comment such "These devices are the minimum
> required to run SeaBIOS" in the 'Supported devices' section.

Well, that's not exactly true. SeaBIOS works without a serial port, it's
just you can't get it to send its debugging messages anywhere (which
most people won't see anyway).

Sergio.

>>
>> Also, as it's explained in the documentation, users that no longer need
>> it can disable the device and just rely on virtio-console.
>>
>> Sergio.
>>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2oVhIACgkQ9GknjS8M
AjWpvBAAonw3XrsDPxBKG5S3Fc0cGjnZ2odGA2BQvYnuXLSag83meMtTLwOBReSg
PhZ5FkM4dR0BmOubiv3V/nI7mkNT4Lt7Kf1fe/lWZ6kKGIe9NjcGPMJuYz6iR59g
O5wJqxJ4bTuwIVdhHgAJd1trmoxB+yHXxcgkCE90nFWuXoTU6MNeXoIUkmaISCFd
P3xj6X8xihMnExOL79qAnuljLr54vfGDvtzSywWRegaeKub7ePGlLK7nx30NsPVB
7CE2kW5h5YnNGZODopGwxkR1cKe6RCHz4pJCJDhkvzl3Ls7gKEQQxHn1opJD1yyZ
Eol3Ex4Z4TecExnqbGDEzF0cXIXBxjll7DepVdGTZYJrir6+W7O0REtbSVSxSm4J
PyUQuWJ5JhC457QPYp9nPp5CgUfJFid0GwsbofjXXyu+eujC7nrQa5P7bNKyi35u
UjCZirSnOYcex/jEvTYjMWqrsXCRcBBU8inLvJc/xuowwEz2kqxMClku4iszgVkr
AH/TjIhWSldxRJNed9VH8b3lLrH7bYIAgjrsySks+GPZ7x6ak101k2H+XR/9HCot
520uqRehcexblnSpwKeDoj8T1GlOc9f/ImXTSpsI14fRaoB0FVWtY+qttx+URWOE
t6+LHZlZQxdfqljjDLzxz28ZbF1jdlZQmCz/MctF0Xp6W6igkwo=
=gX5s
-----END PGP SIGNATURE-----
--=-=-=--

