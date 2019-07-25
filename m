Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA7DC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9A92173B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9A92173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqexR-0003ID-8y
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37962)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hqexG-0002mX-Q9
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hqexF-0006EK-7h
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:42:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hqexE-0006Dr-UQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:42:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so45255062wmj.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=75PFEX3GK/7ufEgBzS6/1sc9iBalSAjLcFKjqOSadxM=;
 b=p1a7uizpjLtiogOY68q9vOdCD2x9cNr2tUwp6X4Sv3c1TmrV4hnV52HfZudluevoMx
 NtPxXVsIrB946r86mw8AhAFAh9aUrVNvJDOpI+QaLtEuhrPpNx+Ik7I6xlSom7SW11Ax
 tXu8vbK/NqTHNOWdFn/RnMb0wotVxJDgMSplgtmVsD7q7yiXCKc9GkC9YKWBTombAcV2
 DfgtzOsZCbYRLyfEeMR7g7fZPp4thnXC9SOWlDhf4hZWpn53P2vVaQJ+SzOPctU/tVNf
 MyYgX5xcjrTAbg8Krj8DAxXbiRFBCpqraWZxHYmOuiS/zLADptT1lEOBT40/31UK3xe8
 isIQ==
X-Gm-Message-State: APjAAAWRGZDnCEMc1FVDaAHDf+DcPHR/CLsRbPVOPzT50dR4GkmhYq8t
 20Y2+MLzEGrzMXLIHlIbzrWJHA==
X-Google-Smtp-Source: APXvYqxpsSVKwaIfSwq5NyC3/aNYSMFTPN41ydlVN7zpJePno12D7/LNqVxND8ZsWPDUQBJyHuhxnw==
X-Received: by 2002:a05:600c:303:: with SMTP id
 q3mr82482452wmd.130.1564065767662; 
 Thu, 25 Jul 2019 07:42:47 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id e3sm48470275wrs.37.2019.07.25.07.42.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 07:42:47 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com> <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
Date: Thu, 25 Jul 2019 16:42:42 +0200
Message-ID: <87muh2mazh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/07/19 15:26, Stefan Hajnoczi wrote:
>> The microvm design has a premise and it can be answered definitively
>> through performance analysis.
>>=20
>> If I had to explain to someone why PCI or ACPI significantly slows
>> things down, I couldn't honestly do so.  I say significantly because
>> PCI init definitely requires more vmexits but can it be a small
>> number?  For ACPI I have no idea why it would consume significant
>> amounts of time.
>
> My guess is that it's just a lot of code that has to run. :(

I think I haven't shared any numbers about ACPI.

I don't have details about where exactly the time is spent, but
compiling a guest kernel without ACPI decreases the average boot time in
~12ms, and the kernel's unstripped ELF binary size goes down in a
whooping ~300KiB.

On the other hand, removing ACPI from QEMU decreases its initialization
time in ~5ms, and the binary size is ~183KiB smaller.

IMHO, those are pretty relevant savings on both fronts.

>> Until we have this knowledge, the premise of microvm is unproven and
>> merging it would be premature because maybe we can get into the same
>> ballpark by optimizing existing code.
>>=20
>> I'm sorry for being a pain.  I actually think the analysis will
>> support microvm, but it still needs to be done in order to justify it.
>
> No, you're not a pain, you're explaining your reasoning and that helps.
>
> To me *maintainability is the biggest consideration* when introducing a
> new feature.  "We can do just as well with q35" is a good reason to
> deprecate and delete microvm, but not a good reason to reject it now as
> long as microvm is good enough in terms of maintainability.  Keeping it
> out of tree only makes it harder to do this kind of experiment.  virtio
> 1 seems to be the biggest remaining blocker and I think it'd be a good
> thing to have even for the ARM virt machine type.
>
> FWIW the "PCI tax" seems to be ~10 ms in QEMU, ~10 ms in the firmware(*)
> and ~25 ms in the kernel.  I must say that's pretty good, but it's still
> 30% of the whole boot time and reducing it is the hardest part.  If
> having microvm in tree can help reducing it, good.  Yes, it will get
> users, but most likely they will have to support pc or q35 as a fallback
> so we could still delete microvm at any time with the due deprecation
> period if it turns out to be a failed experiment.
>
> Whether to use qboot or SeaBIOS for microvm is another story, but it's
> an implementation detail as long as the ROM size doesn't change and/or
> we don't do versioned machine types.  So we can switch from one to the
> other at any time; we can also include qboot directly in QEMU's tree,
> without going through a submodule, which also reduces the infrastructure
> needed (mirrors, etc.) and makes it easier to delete it.
>
> Paolo
>
> (*) I measured 15ms in SeaBIOS and 5ms in qboot from the first to the
> last write to 0xcf8.  I suspect part of qboot's 10ms boot time actually
> end up measured as PCI in SeaBIOS, due to different init order, so the
> real firmware cost of PAM and PCI initialization should be 5ms for qboot
> and 10ms for SeaBIOS.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl05v+IACgkQ9GknjS8M
AjWdwxAAo9PLJcU7MolTX1ZffPUN3PsFk1fo+kHKebCvd6xWJ1ZFDUYf5gz0ey46
OBI9BGJJPEUP+7ahO87fxUMmjLG9/f9QZgzOKrrqWwe9hasoRRnbJG3arMkLlqmd
vUm5TE/zHEtsYfBkLFTJ1qK5gtGKxqpcbamr0Lv5Xze5gT7OkB4dwOCBFhwc16Uf
q6Lzj1yXMrFckVwGh4zPvzgz+Y1e+aW/s97je3nnI4vWqDhBp7IQKm/vgfYlY8Z8
phVqtEMzTXwOTJblaNaTypPqQKnuWlIy3NgM0UAF9K9l3cQRn438CUgFQBx6Rg1Z
MaTgE2LJx00RPY0g2/SVLAQmQar8DFi6lOWID3NAwDKITmvomhOCDCPz+UR/Jx2m
sUvIqV5Zhf3TPBYKh8Avf9UGfWPC3d1EvTrMBWzXrg28fzcadcORuJWLcVjUL/vC
HYefmjDwZpsRsiBj/JftrJIxET0Q0qFFGHH7JlZ7e5YvCpD2hrgBiDj2RVo2DBsH
mZ0+XH9CyDnwXBX2cIo8v3cgehaFUDjtlTc0uNtq4ytIqB4WAqxXm6A0SYrsBkaz
CQPMxRi5ka0l/eb/ek58Fggxxt+qb69IM7kd3mw+xUUqOTH3+DT1aYNJgNbaU3HH
vFWESs0mzJvXCWg+UYt8seWdtYXL0KLoeFXWKe3BREutcnaG0X8=
=bj+n
-----END PGP SIGNATURE-----
--=-=-=--

