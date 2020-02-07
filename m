Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1803BC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8177222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 21:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3ZorjER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8177222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Ba5-0003wH-SO
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 16:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j0BZW-0002pb-Fa
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j0BZU-0002mm-0A
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:53:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50726
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j0BZT-0002kQ-N2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 16:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581112433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cPFzs69CLcsKWh6Zeggqq06x3bj43vrIyQRLMw4e3UM=;
 b=G3ZorjERa/fhh2mDsdsGT1IsFLnEF22u/EKADzNIx4FLCzKLdvZnKhkodiJUpnsBEptosN
 mChPCYq2tI2nFHhpsXbB0PZGf/W79+V5ryrfj1nHGtPI9CD533zyez9BnRdR/fLZOeZL4v
 XuL+t235SkMC5qa8TeZku02MRkcpirs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-BzdheTX4MTGScyM0WzRvgw-1; Fri, 07 Feb 2020 16:53:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2A878014D1;
 Fri,  7 Feb 2020 21:53:48 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 253231001B30;
 Fri,  7 Feb 2020 21:53:42 +0000 (UTC)
Subject: Re: Getting whole-tree patches reviewed and merged
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <CAFEAcA-C5Kvp-tUZfXSeAiFAHW-YXb+ddwFqyo5Y=0ziPhFbDA@mail.gmail.com>
 <871rrs136l.fsf_-_@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f450e310-3614-5e03-b932-ecba95970c95@redhat.com>
Date: Fri, 7 Feb 2020 15:53:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <871rrs136l.fsf_-_@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: BzdheTX4MTGScyM0WzRvgw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 11:16 PM, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On Tue, 21 Jan 2020 at 15:11, Marc-Andr=C3=A9 Lureau
>> <marcandre.lureau@gmail.com> wrote:
>>> There are plenty of refactoring to do. The problem when touching the
>>> whole code-base, imho, is review time. It may take a couple of
>>> hours/days to come up with a cocci/spatch, and make various patches
>>> here and there. But it takes often weeks and a lot of constant push to
>>> various folks to get all the reviews (as seens by the qdev prop-ptr
>>> series earlier for example). How can we better address whole code-base
>>> changes?
>>
>> It depends. If it's literally just a cocci/spatch mechanical
>> transformation, I think we should be OK with reviewing that
>> transform and then applying it; we don't need to get acks
>> from every submaintainer for that kind of thing.
>=20
> I go one step further: I prefer mechanical changes committed together,
> not torn apart and routed through N+1 trees, where N is the number of
> active maintainers picking patches from the series, and 1 is the
> maintainer taking pity of the inevitable leftovers.
>=20
> Tearing a patch series apart may be in order when it's invasive enough
> to risk many conflicts.  The subsystem maintainer may need tighter
> control over merging order then, and routing picked patches through his
> own tree may be the practical way to get it.

And the pending work on ERRP_AUTO_PROPAGATE is an example of that -=20
Vladimir has been trying to get the improvements in for some time, but=20
it touches so many files, and is awkward to review whether it is split=20
into over 100 patches per maintainer area or when it is consolidates=20
into few but large patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


